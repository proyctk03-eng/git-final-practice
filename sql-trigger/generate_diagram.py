import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch

plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_trigger_diagram():
    fig, ax = plt.subplots(figsize=(22, 14), dpi=300)
    ax.set_xlim(0, 26)
    ax.set_ylim(0, 18)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Color Palette
    primary_color = '#1E3A8A'      # Deep Navy
    secondary_color = '#0F766E'    # Teal
    accent_amber = '#D97706'       # Amber
    accent_purple = '#6D28D9'      # Purple
    border_color = '#94A3B8'
    bg_subtle = '#F8FAFC'
    text_dark = '#0F172A'
    text_muted = '#475569'

    # Title
    ax.text(13.0, 17.3, "KIEN TRUC VA CO CHE HOAT DONG CUA TRIGGER TRONG MYSQL", 
            fontsize=17, fontweight='bold', ha='center', va='center', color=text_dark)
    ax.text(13.0, 16.7, "Phan tich luong thuc thi BEFORE INSERT, bien gia lap NEW va co che tu dong phan loai phong ban", 
            fontsize=11.5, fontstyle='italic', ha='center', va='center', color=text_muted)

    def draw_box(x, y, w, h, title, title_bg, text_lines=[], badge=None):
        card = FancyBboxPatch((x, y - h), w, h, boxstyle="round,pad=0.02,rounding_size=0.15",
                              linewidth=1.4, edgecolor=border_color, facecolor='#FFFFFF', zorder=3)
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
                ax.text(x + 2.8, curr_y, val, fontsize=9, color=text_dark, zorder=5)
            else:
                ax.text(x + 0.4, curr_y, line, fontsize=9, color=text_dark, zorder=5)
            curr_y -= 0.45

        return {'x': x, 'y': y, 'w': w, 'h': h, 'bottom': y - h}

    # 1. Step 1 Box: Client DML INSERT
    b_client = draw_box(1.0, 15.5, 6.8, 6.4, "1. CAU LENH INSERT (CLIENT)", primary_color, [
        ("Thao tac:", "INSERT INTO employees", '#1E3A8A'),
        ("Du lieu truyen vao:", "('John Doe', 'A', 3500)", '#0284C7'),
        "",
        "Dac diem dau vao:",
        "- Gia tri department ban dau: 'A'",
        "- Muc luong: 3500.00",
        "- Lenh gui toi Database Engine",
        "",
        "Trang thai du lieu:",
        "Chua duoc ghi xuong o dia (Pending)"
    ], badge="Client DML")

    # 2. Step 2 Box: BEFORE INSERT Trigger Engine
    b_trigger = draw_box(9.5, 15.5, 7.8, 6.4, "2. TRIGGER update_department", secondary_color, [
        ("Thoi diem:", "BEFORE INSERT ON employees", '#0F766E'),
        ("Pham vi:", "FOR EACH ROW", '#059669'),
        "",
        "Logic nghiep vu xu ly:",
        "- Doc gia tri: NEW.salary",
        "- IF NEW.salary >= 5000 -> 'Management'",
        "- ELSEIF NEW.salary >= 3000 -> 'Sales'",
        "- ELSE -> 'Support'",
        "",
        "Hanh dong Trigger thuc thi:",
        "-> SET NEW.department = 'Sales';"
    ], badge="BEFORE INSERT")

    # 3. Step 3 Box: Final Table employees Storage
    b_storage = draw_box(18.8, 15.5, 6.2, 6.4, "3. BANG DỮ LIỆU CHÍNH", accent_purple, [
        ("CSDL:", "company", '#6D28D9'),
        ("Bang:", "employees", '#7C3AED'),
        "",
        "Ket qua ban ghi duoc luu:",
        "- id: 1",
        "- name: 'John Doe'",
        "- department: 'Sales' (Da ghi de)",
        "- salary: 3500.00",
        "",
        "Tinh toan ven:",
        "Dong bo hoan toan voi quy tac luong"
    ], badge="Committed Data")

    # Connectors & Arrows
    # Arrow 1: Client -> Trigger
    ax.annotate("", xy=(9.4, 13.0), xytext=(7.9, 13.0),
                arrowprops=dict(arrowstyle="->", lw=2.2, color='#2563EB'))
    ax.text(8.65, 13.35, "Kich hoat\nTrigger", fontsize=8.5,
            fontweight='bold', color='#1D4ED8', ha='center',
            bbox=dict(boxstyle='round,pad=0.2', facecolor='#EFF6FF', edgecolor='#93C5FD', lw=0.8))

    # Arrow 2: Trigger -> Storage
    ax.annotate("", xy=(18.7, 13.0), xytext=(17.4, 13.0),
                arrowprops=dict(arrowstyle="->", lw=2.2, color='#0F766E'))
    ax.text(18.05, 13.35, "Ghi xuong\nBang", fontsize=8.5,
            fontweight='bold', color='#0F766E', ha='center',
            bbox=dict(boxstyle='round,pad=0.2', facecolor='#F0FDF4', edgecolor='#86EFAC', lw=0.8))

    # Bottom Area: Summary of Demo Results & Principles
    box_x, box_y, box_w, box_h = 1.0, 0.8, 24.0, 7.8
    bot_box = FancyBboxPatch((box_x, box_y), box_w, box_h,
                             boxstyle="round,pad=0.05,rounding_size=0.15",
                             linewidth=1.2, edgecolor='#CBD5E1', facecolor=bg_subtle, zorder=2)
    ax.add_patch(bot_box)

    ax.text(box_x + 0.4, box_y + box_h - 0.45, "KET QUA DEMO THUC THE & QUY TAC QUAN TRI TRIGGER TRONG MYSQL:", 
            fontsize=12, fontweight='bold', color=text_dark)

    # Sub-panel 1: Demo Results Table (Left)
    p1_x, p1_y, p1_w, p1_h = 1.5, 1.2, 11.2, 6.4
    p1 = FancyBboxPatch((p1_x, p1_y), p1_w, p1_h, boxstyle="round,pad=0.03,rounding_size=0.12",
                        linewidth=1.0, edgecolor='#93C5FD', facecolor='#EFF6FF', zorder=3)
    ax.add_patch(p1)
    ax.text(p1_x + 0.4, p1_y + p1_h - 0.45, "BANG KET QUA DEMO CHEN DU LIEU (INSERT DEMO):", fontsize=10.2, fontweight='bold', color='#1E3A8A', zorder=4)

    demo_rows = [
        ("John Doe (Lương 3500):", "Dau vao 'A' -> Trigger gan 'Sales' (Vi 3500 >= 3000)"),
        ("Jane Smith (Lương 2000):", "Dau vao 'A' -> Trigger gan 'Support' (Vi 2000 < 3000)"),
        ("David Johnson (Lương 6000):", "Dau vao 'A' -> Trigger gan 'Management' (Vi 6000 >= 5000)"),
        ("Kiem tra sau INSERT:", "SELECT * FROM employees -> Tat ca phong ban duoc cap nhat tu dong!")
    ]
    cur_y = p1_y + p1_h - 1.0
    for title, desc in demo_rows:
        ax.text(p1_x + 0.3, cur_y, title, fontsize=8.8, fontweight='bold', color='#1D4ED8', zorder=4)
        ax.text(p1_x + 0.3, cur_y - 0.35, desc, fontsize=8.2, color='#334155', zorder=4)
        cur_y -= 0.95

    # Sub-panel 2: Best practices & Rules (Right)
    p2_x, p2_y, p2_w, p2_h = 13.3, 1.2, 11.2, 6.4
    p2 = FancyBboxPatch((p2_x, p2_y), p2_w, p2_h, boxstyle="round,pad=0.03,rounding_size=0.12",
                        linewidth=1.0, edgecolor='#FDE68A', facecolor='#FFFBEB', zorder=3)
    ax.add_patch(p2)
    ax.text(p2_x + 0.4, p2_y + p2_h - 0.45, "QUY TAC COT LOI KHI SU DUNG TRIGGER (CORE RULES):", fontsize=10.2, fontweight='bold', color='#B45309', zorder=4)

    rules_rows = [
        ("1. BEFORE vs AFTER:", "BEFORE dung de validate, gan gia tri mac dinh. AFTER dung de ghi audit log."),
        ("2. Bien NEW va OLD:", "NEW co san trong INSERT/UPDATE. OLD co san trong UPDATE/DELETE."),
        ("3. Thay doi gia tri cot:", "Chi co the SET NEW.col trong trigger BEFORE. Trong AFTER la read-only."),
        ("4. Tranh vong lap vo tan:", "Khong duoc thuc hien UPDATE tren chinh bang dang kich hoat trigger do."),
        ("5. Ghi log kiem toan:", "Ket hop AFTER UPDATE de ghi vet lich su luong vao bang salary_audit.")
    ]
    cur_y = p2_y + p2_h - 1.0
    for title, desc in rules_rows:
        ax.text(p2_x + 0.3, cur_y, title, fontsize=8.8, fontweight='bold', color='#92400E', zorder=4)
        ax.text(p2_x + 0.3, cur_y - 0.35, desc, fontsize=8.2, color='#334155', zorder=4)
        cur_y -= 0.95

    out_file1 = "c:/Users/dathao/Downloads/AI/git-final-practice/sql-trigger/trigger_architecture.png"
    out_file2 = "c:/Users/dathao/Downloads/AI/sql-trigger/trigger_architecture.png"
    plt.tight_layout()
    plt.savefig(out_file1, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.savefig(out_file2, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Generated Trigger Diagram: {out_file1}")

if __name__ == "__main__":
    draw_trigger_diagram()
