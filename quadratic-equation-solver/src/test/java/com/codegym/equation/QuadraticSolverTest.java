package com.codegym.equation;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Bo kiem thu don vi (Unit Test) cho lop tien ich QuadraticSolver.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
class QuadraticSolverTest {

    private static final double EPSILON = 1e-6;

    @Test
    @DisplayName("Kiem tra phuong thuc tinh solve() truc tiep")
    void testStaticSolve() {
        QuadraticResult result = QuadraticSolver.solve(1, -5, 6);
        assertEquals(EquationStatus.TWO_DISTINCT_ROOTS, result.getStatus());
        assertEquals(3.0, result.getRoot1(), EPSILON);
        assertEquals(2.0, result.getRoot2(), EPSILON);
    }

    @Test
    @DisplayName("Kiem tra phuong thuc calculateDiscriminant")
    void testCalculateDiscriminant() {
        double delta = QuadraticSolver.calculateDiscriminant(1, -7, 10);
        // delta = (-7)^2 - 4*1*10 = 49 - 40 = 9
        assertEquals(9.0, delta, EPSILON);
    }

    @Test
    @DisplayName("Kiem tra dinh dang chuoi phuong trinh formatEquation")
    void testFormatEquation() {
        assertEquals("x^2 - 3x + 2 = 0", QuadraticSolver.formatEquation(1, -3, 2));
        assertEquals("-x^2 + 4x - 4 = 0", QuadraticSolver.formatEquation(-1, 4, -4));
        assertEquals("2x^2 + 5x - 3 = 0", QuadraticSolver.formatEquation(2, 5, -3));
        assertEquals("2x - 6 = 0", QuadraticSolver.formatEquation(0, 2, -6));
        assertEquals("5 = 0", QuadraticSolver.formatEquation(0, 0, 5));
        assertEquals("0 = 0", QuadraticSolver.formatEquation(0, 0, 0));
    }
}
