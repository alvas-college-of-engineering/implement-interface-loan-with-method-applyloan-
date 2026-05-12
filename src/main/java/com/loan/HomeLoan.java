package com.loan;

public class HomeLoan implements Loan {
    private String applicantName;
    private double income;
    private double loanAmount;

    public HomeLoan(String applicantName, double income, double loanAmount) {
        this.applicantName = applicantName;
        this.income = income;
        this.loanAmount = loanAmount;
    }

    @Override
    public boolean isApproved() {
        return income >= 30000;
    }

    @Override
    public String applyLoan() {
        return isApproved() ? "Home Loan Approved" : "Home Loan Rejected";
    }

    public String getApplicantName() { return applicantName; }
    public double getIncome() { return income; }
    public double getLoanAmount() { return loanAmount; }
}
