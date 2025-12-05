#!/bin/bash

# Script extract text từ file PowerPoint (.pptx)
# Sử dụng: ./extract_pptx.sh <file.pptx>

INPUT_FILE="${1:-ran bien.pptx}"
OUTPUT_FILE="pptx_content.txt"
TEMP_DIR="temp_pptx_extract"

# Tạo thư mục tạm
mkdir -p "$TEMP_DIR"

# Đổi tên file .pptx thành .zip và giải nén
cp "$INPUT_FILE" "${INPUT_FILE%.pptx}.zip" 2>/dev/null || cp "$INPUT_FILE" "temp.zip"
unzip -q -o "temp.zip" -d "$TEMP_DIR" 2>/dev/null || unzip -q -o "${INPUT_FILE%.pptx}.zip" -d "$TEMP_DIR"

# Trích xuất text từ các slide XML
echo "" > "$OUTPUT_FILE"

# Lấy danh sách các file slide và sắp xếp theo số
for slide_file in "$TEMP_DIR/ppt/slides/slide"*.xml; do
    if [ -f "$slide_file" ]; then
        # Lấy số slide từ tên file
        slide_num=$(basename "$slide_file" | sed 's/slide\([0-9]*\)\.xml/\1/')
        
        echo "=== SLIDE $slide_num ===" >> "$OUTPUT_FILE"
        
        # Extract text từ các thẻ <a:t> trong XML
        # Sử dụng grep và sed để extract text
        grep -o '<a:t[^>]*>[^<]*</a:t>' "$slide_file" | sed 's/<a:t[^>]*>//g; s/<\/a:t>//g' | tr -d '\n' >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
done

# Dọn dẹp
rm -f "temp.zip" "${INPUT_FILE%.pptx}.zip" 2>/dev/null

echo "Đã extract text từ PowerPoint và lưu vào file: $OUTPUT_FILE"

# Đếm số slide
slide_count=$(ls -1 "$TEMP_DIR/ppt/slides/slide"*.xml 2>/dev/null | wc -l)
echo "Tổng số slide: $slide_count"

