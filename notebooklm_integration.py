"""
Module tích hợp với NotebookLM
NotebookLM không có API công khai, nên sử dụng các phương pháp:
1. Upload lên Google Drive (NotebookLM có thể import từ Drive)
2. Tạo file text để copy/paste vào NotebookLM
3. Hướng dẫn upload thủ công
"""

import os
import json
from pathlib import Path
from datetime import datetime

def upload_to_google_drive(file_path, folder_id=None, credentials_file=None):
    """
    Upload file lên Google Drive để import vào NotebookLM
    
    Args:
        file_path: Đường dẫn file cần upload
        folder_id: ID folder trên Google Drive (optional)
        credentials_file: Đường dẫn file credentials.json từ Google Cloud Console
    
    Returns:
        str: Link Google Drive của file đã upload
    """
    try:
        from google.oauth2.credentials import Credentials
        from google_auth_oauthlib.flow import InstalledAppFlow
        from google.auth.transport.requests import Request
        from googleapiclient.discovery import build
        from googleapiclient.http import MediaFileUpload
        import pickle
        
        SCOPES = ['https://www.googleapis.com/auth/drive.file']
        
        creds = None
        token_file = 'token.pickle'
        
        # Kiểm tra token đã lưu
        if os.path.exists(token_file):
            with open(token_file, 'rb') as token:
                creds = pickle.load(token)
        
        # Nếu không có credentials hợp lệ, yêu cầu đăng nhập
        if not creds or not creds.valid:
            if creds and creds.expired and creds.refresh_token:
                creds.refresh(Request())
            else:
                if not credentials_file:
                    credentials_file = 'credentials.json'
                
                if not os.path.exists(credentials_file):
                    print("\n" + "=" * 60)
                    print("⚠️  CẦN THIẾT LẬP GOOGLE DRIVE API")
                    print("=" * 60)
                    print("\n📋 Hướng dẫn:")
                    print("1. Truy cập: https://console.cloud.google.com/")
                    print("2. Tạo project mới hoặc chọn project hiện có")
                    print("3. Bật Google Drive API")
                    print("4. Tạo OAuth 2.0 credentials (Desktop app)")
                    print("5. Tải file credentials.json về thư mục này")
                    print("6. Chạy lại script")
                    print("\n" + "=" * 60)
                    return None
                
                flow = InstalledAppFlow.from_client_secrets_file(
                    credentials_file, SCOPES)
                creds = flow.run_local_server(port=0)
            
            # Lưu credentials cho lần sau
            with open(token_file, 'wb') as token:
                pickle.dump(creds, token)
        
        # Tạo service
        service = build('drive', 'v3', credentials=creds)
        
        # Upload file
        file_metadata = {
            'name': os.path.basename(file_path),
            'parents': [folder_id] if folder_id else []
        }
        
        media = MediaFileUpload(file_path, resumable=True)
        
        print(f"📤 Đang upload {os.path.basename(file_path)} lên Google Drive...")
        file = service.files().create(
            body=file_metadata,
            media_body=media,
            fields='id, webViewLink, webContentLink'
        ).execute()
        
        file_id = file.get('id')
        file_link = f"https://drive.google.com/file/d/{file_id}/view"
        
        print(f"✅ Đã upload thành công!")
        print(f"🔗 Link: {file_link}")
        print(f"\n💡 Để import vào NotebookLM:")
        print(f"   1. Mở https://notebooklm.google.com/")
        print(f"   2. Tạo notebook mới")
        print(f"   3. Chọn 'Add source' → 'Google Drive'")
        print(f"   4. Chọn file vừa upload")
        
        return file_link
        
    except ImportError:
        print("\n⚠️  Cần cài đặt thư viện Google Drive API:")
        print("   pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib")
        return None
    except Exception as e:
        print(f"❌ Lỗi khi upload lên Google Drive: {e}")
        return None


def create_notebooklm_ready_file(text_content, output_file=None, source_name="PDF Document"):
    """
    Tạo file text đã format sẵn để copy/paste vào NotebookLM
    
    Args:
        text_content: Nội dung text cần format
        output_file: Tên file output (optional)
        source_name: Tên nguồn tài liệu
    
    Returns:
        str: Đường dẫn file đã tạo
    """
    if not output_file:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_file = f"notebooklm_ready_{timestamp}.txt"
    
    # Format nội dung với metadata
    formatted_content = f"""NOTES FOR NOTEBOOKLM
Source: {source_name}
Created: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
Length: {len(text_content)} characters

{'=' * 60}
CONTENT
{'=' * 60}

{text_content}

{'=' * 60}
END OF DOCUMENT
{'=' * 60}
"""
    
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(formatted_content)
        
        abs_path = os.path.abspath(output_file)
        print(f"✅ Đã tạo file sẵn sàng cho NotebookLM: {abs_path}")
        print(f"\n💡 Cách sử dụng:")
        print(f"   1. Mở file: {abs_path}")
        print(f"   2. Copy toàn bộ nội dung (Ctrl+A, Ctrl+C)")
        print(f"   3. Mở https://notebooklm.google.com/")
        print(f"   4. Tạo notebook mới")
        print(f"   5. Chọn 'Add source' → 'Paste text'")
        print(f"   6. Paste nội dung vào")
        
        return abs_path
    except Exception as e:
        print(f"❌ Lỗi khi tạo file: {e}")
        return None


def export_to_notebooklm(text_content, method='file', pdf_path=None, **kwargs):
    """
    Export text content để import vào NotebookLM
    
    Args:
        text_content: Nội dung text
        method: 'file' (tạo file text), 'drive' (upload lên Google Drive), 'both'
        pdf_path: Đường dẫn PDF gốc (để lấy tên file)
        **kwargs: Các tham số khác (credentials_file, folder_id, etc.)
    
    Returns:
        dict: Kết quả export
    """
    result = {
        'success': False,
        'method': method,
        'file_path': None,
        'drive_link': None
    }
    
    # Lấy tên source
    if pdf_path:
        source_name = Path(pdf_path).stem
    else:
        source_name = "Extracted Document"
    
    if method in ['file', 'both']:
        output_file = kwargs.get('output_file')
        file_path = create_notebooklm_ready_file(text_content, output_file, source_name)
        result['file_path'] = file_path
        result['success'] = True if file_path else False
    
    if method in ['drive', 'both']:
        # Tạo file tạm để upload
        temp_file = f"temp_notebooklm_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
        try:
            with open(temp_file, 'w', encoding='utf-8') as f:
                f.write(text_content)
            
            drive_link = upload_to_google_drive(
                temp_file,
                folder_id=kwargs.get('folder_id'),
                credentials_file=kwargs.get('credentials_file')
            )
            result['drive_link'] = drive_link
            
            # Xóa file tạm
            if os.path.exists(temp_file):
                os.remove(temp_file)
        except Exception as e:
            print(f"⚠️  Lỗi khi tạo file tạm: {e}")
    
    return result


def show_notebooklm_instructions():
    """Hiển thị hướng dẫn sử dụng NotebookLM"""
    print("\n" + "=" * 60)
    print("📚 HƯỚNG DẪN KẾT NỐI VỚI NOTEBOOKLM")
    print("=" * 60)
    print("\n🔗 Truy cập: https://notebooklm.google.com/")
    print("\n📋 Các cách import tài liệu vào NotebookLM:")
    print("\n1️⃣  COPY/PASTE TEXT (Đơn giản nhất)")
    print("   - Tạo file text bằng script")
    print("   - Copy toàn bộ nội dung")
    print("   - Vào NotebookLM → New notebook → Add source → Paste text")
    
    print("\n2️⃣  UPLOAD FILE")
    print("   - Lưu file .txt hoặc .pdf")
    print("   - Vào NotebookLM → New notebook → Add source → Upload file")
    print("   - Chọn file và upload")
    
    print("\n3️⃣  GOOGLE DRIVE (Khuyến nghị)")
    print("   - Upload file lên Google Drive")
    print("   - Vào NotebookLM → New notebook → Add source → Google Drive")
    print("   - Chọn file từ Drive")
    print("   - NotebookLM sẽ tự động sync khi file thay đổi")
    
    print("\n4️⃣  GOOGLE DOCS")
    print("   - Tạo Google Doc với nội dung")
    print("   - Vào NotebookLM → Add source → Google Docs")
    print("   - Chọn document")
    
    print("\n💡 Lợi ích khi dùng Google Drive:")
    print("   ✓ Tự động sync khi file thay đổi")
    print("   ✓ Dễ quản lý nhiều file")
    print("   ✓ Có thể share với team")
    
    print("\n" + "=" * 60)


if __name__ == "__main__":
    # Test function
    show_notebooklm_instructions()
    
    # Ví dụ sử dụng
    sample_text = """
    Đây là nội dung mẫu để test tích hợp NotebookLM.
    Bạn có thể sử dụng các function trong module này để:
    1. Tạo file text sẵn sàng cho NotebookLM
    2. Upload lên Google Drive
    3. Export theo nhiều cách khác nhau
    """
    
    print("\n📝 Test tạo file:")
    create_notebooklm_ready_file(sample_text, "test_notebooklm.txt", "Test Document")



