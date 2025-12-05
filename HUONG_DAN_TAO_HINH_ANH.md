# HƯỚNG DẪN TẠO HÌNH ẢNH BẰNG CODE

## TỔNG QUAN

Mặc dù tôi không thể tạo hình ảnh trực tiếp bằng cách vẽ như con người, nhưng tôi có thể giúp bạn tạo hình ảnh thông qua các phương pháp sau:

---

## PHƯƠNG PHÁP 1: TẠO HÌNH ẢNH BẰNG PILLOW (PIL)

**Thư viện Pillow** cho phép tạo hình ảnh từ đầu hoặc chỉnh sửa hình ảnh có sẵn.

### Cài đặt:
```bash
pip install pillow
```

### Ví dụ tạo hình ảnh đơn giản:
```python
from PIL import Image, ImageDraw, ImageFont

# Tạo hình ảnh mới (màu nền trắng, kích thước 800x600)
img = Image.new('RGB', (800, 600), color='white')

# Tạo đối tượng vẽ
draw = ImageDraw.Draw(img)

# Vẽ một hình chữ nhật
draw.rectangle([100, 100, 700, 500], outline='black', width=5)

# Vẽ văn bản
draw.text((200, 250), "Hải Sản Rạn Biển", fill='blue')

# Vẽ hình tròn
draw.ellipse([300, 300, 500, 500], outline='red', width=3)

# Lưu hình ảnh
img.save('hinh_anh.png')
print("Đã tạo hình ảnh: hinh_anh.png")
```

### Ví dụ tạo hình ảnh cho website hải sản:
```python
from PIL import Image, ImageDraw, ImageFont
import os

def tao_hinh_hai_san():
    # Tạo canvas mới
    width, height = 1200, 800
    img = Image.new('RGB', (width, height), color='#E8F5E9')  # Màu xanh nhạt
    
    draw = ImageDraw.Draw(img)
    
    # Vẽ header với màu xanh biển
    draw.rectangle([0, 0, width, 150], fill='#0288D1')
    
    # Thêm tiêu đề
    try:
        font_title = ImageFont.truetype("arial.ttf", 60)
    except:
        font_title = ImageFont.load_default()
    
    draw.text((50, 40), "HẢI SẢN RẠN BIỂN", fill='white', font=font_title)
    
    # Vẽ khung cho nội dung
    draw.rectangle([100, 200, width-100, height-100], outline='#0288D1', width=5)
    
    # Vẽ các icon/placeholder cho món ăn
    colors = ['#FF6B6B', '#4ECDC4', '#FFE66D', '#95E1D3']
    positions = [
        (250, 300, 450, 500),
        (550, 300, 750, 500),
        (250, 550, 450, 750),
        (550, 550, 750, 750)
    ]
    
    labels = ['Tôm Hum Alaska', 'Cá Mó Xanh', 'Cua Hoàng Đế', 'Lobster']
    
    for i, (x1, y1, x2, y2) in enumerate(positions):
        # Vẽ khung món ăn
        draw.rectangle([x1, y1, x2, y2], fill=colors[i], outline='#333', width=3)
        # Thêm nhãn
        draw.text((x1+10, y2+10), labels[i], fill='#333', font=ImageFont.load_default())
    
    # Lưu file
    img.save('banner_hai_san.png')
    print("✓ Đã tạo banner_hai_san.png")
    
    return img

if __name__ == "__main__":
    tao_hinh_hai_san()
```

---

## PHƯƠNG PHÁP 2: TẠO BIỂU ĐỒ VÀ ĐỒ THỊ (MATPLOTLIB)

**Matplotlib** rất tốt để tạo biểu đồ, đồ thị, infographic.

### Cài đặt:
```bash
pip install matplotlib
```

### Ví dụ tạo biểu đồ cho blog hải sản:
```python
import matplotlib.pyplot as plt
import numpy as np

def tao_bieu_do_popularity():
    # Dữ liệu
    mon_an = ['Tôm Hum\nAlaska', 'Cá Mó\nXanh', 'Cua Hoàng\nĐế', 'Lobster', 'Cá Hồi']
    do_popularity = [95, 88, 82, 75, 70]
    colors = ['#FF6B6B', '#4ECDC4', '#FFE66D', '#95E1D3', '#A8E6CF']
    
    # Tạo figure
    fig, ax = plt.subplots(figsize=(12, 7))
    
    # Vẽ bar chart
    bars = ax.barh(mon_an, do_popularity, color=colors, edgecolor='#333', linewidth=2)
    
    # Thêm giá trị trên mỗi cột
    for i, (bar, value) in enumerate(zip(bars, do_popularity)):
        ax.text(value + 2, i, f'{value}%', va='center', fontsize=12, fontweight='bold')
    
    # Tùy chỉnh
    ax.set_xlim(0, 100)
    ax.set_xlabel('Độ Phổ Biến (%)', fontsize=14, fontweight='bold')
    ax.set_title('TOP MÓN HẢI SẢN ĐƯỢC YÊU THÍCH NHẤT', 
                 fontsize=18, fontweight='bold', pad=20)
    ax.grid(axis='x', alpha=0.3, linestyle='--')
    ax.set_facecolor('#F5F5F5')
    
    # Lưu file
    plt.tight_layout()
    plt.savefig('bieu_do_popularity.png', dpi=300, bbox_inches='tight')
    print("✓ Đã tạo bieu_do_popularity.png")
    plt.close()

if __name__ == "__main__":
    tao_bieu_do_popularity()
```

---

## PHƯƠNG PHÁP 3: TẠO HÌNH ẢNH TỪ VĂN BẢN VỚI API AI

### 3.1. Sử dụng OpenAI DALL-E API

**Yêu cầu:** Cần API key từ OpenAI

```python
import openai
import requests
from PIL import Image
import io

def tao_hinh_dalle(prompt, api_key, output_file='hinh_ai.png'):
    """
    Tạo hình ảnh bằng DALL-E
    
    Args:
        prompt: Mô tả hình ảnh cần tạo (tiếng Việt hoặc tiếng Anh)
        api_key: API key từ OpenAI
        output_file: Tên file output
    """
    client = openai.OpenAI(api_key=api_key)
    
    try:
        response = client.images.generate(
            model="dall-e-3",
            prompt=prompt,
            size="1024x1024",
            quality="standard",
            n=1,
        )
        
        image_url = response.data[0].url
        
        # Tải hình ảnh về
        img_response = requests.get(image_url)
        img = Image.open(io.BytesIO(img_response.content))
        img.save(output_file)
        
        print(f"✓ Đã tạo hình ảnh: {output_file}")
        return img
        
    except Exception as e:
        print(f"Lỗi: {e}")
        return None

# Ví dụ sử dụng:
# tao_hinh_dalle(
#     "A beautiful plate of fresh seafood on a white plate, professional food photography, high quality",
#     "your-api-key-here"
# )
```

### 3.2. Sử dụng Stable Diffusion API

**Yêu cầu:** Có thể sử dụng các dịch vụ như Stability AI, Replicate, hoặc Hugging Face

```python
import requests
from PIL import Image
import io

def tao_hinh_stable_diffusion(prompt, api_key, api_url):
    """
    Tạo hình ảnh bằng Stable Diffusion API
    
    Args:
        prompt: Mô tả hình ảnh
        api_key: API key
        api_url: URL của API endpoint
    """
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }
    
    data = {
        "prompt": prompt,
        "width": 1024,
        "height": 1024,
        "steps": 20
    }
    
    try:
        response = requests.post(api_url, headers=headers, json=data)
        response.raise_for_status()
        
        # Giả sử API trả về URL hoặc base64
        result = response.json()
        image_url = result.get('url') or result.get('image')
        
        img_response = requests.get(image_url)
        img = Image.open(io.BytesIO(img_response.content))
        img.save('hinh_stable_diffusion.png')
        
        print("✓ Đã tạo hình ảnh")
        return img
        
    except Exception as e:
        print(f"Lỗi: {e}")
        return None
```

---

## PHƯƠNG PHÁP 4: TẠO HÌNH ẢNH ĐỒ HỌA ĐƠN GIẢN (TURTLE)

**Turtle** phù hợp cho đồ họa vector đơn giản, infographic.

### Ví dụ:
```python
import turtle
from PIL import Image

def tao_hinh_turtle():
    # Tạo screen
    screen = turtle.Screen()
    screen.setup(800, 600)
    screen.bgcolor('#E8F5E9')
    screen.title("Hải Sản Rạn Biển")
    
    t = turtle.Turtle()
    t.speed(0)
    
    # Vẽ logo/tên
    t.penup()
    t.goto(-200, 100)
    t.pendown()
    t.color('#0288D1')
    t.write("HẢI SẢN RẠN BIỂN", font=("Arial", 24, "bold"))
    
    # Vẽ một số hình trang trí
    # Vẽ hình tròn (biểu tượng biển)
    t.penup()
    t.goto(0, -50)
    t.pendown()
    t.color('#4ECDC4')
    t.fillcolor('#4ECDC4')
    t.begin_fill()
    t.circle(80)
    t.end_fill()
    
    # Lưu hình ảnh
    screen.getcanvas().postscript(file="hinh_turtle.eps")
    print("✓ Đã tạo hinh_turtle.eps")
    
    turtle.done()

if __name__ == "__main__":
    tao_hinh_turtle()
```

---

## PHƯƠNG PHÁP 5: KẾT HỢP NHIỀU HÌNH ẢNH (COLLAGE)

Tạo collage từ nhiều hình ảnh có sẵn:

```python
from PIL import Image, ImageDraw, ImageFont
import os

def tao_collage_hai_san(list_anh, output='collage.png'):
    """
    Tạo collage từ danh sách hình ảnh
    
    Args:
        list_anh: List đường dẫn các file ảnh
        output: Tên file output
    """
    # Kích thước mỗi ảnh nhỏ
    thumb_size = (300, 300)
    
    # Tính toán layout (2x2 hoặc 3x2)
    cols = 2
    rows = (len(list_anh) + cols - 1) // cols
    
    # Tạo canvas lớn
    canvas_width = cols * thumb_size[0] + (cols + 1) * 20
    canvas_height = rows * thumb_size[1] + (rows + 1) * 20 + 100  # Thêm không gian cho header
    
    canvas = Image.new('RGB', (canvas_width, canvas_height), color='white')
    draw = ImageDraw.Draw(canvas)
    
    # Vẽ header
    draw.rectangle([0, 0, canvas_width, 80], fill='#0288D1')
    draw.text((20, 25), "BỘ SƯU TẬP HẢI SẢN", fill='white', 
              font=ImageFont.load_default())
    
    # Đặt các ảnh vào canvas
    x_offset = 20
    y_offset = 100
    
    for idx, img_path in enumerate(list_anh):
        if not os.path.exists(img_path):
            print(f"⚠ Không tìm thấy: {img_path}")
            continue
            
        img = Image.open(img_path)
        img.thumbnail(thumb_size, Image.Resampling.LANCZOS)
        
        col = idx % cols
        row = idx // cols
        
        x = x_offset + col * (thumb_size[0] + 20)
        y = y_offset + row * (thumb_size[1] + 20)
        
        # Đặt ảnh vào canvas
        canvas.paste(img, (x, y))
        
        # Vẽ khung
        draw.rectangle([x-2, y-2, x+thumb_size[0]+2, y+thumb_size[1]+2], 
                      outline='#333', width=2)
    
    canvas.save(output)
    print(f"✓ Đã tạo collage: {output}")
    return canvas

# Ví dụ sử dụng:
# tao_collage_hai_san(['anh1.jpg', 'anh2.jpg', 'anh3.jpg', 'anh4.jpg'])
```

---

## GỢI Ý SỬ DỤNG CHO DỰ ÁN HẢI SẢN

### 1. Tạo Banner cho Website/Blog
- Sử dụng Pillow để tạo banner với logo, tên nhà hàng, slogan

### 2. Tạo Infographic về Món Ăn
- Dùng Matplotlib để tạo biểu đồ giá trị dinh dưỡng, độ phổ biến

### 3. Tạo Hình Ảnh SEO
- Dùng Pillow để tạo hình ảnh với text overlay cho các bài viết SEO

### 4. Tạo Hình Ảnh Món Ăn (nếu có API)
- Sử dụng DALL-E hoặc Stable Diffusion để tạo hình ảnh mô tả món ăn

---

## YÊU CẦU TẠO HÌNH ẢNH CỤ THỂ

Nếu bạn muốn tôi tạo hình ảnh cho dự án của mình, vui lòng cho biết:
1. **Loại hình ảnh:** Banner, infographic, biểu đồ, logo, v.v.
2. **Nội dung:** Văn bản, số liệu, theme (ví dụ: hải sản, nhà hàng)
3. **Kích thước:** Width x Height (pixel)
4. **Màu sắc:** Màu chủ đạo, style
5. **Mục đích sử dụng:** Website, blog, social media, v.v.

Tôi sẽ tạo script Python để tạo hình ảnh theo yêu cầu của bạn!

---

## LƯU Ý

- Các hình ảnh tạo bằng code có thể đơn giản hơn so với thiết kế chuyên nghiệp
- Để có hình ảnh phức tạp hơn, nên kết hợp với API AI (DALL-E, Stable Diffusion)
- Hình ảnh từ code phù hợp cho: banner, infographic, biểu đồ, placeholder, mockup
- Đối với hình ảnh món ăn thực tế, nên sử dụng ảnh chụp hoặc AI generation API






