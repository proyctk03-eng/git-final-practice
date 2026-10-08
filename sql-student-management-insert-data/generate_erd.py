import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch

plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_student_mgmt_erd():
    fig, ax = plt.subplots(figsize=(19, 13), dpi=300)
    ax.set_xlim(0, 25)
    ax.set_ylim(0, 17)
    ax.axis('off')
    fig.patch.set_facecolor('#FFFFFF')

    # Color Palette
    header_class = '#1E3A8A'      # Navy
    header_student = '#0F766E'    # Teal
    header_subject = '#B45309'    # Amber
    header_mark = '#6D28D9'       # Violet (Bridge / detail table)
    pk_color = '#B45309'          # Amber
    fk_color = '#1D4ED8'          # Blue
    text_color = '#1E293B'
    data_type_color = '#64748B'
    line_color = '#334155'

    # Title
    ax.text(12.5, 16.3, "SƠ ĐỒ THỰC THỂ LIÊN KẾT (ERD) - CƠ SỞ DỮ LIỆU QUẢN LÝ SINH VIÊN", 
            fontsize=17, fontweight='bold', ha='center', va='center', color='#0F172A')
    ax.text(12.5, 15.7, "Cơ sở dữ liệu QuanLySinhVien: Class (Lớp), Student (Học viên), Subject (Môn học), Mark (Điểm thi)", 
            fontsize=11.5, fontstyle='italic', ha='center', va='center', color='#475569')

    def draw_table(x, y, w, title, columns, header_bg):
        row_height = 0.42
        header_height = 0.6
        total_height = header_height + len(columns) * row_height

        box = FancyBboxPatch((x, y - total_height), w, total_height,
                             boxstyle="round,pad=0.02,rounding_size=0.12",
                             linewidth=1.5, edgecolor='#94A3B8', facecolor='#FFFFFF', zorder=3)
        ax.add_patch(box)

        header_box = FancyBboxPatch((x, y - header_height), w, header_height,
                                    boxstyle="round,pad=0.02,rounding_size=0.12",
                                    linewidth=0, facecolor=header_bg, zorder=4)
        ax.add_patch(header_box)
        ax.fill([x, x + w, x + w, x], [y - header_height, y - header_height, y - header_height + 0.1, y - header_height + 0.1],
                color=header_bg, zorder=4)

        ax.text(x + w/2, y - header_height/2, title, fontsize=11, fontweight='bold',
                ha='center', va='center', color='#FFFFFF', zorder=5)

        curr_y = y - header_height
        for i, col in enumerate(columns):
            curr_y -= row_height
            if i % 2 == 1:
                row_bg = patches.Rectangle((x, curr_y), w, row_height,
                                          facecolor='#F8FAFC', edgecolor='none', zorder=3.5)
                ax.add_patch(row_bg)

            key_type, col_name, data_type = col

            badge_x = x + 0.2
            if "PK" in key_type and "FK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "PK,FK", fontsize=8, fontweight='bold', color='#7C3AED', va='center', zorder=5)
            elif "PK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "PK", fontsize=8, fontweight='bold', color=pk_color, va='center', zorder=5)
            elif "FK" in key_type:
                ax.text(badge_x, curr_y + row_height/2, "FK", fontsize=8, fontweight='bold', color=fk_color, va='center', zorder=5)

            name_x = x + 1.1
            font_wt = 'bold' if ("PK" in key_type) else 'normal'
            ax.text(name_x, curr_y + row_height/2, col_name, fontsize=9, fontweight=font_wt, color=text_color, va='center', zorder=5)

            type_x = x + w - 0.25
            ax.text(type_x, curr_y + row_height/2, data_type, fontsize=8, fontstyle='italic', color=data_type_color, ha='right', va='center', zorder=5)

        return {'x': x, 'y': y, 'w': w, 'h': total_height, 'bottom': y - total_height}

    def draw_connector(p1, p2, label_start="1", label_end="N", style="straight"):
        x1, y1 = p1
        x2, y2 = p2
        if style == "orthogonal":
            mid_x = (x1 + x2) / 2
            ax.plot([x1, mid_x, mid_x, x2], [y1, y1, y2, y2], color=line_color, lw=1.6, zorder=2)
        else:
            ax.plot([x1, x2], [y1, y2], color=line_color, lw=1.6, zorder=2)

        ax.text(x1, y1, label_start, fontsize=9.5, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)
        ax.text(x2, y2, label_end, fontsize=9.5, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)

    # 1. Table Class (Top Left)
    t_class = draw_table(1.5, 14.5, 4.8, "Class (Lớp học)", [
        ("PK", "ClassID", "INT AUTO_INC"),
        ("", "ClassName", "VARCHAR(60) NOT NULL"),
        ("", "StartDate", "DATETIME NOT NULL"),
        ("", "Status", "BIT")
    ], header_class)

    # 2. Table Student (Top Center)
    t_student = draw_table(9.5, 14.5, 5.5, "Student (Học viên)", [
        ("PK", "StudentId", "INT AUTO_INC"),
        ("", "StudentName", "VARCHAR(30) NOT NULL"),
        ("", "Address", "VARCHAR(50)"),
        ("", "Phone", "VARCHAR(20)"),
        ("", "Status", "BIT"),
        ("FK", "ClassId", "INT NOT NULL")
    ], header_student)

    # 3. Table Subject (Top Right)
    t_subject = draw_table(18.0, 14.5, 5.2, "Subject (Môn học)", [
        ("PK", "SubId", "INT AUTO_INC"),
        ("", "SubName", "VARCHAR(30) NOT NULL"),
        ("", "Credit", "TINYINT (>= 1)"),
        ("", "Status", "BIT DEFAULT 1")
    ], header_subject)

    # 4. Table Mark (Bottom Center)
    t_mark = draw_table(10.0, 9.2, 5.8, "Mark (Bảng điểm)", [
        ("PK", "MarkId", "INT AUTO_INC"),
        ("FK", "SubId", "INT NOT NULL"),
        ("FK", "StudentId", "INT NOT NULL"),
        ("", "Mark", "FLOAT (0 - 100)"),
        ("", "ExamTimes", "TINYINT DEFAULT 1")
    ], header_mark)

    # Connectors
    # Class (1) -> (N) Student
    draw_connector((t_class['x'] + t_class['w'], 13.0), (t_student['x'], 13.0), label_start="1", label_end="N", style="straight")

    # Student (1) -> (N) Mark
    draw_connector((t_student['x'] + t_student['w']/2 - 0.5, t_student['bottom']), (t_mark['x'] + 1.2, t_mark['y']), label_start="1", label_end="N", style="straight")

    # Subject (1) -> (N) Mark
    draw_connector((t_subject['x'] + 1.0, t_subject['bottom']), (t_mark['x'] + t_mark['w'] - 1.0, t_mark['y']), label_start="1", label_end="N", style="straight")

    # Data Summary Card Box (Bottom Area)
    box_x, box_y, box_w, box_h = 1.5, 0.8, 22.0, 5.2
    exp_box = FancyBboxPatch((box_x, box_y), box_w, box_h,
                             boxstyle="round,pad=0.05,rounding_size=0.15",
                             linewidth=1.2, edgecolor='#CBD5E1', facecolor='#F8FAFC', zorder=2)
    ax.add_patch(exp_box)

    ax.text(box_x + 0.4, box_y + box_h - 0.45, "TỔNG HỢP DỮ LIỆU ĐÃ CHÈN (INSERT INTO SUMMARY):", fontsize=11, fontweight='bold', color='#1E293B')

    data_summary = [
        ("1. Bảng Class (3 bản ghi):", "ClassID: 1 ('A1', 20/12/2008, 1) | ClassID: 2 ('A2', 22/12/2008, 1) | ClassID: 3 ('B3', CurrentDate, 0)"),
        ("2. Bảng Student (3 bản ghi):", "Hung (Ha Noi, 0912113113, Lớp A1) | Hoa (Hai phong, Phone: NULL, Lớp A1) | Manh (HCM, 0123123123, Lớp A2)"),
        ("3. Bảng Subject (4 bản ghi):", "Batch Insert: 1 - CF (5 tín chỉ) | 2 - C (6 tín chỉ) | 3 - HDJ (5 tín chỉ) | 4 - RDBMS (10 tín chỉ)"),
        ("4. Bảng Mark (3 bản ghi):", "Hung thi CF: 8đ (Lần 1) | Hoa thi CF: 10đ (Lần 2) | Hung thi C: 12đ (Lần 1)")
    ]

    cur_ty = box_y + box_h - 1.0
    for title_row, desc_row in data_summary:
        ax.text(box_x + 0.5, cur_ty, title_row, fontsize=9.5, fontweight='bold', color='#0F766E')
        ax.text(box_x + 6.0, cur_ty, desc_row, fontsize=9, color='#334155')
        cur_ty -= 0.85

    ax.text(box_x + 0.5, cur_ty - 0.1, "Lưu ý toàn vẹn: Thứ tự INSERT bắt buộc: Class -> Student -> Subject -> Mark để không vi phạm ràng buộc Foreign Key.", fontsize=8.8, fontstyle='italic', color='#DC2626')

    out_file1 = "c:/Users/dathao/Downloads/AI/git-final-practice/sql-student-management-insert-data/erd_quanly_sinhvien.png"
    out_file2 = "c:/Users/dathao/Downloads/AI/sql-student-management-insert-data/erd_quanly_sinhvien.png"
    plt.tight_layout()
    plt.savefig(out_file1, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.savefig(out_file2, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Generated Student Management ERD: {out_file1}")

if __name__ == "__main__":
    draw_student_mgmt_erd()
