# [Bai tap] Tao Layout Voi Cac The HTML5 va CSS

> **Khoa hoc**: Lap trinh Web Frontend & Thiet ke Giao dien Nguoi dung (CodeGym)  
> **Hoc vien thuc hien**: Nguyen Tuan Dat  
> **Kho luu tru (Repository)**: `https://github.com/proyctk03-eng/tao-layout-html5-css`  
> **Thu muc bai tap**: `tao_layout_html5_css/`  

---

## 1. Gioi Thieu & Muc Tieu Bai Hoc

Bai tap huong dan ky thuat thiet ke bo cuc trang web hien dai (Web Layout Design) su dung cac the ngu nghia chuan HTML5 (Semantic Elements) ket hop voi CSS Flexbox va CSS Grid, thay the hoan toan thoi quen lam dung the `<div>` vo nghia truoc day.

### Muc tieu cot loi:
- **Lam chu cac the HTML5 Semantic**: Su dung chuan xac 6 the cau truc cot loi: `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>` va `<footer>`.
- **Hieu ro su khac biet giua `<section>` va `<article>`**: Phan biet phan vung nhom noi dung (`section`) va bai viet doc lap hoan chinh (`article`).
- **Thiet ke bo cuc trang web chuan dap ung (Responsive Layout)**: Chia cot noi dung chinh va thanh ben (Sidebar), tu dong co gian thich ung tren man hinh may tinh va thiet bi di dong.
- **Toi uu hoa SEO & Kha nang tiep can (Accessibility - a11y)**: Giup cong cu tim kiem va trinh doc man hinh (Screen Reader) de dang phan tich cau truc trang web.

---

## 2. So Do Cau Truc Bo Cuc HTML5 Semantic

```text
+------------------------------------------------------------------+
|                          <header>                                |
|          Tieu de trang web, Logo thuong hieu & Tagline           |
+------------------------------------------------------------------+
|                           <nav>                                  |
|             Thanh menu lien ket dieu huong chinh                 |
+----------------------------------+-------------------------------+
|             <section>            |            <aside>            |
|       Khu vuc noi dung chinh     |      Thanh ben (Sidebar)      |
|  +----------------------------+  |  +-------------------------+  |
|  |         <article>          |  |  |   Chu de thinh hanh     |  |
|  |   Bai viet doc lap so 1    |  |  +-------------------------+  |
|  +----------------------------+  |  +-------------------------+  |
|  +----------------------------+  |  |   Goc loi khuyen / Info |  |
|  |         <article>          |  |  +-------------------------+  |
|  |   Bai viet doc lap so 2    |  |                               |
|  +----------------------------+  |                               |
+----------------------------------+-------------------------------+
|                          <footer>                                |
|            Thong tin ban quyen, lien he & dieu khoan             |
+------------------------------------------------------------------+
```

---

## 3. Cau Truc Du An

```text
tao_layout_html5_css/
|-- index.html           # Ban chuan theo yeu cau bai hoc CodeGym
|-- styles.css           # Dinh kieu CSS Flexbox 2 cot dap ung (Responsive)
|-- modern_layout.html   # Ban nang cap giao dien tap chi cong nghe cao cap
|-- modern_layout.css    # CSS Grid 2 chieu, Dark/Indigo Palette, Glassmorphism
`-- README.md            # Bao cao ky thuat phan tich chi tiet
```

---

## 4. Bang Phan Tich Y Nghia & Vai Tro Cac The HTML5

| The HTML5 | Y nghia ngu nghia (Semantics) | Vai tro trong bo cuc |
| :--- | :--- | :--- |
| **`<header>`** | Phan dau trang / bieu ngu | Chua tieu de trang, logo, slogan hoac phan dau cua tung bai viet |
| **`<nav>`** | Thanh dieu huong | Dong goi danh sach lien ket dan den cac phan muc chinh cua website |
| **`<main>`** | Vung noi dung trong tam | Bao boc noi dung trung tam duy nhat cua trang, khong lap lai giua cac trang |
| **`<section>`** | Phan vung noi dung co chu de | Nhom cac noi dung co lien quan logic voi nhau (thuong co mot tieu de `<h2>`) |
| **`<article>`** | Khoi noi dung doc lap | Dai dien cho mot bai bao, bai viet blog co the tai su dung doc lap o noi khac |
| **`<aside>`** | Noi dung phu tro / ben le | Chua sidebar, danh sach xem nhieu, quang cao hoac ghi chu lien quan |
| **`<footer>`** | Phan chan trang | Chua thong tin ban quyen, lien he, chinh sach bao mat hoac so do trang |

---

## 5. Tai Sao Phai Su Dung HTML5 Semantic Thay Vi The `<div>`?

1. **Toi uu hoa cong cu tim kiem (Semantic SEO)**:
   - Googlebot va cac cong cu tim kiem co the nhan dien ngay dau la bai viet chinh (`<article>`), dau la thanh dieu huong (`<nav>`), va dau la noi dung phu (`<aside>`), tu do lap chi muc chinh xac hon.
2. **Kha nang tiep can cho nguoi khiem thi (Accessibility / a11y)**:
   - Cac phan mem doc man hinh (Screen Reader) co the dieu huong nguoi dung nhay thang toi noi dung chinh (`<main>`) ma khong bi ket o cac thanh menu phuc tap.
3. **Ma nguon sach & De bao tri**:
   - Tranh hien tuong "Div Soup" (long hang chuc the `<div>` vo nghia khien cau truc ma bi roi loan).

---

## 6. Diem Noi Bat O Ban Hien Dai (`modern_layout.html`)

Ngoai ban chuan CodeGym, du an trang bi them phien ban hien dai:
- **CSS Grid hai chieu**: Tach biet ro rang cac khu vuc noi dung voi do phan giai linh hoat.
- **Phong cach Glassmorphism & Editorial**: Vien kinh mo tinh te, do bong da tang, typography hien dai (Plus Jakarta Sans).
- **He thong the bai viet hoan chinh**: Bo sung thoi luong doc (Reading Time), huy hieu danh muc (Category Badges) va thong tin tac gia Nguyen Tuan Dat voi avatar tron.
- **Hoan toan thich ung (Fully Responsive)**: Tu dong chuyen doi tu bo cuc 2 cot sang 1 cot lien mach tren dien thoai di dong.

---

## 7. Huong Dan Mo & Kiem Thu Tren Trinh Duyet

1. **Ban chuan CodeGym**: Mo tep [index.html](file:///C:/Users/dathao/Downloads/tao_layout_html5_css/index.html).
2. **Ban nang cap UI/UX cao cap**: Mo tep [modern_layout.html](file:///C:/Users/dathao/Downloads/tao_layout_html5_css/modern_layout.html).
