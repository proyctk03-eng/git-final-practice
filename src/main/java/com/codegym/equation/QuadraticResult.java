package com.codegym.equation;

import java.io.Serializable;
import java.util.Objects;

/**
 * Lop dong goi ket qua giai phuong trinh bac hai.
 * Cung cap trang thai nghiem, gia tri biet thuc delta, va gia tri cac nghiem.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public class QuadraticResult implements Serializable {
    private static final long serialVersionUID = 1L;

    private final EquationStatus status;
    private final double discriminant;
    private final Double root1;
    private final Double root2;
    private final String message;

    public QuadraticResult(EquationStatus status, double discriminant, Double root1, Double root2, String message) {
        this.status = status;
        this.discriminant = discriminant;
        this.root1 = root1;
        this.root2 = root2;
        this.message = message;
    }

    public EquationStatus getStatus() {
        return status;
    }

    public double getDiscriminant() {
        return discriminant;
    }

    public Double getRoot1() {
        return root1;
    }

    public Double getRoot2() {
        return root2;
    }

    public String getMessage() {
        return message;
    }

    public boolean hasSolutions() {
        return status == EquationStatus.ONE_ROOT
                || status == EquationStatus.DOUBLE_ROOT
                || status == EquationStatus.TWO_DISTINCT_ROOTS
                || status == EquationStatus.INFINITE_ROOTS;
    }

    public int getRootCount() {
        switch (status) {
            case ONE_ROOT:
            case DOUBLE_ROOT:
                return 1;
            case TWO_DISTINCT_ROOTS:
                return 2;
            case INFINITE_ROOTS:
                return Integer.MAX_VALUE;
            case NO_SOLUTION:
            default:
                return 0;
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        QuadraticResult that = (QuadraticResult) o;
        return Double.compare(that.discriminant, discriminant) == 0 &&
                status == that.status &&
                Objects.equals(root1, that.root1) &&
                Objects.equals(root2, that.root2);
    }

    @Override
    public int hashCode() {
        return Objects.hash(status, discriminant, root1, root2);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("QuadraticResult{status=").append(status);
        sb.append(", delta=").append(discriminant);
        if (root1 != null) {
            sb.append(", root1=").append(root1);
        }
        if (root2 != null) {
            sb.append(", root2=").append(root2);
        }
        sb.append(", message='").append(message).append("'}");
        return sb.toString();
    }
}
