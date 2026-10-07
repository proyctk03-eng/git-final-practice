import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch, Polygon, Ellipse
import numpy as np

# Set font family
plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_chen_erd(output_path):
    fig, ax = plt.subplots(figsize=(18, 12), dpi=300)
    ax.set_xlim(0, 24)
    ax.set_ylim(0, 16)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Color palette
    entity_color = '#1E3A8A'     # Navy
    entity_bg = '#EFF6FF'        # Light Blue
    rel_color = '#6D28D9'        # Purple
    rel_bg = '#F5F3FF'           # Light Purple
    attr_color = '#0F766E'       # Teal
    attr_bg = '#F0FDFA'          # Light Teal
    line_color = '#334155'       # Slate line
    pk_color = '#B45309'         # Amber/Brown for PK

    # Title
    ax.text(12, 15.3, "SƠ ĐỒ THỰC THỂ LIÊN KẾT (ERD) - KÝ PHÁP CHEN", 
            fontsize=18, fontweight='bold', ha='center', va='center', color='#0F172A')
    ax.text(12, 14.7, "Bài toán: Quản lý Đơn đặt hàng & Phiếu giao hàng (Đã chuẩn hóa gộp Đơn vị khách)", 
            fontsize=12, fontstyle='italic', ha='center', va='center', color='#475569')

    # Helpers
    def draw_entity(x, y, w, h, text):
        rect = FancyBboxPatch((x - w/2, y - h/2), w, h,
                              boxstyle="round,pad=0.08,rounding_size=0.15",
                              linewidth=2, edgecolor=entity_color, facecolor=entity_bg, zorder=3)
        ax.add_patch(rect)
        ax.text(x, y, text, fontsize=11, fontweight='bold', ha='center', va='center', color=entity_color, zorder=4)

    def draw_relationship(x, y, size, text):
        diamond = Polygon([[x, y + size], [x + size*1.3, y], [x, y - size], [x - size*1.3, y]],
                          closed=True, linewidth=2, edgecolor=rel_color, facecolor=rel_bg, zorder=3)
        ax.add_patch(diamond)
        ax.text(x, y, text, fontsize=10, fontweight='bold', ha='center', va='center', color=rel_color, zorder=4)

    def draw_attribute(x, y, w, h, text, is_pk=False):
        edge = pk_color if is_pk else attr_color
        bg = '#FEF3C7' if is_pk else attr_bg
        fg = pk_color if is_pk else attr_color
        ellipse = Ellipse((x, y), w, h, linewidth=1.5, edgecolor=edge, facecolor=bg, zorder=3)
        ax.add_patch(ellipse)
        display_text = f"<u>{text}</u>" if is_pk else text
        ax.text(x, y, text, fontsize=8.5, fontweight='bold' if is_pk else 'normal',
                ha='center', va='center', color=fg, zorder=4)

    def draw_line(x1, y1, x2, y2, label=None, label_pos=0.5, label_offset=(0, 0)):
        ax.plot([x1, x2], [y1, y2], color=line_color, linewidth=1.5, zorder=2)
        if label:
            lx = x1 + (x2 - x1) * label_pos + label_offset[0]
            ly = y1 + (y2 - y1) * label_pos + label_offset[1]
            ax.text(lx, ly, label, fontsize=10, fontweight='bold', ha='center', va='center',
                    color='#DC2626', bbox=dict(boxstyle='circle,pad=0.15', facecolor='#FFFFFF', edgecolor='none'), zorder=5)

    # 1. ENTITIES
    # ĐƠN VỊ KHÁCH
    dvk_x, dvk_y = 12, 12.2
    draw_entity(dvk_x, dvk_y, 3.8, 1.0, "ĐƠN VỊ KHÁCH")

    # NGƯỜI ĐẶT
    nd_x, nd_y = 5.5, 9.0
    draw_entity(nd_x, nd_y, 3.2, 0.9, "NGƯỜI ĐẶT")

    # NGƯỜI NHẬN
    nn_x, nn_y = 18.5, 9.0
    draw_entity(nn_x, nn_y, 3.2, 0.9, "NGƯỜI NHẬN")

    # NGƯỜI GIAO
    ng_x, ng_y = 21.0, 5.0
    draw_entity(ng_x, ng_y, 3.0, 0.9, "NGƯỜI GIAO")

    # NƠI GIAO
    dg_x, dg_y = 16.5, 2.0
    draw_entity(dg_x, dg_y, 3.0, 0.9, "NƠI GIAO")

    # HÀNG
    hang_x, hang_y = 4.0, 3.5
    draw_entity(hang_x, hang_y, 3.0, 0.9, "HÀNG")

    # 2. RELATIONSHIPS
    # Thuộc 1 (Đơn vị khách - Người đặt)
    thuoc1_x, thuoc1_y = 8.5, 10.6
    draw_relationship(thuoc1_x, thuoc1_y, 0.6, "THUỘC")
    draw_line(dvk_x, dvk_y, thuoc1_x, thuoc1_y, label="1", label_pos=0.6, label_offset=(-0.2, 0.2))
    draw_line(thuoc1_x, thuoc1_y, nd_x, nd_y, label="N", label_pos=0.6, label_offset=(-0.2, -0.2))

    # Thuộc 2 (Đơn vị khách - Người nhận)
    thuoc2_x, thuoc2_y = 15.5, 10.6
    draw_relationship(thuoc2_x, thuoc2_y, 0.6, "THUỘC")
    draw_line(dvk_x, dvk_y, thuoc2_x, thuoc2_y, label="1", label_pos=0.6, label_offset=(0.2, 0.2))
    draw_line(thuoc2_x, thuoc2_y, nn_x, nn_y, label="N", label_pos=0.6, label_offset=(0.2, -0.2))

    # ĐẶT (Người đặt - Hàng)
    dat_x, dat_y = 4.8, 6.2
    draw_relationship(dat_x, dat_y, 0.7, "ĐẶT")
    draw_line(nd_x, nd_y, dat_x, dat_y, label="1", label_pos=0.5, label_offset=(-0.3, 0))
    draw_line(dat_x, dat_y, hang_x, hang_y, label="N", label_pos=0.5, label_offset=(-0.3, 0))

    # GIAO (Quaternary: Người giao, Người nhận, Hàng, Nơi giao)
    giao_x, giao_y = 13.0, 5.5
    draw_relationship(giao_x, giao_y, 0.8, "GIAO")
    draw_line(nn_x, nn_y, giao_x, giao_y, label="N", label_pos=0.4, label_offset=(0.2, 0.2))
    draw_line(ng_x, ng_y, giao_x, giao_y, label="N", label_pos=0.4, label_offset=(0.2, 0.2))
    draw_line(hang_x, hang_y, giao_x, giao_y, label="N", label_pos=0.4, label_offset=(-0.2, 0.2))
    draw_line(dg_x, dg_y, giao_x, giao_y, label="N", label_pos=0.4, label_offset=(0.2, -0.2))

    # 3. ATTRIBUTES
    # Attributes for ĐƠN VỊ KHÁCH
    dvk_attrs = [
        (10.0, 13.7, "Mã ĐV (PK)", True),
        (12.0, 13.9, "Tên ĐV", False),
        (14.0, 13.8, "Địa chỉ", False),
        (15.7, 12.8, "Điện thoại", False)
    ]
    for ax_pos, ay_pos, text, is_pk in dvk_attrs:
        draw_line(dvk_x, dvk_y, ax_pos, ay_pos)
        draw_attribute(ax_pos, ay_pos, 1.8, 0.6, text, is_pk)

    # Attributes for NGƯỜI ĐẶT
    nd_attrs = [
        (2.6, 9.8, "Mã số NĐ (PK)", True),
        (2.6, 8.8, "Họ tên NĐ", False)
    ]
    for ax_pos, ay_pos, text, is_pk in nd_attrs:
        draw_line(nd_x, nd_y, ax_pos, ay_pos)
        draw_attribute(ax_pos, ay_pos, 2.0, 0.6, text, is_pk)

    # Attributes for NGƯỜI NHẬN
    nn_attrs = [
        (21.4, 9.8, "Mã số NN (PK)", True),
        (21.4, 8.8, "Họ tên NN", False)
    ]
    for ax_pos, ay_pos, text, is_pk in nn_attrs:
        draw_line(nn_x, nn_y, ax_pos, ay_pos)
        draw_attribute(ax_pos, ay_pos, 2.0, 0.6, text, is_pk)

    # Attributes for NGƯỜI GIAO
    ng_attrs = [
        (21.8, 6.4, "Mã số NG (PK)", True),
        (22.0, 3.8, "Họ tên NG", False)
    ]
    for ax_pos, ay_pos, text, is_pk in ng_attrs:
        draw_line(ng_x, ng_y, ax_pos, ay_pos)
        draw_attribute(ax_pos, ay_pos, 2.0, 0.6, text, is_pk)

    # Attributes for NƠI GIAO
    dg_attrs = [
        (14.0, 0.8, "Mã số ĐĐG (PK)", True),
        (18.5, 0.8, "Tên nơi giao", False)
    ]
    for ax_pos, ay_pos, text, is_pk in dg_attrs:
        draw_line(dg_x, dg_y, ax_pos, ay_pos)
        draw_attribute(ax_pos, ay_pos, 2.1, 0.6, text, is_pk)

    # Attributes for HÀNG
    hang_attrs = [
        (1.8, 4.5, "Mã hàng (PK)", True),
        (1.5, 3.4, "Tên hàng", False),
        (1.8, 2.3, "Đv tính", False),
        (3.5, 1.2, "Mô tả hàng", False)
    ]
    for ax_pos, ay_pos, text, is_pk in hang_attrs:
        draw_line(hang_x, hang_y, ax_pos, ay_pos)
        draw_attribute(ax_pos, ay_pos, 1.9, 0.6, text, is_pk)

    # Attributes for relationship ĐẶT
    dat_attrs = [
        (1.6, 7.3, "Số ĐH", False),
        (1.6, 6.3, "Ngày đặt", False),
        (2.0, 5.3, "Số lượng", False)
    ]
    for ax_pos, ay_pos, text, is_pk in dat_attrs:
        draw_line(dat_x, dat_y, ax_pos, ay_pos)
        draw_attribute(ax_pos, ay_pos, 1.6, 0.55, text, is_pk)

    # Attributes for relationship GIAO
    giao_attrs = [
        (10.5, 7.3, "Số PG", False),
        (13.0, 7.8, "Ngày giao", False),
        (11.0, 3.7, "Số lượng", False),
        (13.0, 3.3, "Đơn giá", False),
        (14.8, 3.8, "Thành tiền", False)
    ]
    for ax_pos, ay_pos, text, is_pk in giao_attrs:
        draw_line(giao_x, giao_y, ax_pos, ay_pos)
        draw_attribute(ax_pos, ay_pos, 1.6, 0.55, text, is_pk)

    # Legend box
    legend_box = FancyBboxPatch((0.5, 14.0), 5.5, 1.6,
                                boxstyle="round,pad=0.05,rounding_size=0.1",
                                linewidth=1, edgecolor='#CBD5E1', facecolor='#F8FAFC', zorder=2)
    ax.add_patch(legend_box)
    ax.text(0.7, 15.3, "Chú giải ký pháp Chen:", fontsize=9.5, fontweight='bold', color='#1E293B')
    
    # Symbols in legend
    r_ent = FancyBboxPatch((0.8, 14.8), 0.6, 0.25, boxstyle="round,pad=0.02,rounding_size=0.05",
                           facecolor=entity_bg, edgecolor=entity_color, lw=1)
    ax.add_patch(r_ent)
    ax.text(1.6, 14.9, "Thực thể", fontsize=8.5, color='#334155')

    d_rel = Polygon([[2.8, 15.05], [3.1, 14.92], [2.8, 14.8], [2.5, 14.92]],
                    facecolor=rel_bg, edgecolor=rel_color, lw=1)
    ax.add_patch(d_rel)
    ax.text(3.3, 14.9, "Quan hệ", fontsize=8.5, color='#334155')

    e_attr = Ellipse((4.5, 14.92), 0.5, 0.25, facecolor=attr_bg, edgecolor=attr_color, lw=1)
    ax.add_patch(e_attr)
    ax.text(4.9, 14.9, "Thuộc tính", fontsize=8.5, color='#334155')

    e_pk = Ellipse((0.8 + 0.3, 14.35), 0.5, 0.25, facecolor='#FEF3C7', edgecolor=pk_color, lw=1)
    ax.add_patch(e_pk)
    ax.text(1.6, 14.35, "Khoá chính (PK)", fontsize=8.5, color='#334155')

    ax.text(3.5, 14.35, "1, N: Bản số quan hệ", fontsize=8.5, fontweight='bold', color='#DC2626')

    plt.tight_layout()
    plt.savefig(output_path, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Rendered Chen ERD: {output_path}")

if __name__ == "__main__":
    draw_chen_erd("c:/Users/dathao/Downloads/AI/git-final-practice/erd-order-management/erd_chen_model.png")
