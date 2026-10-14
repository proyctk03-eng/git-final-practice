package com.codegym.equation;

/**
 * Trang thai ket qua cua phuong trinh bac hai ax^2 + bx + c = 0.
 *
 * Cac truong hop:
 * - INFINITE_ROOTS: Phuong trinh co vo so nghiem (a = 0, b = 0, c = 0).
 * - NO_SOLUTION: Phuong trinh vo nghiem (a = 0, b = 0, c != 0 hoac delta < 0).
 * - ONE_ROOT: Phuong trinh suy bien thanh bac nhat co 1 nghiem duy nhat (a = 0, b != 0).
 * - DOUBLE_ROOT: Phuong trinh co nghiem kep (a != 0, delta = 0).
 * - TWO_DISTINCT_ROOTS: Phuong trinh co hai nghiem phan biet (a != 0, delta > 0).
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public enum EquationStatus {
    INFINITE_ROOTS("Phuong trinh co vo so nghiem"),
    NO_SOLUTION("Phuong trinh vo nghiem"),
    ONE_ROOT("Phuong trinh bac nhat co 1 nghiem duy nhat"),
    DOUBLE_ROOT("Phuong trinh co nghiem kep"),
    TWO_DISTINCT_ROOTS("Phuong trinh co 2 nghiem phan biet");

    private final String description;

    EquationStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    @Override
    public String toString() {
        return description;
    }
}
