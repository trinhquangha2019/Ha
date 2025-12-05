"""
Script tạo hình ảnh bằng Pillow
Tạo banner và hình ảnh cho website/blog hải sản
"""

from PIL import Image, ImageDraw, ImageFont
import os

def tao_banner_hai_san():
    """Tạo banner cho website hải sản"""
    
    # Tạo canvas mới (1200x600 là kích thước banner chuẩn)
    width, height = 1200, 600
    img = Image.new('RGB', (width, height), color='#E8F5E9')  # Màu xanh nhạt
    
    draw = ImageDraw.Draw(img)
    
    # Vẽ header với màu xanh biển
    draw.rectangle([0, 0, width, 200], fill='#0288D1')
    
    # Thêm tiêu đề
    try:
        # Thử sử dụng font hệ thống
        font_title = ImageFont.truetype("arial.ttf", 70)
        font_subtitle = ImageFont.truetype("arial.ttf", 40)
    except:
        # Fallback về font mặc định nếu không tìm thấy
        font_title = ImageFont.load_default()
        font_subtitle = ImageFont.load_default()
    
    # Tiêu đề chính
    draw.text((50, 50), "HẢI SẢN RẠN BIỂN", fill='white', font=font_title)
    
    # Slogan
    draw.text((50, 130), "Tươi ngon từ đại dương - Chất lượng đẳng cấp", 
              fill='#E3F2FD', font=font_subtitle)
    
    # Vẽ khung cho nội dung
    draw.rectangle([100, 250, width-100, height-100], outline='#0288D1', width=5)
    
    # Thêm text trong khung
    content_text = """• Tôm Hum Alaska
• Cá Mó Xanh
• Cua Hoàng Đế
• Lobster tươi sống"""
    
    y_offset = 280
    for line in content_text.split('\n'):
        draw.text((150, y_offset), line, fill='#333', font=font_subtitle)
        y_offset += 60
    
    # Vẽ một số icon/placeholder cho món ăn
    colors = ['#FF6B6B', '#4ECDC4', '#FFE66D', '#95E1D3']
    positions = [
        (850, 280, 1000, 430),
        (1050, 280, 1200, 430),
        (850, 460, 1000, 610),
        (1050, 460, 1200, 610)
    ]
    
    labels = ['🦞', '🐟', '🦀', '🦐']
    
    for i, (x1, y1, x2, y2) in enumerate(positions):
        # Vẽ khung món ăn
        draw.rectangle([x1, y1, x2, y2], fill=colors[i], outline='#333', width=3)
        # Thêm emoji/text
        try:
            font_emoji = ImageFont.truetype("seguiemj.ttf", 80)  # Windows emoji font
        except:
            font_emoji = ImageFont.load_default()
        draw.text((x1 + (x2-x1)//4, y1 + (y2-y1)//4), labels[i], 
                 fill='#333', font=font_emoji)
    
    # Lưu file
    output_file = 'banner_hai_san.png'
    img.save(output_file)
    print(f"✓ Đã tạo banner: {output_file}")
    
    return img

def tao_hinh_seo(text, output_file='hinh_seo.png'):
    """Tạo hình ảnh SEO với text overlay"""
    
    # Kích thước hình ảnh SEO thường là 1200x630 (Facebook/LinkedIn)
    width, height = 1200, 630
    img = Image.new('RGB', (width, height), color='#0288D1')
    
    draw = ImageDraw.Draw(img)
    
    # Tạo background gradient (đơn giản)
    for i in range(height):
        color_intensity = int(255 - (i / height) * 50)
        color = (2, 136, 209, color_intensity)
        draw.line([(0, i), (width, i)], fill=(2, 136, 209))
    
    # Thêm văn bản chính
    try:
        font_large = ImageFont.truetype("arial.ttf", 60)
        font_medium = ImageFont.truetype("arial.ttf", 35)
    except:
        font_large = ImageFont.load_default()
        font_medium = ImageFont.load_default()
    
    # Text chính
    draw.text((width//2, height//2 - 80), text, 
              fill='white', font=font_large, anchor='mm')
    
    # Subtitle
    draw.text((width//2, height//2 + 40), "haisanranbien.vn", 
              fill='#E3F2FD', font=font_medium, anchor='mm')
    
    # Lưu file
    img.save(output_file)
    print(f"✓ Đã tạo hình SEO: {output_file}")
    
    return img

if __name__ == "__main__":
    print("=" * 50)
    print("TẠO HÌNH ẢNH CHO WEBSITE HẢI SẢN")
    print("=" * 50)
    
    # Tạo banner
    print("\n1. Đang tạo banner...")
    tao_banner_hai_san()
    
    # Tạo hình SEO
    print("\n2. Đang tạo hình SEO...")
    tao_hinh_seo("Tôm Hum Alaska Tươi Sống", "hinh_seo_tom_hum.png")
    
    print("\n" + "=" * 50)
    print("HOÀN TẤT!")
    print("=" * 50)






