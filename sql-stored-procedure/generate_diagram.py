import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch

plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_stored_procedure_diagram():
    fig, ax = plt.subplots(figsize=(22, 14), dpi=300)
    ax.set_xlim(0, 26)
    ax.set_ylim(0, 18)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Color Palette
    primary_color = '#1E3A8A'      # Deep Navy
    secondary_color = '#0F766E'    # Teal
    accent_blue = '#2563EB'        # Royal Blue
    accent_purple = '#6D28D9'      # Purple
    border_color = '#94A3B8'
    bg_subtle = '#F8FAFC'
    text_dark = '#0F172A'
    text_muted = '#475569'

    # Title
    ax.text(13.0, 17.3, "KIEN TRUC VA CO CHE THUC THI STORED PROCEDURE TRONG MYSQL", 
            fontsize=17, fontweight='bold', ha='center', va='center', color=text_dark)
    ax.text(13.0, 16.7, "Mo hinh hoa luong goi CALL procedureName(), bo nho dem Execution Plan Cache va so sanh hieu nang", 
            fontsize=11.5, fontstyle='italic', ha='center', va='center', color=text_muted)

    def draw_card(x, y, w, h, title, title_bg, text_lines=[], badge=None):
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

    # 1. Left Component: Application Client (Web App / API)
    c_client = draw_card(1.0, 15.5, 6.5, 6.2, "1. APPLICATION CLIENT", primary_color, [
        ("Vai tro:", "Giao dien / Chuong trinh nguoi dung", '#1E3A8A'),
        ("Giao thuc:", "TCP/IP Socket toi MySQL Server", '#0284C7'),
        "",
        "Lenh truyen qua mang:",
        "  -> CALL findAllCustomers();",
        "  -> CALL getCustomerById(175);",
        "",
        "Dac diem noi bat:",
        "- Chi gui chuoi ngan chua ten thu tuc",
        "- Giam toi da payload truyen tai mang",
        "- Che giau cau truc bang va logic SQL"
    ], badge="Client App")

    # 2. Middle Component: MySQL Database Engine (Compilation & Cache)
    c_engine = draw_card(9.5, 15.5, 8.0, 6.2, "2. MYSQL SERVER ENGINE", secondary_color, [
        ("Bien dich:", "Parse & Compile 1 lan duy nhat", '#0F766E'),
        ("Luu tru:", "Procedure Cache / Plan Cache (RAM)", '#059669'),
        "",
        "Quy trinh xu ly ben trong:",
        "1. Kiem tra xem Procedure da compile chua",
        "2. Lay san Execution Plan tu RAM",
        "3. Bo qua cong doan Parser & Optimizer",
        "4. Thuc thi truc tiep voi toc do cuc cao",
        "",
        "Lenh quan ly:",
        "- DELIMITER // ... END // DELIMITER ;",
        "- DROP PROCEDURE IF EXISTS"
    ], badge="Database Server")

    # 3. Right Component: Database & Table Storage (classicmodels.customers)
    c_storage = draw_card(19.5, 15.5, 5.5, 6.2, "3. STORAGE & DATA", accent_purple, [
        ("CSDL:", "classicmodels", '#6D28D9'),
        ("Bang:", "customers", '#7C3AED'),
        "",
        "Cot du lieu tieu bieu:",
        "- customerNumber (PK: 175)",
        "- customerName ('Gift Depot Inc.')",
        "- contactLastName ('King')",
        "- contactFirstName ('Julie')",
        "- phone ('2035552570')",
        "- city ('Bridgewater'), country ('USA')",
        "- creditLimit (84300.00)"
    ], badge="Storage")

    # Connectors & Arrows between components
    # Arrow 1: Client -> Engine (CALL procedure)
    ax.annotate("", xy=(9.4, 13.5), xytext=(7.6, 13.5),
                arrowprops=dict(arrowstyle="->", lw=2.2, color='#2563EB'))
    ax.text(8.5, 13.85, "CALL findAllCustomers()\n(Payload rat nho)", fontsize=8.5,
            fontweight='bold', color='#1D4ED8', ha='center',
            bbox=dict(boxstyle='round,pad=0.2', facecolor='#EFF6FF', edgecolor='#93C5FD', lw=0.8))

    # Arrow 2: Engine -> Storage (Fetch Data)
    ax.annotate("", xy=(19.4, 13.5), xytext=(17.6, 13.5),
                arrowprops=dict(arrowstyle="->", lw=2.2, color='#7C3AED'))
    ax.text(18.5, 13.85, "Query Engine\nDoc du lieu ban ghi", fontsize=8.5,
            fontweight='bold', color='#6D28D9', ha='center',
            bbox=dict(boxstyle='round,pad=0.2', facecolor='#F5F3FF', edgecolor='#C4B5FD', lw=0.8))

    # Arrow 3: Return Result Set from Engine back to Client
    ax.annotate("", xy=(7.6, 11.2), xytext=(9.4, 11.2),
                arrowprops=dict(arrowstyle="->", lw=2.0, color='#15803D', linestyle='dashed'))
    ax.text(8.5, 10.75, "Tra ve Result Set\n(Ket qua ban ghi)", fontsize=8.5,
            fontweight='bold', color='#15803D', ha='center',
            bbox=dict(boxstyle='round,pad=0.2', facecolor='#F0FDF4', edgecolor='#86EFAC', lw=0.8))

    # Bottom Section: Comparison & Best Practices (2 Comparison Panels)
    box_x, box_y, box_w, box_h = 1.0, 0.8, 24.0, 7.6
    comp_box = FancyBboxPatch((box_x, box_y), box_w, box_h,
                              boxstyle="round,pad=0.05,rounding_size=0.15",
                              linewidth=1.2, edgecolor='#CBD5E1', facecolor=bg_subtle, zorder=2)
    ax.add_patch(comp_box)

    ax.text(box_x + 0.4, box_y + box_h - 0.45, "PHAN TICH TOAN DIEN: UU DIEM, NHUOC DIEM & QUY TAC QUAN TRI STORED PROCEDURE", 
            fontsize=12, fontweight='bold', color=text_dark)

    # Sub-panel 1: Ưu điểm (Left)
    p1_x, p1_y, p1_w, p1_h = 1.5, 1.2, 11.2, 6.2
    p1 = FancyBboxPatch((p1_x, p1_y), p1_w, p1_h, boxstyle="round,pad=0.03,rounding_size=0.12",
                        linewidth=1.0, edgecolor='#86EFAC', facecolor='#F0FDF4', zorder=3)
    ax.add_patch(p1)
    ax.text(p1_x + 0.4, p1_y + p1_h - 0.45, "UU DIEM VUOT TROI (ADVANTAGES):", fontsize=10.5, fontweight='bold', color='#166534', zorder=4)

    adv_items = [
        ("1. Hieu nang cao hon (Compiled Once):", "Bien dich san tai server, bo qua overhead phan tich cu phap moi khi goi."),
        ("2. Giam tai bang thong (Network Traffic):", "Thay vi gui doan SQL dai, client chi can truyen lenh ngan gon: CALL procName()."),
        ("3. Dong goi & Bao mat (Encapsulation):", "Phan quyen cho user thuc thi (EXECUTE) ma khong can cap quyen truc tiep tren bang."),
        ("4. De dang tai su dung (Reusability):", "Logic nghiep vu tap trung tai CSDL, duoc tai su dung boi nhieu ung dung khac nhau."),
        ("5. Giam rui ro SQL Injection:", "Tham so truyen vao duoc tham so hoa tu dong, ngan chan ma doc chen vao truy van.")
    ]
    cur_y = p1_y + p1_h - 1.0
    for title, desc in adv_items:
        ax.text(p1_x + 0.3, cur_y, title, fontsize=8.8, fontweight='bold', color='#15803D', zorder=4)
        ax.text(p1_x + 0.3, cur_y - 0.32, desc, fontsize=8.2, color='#334155', zorder=4)
        cur_y -= 0.88

    # Sub-panel 2: Nhược điểm & Lưu ý (Right)
    p2_x, p2_y, p2_w, p2_h = 13.3, 1.2, 11.2, 6.2
    p2 = FancyBboxPatch((p2_x, p2_y), p2_w, p2_h, boxstyle="round,pad=0.03,rounding_size=0.12",
                        linewidth=1.0, edgecolor='#FCA5A5', facecolor='#FEF2F2', zorder=3)
    ax.add_patch(p2)
    ax.text(p2_x + 0.4, p2_y + p2_h - 0.45, "NHUOC DIEM & LUU Y QUAN TRI (DISADVANTAGES & RULES):", fontsize=10.5, fontweight='bold', color='#991B1B', zorder=4)

    disadv_items = [
        ("1. Tieu ton tai nguyen RAM Server:", "Neu tao qua nhieu Procedure, MySQL ton bo nho dem de luu tru cache thu tuc."),
        ("2. Gia tang tai CPU cho Database:", "Cac xu ly vong lap, dieu kien phuc tap nen day len App tier thay vi DB server."),
        ("3. Kho Debug va kiem thu:", "MySQL khong ho tro cong cu Debug Stored Procedure manh me nhu SQL Server/Oracle."),
        ("4. Khong ho tro ALTER sua than thu tuc:", "Phai dung co che DROP PROCEDURE IF EXISTS sau do CREATE PROCEDURE lai."),
        ("5. Can thay doi DELIMITER khi khai bao:", "Bat buoc doi DELIMITER // de trinh bien dich nhan dien dung khoi BEGIN...END.")
    ]
    cur_y = p2_y + p2_h - 1.0
    for title, desc in disadv_items:
        ax.text(p2_x + 0.3, cur_y, title, fontsize=8.8, fontweight='bold', color='#B91C1C', zorder=4)
        ax.text(p2_x + 0.3, cur_y - 0.32, desc, fontsize=8.2, color='#334155', zorder=4)
        cur_y -= 0.88

    out_file1 = "c:/Users/dathao/Downloads/AI/git-final-practice/sql-stored-procedure/stored_procedure_architecture.png"
    out_file2 = "c:/Users/dathao/Downloads/AI/sql-stored-procedure/stored_procedure_architecture.png"
    plt.tight_layout()
    plt.savefig(out_file1, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.savefig(out_file2, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Generated Stored Procedure Diagram: {out_file1}")

if __name__ == "__main__":
    draw_stored_procedure_diagram()
