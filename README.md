# [Thuc hanh] Su dung Bootstrap xay dung form login

> **Khoa hoc**: Lap trinh Web Frontend & Thiet ke Giao dien Nguoi dung (CodeGym)  
> **Hoc vien thuc hien**: Nguyen Tuan Dat  
> **Kho luu tru (Repository)**: `https://github.com/proyctk03-eng/git-final-practice`  
> **Nhanh thuc hanh**: `jwbd-login-bootstrap`  
> **Thu muc bai tap**: `jwbd-login-bootstrap/`  
> **Tham chieu CodeGym**: `https://github.com/codegym-vn/jwbd-login-bootstrap/tree/develop`  

---

## 1. Muc Tieu Bai Thuc Hanh

- Tich hop thanh cong thu vien **Bootstrap 5.0.0-beta2** thong qua mang phan phoi CDN (`cdn.jsdelivr.net`).
- Xay dung giao dien Form dang nhap (Sign in) chuan muc, can giua man hinh ca theo chieu doc va chieu ngang.
- Su dung he thong lop tien ich cua Bootstrap:
  - `.form-control`: Bo cuc o nhap du lieu co tinh nang focus noi bat.
  - `.checkbox`: O danh dau luu thong tin dang nhap "Remember me".
  - `.btn .btn-primary .btn-block .w-100`: Nut bam dang nhap phu kin chieu rong form.
  - `.text-center`, `.text-muted`: Can giua van ban va dong chu ban quyen.
- Ket hop CSS tuy bien (`styles.css`) de thiet lap Flexbox can giua trang, ghep noi vien hai o input email va password thanh mot khoi thong nhat.

---

## 2. Cac Buoc Trien Khai Thuc Te

1. **Buoc 1 & 2: Khoi tao du an va tich hop Bootstrap 5 CDN**:
   - Khai bao the `<meta name="viewport" content="width=device-width, initial-scale=1">` bao dam tinh responsive.
   - Nhap Bootstrap CSS v5.0.0-beta2 qua the `<link>` trong phan `<head>`.
   - Nhap Bootstrap Bundle JS (tich hop Popper) truoc the dong `</body>`.
2. **Buoc 3: Bo sung bieu tuong Bootstrap (`bootstrap.png`)**:
   - Tai tep hinh anh logo Bootstrap 72x72 pixel va luu truc tiep tai thu muc goc du an.
3. **Buoc 4: Xay dung cau truc HTML Form (`index.html`)**:
   - The `<form class="form-signin">` gioi han do rong toi da 330px va can giua tu dong.
   - O nhap Email (`type="email"`, `autofocus`, `required`).
   - O nhap Password (`type="password"`, `required`).
   - Hop kiem Remember me.
   - Nut Submit Sign in.
4. **Buoc 5: Tinh chinh kieu dang CSS (`styles.css`)**:
   - Thiet lap `height: 100%` cho `html` va `body`.
   - Su dung `display: flex; align-items: center; justify-content: center;` de can giua toan bo form dang nhap vao chinh giua viewport.
   - Xu ly goc bo tron: O email bo goc duoi (`border-bottom-*-radius: 0`), o password bo goc tren (`border-top-*-radius: 0`) tao cam giac lien mach hien dai.

---

## 3. Cau Truc Tep Du An

```
jwbd-login-bootstrap/
|-- bootstrap.png    # Bieu tuong Bootstrap (72x72)
|-- index.html       # Giao dien form login Bootstrap 5 hoan chinh
|-- styles.css       # CSS can giua Flexbox va bo goc o nhap
`-- README.md        # Thuyet minh ky thuat chi tiet
```

---

## 4. Huong Dan Mo & Kiem Tra

1. Mo tep `index.html` truc tiep trong trinh duyet (Chrome, Firefox, Edge).
2. Quan sat form dang nhap luon nam o chinh giua man hinh bat ke do phan giai cua cua so trinh duyet.
3. Thu nhap email va password de kiem tra hieu ung vien xanh focus (`z-index: 2`).
