package com.codegym.demo;

import com.codegym.equation.EquationStatus;
import com.codegym.equation.QuadraticEquation;
import com.codegym.equation.QuadraticResult;
import com.codegym.equation.QuadraticSolver;

/**
 * Ung dung mau minh hoa cach tich hop va su dung thu vien giai phuong trinh bac hai.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public class LibraryDemoApp {

    public static void main(String[] args) {
        System.out.println("================================================================================");
        System.out.println("     DEMO SU DUNG THU VIEN JAVA GIAI PHUONG TRINH BAC HAI (ax^2 + bx + c = 0)");
        System.out.println("     Tac gia: Nguyen Tuan Dat (proyctk03@gmail.com)");
        System.out.println("     Thu vien: com.codegym:quadratic-equation-solver:1.0.0");
        System.out.println("================================================================================\n");

        double[][] testCases = {
                {1, -3, 2},     // Delta = 1 > 0 -> x1 = 2, x2 = 1
                {1, -4, 4},     // Delta = 0 -> nghiem kep x = 2
                {1, 2, 5},      // Delta = -16 < 0 -> vo nghiem thuc
                {0, 2, -6},     // a = 0, b = 2, c = -6 -> bac nhat x = 3
                {0, 0, 7},      // a = 0, b = 0, c = 7 -> vo nghiem
                {0, 0, 0},      // a = 0, b = 0, c = 0 -> vo so nghiem
                {2, 5, -3}      // Delta = 49 -> x1 = 0.5, x2 = -3
        };

        System.out.println("--------------------------------------------------------------------------------");
        System.out.println("PHAN 1: SU DUNG DOI TUONG HUONG DOI TUONG (OOP) - QuadraticEquation");
        System.out.println("--------------------------------------------------------------------------------");

        for (int i = 0; i < testCases.length; i++) {
            double a = testCases[i][0];
            double b = testCases[i][1];
            double c = testCases[i][2];

            QuadraticEquation eq = new QuadraticEquation(a, b, c);
            QuadraticResult res = eq.solve();

            System.out.printf("[%d] Phuong trinh: %s\n", (i + 1), QuadraticSolver.formatEquation(a, b, c));
            System.out.printf("    - He so: a = %.2f, b = %.2f, c = %.2f\n", eq.getA(), eq.getB(), eq.getC());
            System.out.printf("    - Delta: %.4f\n", eq.getDiscriminant());
            System.out.printf("    - Trang thai: %s\n", res.getStatus().getDescription());
            System.out.printf("    - Thong diep: %s\n", res.getMessage());

            if (res.getStatus() == EquationStatus.TWO_DISTINCT_ROOTS) {
                System.out.printf("    - Ket qua: x1 = %.4f | x2 = %.4f\n", res.getRoot1(), res.getRoot2());
            } else if (res.getStatus() == EquationStatus.DOUBLE_ROOT || res.getStatus() == EquationStatus.ONE_ROOT) {
                System.out.printf("    - Ket qua: x = %.4f\n", res.getRoot1());
            }
            System.out.println();
        }

        System.out.println("--------------------------------------------------------------------------------");
        System.out.println("PHAN 2: SU DUNG PHUONG THUC TINH (STATIC UTILITY) - QuadraticSolver");
        System.out.println("--------------------------------------------------------------------------------");

        double a = 1.0, b = -7.0, c = 12.0;
        System.out.printf("Giai nhanh phuong trinh: %s\n", QuadraticSolver.formatEquation(a, b, c));
        QuadraticResult quickResult = QuadraticSolver.solve(a, b, c);
        System.out.println("Ket qua: " + quickResult.getMessage());
        System.out.printf("x1 = %.4f, x2 = %.4f\n\n", quickResult.getRoot1(), quickResult.getRoot2());

        System.out.println("================================================================================");
        System.out.println("     DA HOAN THANH KIEM THU TOAN DIEN CAC CHUC NANG CUA THU VIEN");
        System.out.println("================================================================================");
    }
}
