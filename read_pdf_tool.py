"""
Tool đọc file PDF và extract text
Có thể kết hợp với các API AI để phân tích nội dung
"""

import os
import sys
from pathlib import Path

def install_requirements():
    """Cài đặt các thư viện cần thiết"""
    try:
        import PyPDF2
        import pdfplumber
    except ImportError:
        print("Đang cài đặt các thư viện cần thiết...")
        os.system("pip install PyPDF2 pdfplumber")
        print("Cài đặt thành công!")

def read_pdf_pypdf2(pdf_path):
    """Đọc PDF sử dụng PyPDF2"""
    try:
        import PyPDF2
        text_content = []
        with open(pdf_path, 'rb') as file:
            pdf_reader = PyPDF2.PdfReader(file)
            total_pages = len(pdf_reader.pages)
            print(f"Tổng số trang: {total_pages}")
            
            for page_num in range(total_pages):
                page = pdf_reader.pages[page_num]
                text = page.extract_text()
                if text.strip():
                    text_content.append(f"\n--- Trang {page_num + 1} ---\n{text}")
                    
        return "\n".join(text_content)
    except Exception as e:
        print(f"Lỗi khi đọc PDF với PyPDF2: {e}")
        return None

def read_pdf_pdfplumber(pdf_path):
    """Đọc PDF sử dụng pdfplumber (chính xác hơn)"""
    try:
        import pdfplumber
        text_content = []
        with pdfplumber.open(pdf_path) as pdf:
            total_pages = len(pdf.pages)
            print(f"Tổng số trang: {total_pages}")
            
            for page_num, page in enumerate(pdf.pages):
                text = page.extract_text()
                if text and text.strip():
                    text_content.append(f"\n--- Trang {page_num + 1} ---\n{text}")
                    
        return "\n".join(text_content)
    except Exception as e:
        print(f"Lỗi khi đọc PDF với pdfplumber: {e}")
        return None

def save_to_text(content, output_path):
    """Lưu nội dung ra file text"""
    try:
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"\nĐã lưu nội dung vào: {output_path}")
        return True
    except Exception as e:
        print(f"Lỗi khi lưu file: {e}")
        return False

def main():
    """Hàm chính"""
    print("=" * 60)
    print("TOOL ĐỌC FILE PDF")
    print("=" * 60)
    
    # Cài đặt thư viện nếu cần
    install_requirements()
    
    # Nhận đường dẫn file PDF
    if len(sys.argv) > 1:
        pdf_path = sys.argv[1]
    else:
        pdf_path = input("\nNhập đường dẫn file PDF: ").strip().strip('"')
    
    # Kiểm tra file có tồn tại không
    if not os.path.exists(pdf_path):
        print(f"❌ Không tìm thấy file: {pdf_path}")
        return
    
    print(f"\n📄 Đang đọc file: {pdf_path}")
    print("-" * 60)
    
    # Thử đọc với pdfplumber trước (chính xác hơn)
    text_content = read_pdf_pdfplumber(pdf_path)
    
    # Nếu pdfplumber không được, thử PyPDF2
    if not text_content:
        print("\nThử phương pháp khác...")
        text_content = read_pdf_pypdf2(pdf_path)
    
    if not text_content:
        print("❌ Không thể đọc được nội dung từ file PDF")
        print("   File có thể là PDF scan hoặc có bảo vệ.")
        return
    
    # Hiển thị preview
    preview_length = 500
    print(f"\n📝 Preview nội dung (first {preview_length} ký tự):")
    print("-" * 60)
    print(text_content[:preview_length] + "..." if len(text_content) > preview_length else text_content)
    print("-" * 60)
    
    # Tùy chọn lưu file
    save_option = input("\n💾 Bạn có muốn lưu nội dung ra file text? (y/n): ").strip().lower()
    if save_option == 'y':
        pdf_name = Path(pdf_path).stem
        output_path = f"{pdf_name}_extracted.txt"
        save_to_text(text_content, output_path)
        
        # Tùy chọn copy vào clipboard để dán vào NotebookLM
        copy_option = input("\n📋 Bạn có muốn copy toàn bộ nội dung vào clipboard? (y/n): ").strip().lower()
        if copy_option == 'y':
            try:
                import pyperclip
                pyperclip.copy(text_content)
                print("✅ Đã copy vào clipboard! Bạn có thể dán vào NotebookLM.")
            except ImportError:
                print("⚠️  Cần cài đặt pyperclip để copy: pip install pyperclip")
                print(f"   Hoặc mở file {output_path} và copy thủ công.")
    
    print(f"\n✅ Hoàn thành! Đã đọc {len(text_content)} ký tự từ PDF.")
    print("\n💡 Mẹo: Bạn có thể copy nội dung này và dán vào NotebookLM để phân tích.")

if __name__ == "__main__":
    main()




