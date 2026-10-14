package com.codegym.equation;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Bo kiem thu don vi (Unit Test) cho lop QuadraticEquation.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
class QuadraticEquationTest {

    private static final double EPSILON = 1e-6;

    @Test
    @DisplayName("Kiem tra tinh biet thuc Delta chinh xac")
    void testGetDiscriminant() {
        QuadraticEquation eq1 = new QuadraticEquation(1, -3, 2);
        // delta = (-3)^2 - 4*1*2 = 9 - 8 = 1
        assertEquals(1.0, eq1.getDiscriminant(), EPSILON);

        QuadraticEquation eq2 = new QuadraticEquation(1, -4, 4);
        // delta = (-4)^2 - 4*1*4 = 16 - 16 = 0
        assertEquals(0.0, eq2.getDiscriminant(), EPSILON);

        QuadraticEquation eq3 = new QuadraticEquation(1, 2, 5);
        // delta = 2^2 - 4*1*5 = 4 - 20 = -16
        assertEquals(-16.0, eq3.getDiscriminant(), EPSILON);
    }

    @Test
    @DisplayName("Kiem tra truong hop a != 0, delta > 0: Hai nghiem phan biet")
    void testTwoDistinctRoots() {
        QuadraticEquation eq = new QuadraticEquation(1, -3, 2);
        QuadraticResult result = eq.solve();

        assertEquals(EquationStatus.TWO_DISTINCT_ROOTS, result.getStatus());
        assertEquals(1.0, result.getDiscriminant(), EPSILON);
        assertNotNull(result.getRoot1());
        assertNotNull(result.getRoot2());
        assertEquals(2.0, result.getRoot1(), EPSILON);
        assertEquals(1.0, result.getRoot2(), EPSILON);
        assertEquals(2, result.getRootCount());
        assertTrue(result.hasSolutions());

        // Kiem tra truc tiep ham getRoot1 va getRoot2
        assertEquals(2.0, eq.getRoot1(), EPSILON);
        assertEquals(1.0, eq.getRoot2(), EPSILON);
    }

    @Test
    @DisplayName("Kiem tra truong hop a != 0, delta = 0: Nghiem kep")
    void testDoubleRoot() {
        QuadraticEquation eq = new QuadraticEquation(1, -4, 4);
        QuadraticResult result = eq.solve();

        assertEquals(EquationStatus.DOUBLE_ROOT, result.getStatus());
        assertEquals(0.0, result.getDiscriminant(), EPSILON);
        assertEquals(2.0, result.getRoot1(), EPSILON);
        assertEquals(2.0, result.getRoot2(), EPSILON);
        assertEquals(1, result.getRootCount());
        assertTrue(result.hasSolutions());

        assertEquals(2.0, eq.getRoot1(), EPSILON);
        assertEquals(2.0, eq.getRoot2(), EPSILON);
    }

    @Test
    @DisplayName("Kiem tra truong hop a != 0, delta < 0: Vo nghiem thuc")
    void testNoRealRoots() {
        QuadraticEquation eq = new QuadraticEquation(1, 2, 5);
        QuadraticResult result = eq.solve();

        assertEquals(EquationStatus.NO_SOLUTION, result.getStatus());
        assertEquals(-16.0, result.getDiscriminant(), EPSILON);
        assertNull(result.getRoot1());
        assertNull(result.getRoot2());
        assertEquals(0, result.getRootCount());
        assertFalse(result.hasSolutions());

        // Theo quy uoc getRoot1, getRoot2 tra ve 0 khi delta < 0
        assertEquals(0.0, eq.getRoot1(), EPSILON);
        assertEquals(0.0, eq.getRoot2(), EPSILON);
    }

    @Test
    @DisplayName("Kiem tra truong hop a = 0, b != 0: Suy bien thanh phuong trinh bac nhat")
    void testLinearEquation() {
        QuadraticEquation eq = new QuadraticEquation(0, 2, -6);
        QuadraticResult result = eq.solve();

        assertEquals(EquationStatus.ONE_ROOT, result.getStatus());
        assertNotNull(result.getRoot1());
        assertEquals(3.0, result.getRoot1(), EPSILON);
        assertNull(result.getRoot2());
        assertEquals(1, result.getRootCount());
        assertTrue(result.hasSolutions());
    }

    @Test
    @DisplayName("Kiem tra truong hop a = 0, b = 0, c != 0: Phuong trinh vo nghiem")
    void testNoSolutionWhenAAndBAreZero() {
        QuadraticEquation eq = new QuadraticEquation(0, 0, 7);
        QuadraticResult result = eq.solve();

        assertEquals(EquationStatus.NO_SOLUTION, result.getStatus());
        assertNull(result.getRoot1());
        assertNull(result.getRoot2());
        assertEquals(0, result.getRootCount());
        assertFalse(result.hasSolutions());
    }

    @Test
    @DisplayName("Kiem tra truong hop a = 0, b = 0, c = 0: Phuong trinh vo so nghiem")
    void testInfiniteRoots() {
        QuadraticEquation eq = new QuadraticEquation(0, 0, 0);
        QuadraticResult result = eq.solve();

        assertEquals(EquationStatus.INFINITE_ROOTS, result.getStatus());
        assertNull(result.getRoot1());
        assertNull(result.getRoot2());
        assertEquals(Integer.MAX_VALUE, result.getRootCount());
        assertTrue(result.hasSolutions());
    }

    @ParameterizedTest
    @CsvSource({
            "2.0, 5.0, -3.0, TWO_DISTINCT_ROOTS, 0.5, -3.0",
            "1.0, -6.0, 9.0, DOUBLE_ROOT, 3.0, 3.0",
            "3.0, 4.0, 5.0, NO_SOLUTION, 0.0, 0.0"
    })
    @DisplayName("Kiem tra tham so hoa nhieu bo du lieu he so")
    void testParameterizedCases(double a, double b, double c, String expectedStatusName, double expectedR1, double expectedR2) {
        QuadraticEquation eq = new QuadraticEquation(a, b, c);
        QuadraticResult res = eq.solve();

        EquationStatus expectedStatus = EquationStatus.valueOf(expectedStatusName);
        assertEquals(expectedStatus, res.getStatus());

        if (expectedStatus == EquationStatus.TWO_DISTINCT_ROOTS) {
            assertEquals(expectedR1, res.getRoot1(), EPSILON);
            assertEquals(expectedR2, res.getRoot2(), EPSILON);
        } else if (expectedStatus == EquationStatus.DOUBLE_ROOT) {
            assertEquals(expectedR1, res.getRoot1(), EPSILON);
        }
    }

    @Test
    @DisplayName("Kiem tra getters, setters va toString")
    void testGettersSettersAndToString() {
        QuadraticEquation eq = new QuadraticEquation();
        eq.setA(2.5);
        eq.setB(-4.0);
        eq.setC(1.5);

        assertEquals(2.5, eq.getA(), EPSILON);
        assertEquals(-4.0, eq.getB(), EPSILON);
        assertEquals(1.5, eq.getC(), EPSILON);
        assertNotNull(eq.toString());
        assertTrue(eq.toString().contains("2.50x^2"));
    }
}
