# [Bai tap] Thiet ke Trang Dang Ky voi Bootstrap Forms

- **Sinh vien thuc hien**: Nguyen Tuan Dat
- **Lop / Ma sinh vien**: K23C - Khoa Cong nghe Thong tin
- **Du an**: bootstrap-registration-form

---

## 1. Muc tieu & Mo ta bai tap

Luyen tap su dung cac thanh phan bieu mau cua thu vien **Bootstrap 5.3.0** (Bootstrap Forms, Form Controls, Buttons va Text Elements) de xay dung mot giao dien dang ky tai khoan nguoi dung chuyen nghiep:
- **Ho va ten**: Truong van ban (`input type="text"` su dung class `form-control`).
- **Email**: Truong thu dien tu (`input type="email"` voi `form-control`) kem chu thich bao mat `text-muted`.
- **Mat khau & Xac nhan mat khau**: Hai truong bao mat (`input type="password"`) nam canh nhau tren he thong luoi chia doi cot (`row`, `col-md-6`), co kiem tra do dai toi thieu 8 ky tu va xac thuc trung khop bang JavaScript.
- **Gioi tinh**: Lua chon duy nhat dang Radio Button (`form-check-input`, `form-check-inline`) gom cac gia tri: Nam, Nu, Khac.
- **So thich**: Lua chon da muc dang Checkbox (`form-check-input`, `form-check-inline`) gom: Doc sach, Du lich, The thao, Am nhac.
- **Quoc gia**: Trinh don tha chon (`select` su dung class `form-select`) voi danh sach cac quoc gia.
- **Nut Submit**: Nut gui bieu mau noi bat (`btn btn-primary btn-lg w-100 shadow-sm`).

---

## 2. Cau truc thu muc

```text
bootstrap-registration-form/
├── index.html           # Trang dang ky tai khoan day du cac truong Bootstrap Forms
├── styles.css           # Dinh dang CSS bo tro hieu ung hover va focus vien xanh
└── README.md            # Tai lieu thuyet minh ky thuat va huong dan su dung
```

---

## 3. Cac ky thuat va thanh phan Bootstrap su dung

1. **Bootstrap Form Controls:**
   - `.form-control`: Dinh dang o nhap lieu co border bo tron, padding can doi va transition muot ma.
   - `.form-select`: Trinh bay dropdown box chuan responsive voi mui ten icon tu dong.
   - `.form-check`, `.form-check-input`, `.form-check-label`: Tao hop kiem va nut radio dong bo.
   - `.form-check-inline`: Xep cac lua chon tren cung mot dong giup tiet kiem dien tich doc.

2. **Bootstrap Buttons:**
   - `.btn .btn-primary .btn-lg .w-100 .shadow-sm`: Nut bam kich thuoc lon, mau xanh chu dao, phu kin be rong form.

3. **Bootstrap Text & Feedback Elements:**
   - `.form-label .fw-semibold`: Nhan truong chu dam ro rang.
   - `.form-text .text-muted`: Dong chu thich nho ben duoi input.
   - `.invalid-feedback` va `.was-validated`: Hien thi thong bao loi nhap lieu mau do truc quan.
