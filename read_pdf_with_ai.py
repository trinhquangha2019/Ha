"""
Tool đọc PDF và phân tích bằng AI (OpenAI API)
Thay thế cho NotebookLM khi cần phân tích tự động
Hỗ trợ OCR cho PDF ảnh (scanned PDF)
"""

import os
import sys
from pathlib import Path

def read_pdf(pdf_path):
    """Đọc PDF và extract text"""
    try:
        import pdfplumber
        text_content = []
        with pdfplumber.open(pdf_path) as pdf:
            total_pages = len(pdf.pages)
            print(f"📑 Tổng số trang: {total_pages}")
            for i, page in enumerate(pdf.pages, 1):
                text = page.extract_text()
                if text and text.strip():
                    text_content.append(text)
                    print(f"✅ Trang {i}: Đã trích xuất {len(text.strip())} ký tự")
                else:
                    print(f"⚠️  Trang {i}: Không có text (có thể là ảnh/scanned PDF)")
        result = "\n".join(text_content)
        if not result:
            print("\n⚠️  CẢNH BÁO: PDF này không có text có thể trích xuất.")
            print("   PDF có thể là file ảnh (scanned). Cần dùng OCR để đọc.")
        return result if result else None
    except ImportError:
        print("Đang cài đặt pdfplumber...")
        os.system("pip install pdfplumber")
        return read_pdf(pdf_path)
    except Exception as e:
        print(f"Lỗi khi đọc PDF: {e}")
        return None

def fix_vietnamese_ocr_errors(text):
    """Sửa một số lỗi OCR phổ biến cho tiếng Việt"""
    import re
    
    # Dictionary các lỗi thường gặp và cách sửa (không dùng word boundary để match linh hoạt hơn)
    fixes = [
        # Lỗi dấu cơ bản
        (r'\bngay\b', 'ngày'),
        (r'\bthang\b', 'tháng'),
        (r'\bnam\b', 'năm'),
        (r'Viét năm', 'Việt Nam'),
        (r'VIET năm', 'VIETNAM'),
        (r'viet năm', 'Việt Nam'),
        
        # Lỗi ký tự đặc biệt
        (r'S6é', 'Số'),
        (r'Sé6', 'Số'),
        (r'\$6', 'Số'),
        (r'Ma sé', 'Mã số'),
        (r'Ma so', 'Mã số'),
        (r'Céng', 'Công'),
        (r'Cdiig', 'Công'),
        (r'Cong', 'Công'),
        (r'Dia chi', 'Địa chỉ'),
        (r'Hé Chi Minh', 'Hồ Chí Minh'),
        (r'H6 Chi Minh', 'Hồ Chí Minh'),
        (r'Kinh gi', 'Kính gửi'),
        (r'Thué', 'Thuế'),
        (r'Thue', 'Thuế'),
        (r'Gia tr', 'Giá trị'),
        (r'gia tri', 'giá trị'),
        (r'gia tang', 'gia tăng'),
        (r'Téng cng', 'Tổng cộng'),
        (r'tra trvdc', 'trả trước'),
        (r'tra trwéc', 'trả trước'),
        (r'truéc', 'trước'),
        (r'truc tiép', 'trực tiếp'),
        (r'truc tiep', 'trực tiếp'),
        (r'nhanh chéng', 'nhanh chóng'),
        (r'nhanh cheng', 'nhanh chóng'),
        (r'Chinh sira', 'Chỉnh sửa'),
        (r'Chinh stra', 'Chỉnh sửa'),
        (r'thong tin', 'thông tin'),
        (r'thông tin', 'thông tin'),  # Đã đúng nhưng để đảm bảo
        (r'chit ky', 'chữ ký'),
        (r'chữ ký', 'chữ ký'),  # Đã đúng
        (r'Quang ba', 'Quảng bá'),
        (r'Quảng bá', 'Quảng bá'),  # Đã đúng
        (r'Tai con dau', 'Tải con dấu'),
        (r'Tải con dấu', 'Tải con dấu'),  # Đã đúng
        (r'danh ba toan cau', 'danh bạ toàn cầu'),
        (r'danh bạ toàn cầu', 'danh bạ toàn cầu'),  # Đã đúng
        (r'tén cong ty', 'tên công ty'),
        (r'Tén Céng ty', 'Tên Công ty'),
        (r'Tén Ngan hang', 'Tên Ngân hàng'),
        (r'Tên Ngân hàng', 'Tên Ngân hàng'),  # Đã đúng
        (r'Bao gia co hiéu luc', 'Báo giá có hiệu lực'),
        (r'Báo giá có hiệu lực', 'Báo giá có hiệu lực'),  # Đã đúng
        
        # Lỗi từ vựng
        (r'chan thanh cam on', 'chân thành cảm ơn'),
        (r'Quy Khach hang', 'Quý Khách hàng'),
        (r'Quý Khách hàng', 'Quý Khách hàng'),  # Đã đúng
        (r'san pham', 'sản phẩm'),
        (r'dich vu', 'dịch vụ'),
        (r'cia ching t6i', 'của chúng tôi'),
        (r'cia ching tdi', 'của chúng tôi'),
        (r'Ching t6i', 'Chúng tôi'),
        (r'Ching tdi', 'Chúng tôi'),
        (r'tran trong giri dén', 'trân trọng gửi đến'),
        (r'tran trong gti dén', 'trân trọng gửi đến'),
        (r'bang bao gia', 'bằng báo giá'),
        (r'giai phap so', 'giải pháp số'),
        (r'giai phap', 'giải pháp'),
        (r'Goi', 'Gói'),
        (r'Chi tiét', 'Chi tiết'),
        (r'Chi tiết', 'Chi tiết'),  # Đã đúng
        (r'thanh toan', 'thanh toán'),
        (r'thanh toán', 'thanh toán'),  # Đã đúng
        (r'nhan duoe', 'nhận được'),
        (r'nhan duoc', 'nhận được'),
        (r'Nhan s6', 'Nhận số'),
        (r'Nhan sé', 'Nhận số'),
        (r'Nhan con dau dién tir', 'Nhận con dấu điện tử'),
        (r'Nhan con dau di¢n tr', 'Nhận con dấu điện tử'),
        (r'Nhan gidy chimg nhan', 'Nhận giấy chứng nhận'),
        (r'Nhan giay chitmg nhan', 'Nhận giấy chứng nhận'),
        (r'Sir dung', 'Sử dụng'),
        (r'Su dung', 'Sử dụng'),
        (r'con dau néi', 'con dấu nổi'),
        (r'con dau noi', 'con dấu nổi'),
        (r'da quan tam dén', 'đã quan tâm đến'),
        (r'da quan tam', 'đã quan tâm'),
    ]
    
    # Áp dụng các sửa lỗi
    for pattern, replacement in fixes:
        text = re.sub(pattern, replacement, text, flags=re.IGNORECASE)
    
    # Sửa các lỗi số và ký tự đặc biệt
    text = re.sub(r'(\d+)\s*VND', r'\1 VND', text)  # Chuẩn hóa khoảng trắng trước VND
    
    return text

def read_pdf_with_ocr(pdf_path):
    """Đọc PDF ảnh bằng OCR (Optical Character Recognition)"""
    try:
        import pdfplumber
        import pytesseract
        from PIL import Image
        import io
        
        # Tự động tìm đường dẫn Tesseract trên Windows
        import platform
        if platform.system() == 'Windows':
            tesseract_paths = [
                r"C:\Program Files\Tesseract-OCR\tesseract.exe",
                r"C:\Program Files (x86)\Tesseract-OCR\tesseract.exe",
                os.path.expanduser(r"~\AppData\Local\Programs\Tesseract-OCR\tesseract.exe"),
            ]
            for path in tesseract_paths:
                if os.path.exists(path):
                    pytesseract.pytesseract.tesseract_cmd = path
                    break
        
        print("\n🔍 Đang lấy ảnh từ PDF...")
        
        # Thử dùng pdfplumber để lấy ảnh (không cần poppler)
        images = []
        with pdfplumber.open(pdf_path) as pdf:
            total_pages = len(pdf.pages)
            print(f"📸 Đang xử lý {total_pages} trang...")
            
            for i, page in enumerate(pdf.pages, 1):
                print(f"   Đang lấy ảnh trang {i}/{total_pages}...", end='\r')
                # Lấy ảnh từ trang PDF
                try:
                    # Thử lấy ảnh từ page với độ phân giải cao hơn để OCR tốt hơn
                    page_image = page.to_image(resolution=400)
                    if page_image:
                        # Chuyển sang PIL Image
                        pil_image = page_image.original
                        images.append((i, pil_image))
                except Exception as e:
                    # Nếu không lấy được bằng pdfplumber, thử pdf2image
                    print(f"\n⚠️  Không thể lấy ảnh bằng pdfplumber, thử pdf2image...")
                    try:
                        from pdf2image import convert_from_path
                        images_list = convert_from_path(pdf_path, dpi=300, first_page=i, last_page=i)
                        if images_list:
                            images.append((i, images_list[0]))
                    except:
                        print(f"❌ Không thể lấy ảnh trang {i}: {e}")
                        continue
        
        if not images:
            print("\n❌ Không thể lấy ảnh từ PDF")
            print("💡 Thử cài đặt poppler-utils:")
            print("   Windows: Tải từ https://github.com/oschwartz10612/poppler-windows/releases/")
            return None
        
        print(f"\n✅ Đã lấy {len(images)} ảnh từ PDF")
        print("🔤 Đang đọc text bằng OCR (có thể mất vài phút)...")
        
        # Kiểm tra xem có language pack tiếng Việt không
        try:
            langs = pytesseract.get_languages()
            has_vie = 'vie' in langs
            if not has_vie:
                print("⚠️  Chưa cài language pack tiếng Việt. Chất lượng OCR có thể kém.")
                print("💡 Hướng dẫn: Tải file vie.traineddata từ:")
                print("   https://github.com/tesseract-ocr/tessdata")
                print("   Đặt vào: C:\\Program Files\\Tesseract-OCR\\tessdata\\")
        except:
            pass
        
        text_content = []
        for page_num, image in images:
            print(f"   Đang OCR trang {page_num}/{len(images)}...", end='\r')
            try:
                # Xử lý ảnh trước khi OCR để cải thiện chất lượng
                # Chuyển sang grayscale nếu cần
                if image.mode != 'RGB':
                    image = image.convert('RGB')
                
                # Tăng kích thước ảnh để OCR tốt hơn (nếu ảnh quá nhỏ)
                width, height = image.size
                if width < 1000 or height < 1000:
                    scale = max(1000 / width, 1000 / height)
                    new_width = int(width * scale)
                    new_height = int(height * scale)
                    image = image.resize((new_width, new_height), Image.Resampling.LANCZOS)
                
                # Cấu hình Tesseract với PSM (Page Segmentation Mode) phù hợp
                # PSM 6: Giả định một khối văn bản đồng nhất
                # PSM 3: Tự động phân đoạn trang (mặc định)
                custom_config = r'--oem 3 --psm 6'
                
                # Thử OCR với tiếng Việt và tiếng Anh
                try:
                    text = pytesseract.image_to_string(image, lang='vie+eng', config=custom_config)
                except:
                    # Nếu không có lang 'vie', thử chỉ 'eng'
                    try:
                        text = pytesseract.image_to_string(image, lang='eng', config=custom_config)
                    except:
                        # Nếu vẫn lỗi, dùng mặc định
                        text = pytesseract.image_to_string(image, config=custom_config)
                
                if text and text.strip():
                    # Xử lý post-processing để sửa một số lỗi phổ biến
                    text = fix_vietnamese_ocr_errors(text)
                    text_content.append(f"--- Trang {page_num} ---\n{text.strip()}")
            except Exception as e:
                print(f"\n⚠️  Lỗi OCR trang {page_num}: {e}")
        
        print(f"\n✅ Đã đọc {len(images)} trang bằng OCR")
        result = "\n\n".join(text_content)
        return result if result else None
        
    except ImportError as e:
        missing = str(e).split("'")[1] if "'" in str(e) else "thư viện"
        print(f"Đang cài đặt {missing}...")
        if "pytesseract" in str(e):
            os.system("pip install pytesseract")
        return read_pdf_with_ocr(pdf_path)
    except Exception as e:
        error_msg = str(e).lower()
        if "tesseract" in error_msg or "not found" in error_msg or "not installed" in error_msg:
            print(f"\n❌ Lỗi: Không tìm thấy Tesseract OCR engine")
            print("\n" + "=" * 60)
            print("💡 HƯỚNG DẪN CÀI ĐẶT TESSERACT OCR:")
            print("=" * 60)
            print("\n📥 Cách 1: Tải và cài đặt thủ công (Khuyến nghị)")
            print("   1. Truy cập: https://github.com/UB-Mannheim/tesseract/wiki")
            print("   2. Tải file cài đặt cho Windows (tesseract-ocr-w64-setup-*.exe)")
            print("   3. Chạy file .exe và cài đặt")
            print("   4. ✅ QUAN TRỌNG: Tích chọn 'Add to PATH' khi cài đặt")
            print("   5. Đóng và mở lại PowerShell/CMD")
            print("\n📥 Cách 2: Dùng Chocolatey (nếu đã cài)")
            print("   choco install tesseract")
            print("\n📥 Cách 3: Dùng winget (Windows 10/11)")
            print("   winget install --id UB-Mannheim.TesseractOCR")
            print("\n🔍 Sau khi cài, kiểm tra bằng lệnh:")
            print("   tesseract --version")
            print("\n" + "=" * 60)
            print("⚠️  Lưu ý: Tesseract là công cụ cần cài đặt riêng, không phải Python package")
            print("=" * 60)
        else:
            print(f"❌ Lỗi khi đọc PDF bằng OCR: {e}")
        return None

def analyze_with_openai(text_content, api_key=None, question="Hãy tóm tắt nội dung này"):
    """Phân tích nội dung bằng OpenAI API"""
    try:
        from openai import OpenAI
        
        if not api_key:
            api_key = os.getenv("OPENAI_API_KEY")
            if not api_key:
                api_key = input("Nhập OpenAI API Key (hoặc Enter để bỏ qua): ").strip()
                if not api_key:
                    return None
        
        client = OpenAI(api_key=api_key)
        
        # Chia nhỏ nội dung nếu quá dài (token limit)
        max_chars = 15000  # Giới hạn cho mỗi lần gọi
        if len(text_content) > max_chars:
            text_content = text_content[:max_chars] + "\n\n[... nội dung bị cắt do quá dài ...]"
        
        print("🤖 Đang phân tích với AI...")
        
        response = client.chat.completions.create(
            model="gpt-4o-mini",  # Hoặc "gpt-3.5-turbo" để rẻ hơn
            messages=[
                {"role": "system", "content": "Bạn là trợ lý AI chuyên phân tích tài liệu."},
                {"role": "user", "content": f"{question}\n\nNội dung tài liệu:\n{text_content}"}
            ],
            max_tokens=2000
        )
        
        return response.choices[0].message.content
    except ImportError:
        print("Đang cài đặt openai...")
        os.system("pip install openai")
        return analyze_with_openai(text_content, api_key, question)
    except Exception as e:
        print(f"Lỗi khi phân tích với AI: {e}")
        return None

def main():
    """Hàm chính"""
    print("=" * 60)
    print("TOOL ĐỌC PDF VÀ PHÂN TÍCH BẰNG AI")
    print("=" * 60)
    
    # Nhận đường dẫn file PDF
    if len(sys.argv) > 1:
        pdf_path = sys.argv[1]
    else:
        pdf_path = input("\nNhập đường dẫn file PDF: ").strip().strip('"')
    
    if not os.path.exists(pdf_path):
        print(f"❌ Không tìm thấy file: {pdf_path}")
        return
    
    print(f"\n📄 Đang đọc file: {pdf_path}")
    text_content = read_pdf(pdf_path)
    
    # Nếu không đọc được text, hỏi có muốn dùng OCR không
    if not text_content:
        print("\n" + "=" * 60)
        print("PDF này không có text có thể trích xuất.")
        print("Bạn có muốn dùng OCR để đọc PDF ảnh không?")
        use_ocr = input("Nhập 'y' để dùng OCR, hoặc Enter để thoát: ").strip().lower()
        
        if use_ocr == 'y':
            text_content = read_pdf_with_ocr(pdf_path)
            if not text_content:
                print("❌ Không thể đọc được nội dung từ PDF bằng OCR")
                return
        else:
            print("❌ Không thể đọc được nội dung từ PDF")
            return
    
    print(f"✅ Đã đọc {len(text_content)} ký tự từ PDF\n")
    
    # Menu lựa chọn
    print("Chọn hành động:")
    print("1. Chỉ lưu text ra file")
    print("2. Phân tích với AI (cần OpenAI API Key)")
    print("3. Cả hai")
    print("4. Export lên NotebookLM")
    print("5. Lưu file + Export NotebookLM")
    
    choice = None
    try:
        choice = input("\nLựa chọn (1/2/3/4/5): ").strip()
    except (EOFError, KeyboardInterrupt):
        # Nếu không có input (chạy non-interactive), tự động lưu file
        print("\n⚠️  Không có input, tự động lưu text ra file...")
        choice = '1'
    
    # Nếu không có lựa chọn hợp lệ, mặc định lưu file
    if not choice or choice not in ['1', '2', '3', '4', '5']:
        print("⚠️  Lựa chọn không hợp lệ, tự động lưu text ra file...")
        choice = '1'
    
    pdf_name = Path(pdf_path).stem
    output_text = f"{pdf_name}_extracted.txt"
    
    # Lưu text
    if choice in ['1', '3']:
        try:
            # Tạo đường dẫn tuyệt đối để đảm bảo lưu đúng vị trí
            output_path = os.path.abspath(output_text)
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(text_content)
            print(f"✅ Đã lưu text vào: {output_path}")
            print(f"   ({len(text_content)} ký tự)")
        except PermissionError:
            print(f"❌ Lỗi: Không có quyền ghi file: {output_text}")
            print("   File có thể đang được mở trong chương trình khác.")
        except Exception as e:
            print(f"❌ Lỗi khi lưu file: {e}")
            print(f"   Đang thử lưu với tên khác...")
            # Thử lưu với timestamp
            from datetime import datetime
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            backup_name = f"{pdf_name}_extracted_{timestamp}.txt"
            try:
                with open(backup_name, 'w', encoding='utf-8') as f:
                    f.write(text_content)
                print(f"✅ Đã lưu vào file dự phòng: {backup_name}")
            except Exception as e2:
                print(f"❌ Không thể lưu file: {e2}")
    
    # Phân tích với AI
    if choice in ['2', '3']:
        question = input("\nNhập câu hỏi/phân tích bạn muốn (hoặc Enter để tóm tắt): ").strip()
        if not question:
            question = "Hãy tóm tắt nội dung chính của tài liệu này"
        
        analysis = analyze_with_openai(text_content, question=question)
        
        if analysis:
            output_analysis = f"{pdf_name}_analysis.txt"
            try:
                output_analysis_path = os.path.abspath(output_analysis)
                with open(output_analysis_path, 'w', encoding='utf-8') as f:
                    f.write(f"Câu hỏi: {question}\n\n")
                    f.write("=" * 60 + "\n\n")
                    f.write(analysis)
                
                print(f"\n✅ Đã lưu phân tích vào: {output_analysis_path}")
                print("\n📋 Kết quả phân tích:")
                print("-" * 60)
                print(analysis)
            except PermissionError:
                print(f"❌ Lỗi: Không có quyền ghi file: {output_analysis}")
            except Exception as e:
                print(f"❌ Lỗi khi lưu file phân tích: {e}")
        else:
            print("❌ Không thể phân tích với AI. Vui lòng kiểm tra API Key.")
    
    # Export lên NotebookLM
    if choice in ['4', '5']:
        try:
            from notebooklm_integration import export_to_notebooklm, show_notebooklm_instructions
            
            print("\n" + "=" * 60)
            print("📚 EXPORT LÊN NOTEBOOKLM")
            print("=" * 60)
            
            print("\nChọn phương thức export:")
            print("1. Tạo file text (copy/paste vào NotebookLM)")
            print("2. Upload lên Google Drive (cần setup API)")
            print("3. Cả hai")
            
            export_method = input("\nLựa chọn (1/2/3, mặc định 1): ").strip()
            if not export_method or export_method not in ['1', '2', '3']:
                export_method = '1'
            
            method_map = {
                '1': 'file',
                '2': 'drive',
                '3': 'both'
            }
            
            method = method_map[export_method]
            
            # Tạo file output cho NotebookLM
            pdf_name = Path(pdf_path).stem
            output_notebooklm = f"{pdf_name}_notebooklm.txt"
            
            result = export_to_notebooklm(
                text_content,
                method=method,
                pdf_path=pdf_path,
                output_file=output_notebooklm
            )
            
            if result['success']:
                print("\n✅ Export thành công!")
                if result['file_path']:
                    print(f"📄 File: {result['file_path']}")
                if result['drive_link']:
                    print(f"🔗 Google Drive: {result['drive_link']}")
                
                print("\n💡 Bước tiếp theo:")
                show_notebooklm_instructions()
            else:
                print("\n⚠️  Export không thành công. Vui lòng thử lại.")
                
        except ImportError:
            print("\n⚠️  Module notebooklm_integration không tìm thấy.")
            print("   Đảm bảo file notebooklm_integration.py ở cùng thư mục.")
            print("\n💡 Tạo file text thủ công:")
            pdf_name = Path(pdf_path).stem
            output_notebooklm = f"{pdf_name}_notebooklm.txt"
            try:
                with open(output_notebooklm, 'w', encoding='utf-8') as f:
                    f.write(text_content)
                print(f"✅ Đã tạo file: {os.path.abspath(output_notebooklm)}")
                print("   Bạn có thể copy nội dung và paste vào NotebookLM")
            except Exception as e:
                print(f"❌ Lỗi: {e}")
        except Exception as e:
            print(f"\n❌ Lỗi khi export lên NotebookLM: {e}")

if __name__ == "__main__":
    main()


