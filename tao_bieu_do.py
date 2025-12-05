"""
Script tạo biểu đồ và đồ thị bằng Matplotlib
Tạo infographic cho blog hải sản
"""

import matplotlib.pyplot as plt
import numpy as np

# Cấu hình font tiếng Việt (nếu cần)
plt.rcParams['font.family'] = ['Arial', 'DejaVu Sans', 'sans-serif']

def tao_bieu_do_popularity():
    """Tạo biểu đồ độ phổ biến của các món ăn"""
    
    # Dữ liệu
    mon_an = ['Tôm Hum\nAlaska', 'Cá Mó\nXanh', 'Cua Hoàng\nĐế', 'Lobster', 'Cá Hồi']
    do_popularity = [95, 88, 82, 75, 70]
    colors = ['#FF6B6B', '#4ECDC4', '#FFE66D', '#95E1D3', '#A8E6CF']
    
    # Tạo figure với kích thước lớn hơn
    fig, ax = plt.subplots(figsize=(14, 8))
    
    # Vẽ bar chart (horizontal)
    bars = ax.barh(mon_an, do_popularity, color=colors, edgecolor='#333', linewidth=2)
    
    # Thêm giá trị trên mỗi cột
    for i, (bar, value) in enumerate(zip(bars, do_popularity)):
        ax.text(value + 2, i, f'{value}%', va='center', 
                fontsize=14, fontweight='bold', color='#333')
    
    # Tùy chỉnh
    ax.set_xlim(0, 100)
    ax.set_xlabel('Độ Phổ Biến (%)', fontsize=16, fontweight='bold', color='#333')
    ax.set_title('TOP MÓN HẢI SẢN ĐƯỢC YÊU THÍCH NHẤT', 
                 fontsize=22, fontweight='bold', pad=25, color='#0288D1')
    
    ax.grid(axis='x', alpha=0.3, linestyle='--', color='#999')
    ax.set_facecolor('#F5F5F5')
    
    # Xóa viền
    for spine in ax.spines.values():
        spine.set_visible(False)
    
    ax.tick_params(colors='#666', labelsize=12)
    
    # Layout
    plt.tight_layout()
    
    # Lưu file với độ phân giải cao
    plt.savefig('bieu_do_popularity.png', dpi=300, bbox_inches='tight', 
                facecolor='white', edgecolor='none')
    print("✓ Đã tạo biểu đồ: bieu_do_popularity.png")
    plt.close()

def tao_bieu_do_gia_tri_dinh_duong():
    """Tạo biểu đồ giá trị dinh dưỡng"""
    
    # Dữ liệu
    mon_an = ['Tôm Hum\nAlaska', 'Cá Mó\nXanh', 'Cua Hoàng\nĐế', 'Lobster']
    
    protein = [24, 20, 18, 19]
    omega3 = [1.2, 2.5, 0.8, 1.5]
    
    x = np.arange(len(mon_an))
    width = 0.35
    
    # Tạo figure
    fig, ax = plt.subplots(figsize=(14, 8))
    
    # Vẽ bar chart (grouped)
    bars1 = ax.bar(x - width/2, protein, width, label='Protein (g/100g)', 
                   color='#FF6B6B', edgecolor='#333', linewidth=2)
    bars2 = ax.bar(x + width/2, omega3, width, label='Omega-3 (g/100g)', 
                   color='#4ECDC4', edgecolor='#333', linewidth=2)
    
    # Thêm giá trị trên mỗi cột
    for bars in [bars1, bars2]:
        for bar in bars:
            height = bar.get_height()
            ax.text(bar.get_x() + bar.get_width()/2., height,
                   f'{height:.1f}',
                   ha='center', va='bottom', fontsize=11, fontweight='bold')
    
    # Tùy chỉnh
    ax.set_ylabel('Giá Trị Dinh Dưỡng (g/100g)', fontsize=16, fontweight='bold')
    ax.set_title('GIÁ TRỊ DINH DƯỠNG CÁC LOẠI HẢI SẢN', 
                 fontsize=22, fontweight='bold', pad=25, color='#0288D1')
    ax.set_xticks(x)
    ax.set_xticklabels(mon_an, fontsize=12)
    ax.legend(fontsize=14, loc='upper right')
    
    ax.grid(axis='y', alpha=0.3, linestyle='--', color='#999')
    ax.set_facecolor('#F5F5F5')
    
    # Xóa viền
    for spine in ax.spines.values():
        spine.set_visible(False)
    
    ax.tick_params(colors='#666', labelsize=12)
    
    # Layout
    plt.tight_layout()
    
    # Lưu file
    plt.savefig('bieu_do_dinh_duong.png', dpi=300, bbox_inches='tight',
                facecolor='white', edgecolor='none')
    print("✓ Đã tạo biểu đồ dinh dưỡng: bieu_do_dinh_duong.png")
    plt.close()

def tao_bieu_do_doanh_thu():
    """Tạo biểu đồ doanh thu theo tháng (ví dụ)"""
    
    # Dữ liệu
    thang = ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6']
    doanh_thu = [150, 180, 220, 250, 280, 320]  # triệu đồng
    
    # Tạo figure
    fig, ax = plt.subplots(figsize=(14, 8))
    
    # Vẽ line chart
    ax.plot(thang, doanh_thu, marker='o', linewidth=3, markersize=10,
            color='#0288D1', markerfacecolor='#FF6B6B', 
            markeredgecolor='#333', markeredgewidth=2)
    
    # Fill area dưới đường
    ax.fill_between(thang, doanh_thu, alpha=0.3, color='#4ECDC4')
    
    # Thêm giá trị trên mỗi điểm
    for x, y in zip(thang, doanh_thu):
        ax.text(x, y + 15, f'{y}tr', ha='center', va='bottom',
               fontsize=12, fontweight='bold', color='#333')
    
    # Tùy chỉnh
    ax.set_ylabel('Doanh Thu (Triệu VNĐ)', fontsize=16, fontweight='bold')
    ax.set_title('DOANH THU NHÀ HÀNG HẢI SẢN RẠN BIỂN', 
                 fontsize=22, fontweight='bold', pad=25, color='#0288D1')
    
    ax.grid(axis='y', alpha=0.3, linestyle='--', color='#999')
    ax.set_facecolor('#F5F5F5')
    
    # Xóa viền
    for spine in ax.spines.values():
        spine.set_visible(False)
    
    ax.tick_params(colors='#666', labelsize=12)
    
    # Layout
    plt.tight_layout()
    
    # Lưu file
    plt.savefig('bieu_do_doanh_thu.png', dpi=300, bbox_inches='tight',
                facecolor='white', edgecolor='none')
    print("✓ Đã tạo biểu đồ doanh thu: bieu_do_doanh_thu.png")
    plt.close()

if __name__ == "__main__":
    print("=" * 50)
    print("TẠO BIỂU ĐỒ VÀ INFographic")
    print("=" * 50)
    
    # Tạo các biểu đồ
    print("\n1. Đang tạo biểu đồ độ phổ biến...")
    tao_bieu_do_popularity()
    
    print("\n2. Đang tạo biểu đồ giá trị dinh dưỡng...")
    tao_bieu_do_gia_tri_dinh_duong()
    
    print("\n3. Đang tạo biểu đồ doanh thu...")
    tao_bieu_do_doanh_thu()
    
    print("\n" + "=" * 50)
    print("HOÀN TẤT!")
    print("=" * 50)






