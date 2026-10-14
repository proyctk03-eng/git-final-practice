# [Thuc hanh] Xay dung Landing Page voi Bootstrap

- **Sinh vien thuc hien**: Nguyen Tuan Dat
- **Lop / Ma sinh vien**: K23C - Khoa Cong nghe Thong tin
- **Du an**: bootstrap-landing-page

---

## 1. Muc tieu & Mo ta

Luyen tap su dung thu vien **Bootstrap 5.3.0** de xay dung mot Landing Page chuyen nghiep, hoan thien voi day du cac thanh phan:
- **Navbar Component**: Thanh dieu huong responsive co nut hamburger menu tren thiet bi di dong (`navbar-toggler`) va logo thuong hieu `MyBrand`.
- **Hero Section**: Khung gioi thieu chinh voi mau nen `bg-primary`, tieu de `display-4`, doan mo dau `lead` va nut hanh dong `btn-light`.
- **Grid System - Services**: Su dung he thong luoi 12 cot (`row`, `col-md-4`) ket hop `card` de trinh bay 3 dich vu chu dao:
  - Thiet ke Web
  - SEO & Marketing
  - Ho tro 24/7
- **Footer Component**: Khung chan trang `bg-dark` hien thi thong tin ban quyen.

---

## 2. Cau truc thu muc

```text
bootstrap-landing-page/
├── index.html           # Trang chu Landing Page su dung Bootstrap 5.3.0 CDN
├── styles.css           # CSS bo tro hieu ung hover nhe nhang cho service cards
└── README.md            # Tai lieu huong dan va thuyet minh ky thuat
```

---

## 3. Cac ky thuat Bootstrap ap dung

1. **Nhung Bootstrap qua CDN:**
   - CSS: `https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css`
   - JS Bundle: `https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js`

2. **He thong luoi 12 cot Responsive Grid:**
   - Su dung `.row` va `.col-md-4` giup hien thi 3 cot tren Desktop (>= 768px) va tu dong co ve 1 cot tren Mobile (< 768px).

3. **Tien ich Bootstrap (Utilities):**
   - Khoang cach: `py-5`, `py-4`, `mb-3`, `mb-4`, `px-4`.
   - Mau sac va hieu ung: `bg-primary`, `bg-dark`, `text-white`, `text-muted`, `shadow-sm`.
