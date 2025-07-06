#!/usr/bin/env bash

set -e
set -o pipefail

# Configuration
DATA_DIR="$HOME/Documents/data"
BASE_URL="https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod"
FILE_PATTERNS=(
    "gfs.*.pgrb2.0p25.f*"
    "gfs.*.pgrb2b.0p25*"
    "gfs.*.xfluxgrbf*.grib2"
)

# Get current UTC time
CURRENT_HOUR_UTC=$(date -u +%H)
CURRENT_DATE_UTC=$(date -u +%Y%m%d)

# Function to check if a specific run is available
check_run_available() {
    local check_date=$1
    local check_hour=$2
    local check_url="$BASE_URL/gfs.${check_date}/${check_hour}/atmos"
    
    # Try to get the directory listing (but don't download anything)
    if wget -q --spider "$check_url" 2>/dev/null; then
        echo "$check_date $check_hour"
        return 0
    fi
    return 1
}

# Function to check if we already have this data
data_exists() {
    local check_date=$1
    local check_hour=$2
    local target_dir="$DATA_DIR/gfs_${check_date}_${check_hour}Z"
    
    # Check if directory exists and has files
    if [ -d "$target_dir" ]; then
        # Count files matching our patterns
        local file_count=0
        for pattern in "${FILE_PATTERNS[@]}"; do
            # Convert pattern to a find-compatible pattern
            local find_pattern=$(echo "$pattern" | sed 's/\./\\./g; s/\*/.*/g')
            local matches=$(find "$target_dir" -type f -regex ".*/$find_pattern" -not -name "*.idx" -print -quit)
            if [ -n "$matches" ]; then
                file_count=$((file_count + 1))
            fi
        done
        
        # If we found files matching all our patterns, assume we have the data
        if [ $file_count -eq ${#FILE_PATTERNS[@]} ]; then
            echo "Found existing data in $target_dir"
            return 0
        fi
    fi
    return 1
}

# Try multiple runs in reverse chronological order
found_run=false
for hours_back in 0 6 12 18 24 30 36 42 48; do
    # Calculate the date and hour for this attempt
    attempt_date=$(date -u -d "$CURRENT_DATE_UTC $CURRENT_HOUR_UTC:00:00 UTC - $hours_back hours" +%Y%m%d)
    attempt_hour=$(date -u -d "$CURRENT_DATE_UTC $CURRENT_HOUR_UTC:00:00 UTC - $hours_back hours" +%H)
    
    # Round down to the nearest 6-hour interval (00, 06, 12, 18)
    attempt_hour=$(printf "%02d" $(( (attempt_hour / 6) * 6 )))
    
    echo "Checking for available run: ${attempt_date} ${attempt_hour}Z"
    
    if run_info=$(check_run_available "$attempt_date" "$attempt_hour"); then
        IFS=' ' read -r RUN_DATE RUN_HOUR <<< "$run_info"
        
        # Check if we already have this data
        if data_exists "$RUN_DATE" "$RUN_HOUR"; then
            echo "Skipping already downloaded run: ${RUN_DATE} ${RUN_HOUR}Z"
            # Don't break, continue to check older runs
            continue
        fi
        
        found_run=true
        echo "Found available run to download: ${RUN_DATE} ${RUN_HOUR}Z"
        break
    fi
    
    echo "Run not available: ${attempt_date} ${attempt_hour}Z"
done

if [ "$found_run" = false ]; then
    echo "Error: No recent GFS runs found in the last 48 hours"
    exit 1
fi

# Create output directory
OUTPUT_DIR="$DATA_DIR/gfs_${RUN_DATE}_${RUN_HOUR}Z"
mkdir -p "$OUTPUT_DIR"

# Base URL for this run
RUN_URL="$BASE_URL/gfs.${RUN_DATE}/${RUN_HOUR}/atmos"

# Log file
LOG_FILE="$OUTPUT_DIR/download_$(date +%Y%m%d_%H%M%S).log"

echo "Starting GFS data download at $(date)" | tee -a "$LOG_FILE"
echo "Run: ${RUN_DATE} ${RUN_HOUR}Z" | tee -a "$LOG_FILE"
echo "Output directory: $OUTPUT_DIR" | tee -a "$LOG_FILE"

# Function to download files
download_files() {
    local pattern=$1
    echo "Downloading files matching: $pattern" | tee -a "$LOG_FILE"
    
    # Get the file list, exclude .idx files, and download each file
    wget -r -np -nd -P "$OUTPUT_DIR" --accept "$pattern" --reject "*.idx" \
        --wait=2 --random-wait --no-parent -e robots=off \
        "$RUN_URL/" 2>&1 | tee -a "$LOG_FILE"
    
    # Check if wget was successful
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        echo "Error downloading files matching: $pattern" | tee -a "$LOG_FILE"
        return 1
    fi
    return 0
}

# Change to output directory
cd "$OUTPUT_DIR" || exit 1

# Download files for each pattern
for pattern in "${FILE_PATTERNS[@]}"; do
    download_files "$pattern"
done

# Check if any files were downloaded
if [ "$(find "$OUTPUT_DIR" -type f -name 'gfs.*' | wc -l)" -eq 0 ]; then
    echo "Error: No GFS files were downloaded. Please check the logs at $LOG_FILE"
    exit 1
fi

echo "Download completed successfully at $(date)" | tee -a "$LOG_FILE"
echo "Files downloaded to: $OUTPUT_DIR" | tee -a "$LOG_FILE"

# Return to original directory
popd >/dev/null 2>&1 || true

exit 0
