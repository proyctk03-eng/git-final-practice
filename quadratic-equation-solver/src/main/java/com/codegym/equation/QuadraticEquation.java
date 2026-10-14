package com.codegym.equation;

import java.io.Serializable;

/**
 * Lop bieu dien va giai phuong trinh bac hai ax^2 + bx + c = 0.
 *
 * Cung cap cac phuong thuc tinh toan biet thuc delta, tim nghiem theo cong thuc toan hoc,
 * va dong goi toan bo ket qua vao doi tuong QuadraticResult.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public class QuadraticEquation implements Serializable {
    private static final long serialVersionUID = 1L;

    private double a;
    private double b;
    private double c;

    /**
     * Khoi tao mac dinh voi cac he so bang 0.
     */
    public QuadraticEquation() {
        this(0, 0, 0);
    }

    /**
     * Khoi tao phuong trinh bac hai voi ba he so a, b, c.
     *
     * @param a He so bac hai
     * @param b He so bac nhat
     * @param c He so tu do
     */
    public QuadraticEquation(double a, double b, double c) {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public double getA() {
        return a;
    }

    public void setA(double a) {
        this.a = a;
    }

    public double getB() {
        return b;
    }

    public void setB(double b) {
        this.b = b;
    }

    public double getC() {
        return c;
    }

    public void setC(double c) {
        this.c = c;
    }

    /**
     * Tinh biet thuc delta (b^2 - 4ac).
     *
     * @return Gia tri cua delta
     */
    public double getDiscriminant() {
        return (b * b) - (4 * a * c);
    }

    /**
     * Tinh nghiem thu nhat x1 = (-b + sqrt(delta)) / (2a).
     * Neu delta < 0 hoac a == 0, phuong thuc tra ve 0 theo quy uoc co ban.
     *
     * @return Gia tri nghiem x1
     */
    public double getRoot1() {
        double delta = getDiscriminant();
        if (delta < 0 || a == 0) {
            return 0;
        }
        return (-b + Math.sqrt(delta)) / (2 * a);
    }

    /**
     * Tinh nghiem thu hai x2 = (-b - sqrt(delta)) / (2a).
     * Neu delta < 0 hoac a == 0, phuong thuc tra ve 0 theo quy uoc co ban.
     *
     * @return Gia tri nghiem x2
     */
    public double getRoot2() {
        double delta = getDiscriminant();
        if (delta < 0 || a == 0) {
            return 0;
        }
        return (-b - Math.sqrt(delta)) / (2 * a);
    }

    /**
     * Kiem tra phuong trinh co nghiem thuc hay khong.
     *
     * @return true neu co it nhat mot nghiem thuc hoac vo so nghiem
     */
    public boolean hasRealRoots() {
        if (a == 0) {
            return b != 0 || c == 0;
        }
        return getDiscriminant() >= 0;
    }

    /**
     * Giai toan dien phuong trinh bac hai va tra ve doi tuong ket qua chi tiet.
     *
     * @return QuadraticResult chua day du trang thai va cac nghiem
     */
    public QuadraticResult solve() {
        // Truong hop a = 0: Phuong trinh suy bien thanh bac nhat bx + c = 0
        if (a == 0) {
            if (b == 0) {
                if (c == 0) {
                    return new QuadraticResult(
                            EquationStatus.INFINITE_ROOTS,
                            0,
                            null,
                            null,
                            "Phuong trinh 0x^2 + 0x + 0 = 0 co vo so nghiem (dung voi moi x)."
                    );
                } else {
                    return new QuadraticResult(
                            EquationStatus.NO_SOLUTION,
                            0,
                            null,
                            null,
                            String.format("Phuong trinh 0x = %.4f vo nghiem.", -c)
                    );
                }
            } else {
                double root = -c / b;
                return new QuadraticResult(
                        EquationStatus.ONE_ROOT,
                        0,
                        root,
                        null,
                        String.format("He so a = 0, phuong trinh tro thanh bac nhat co 1 nghiem duy nhat: x = %.4f", root)
                );
            }
        }

        // Truong hop a != 0: Phuong trinh bac hai thuan tuy
        double delta = getDiscriminant();

        if (delta < 0) {
            return new QuadraticResult(
                    EquationStatus.NO_SOLUTION,
                    delta,
                    null,
                    null,
                    String.format("Delta = %.4f < 0, phuong trinh vo nghiem thuc.", delta)
            );
        } else if (delta == 0) {
            double doubleRoot = -b / (2 * a);
            return new QuadraticResult(
                    EquationStatus.DOUBLE_ROOT,
                    delta,
                    doubleRoot,
                    doubleRoot,
                    String.format("Delta = 0, phuong trinh co nghiem kep: x1 = x2 = %.4f", doubleRoot)
            );
        } else {
            double r1 = (-b + Math.sqrt(delta)) / (2 * a);
            double r2 = (-b - Math.sqrt(delta)) / (2 * a);
            return new QuadraticResult(
                    EquationStatus.TWO_DISTINCT_ROOTS,
                    delta,
                    r1,
                    r2,
                    String.format("Delta = %.4f > 0, phuong trinh co 2 nghiem phan biet: x1 = %.4f, x2 = %.4f", delta, r1, r2)
            );
        }
    }

    @Override
    public String toString() {
        return String.format("%.2fx^2 + %.2fx + %.2f = 0", a, b, c);
    }
}
