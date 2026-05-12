<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String loanType   = (String)  request.getAttribute("loanType");
    String name       = (String)  request.getAttribute("name");
    Boolean approved  = (Boolean) request.getAttribute("approved");
    String resultMsg  = (String)  request.getAttribute("resultMsg");
    String selType    = (String)  request.getAttribute("selectedType");
    Object incomeObj  = request.getAttribute("income");
    Object marksObj   = request.getAttribute("marks");
    Object loanAmtObj = request.getAttribute("loanAmount");

    boolean isApproved = (approved != null && approved);
    double loanAmount = loanAmtObj != null ? ((Number) loanAmtObj).doubleValue() : 0;
    double income     = incomeObj  != null ? ((Number) incomeObj).doubleValue()  : 0;
    double marks      = marksObj   != null ? ((Number) marksObj).doubleValue()   : 0;

    java.text.NumberFormat nf = java.text.NumberFormat.getInstance(new java.util.Locale("en", "IN"));
    nf.setMaximumFractionDigits(0);

    if (loanType == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoanSphere — Application Result</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --ink: #0d0d0d;
            --cream: #f5f0e8;
            --gold: #c8993a;
            --gold-light: #e8c46a;
            --teal: #1a4a5c;
            --teal-light: #2a6e87;
            --border: #ddd6c4;
            --approved-bg: #eef8f2;
            --approved-border: #b5e0c8;
            --approved-text: #1a7a4a;
            --rejected-bg: #fef2f2;
            --rejected-border: #f5c6c6;
            --rejected-text: #c0392b;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background-color: var(--cream);
            min-height: 100vh;
            color: var(--ink);
        }

        header {
            background: var(--teal);
            padding: 0 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 70px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.25);
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.7rem;
            font-weight: 900;
            color: var(--gold-light);
        }
        .logo span { color: #fff; }

        nav a {
            color: rgba(255,255,255,0.75);
            text-decoration: none;
            margin-left: 28px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        nav a:hover { color: var(--gold-light); }

        .container {
            max-width: 680px;
            margin: 60px auto;
            padding: 0 24px;
        }

        /* Result badge */
        .result-badge {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 20px 28px;
            border-radius: 16px 16px 0 0;
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            font-weight: 700;
        }

        .result-badge.approved {
            background: var(--approved-bg);
            border: 1px solid var(--approved-border);
            border-bottom: none;
            color: var(--approved-text);
        }

        .result-badge.rejected {
            background: var(--rejected-bg);
            border: 1px solid var(--rejected-border);
            border-bottom: none;
            color: var(--rejected-text);
        }

        .badge-icon { font-size: 2rem; }

        /* Detail card */
        .detail-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 0 0 16px 16px;
            padding: 36px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.08);
        }

        .detail-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1rem;
            color: #888;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 20px;
        }

        .detail-table {
            width: 100%;
            border-collapse: collapse;
        }

        .detail-table tr {
            border-bottom: 1px solid #f0ebe0;
        }

        .detail-table tr:last-child { border-bottom: none; }

        .detail-table td {
            padding: 14px 0;
            font-size: 0.95rem;
        }

        .detail-table td:first-child {
            color: #888;
            font-weight: 500;
            width: 45%;
        }

        .detail-table td:last-child {
            color: var(--ink);
            font-weight: 600;
            text-align: right;
        }

        .verdict-row td {
            padding-top: 20px !important;
        }

        .verdict-pill {
            display: inline-block;
            padding: 6px 20px;
            border-radius: 100px;
            font-size: 0.88rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .verdict-pill.approved {
            background: var(--approved-bg);
            color: var(--approved-text);
            border: 1px solid var(--approved-border);
        }

        .verdict-pill.rejected {
            background: var(--rejected-bg);
            color: var(--rejected-text);
            border: 1px solid var(--rejected-border);
        }

        /* Criteria box */
        .criteria-box {
            margin-top: 24px;
            padding: 18px 20px;
            border-radius: 12px;
            font-size: 0.88rem;
            line-height: 1.6;
        }

        .criteria-box.approved {
            background: var(--approved-bg);
            border: 1px solid var(--approved-border);
            color: var(--approved-text);
        }

        .criteria-box.rejected {
            background: var(--rejected-bg);
            border: 1px solid var(--rejected-border);
            color: var(--rejected-text);
        }

        .criteria-box strong { display: block; margin-bottom: 4px; font-size: 0.92rem; }

        /* Actions */
        .actions {
            display: flex;
            gap: 14px;
            margin-top: 36px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--teal), var(--teal-light));
            color: white;
            text-decoration: none;
            padding: 13px 28px;
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-weight: 600;
            font-size: 0.92rem;
            transition: all 0.2s;
            box-shadow: 0 4px 14px rgba(26,74,92,0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26,74,92,0.4);
        }

        .btn-secondary {
            background: white;
            color: var(--teal);
            text-decoration: none;
            padding: 13px 28px;
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-weight: 600;
            font-size: 0.92rem;
            border: 1.5px solid var(--border);
            transition: all 0.2s;
        }

        .btn-secondary:hover {
            background: var(--cream);
            border-color: var(--teal-light);
        }

        footer {
            text-align: center;
            padding: 30px;
            color: #aaa;
            font-size: 0.82rem;
            border-top: 1px solid var(--border);
            margin-top: 40px;
        }

        @media (max-width: 480px) {
            .actions { flex-direction: column; }
            .detail-card { padding: 24px; }
        }
    </style>
</head>
<body>

<header>
    <div class="logo">Loan<span>Sphere</span></div>
    <nav>
        <a href="index.jsp">Apply</a>
        <a href="#">About</a>
        <a href="#">Contact</a>
    </nav>
</header>

<div class="container">

    <div class="result-badge <%= isApproved ? "approved" : "rejected" %>">
        <span class="badge-icon"><%= isApproved ? "✅" : "❌" %></span>
        <%= isApproved ? "Congratulations! Your loan is approved." : "Unfortunately, your loan was not approved." %>
    </div>

    <div class="detail-card">

        <h3>Application Summary</h3>

        <table class="detail-table">
            <tr>
                <td>Loan Type</td>
                <td><%= loanType %></td>
            </tr>
            <tr>
                <td><%= "home".equals(selType) ? "Applicant Name" : "Student Name" %></td>
                <td><%= name %></td>
            </tr>
            <% if ("home".equals(selType)) { %>
            <tr>
                <td>Monthly Income</td>
                <td>₹ <%= nf.format(income) %></td>
            </tr>
            <% } else { %>
            <tr>
                <td>Academic Score</td>
                <td><%= marks %>%</td>
            </tr>
            <% } %>
            <tr>
                <td>Loan Amount Requested</td>
                <td>₹ <%= nf.format(loanAmount) %></td>
            </tr>
            <tr class="verdict-row">
                <td>Verdict</td>
                <td>
                    <span class="verdict-pill <%= isApproved ? "approved" : "rejected" %>">
                        <%= isApproved ? "✓ APPROVED" : "✗ REJECTED" %>
                    </span>
                </td>
            </tr>
        </table>

        <div class="criteria-box <%= isApproved ? "approved" : "rejected" %>">
            <% if ("home".equals(selType)) { %>
                <% if (isApproved) { %>
                    <strong>✅ Eligibility Criteria Met</strong>
                    Your monthly income of ₹<%= nf.format(income) %> meets the minimum requirement of ₹30,000/month for Home Loans.
                <% } else { %>
                    <strong>❌ Eligibility Criteria Not Met</strong>
                    Your monthly income of ₹<%= nf.format(income) %> is below the required ₹30,000/month. Please reapply when your income increases.
                <% } %>
            <% } else { %>
                <% if (isApproved) { %>
                    <strong>✅ Eligibility Criteria Met</strong>
                    Your academic score of <%= marks %>% meets the minimum requirement of 60% for Education Loans.
                <% } else { %>
                    <strong>❌ Eligibility Criteria Not Met</strong>
                    Your academic score of <%= marks %>% is below the required 60%. Please reapply with updated academic records.
                <% } %>
            <% } %>
        </div>

        <div class="actions">
            <a href="index.jsp" class="btn-primary">← Apply for Another Loan</a>
            <a href="index.jsp" class="btn-secondary">Back to Home</a>
        </div>

    </div>
</div>

<footer>
    &copy; 2026 LoanSphere &mdash; A demo JSP project. All rights reserved.
</footer>

</body>
</html>
