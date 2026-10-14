# [Thuc hanh] CSS | flex-flow Property

- **Sinh vien thuc hien**: Nguyen Tuan Dat
- **Lop / Ma sinh vien**: K23C - Khoa Cong nghe Thong tin
- **Bai tap**: Thuc hanh thuoc tinh CSS flex-flow

---

## 1. Ly thuyet ve thuoc tinh flex-flow

Thuoc tinh `flex-flow` la thuoc tinh viet tat (shorthand) ket hop giua `flex-direction` va `flex-wrap`:

```css
flex-flow: flex-direction flex-wrap;
```

Luu y: Thuoc tinh `flex-flow` chi co tac dung khi dat o phan tu cha (Flex Container - co `display: flex` hoac `display: inline-flex`).

---

## 2. Cac vi du thuc hanh da trien khai

### Vi du 1: row nowrap (Gia tri mac dinh)
Sap xep cac item nam tren cung 1 hang theo huong doc van ban (trai qua phai) va khong co gian/xuong dong khi het khoang trong.

```css
.container-1 {
    display: flex;
    flex-flow: row nowrap;
    background-color: #f1f1f1;
}
.container-1 > div {
    background-color: #007bff;
    color: white;
    width: 100px;
    margin: 10px;
    text-align: center;
    line-height: 50px;
}
```

### Vi du 2: row-reverse nowrap
Sap xep cac item nam tren cung 1 hang nhung theo huong nguoc lai voi huong doc van ban (phai qua trai) va khong xuong dong.

```css
.container-2 {
    display: flex;
    flex-flow: row-reverse nowrap;
    background-color: #f1f1f1;
}
.container-2 > div {
    background-color: #28a745;
    color: white;
    width: 100px;
    margin: 10px;
    text-align: center;
    line-height: 50px;
}
```

---

## 3. Cau truc thu muc

```text
css-flex-flow/
├── index.html           # Trang giao dien HTML chua 2 vi du thuc hanh flex-flow
├── styles.css           # Dinh dang CSS voi container-1 va container-2
└── README.md            # Thuyet minh ly thuyet va ma nguon mau
```
