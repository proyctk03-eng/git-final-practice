import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch

plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_smartfactory_diagram():
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
    border_color = '#94A3B8'
    bg_subtle = '#F8FAFC'
    text_dark = '#0F172A'
    text_muted = '#475569'

    # Title
    ax.text(14.0, 18.2, "TOI UU HOA INDEX HE THONG IOT SMARTFACTORY: CAN BANG READ - WRITE - STORAGE", 
            fontsize=17, fontweight='bold', ha='center', va='center', color=text_dark)
    ax.text(14.0, 17.6, "Phan tich su danh doi giua Fat Covering Index va Lean Search Index, Write Penalty va chi phi Cloud AWS", 
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
                ax.text(x + 3.4, curr_y, val, fontsize=9, color=text_dark, zorder=5)
            else:
                ax.text(x + 0.4, curr_y, line, fontsize=9, color=text_dark, zorder=5)
            curr_y -= 0.45

        return {'x': x, 'y': y, 'w': w, 'h': h, 'bottom': y - h}

    # 1. Left Card: Fat Covering Index (Disaster)
    draw_card(1.0, 16.5, 8.2, 7.8, "1. FAT COVERING INDEX (THAM HOA)", danger_color, [
        ("Khoa Index:", "(sensor_id, time, temp, humi, status)", danger_color),
        ("Kich thuoc dong Index:", "~50 - 55 Bytes / Ban ghi", danger_color),
        ("Hau qua Ghi (Write):", "Pipeline DROP record, INSERT bi nghen", danger_color),
        ("Hoa don AWS SSD:", "Tang gap 4 lan (Index > Data!)", danger_color),
        "",
        "Co che gay sup do:",
        "- Nhiet do / do am bien dong lien tuc",
        "- B-Tree phai rebalance & split khap noi",
        "- Random I/O pha huy throughput ghi",
        "- Uu diem duy nhat: SELECT doc tren Index",
        "-> Danh doi bat hop ly cho he thong IoT!"
    ], badge="Write Bottleneck", border_c='#FCA5A5')

    # 2. Middle Card: The Architecture Trade-off
    draw_card(10.0, 16.5, 8.0, 7.8, "2. SO SANH KE HOACH EXPLAIN", primary_color, [
        ("Cau truy van:", "SELECT temp, humi, status WHERE sensor_id & time", '#1E3A8A'),
        "",
        "Truoc toi uu (Covering Index):",
        "- key: idx_fat_covering",
        "- Extra: Using index (Khong cham o cung)",
        "- Danh doi: Ghi bi pha huy hoan toan!",
        "",
        "Sau toi uu (Lean Index):",
        "- key: idx_lean_search",
        "- type: range (Loc thoi gian van cuc nhanh)",
        "- Extra: Bookmark Lookup bang goc",
        "- Thoi gian doc: ~0.2ms (Dashboard van muot!)",
        "-> Toc do Ghi phuc hoi gap 5 lan!"
    ], badge="EXPLAIN Plan", border_c='#93C5FD')

    # 3. Right Card: Lean Search Index (Optimized Solution)
    draw_card(18.8, 16.5, 8.2, 7.8, "3. LEAN SEARCH INDEX (TINH GON)", success_color, [
        ("Khoa Index:", "(sensor_id, recorded_at) + log_id", success_color),
        ("Kich thuoc dong Index:", "~17 - 22 Bytes / Ban ghi", success_color),
        ("Hieu qua Ghi (Write):", "Throughput tang 5x, khong rot record", success_color),
        ("Dung luong Index:", "Giam ngay lap tuc > 65% - 70%", success_color),
        "",
        "Loi ich van hanh dat duoc:",
        "- Khoa (sensor_id, time) tang tuan tu",
        "- Ghi vao mep phai B-Tree (Right-edge appends)",
        "- Triet tieu phan manh & Page Split",
        "- Hoa don AWS SSD giam tro lai muc chuan",
        "- Dashboard van chay sieu toc (< 1ms)"
    ], badge="Optimal Balance", border_c='#86EFAC')

    # Connectors
    ax.annotate("", xy=(9.8, 12.5), xytext=(9.3, 12.5),
                arrowprops=dict(arrowstyle="->", lw=2.2, color='#2563EB'))
    ax.annotate("", xy=(18.6, 12.5), xytext=(18.1, 12.5),
                arrowprops=dict(arrowstyle="->", lw=2.2, color='#15803D'))

    # Bottom Area: 3 Defense Questions for Cloud Financial Controller
    box_x, box_y, box_w, box_h = 1.0, 0.6, 26.0, 7.6
    bot_box = FancyBboxPatch((box_x, box_y), box_w, box_h,
                             boxstyle="round,pad=0.05,rounding_size=0.15",
                             linewidth=1.2, edgecolor='#CBD5E1', facecolor=bg_subtle, zorder=2)
    ax.add_patch(bot_box)

    ax.text(box_x + 0.4, box_y + box_h - 0.45, "BAO VE DANH GIA - 3 CAU HOI VAN DAP VOI CLOUD FINANCIAL CONTROLLER:", 
            fontsize=12, fontweight='bold', color=text_dark)

    qa_panels = [
        (1.5, 1.0, 8.0, 6.2, "CAU 1: BANG COUNTRIES IT SUA CO SAO KHONG?", [
            ("Bang it thay doi:", "Bang danh muc quoc gia (Countries) gan nhu chi doc (Read-only), rat hiem khi INSERT/UPDATE."),
            ("Covering Index la toi uu:", "Khong phai 'toi ac' ma la thiet ke cuc tot! Giup truy van doc chay 100% tren RAM, khong cham o dia."),
            ("Ket luan:", "Chi phi Write Penalty chi xay ra khi co thao tac ghi lien tuc (nhu he thong IoT).")
        ], '#1E3A8A', '#EFF6FF', '#BFDBFE'),

        (10.0, 1.0, 8.0, 6.2, "CAU 2: KHAI NIEM 'WRITE PENALTY' LA GI?", [
            ("Dinh nghia Write Penalty:", "Hinh phat ve do tre va tai nguyen I/O ma he thong phai tra cho moi thao tac INSERT/UPDATE."),
            ("Tai sao them cot lam cham?", "Moi cot them vao lam tang kich thuoc dong Index, lam giam so ban ghi tren moi trang 16KB."),
            ("Page Split thuong xuyen:", "Cac cot bien dong lam cay B-Tree phai tach trang lien tuc, gay Random Disk I/O va khoa trang.")
        ], '#B45309', '#FFFBEB', '#FDE68A'),

        (18.5, 1.0, 8.0, 6.2, "CAU 3: THAY VARCHAR(20) BANG TINYINT?", [
            ("Tac dong den Data Length:", "VARCHAR(20) utf8mb4 chiem 1 byte length + toi da 80 bytes. TINYINT chi ton dung 1 byte."),
            ("Tac dong den Index Length:", "Neu dua status vao Index, TINYINT tiet kiem hang chuc bytes tren moi nut la B-Tree."),
            ("Loi khuyen kien truc:", "Voi he thong IoT ghi nhieu, giai phap dung nhat la bo han status khoi Index, chi de lai 2 cot loc!")
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

    out_file1 = "c:/Users/dathao/Downloads/AI/git-final-practice/smartfactory-index-tradeoff/smartfactory_index_tradeoff.png"
    out_file2 = "c:/Users/dathao/Downloads/AI/smartfactory-index-tradeoff/smartfactory_index_tradeoff.png"
    plt.tight_layout()
    plt.savefig(out_file1, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.savefig(out_file2, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Generated SmartFactory Diagram: {out_file1}")

if __name__ == "__main__":
    draw_smartfactory_diagram()
