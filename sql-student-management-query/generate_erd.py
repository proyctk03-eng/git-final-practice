import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch

plt.rcParams['font.sans-serif'] = ['Segoe UI', 'Arial', 'Tahoma']
plt.rcParams['font.family'] = 'sans-serif'

def draw_student_mgmt_query_erd():
    fig, ax = plt.subplots(figsize=(20, 14), dpi=300)
    ax.set_xlim(0, 26)
    ax.set_ylim(0, 18)
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
    ax.text(13.0, 17.3, "SO DO THUC THE VA CO CHE TRUY VAN (JOIN / QUERY) - CSDL QUAN LY SINH VIEN", 
            fontsize=17, fontweight='bold', ha='center', va='center', color='#0F172A')
    ax.text(13.0, 16.7, "Minh hoa quan he 1-N giua cac bang va luong du lieu khi thuc hien cac phep JOIN trong SELECT query", 
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

    def draw_connector(p1, p2, label_start="1", label_end="N", style="straight", color=line_color, lw=1.6):
        x1, y1 = p1
        x2, y2 = p2
        if style == "orthogonal":
            mid_x = (x1 + x2) / 2
            ax.plot([x1, mid_x, mid_x, x2], [y1, y1, y2, y2], color=color, lw=lw, zorder=2)
        else:
            ax.plot([x1, x2], [y1, y2], color=color, lw=lw, zorder=2)

        ax.text(x1, y1, label_start, fontsize=9.5, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)
        ax.text(x2, y2, label_end, fontsize=9.5, fontweight='bold', color='#DC2626',
                bbox=dict(boxstyle='round,pad=0.15', facecolor='#FEF2F2', edgecolor='#DC2626', lw=0.8), zorder=6)

    # 1. Table Class (Top Left)
    t_class = draw_table(1.5, 15.5, 4.8, "Class (Lop hoc)", [
        ("PK", "ClassID", "INT AUTO_INC"),
        ("", "ClassName", "VARCHAR(60) NOT NULL"),
        ("", "StartDate", "DATETIME NOT NULL"),
        ("", "Status", "BIT")
    ], header_class)

    # 2. Table Student (Top Center)
    t_student = draw_table(10.0, 15.5, 5.5, "Student (Hoc vien)", [
        ("PK", "StudentId", "INT AUTO_INC"),
        ("", "StudentName", "VARCHAR(30) NOT NULL"),
        ("", "Address", "VARCHAR(50)"),
        ("", "Phone", "VARCHAR(20)"),
        ("", "Status", "BIT"),
        ("FK", "ClassId", "INT NOT NULL")
    ], header_student)

    # 3. Table Subject (Top Right)
    t_subject = draw_table(18.5, 15.5, 5.2, "Subject (Mon hoc)", [
        ("PK", "SubId", "INT AUTO_INC"),
        ("", "SubName", "VARCHAR(30) NOT NULL"),
        ("", "Credit", "TINYINT (>= 1)"),
        ("", "Status", "BIT DEFAULT 1")
    ], header_subject)

    # 4. Table Mark (Middle Center)
    t_mark = draw_table(10.0, 10.2, 5.8, "Mark (Bang diem)", [
        ("PK", "MarkId", "INT AUTO_INC"),
        ("FK", "SubId", "INT NOT NULL"),
        ("FK", "StudentId", "INT NOT NULL"),
        ("", "Mark", "FLOAT (0 - 100)"),
        ("", "ExamTimes", "TINYINT DEFAULT 1")
    ], header_mark)

    # Connectors
    # Class (1) -> (N) Student
    draw_connector((t_class['x'] + t_class['w'], 13.8), (t_student['x'], 13.8), label_start="1", label_end="N", style="straight")

    # Student (1) -> (N) Mark
    draw_connector((t_student['x'] + t_student['w']/2 - 0.5, t_student['bottom']), (t_mark['x'] + 1.2, t_mark['y']), label_start="1", label_end="N", style="straight")

    # Subject (1) -> (N) Mark
    draw_connector((t_subject['x'] + 1.0, t_subject['bottom']), (t_mark['x'] + t_mark['w'] - 1.0, t_mark['y']), label_start="1", label_end="N", style="straight")

    # Highlights for JOIN paths
    # Join Path 1 annotation
    ax.annotate("JOIN Buoc 5: Student + Class\nON S.ClassId = C.ClassID\nWHERE C.ClassName = 'A1'",
                xy=(7.6, 13.8), xytext=(7.6, 11.8),
                fontsize=8.5, fontweight='bold', color='#1E3A8A', ha='center',
                bbox=dict(boxstyle='round,pad=0.3', facecolor='#EFF6FF', edgecolor='#3B82F6', lw=1),
                arrowprops=dict(arrowstyle='->', lw=1.2, color='#3B82F6'))

    # Join Path 2 annotation
    ax.annotate("JOIN Buoc 6: Student + Mark + Subject\nON S.StudentId = M.StudentId\nJOIN Subject ON M.SubId = Sub.SubId\nWHERE Sub.SubName = 'CF'",
                xy=(16.8, 11.2), xytext=(20.5, 11.2),
                fontsize=8.5, fontweight='bold', color='#6D28D9', ha='center',
                bbox=dict(boxstyle='round,pad=0.3', facecolor='#F5F3FF', edgecolor='#8B5CF6', lw=1),
                arrowprops=dict(arrowstyle='->', lw=1.2, color='#8B5CF6'))

    # Query Results Summary Box (Bottom Area)
    box_x, box_y, box_w, box_h = 1.0, 0.6, 24.0, 5.8
    exp_box = FancyBboxPatch((box_x, box_y), box_w, box_h,
                             boxstyle="round,pad=0.05,rounding_size=0.15",
                             linewidth=1.2, edgecolor='#CBD5E1', facecolor='#F8FAFC', zorder=2)
    ax.add_patch(exp_box)

    ax.text(box_x + 0.4, box_y + box_h - 0.45, "TONG HOP CAC CAU TRUY VAN DU LIEU (DQL QUERY EXECUTION RESULTS):", 
            fontsize=11.5, fontweight='bold', color='#1E293B')

    queries_summary = [
        ("Buoc 2: Danh sach tat ca hoc vien", "SELECT * FROM Student;", "Hung (Ha Noi), Hoa (Hai phong), Manh (HCM) -> 3 ban ghi"),
        ("Buoc 3: Hoc vien dang theo hoc", "SELECT * FROM Student WHERE Status = true;", "Hung (Status: 1), Hoa (Status: 1) -> Loai bo Manh (Status: 0)"),
        ("Buoc 4: Mon hoc co tin chi < 10", "SELECT * FROM Subject WHERE Credit < 10;", "CF (5 tin chi), C (6 tin chi), HDJ (5 tin chi) -> Loai bo RDBMS (10 tin chi)"),
        ("Buoc 5: Hoc vien thuoc lop A1", "SELECT S.StudentId, S.StudentName, C.ClassName\nFROM Student S JOIN Class C ON S.ClassId = C.ClassID\nWHERE C.ClassName = 'A1';", "Hung (Lop A1), Hoa (Lop A1) -> 2 ban ghi hoc vien lop A1"),
        ("Buoc 6: Diem mon 'CF' cua hoc vien", "SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark\nFROM Student S JOIN Mark M ON S.StudentId = M.StudentId\nJOIN Subject Sub ON M.SubId = Sub.SubId\nWHERE Sub.SubName = 'CF';", "Hung - CF: 8.0 diem | Hoa - CF: 10.0 diem -> Ket qua JOIN 3 bang chinh xac")
    ]

    cur_ty = box_y + box_h - 1.0
    for step_title, sql_txt, res_txt in queries_summary:
        ax.text(box_x + 0.4, cur_ty, step_title, fontsize=9, fontweight='bold', color='#0F766E')
        ax.text(box_x + 6.2, cur_ty, sql_txt, fontsize=8.2, fontfamily='monospace', color='#1E293B')
        ax.text(box_x + 16.5, cur_ty, res_txt, fontsize=8.5, color='#475569')
        cur_ty -= 0.95

    out_file1 = "c:/Users/dathao/Downloads/AI/git-final-practice/sql-student-management-query/erd_quanly_sinhvien_queries.png"
    out_file2 = "c:/Users/dathao/Downloads/AI/sql-student-management-query/erd_quanly_sinhvien_queries.png"
    plt.tight_layout()
    plt.savefig(out_file1, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.savefig(out_file2, dpi=300, bbox_inches='tight', facecolor='#FFFFFF')
    plt.close()
    print(f"Generated Student Management Query ERD: {out_file1}")

if __name__ == "__main__":
    draw_student_mgmt_query_erd()
