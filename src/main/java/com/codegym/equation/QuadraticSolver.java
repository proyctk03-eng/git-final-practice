package com.codegym.equation;

/**
 * Lop tien ich tinh toan (Static Utility) giup giai nhanh phuong trinh bac hai
 * ma khong can khoi tao the hien doi tuong QuadraticEquation.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public final class QuadraticSolver {

    private QuadraticSolver() {
        // Private constructor ngan chan khoi tao doi tuong tien ich
    }

    /**
     * Giai phuong trinh bac hai ax^2 + bx + c = 0.
     *
     * @param a He so bac hai
     * @param b He so bac nhat
     * @param c He so tu do
     * @return Ket qua giai phuong trinh
     */
    public static QuadraticResult solve(double a, double b, double c) {
        QuadraticEquation equation = new QuadraticEquation(a, b, c);
        return equation.solve();
    }

    /**
     * Tinh biet thuc delta = b^2 - 4ac.
     *
     * @param a He so bac hai
     * @param b He so bac nhat
     * @param c He so tu do
     * @return Gia tri delta
     */
    public static double calculateDiscriminant(double a, double b, double c) {
        return (b * b) - (4 * a * c);
    }

    /**
     * Dinh dang chuoi phuong trinh toan hoc dep mat.
     *
     * @param a He so a
     * @param b He so b
     * @param c He so c
     * @return Chuoi bieu dien phuong trinh
     */
    public static String formatEquation(double a, double b, double c) {
        StringBuilder sb = new StringBuilder();

        if (a != 0) {
            sb.append(a == 1 ? "" : (a == -1 ? "-" : stripTrailingZeros(a))).append("x^2");
        }

        if (b != 0) {
            if (sb.length() > 0) {
                sb.append(b > 0 ? " + " : " - ");
                double absB = Math.abs(b);
                sb.append(absB == 1 ? "" : stripTrailingZeros(absB)).append("x");
            } else {
                sb.append(b == 1 ? "" : (b == -1 ? "-" : stripTrailingZeros(b))).append("x");
            }
        }

        if (c != 0) {
            if (sb.length() > 0) {
                sb.append(c > 0 ? " + " : " - ");
                sb.append(stripTrailingZeros(Math.abs(c)));
            } else {
                sb.append(stripTrailingZeros(c));
            }
        }

        if (sb.length() == 0) {
            sb.append("0");
        }

        sb.append(" = 0");
        return sb.toString();
    }

    private static String stripTrailingZeros(double val) {
        if (val == (long) val) {
            return String.format("%d", (long) val);
        } else {
            return String.format("%s", val);
        }
    }
}
