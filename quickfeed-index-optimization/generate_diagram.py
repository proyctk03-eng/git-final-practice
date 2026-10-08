import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch

plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_quickfeed_diagram():
    fig, ax = plt.subplots(figsize=(24, 15), dpi=300)
    ax.set_xlim(0, 28)
    ax.set_ylim(0, 19)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Color Palette
    danger_color = '#DC2626'      # Red
    success_color = '#16A34A'     # Green
    primary_color = '#1E3A8A'     # Navy
    secondary_color = '#0F766E'   # Teal
    amber_color = '#D97706'       # Amber
    border_color = '#94A3B8'
    bg_subtle = '#F8FAFC'
    text_dark = '#0F172A'
    text_muted = '#475569'

    # Title
    ax.text(14.0, 18.2, "THAM HOA OVER-INDEXING & GIAI PHAP TOI UU HOA TAI MANG XA HOI QUICKFEED", 
            fontsize=17, fontweight='bold', ha='center', va='center', color=text_dark)
    ax.text(14.0, 17.6, "Danh gia su danh doi Read vs Write, do phan giai Cardinality va co che giai phong tai nguyen dia/RAM", 
            fontsize=11.5, fontstyle='italic', ha='center', va='center', color=text_muted)

    def draw_card(x, y, w, h, title, title_bg, text_lines=[], badge=None, border_c=border_color):
        card = FancyBboxPatch((x, y - h), w, h, boxstyle="round,pad=0.02,rounding_size=0.15",
                              linewidth=1.4, edgecolor=border_c, facecolor='#FFFFFF', zorder=3)
        ax.add_patch(card)

        header_h = 0.65
        hdr = FancyBboxPatch((x, y - header_h), w, header_h, boxstyle="round,pad=0.02,rounding_size=0.15",
                             linewidth=0, facecolor=title_bg, zorder=4)
        ax.add_patch(hdr)
        ax.fill([x, x + w, x + w, x], [y - header_h, y - header_h, y - header_h + 0.1, y - header_h + 0.1],
                color=title_bg, zorder=4)

        ax.text(x + 0.4, y - header_h/2, title, fontsize=11, fontweight='bold',
                ha='left', va='center', color='#FFFFFF', zorder=5)

        if badge:
            badge_w = len(badge) * 0.16 + 0.4
            badge_box = FancyBboxPatch((x + w - badge_w - 0.2, y - header_h/2 - 0.16), badge_w, 0.32,
                                       boxstyle="round,pad=0.02,rounding_size=0.08",
                                       linewidth=0, facecolor='#FFFFFF', alpha=0.25, zorder=5)
            ax.add_patch(badge_box)
            ax.text(x + w - 0.3, y - header_h/2, badge, fontsize=8.5, fontweight='bold',
                    ha='right', va='center', color='#FFFFFF', zorder=6)

        curr_y = y - header_h - 0.4
        for line in text_lines:
            if isinstance(line, tuple):
                label, val, color = line
                ax.text(x + 0.4, curr_y, label, fontsize=9.2, fontweight='bold', color=color, zorder=5)
                ax.text(x + 3.2, curr_y, val, fontsize=9, color=text_dark, zorder=5)
            else:
                ax.text(x + 0.4, curr_y, line, fontsize=9, color=text_dark, zorder=5)
            curr_y -= 0.45

        return {'x': x, 'y': y, 'w': w, 'h': h, 'bottom': y - h}

    # 1. Left Card: Before Optimization (The Disaster)
    draw_card(1.0, 16.5, 8.2, 7.8, "1. TRƯỚC TỐI ƯU (OVER-INDEXING)", danger_color, [
        ("So luong Index:", "6 Indexes (1 PK + 5 Secondary)", danger_color),
        ("Hau qua ghi (Write):", "Timeout 5 - 10 giay khi dang status", danger_color),
        ("Dung luong dia:", "Index chiem gap 2 lan Data thuc te!", danger_color),
        "",
        "Chi phi ngam cho 1 lenh INSERT:",
        "- Cap nhat Clustered Index (PRIMARY)",
        "- Cap nhat idx_user_id (B-Tree write)",
        "- Cap nhat idx_content(255) (TEXT lon)",
        "- Cap nhat idx_post_type (B-Tree rebalance)",
        "- Cap nhat idx_is_visible (Page splits)",
        "- Cap nhat idx_created_at (B-Tree write)",
        "-> 6 lan ghi dia ngau nhien (Random I/O)!"
    ], badge="Thảm Họa Ghi", border_c='#FCA5A5')

    # 2. Middle Card: Decision Matrix (Cardinality Analysis)
    draw_card(10.0, 16.5, 8.0, 7.8, "2. MA TRẬN QUYẾT ĐỊNH (DECISION MATRIX)", primary_color, [
        ("idx_user_id:", "GIU LAI | Cardinality cao (Loc user)", success_color),
        ("idx_content(255):", "DROP | Text dai, ton dia, nen dung FTS", danger_color),
        ("idx_post_type:", "DROP | Cardinality = 3, kem hieu qua", danger_color),
        ("idx_is_visible:", "DROP | Cardinality = 2, Optimizer bo qua", danger_color),
        ("idx_created_at:", "GIU LAI | Cardinality cao, sort timeline", success_color),
        "",
        "Cong thuc Selectivity:",
        "  Selectivity = Cardinality / Total Rows",
        "- idx_is_visible: 2 / 1,000,000 = 0.0002% (Vo dung)",
        "- idx_post_type: 3 / 1,000,000 = 0.0003% (Bo qua)",
        "- idx_user_id: 50,000 / 1,000,000 = 5% (Rat tot)"
    ], badge="Audit Index", border_c='#93C5FD')

    # 3. Right Card: After Optimization (Recovered System)
    draw_card(18.8, 16.5, 8.2, 7.8, "3. SAU TỐI ƯU (SLIM & OPTIMIZED)", success_color, [
        ("So luong Index:", "3 Indexes (1 PK + 2 Secondary)", success_color),
        ("Hau qua ghi (Write):", "INSERT tuc thi (< 15 milliseconds)", success_color),
        ("Dung luong dia:", "Giai phong > 60% bo nho Index", success_color),
        "",
        "Loi ich van hanh dat duoc:",
        "- Giam 3 lan thao tac B-Tree updates",
        "- Giai phong RAM trong InnoDB Buffer Pool",
        "- Triet tieu tinh trang tranh chap Page Lock",
        "- Query Optimizer khong bi roi loan ke hoach",
        "- He thong khong con nguy co can kiet o cung",
        "-> Can bang hoan hao giua Read va Write!"
    ], badge="He Thong On Dinh", border_c='#86EFAC')

    # Connectors & Arrows
    ax.annotate("", xy=(9.8, 12.5), xytext=(9.3, 12.5),
                arrowprops=dict(arrowstyle="->", lw=2.2, color='#2563EB'))
    ax.annotate("", xy=(18.6, 12.5), xytext=(18.1, 12.5),
                arrowprops=dict(arrowstyle="->", lw=2.2, color='#15803D'))

    # Bottom Area: 3 Oral Defense Q&A Panels
    box_x, box_y, box_w, box_h = 1.0, 0.6, 26.0, 7.6
    bot_box = FancyBboxPatch((box_x, box_y), box_w, box_h,
                             boxstyle="round,pad=0.05,rounding_size=0.15",
                             linewidth=1.2, edgecolor='#CBD5E1', facecolor=bg_subtle, zorder=2)
    ax.add_patch(bot_box)

    ax.text(box_x + 0.4, box_y + box_h - 0.45, "BAO VE GIAI PHAP - 3 CAU HOI VAN DAP CHUYEN SAU VOI TECH LEAD (ORAL DEFENSE):", 
            fontsize=12, fontweight='bold', color=text_dark)

    qa_panels = [
        (1.5, 1.0, 8.0, 6.2, "CAU HOI 1: TAI SAO INSERT BI TIMEOUT?", [
            ("Hien tuong o tang vat ly:", "Khi co 5 secondary indexes, 1 lenh INSERT phai ghi 1 dong du lieu va cap nhat 5 cay B-Tree phu tro."),
            ("Random Disk I/O:", "Cac secondary key nam rai rac tren nhieu trang dia khac nhau, buoc he thong doc/ghi dia ngau nhien."),
            ("Page Splits & Lock:", "Khi trang B-Tree bi day, InnoDB phai chia tach trang (Page Split), khoa doc/ghi gay nghẽn dong va Timeout nguoi dung.")
        ], '#1E3A8A', '#EFF6FF', '#BFDBFE'),

        (10.0, 1.0, 8.0, 6.2, "CAU HOI 2: CARDINALITY & COT BOOLEAN", [
            ("Dinh nghia Cardinality:", "So luong cac gia tri duy nhat (Unique values) trong mot cot cua co so du lieu."),
            ("Tai sao Boolean lai toi te?", "Cot is_visible chi co 2 gia tri (0 va 1). Ty le chon loc (Selectivity) cuc kem khi 95% dong la 1."),
            ("Optimizer tu choi Index:", "Chi phi duyet Index roi doc nguoc lai Clustered Index (Bookmark Lookup) dat hon quet thang toan bang (Full Table Scan).")
        ], '#B45309', '#FFFBEB', '#FDE68A'),

        (18.5, 1.0, 8.0, 6.2, "CAU HOI 3: BANG ARCHIVE LICH SU CO SAO KHONG?", [
            ("Ban chat bang Archive:", "Bang chi doc (Read-only / OLAP), du lieu chi doc vao theo lo (Batch ETL) vao ban dem va khong co UPDATE/DELETE."),
            ("Khong phai tham hoa:", "Vi khong co nguoi dung thao tac INSERT truc tiep nen chi phi ghi bi loai bo hoan toan."),
            ("Uu tien toi da toc do Read:", "Nhieu Index tren bang Archive giup bao cao phan tich, thong ke du lieu chay voi toc do toi da.")
        ], '#0F766E', '#F0FDF4', '#BBF7D0')
    ]

    for px, py, pw, ph, qtitle, items, tcol, bgcol, bcol in qa_panels:
        pbox = FancyBboxPatch((px, py), pw, ph, boxstyle="round,pad=0.03,rounding_size=0.12",
                              linewidth=1.0, edgecolor=bcol, facecolor=bgcol, zorder=3)
        ax.add_patch(pbox)
        ax.text(px + 0.3, py + ph - 0.42, qtitle, fontsize=9.2, fontweight='bold', color=tcol, zorder=4)

        cy = py + ph - 0.95
        for htitle, hdesc in items:
            ax.text(px + 0.3, cy, htitle, fontsize=8.6, fontweight='bold', color=tcol, zorder=4)
            ax.text(px + 0.3, cy - 0.32, hdesc, fontsize=8.0, color='#334155', zorder=4)
            cy -= 0.88

    out_file1 = "c:/Users/dathao/Downloads/AI/git-final-practice/quickfeed-index-optimization/quickfeed_index_tradeoff.png"
    out_file2 = "c:/Users/dathao/Downloads/AI/quickfeed-index-optimization/quickfeed_index_tradeoff.png"
    plt.tight_layout()
    plt.savefig(out_file1, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.savefig(out_file2, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Generated QuickFeed Diagram: {out_file1}")

if __name__ == "__main__":
    draw_quickfeed_diagram()
