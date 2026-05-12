package com.loan;

public class EducationLoan implements Loan {
    private String studentName;
    private double marks;
    private double loanAmount;

    public EducationLoan(String studentName, double marks, double loanAmount) {
        this.studentName = studentName;
        this.marks = marks;
        this.loanAmount = loanAmount;
    }

    @Override
    public boolean isApproved() {
        return marks >= 60;
    }

    @Override
    public String applyLoan() {
        return isApproved() ? "Education Loan Approved" : "Education Loan Rejected";
    }

    public String getStudentName() { return studentName; }
    public double getMarks() { return marks; }
    public double getLoanAmount() { return loanAmount; }
}
