package com.loan;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoanServlet extends HttpServlet {

    private Double parseDoubleOrNull(HttpServletRequest request, String name) {
        String raw = request.getParameter(name);
        if (raw == null || raw.isBlank()) {
            return null;
        }
        try {
            return Double.parseDouble(raw.trim());
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String loanType = request.getParameter("loanType");
        if (loanType == null || loanType.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        if ("home".equals(loanType)) {
            String applicantName = request.getParameter("applicantName");
            Double income = parseDoubleOrNull(request, "income");
            Double loanAmount = parseDoubleOrNull(request, "loanAmount");

            if (applicantName == null || applicantName.isBlank() || income == null || loanAmount == null) {
                request.setAttribute("errorMessage", "Please enter a valid name, income, and loan amount for Home Loan.");
                request.setAttribute("selectedType", "home");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            HomeLoan loan = new HomeLoan(applicantName, income, loanAmount);
            request.setAttribute("loanType", "Home Loan");
            request.setAttribute("name", applicantName);
            request.setAttribute("income", income);
            request.setAttribute("loanAmount", loanAmount);
            request.setAttribute("approved", loan.isApproved());
            request.setAttribute("resultMsg", loan.applyLoan());

        } else if ("education".equals(loanType)) {
            String studentName = request.getParameter("studentName");
            Double marks = parseDoubleOrNull(request, "marks");
            Double loanAmount = parseDoubleOrNull(request, "loanAmount");

            if (studentName == null || studentName.isBlank() || marks == null || loanAmount == null) {
                request.setAttribute("errorMessage", "Please enter a valid name, marks, and loan amount for Education Loan.");
                request.setAttribute("selectedType", "education");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            EducationLoan loan = new EducationLoan(studentName, marks, loanAmount);
            request.setAttribute("loanType", "Education Loan");
            request.setAttribute("name", studentName);
            request.setAttribute("marks", marks);
            request.setAttribute("loanAmount", loanAmount);
            request.setAttribute("approved", loan.isApproved());
            request.setAttribute("resultMsg", loan.applyLoan());
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        request.setAttribute("selectedType", loanType);
        RequestDispatcher rd = request.getRequestDispatcher("/result.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
