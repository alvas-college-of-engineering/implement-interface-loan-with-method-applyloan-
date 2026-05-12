<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoanSphere — Apply for a Loan</title>
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
            --red: #c0392b;
            --green: #1a7a4a;
            --card-bg: #ffffff;
            --border: #ddd6c4;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background-color: var(--cream);
            min-height: 100vh;
            color: var(--ink);
        }

        /* ── Header ── */
        header {
            background: var(--teal);
            padding: 0 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 70px;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 20px rgba(0,0,0,0.25);
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.7rem;
            font-weight: 900;
            color: var(--gold-light);
            letter-spacing: -0.5px;
        }

        .logo span { color: #ffffff; }

        nav a {
            color: rgba(255,255,255,0.75);
            text-decoration: none;
            margin-left: 28px;
            font-size: 0.9rem;
            font-weight: 500;
            transition: color 0.2s;
        }
        nav a:hover { color: var(--gold-light); }

        /* ── Hero ── */
        .hero {
            background: linear-gradient(135deg, var(--teal) 0%, #0d2e3c 100%);
            color: white;
            text-align: center;
            padding: 80px 40px 100px;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 350px; height: 350px;
            background: radial-gradient(circle, rgba(200,153,58,0.2) 0%, transparent 70%);
            border-radius: 50%;
        }

        .hero::after {
            content: '';
            position: absolute;
            bottom: -80px; left: -40px;
            width: 280px; height: 280px;
            background: radial-gradient(circle, rgba(200,153,58,0.15) 0%, transparent 70%);
            border-radius: 50%;
        }

        .hero-tag {
            display: inline-block;
            background: rgba(200,153,58,0.2);
            color: var(--gold-light);
            border: 1px solid rgba(200,153,58,0.4);
            border-radius: 100px;
            padding: 6px 18px;
            font-size: 0.8rem;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.2rem, 5vw, 3.8rem);
            font-weight: 900;
            line-height: 1.15;
            margin-bottom: 16px;
        }

        .hero h1 em {
            font-style: normal;
            color: var(--gold-light);
        }

        .hero p {
            font-size: 1.05rem;
            color: rgba(255,255,255,0.7);
            max-width: 520px;
            margin: 0 auto;
            line-height: 1.7;
        }

        /* ── Main container ── */
        .container {
            max-width: 900px;
            margin: -50px auto 60px;
            padding: 0 24px;
            position: relative;
            z-index: 10;
        }

        /* ── Loan Type Tabs ── */
        .tab-bar {
            display: flex;
            background: var(--card-bg);
            border-radius: 16px 16px 0 0;
            border: 1px solid var(--border);
            border-bottom: none;
            overflow: hidden;
        }

        .tab-btn {
            flex: 1;
            padding: 18px;
            border: none;
            background: transparent;
            cursor: pointer;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            font-weight: 500;
            color: #888;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.25s;
            border-bottom: 3px solid transparent;
        }

        .tab-btn.active {
            color: var(--teal);
            border-bottom-color: var(--gold);
            background: rgba(26,74,92,0.04);
            font-weight: 600;
        }

        .tab-btn:hover:not(.active) {
            background: rgba(0,0,0,0.03);
            color: var(--teal);
        }

        .tab-icon { font-size: 1.2rem; }

        /* ── Form card ── */
        .form-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-top: none;
            border-radius: 0 0 16px 16px;
            padding: 40px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.08);
        }

        .form-panel { display: none; }
        .form-panel.active { display: block; animation: fadeIn 0.3s ease; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .panel-header {
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 1px solid var(--border);
        }

        .panel-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.7rem;
            font-weight: 700;
            color: var(--teal);
            margin-bottom: 6px;
        }

        .panel-header p {
            color: #888;
            font-size: 0.9rem;
        }

        .eligibility-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(26,74,92,0.08);
            color: var(--teal);
            border-radius: 100px;
            padding: 5px 14px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-top: 10px;
        }

        /* ── Form fields ── */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full-width { grid-column: 1 / -1; }

        label {
            font-size: 0.82rem;
            font-weight: 600;
            color: #555;
            letter-spacing: 0.4px;
            text-transform: uppercase;
        }

        input[type="text"],
        input[type="number"] {
            padding: 12px 16px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            color: var(--ink);
            background: #fafaf8;
            transition: border-color 0.2s, box-shadow 0.2s;
            outline: none;
        }

        input:focus {
            border-color: var(--teal-light);
            box-shadow: 0 0 0 3px rgba(26,74,92,0.12);
            background: #fff;
        }

        .input-prefix-wrap {
            position: relative;
        }

        .input-prefix {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            font-weight: 600;
            font-size: 0.9rem;
            pointer-events: none;
        }

        .input-prefix-wrap input { padding-left: 30px; }

        .hint {
            font-size: 0.78rem;
            color: #aaa;
            margin-top: 2px;
        }

        /* ── Submit button ── */
        .submit-wrap {
            margin-top: 36px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .btn-apply {
            background: linear-gradient(135deg, var(--teal) 0%, var(--teal-light) 100%);
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 12px;
            font-family: 'DM Sans', sans-serif;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            letter-spacing: 0.3px;
            transition: all 0.25s;
            box-shadow: 0 4px 16px rgba(26,74,92,0.3);
        }

        .btn-apply:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(26,74,92,0.4);
        }

        .btn-apply:active { transform: translateY(0); }

        .submit-note {
            font-size: 0.82rem;
            color: #aaa;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* ── Info cards ── */
        .info-strip {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 40px;
        }

        .info-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 24px;
            text-align: center;
        }

        .info-card .ic-icon {
            font-size: 2rem;
            margin-bottom: 12px;
        }

        .info-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1rem;
            color: var(--teal);
            margin-bottom: 6px;
        }

        .info-card p {
            font-size: 0.83rem;
            color: #888;
            line-height: 1.5;
        }

        /* ── Footer ── */
        footer {
            text-align: center;
            padding: 30px;
            color: #aaa;
            font-size: 0.82rem;
            border-top: 1px solid var(--border);
        }

        @media (max-width: 640px) {
            .form-grid { grid-template-columns: 1fr; }
            .info-strip { grid-template-columns: 1fr; }
            .form-card { padding: 24px; }
            header { padding: 0 20px; }
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

<div class="hero">
    <div class="hero-tag">🏦 Instant Eligibility Check</div>
    <h1>Your dream, <em>funded.</em><br>Apply in minutes.</h1>
    <p>Home loans & Education loans with transparent eligibility criteria and instant approval decisions.</p>
</div>

<div class="container">
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String selectedType = (String) request.getAttribute("selectedType");
%>
<% if (errorMessage != null) { %>
    <div class="alert-banner" style="margin-bottom: 24px; padding: 18px 22px; border-radius: 14px; background: #fff1f0; color: #9d1f1f; border: 1px solid #f4c6c4; font-size: 0.95rem;">
        <strong>Heads up:</strong> <%= errorMessage %>
    </div>
<% } %>

    <!-- Tab Bar -->
    <div class="tab-bar">
        <button id="tab-home" class="tab-btn active" onclick="switchTab('home')">
            <span class="tab-icon">🏠</span> Home Loan
        </button>
        <button id="tab-education" class="tab-btn" onclick="switchTab('education')">
            <span class="tab-icon">🎓</span> Education Loan
        </button>
    </div>

    <!-- Form Card -->
    <div class="form-card">

        <!-- Home Loan Panel -->
        <div id="panel-home" class="form-panel active">
            <div class="panel-header">
                <h2>Home Loan Application</h2>
                <p>Fill in your details to check eligibility instantly.</p>
                <div class="eligibility-badge">✅ Min. Income: ₹30,000/month</div>
            </div>

            <form action="${pageContext.request.contextPath}/applyLoan" method="post">
                <input type="hidden" name="loanType" value="home">
                <div class="form-grid">
                    <div class="form-group full-width">
                        <label>Applicant Full Name</label>
                        <input type="text" name="applicantName" placeholder="e.g. Aishwarya Sharma" required>
                    </div>
                    <div class="form-group">
                        <label>Monthly Income</label>
                        <div class="input-prefix-wrap">
                            <span class="input-prefix">₹</span>
                            <input type="number" name="income" placeholder="45000" min="0" step="1000" required>
                        </div>
                        <span class="hint">Minimum ₹30,000 required for approval</span>
                    </div>
                    <div class="form-group">
                        <label>Requested Loan Amount</label>
                        <div class="input-prefix-wrap">
                            <span class="input-prefix">₹</span>
                            <input type="number" name="loanAmount" placeholder="2500000" min="0" step="10000" required>
                        </div>
                        <span class="hint">Enter desired loan amount in rupees</span>
                    </div>
                </div>
                <div class="submit-wrap">
                    <button type="submit" class="btn-apply">Check Eligibility →</button>
                    <span class="submit-note">🔒 Secure &amp; Confidential</span>
                </div>
            </form>
        </div>

        <!-- Education Loan Panel -->
        <div id="panel-education" class="form-panel">
            <div class="panel-header">
                <h2>Education Loan Application</h2>
                <p>Support your academic journey with our education loan.</p>
                <div class="eligibility-badge">✅ Min. Academic Score: 60%</div>
            </div>

            <form action="${pageContext.request.contextPath}/applyLoan" method="post">
                <input type="hidden" name="loanType" value="education">
                <div class="form-grid">
                    <div class="form-group full-width">
                        <label>Student Full Name</label>
                        <input type="text" name="studentName" placeholder="e.g. Rahul Verma" required>
                    </div>
                    <div class="form-group">
                        <label>Academic Score (%)</label>
                        <input type="number" name="marks" placeholder="75" min="0" max="100" step="0.1" required>
                        <span class="hint">Minimum 60% required for approval</span>
                    </div>
                    <div class="form-group">
                        <label>Requested Loan Amount</label>
                        <div class="input-prefix-wrap">
                            <span class="input-prefix">₹</span>
                            <input type="number" name="loanAmount" placeholder="500000" min="0" step="10000" required>
                        </div>
                        <span class="hint">Enter desired loan amount in rupees</span>
                    </div>
                </div>
                <div class="submit-wrap">
                    <button type="submit" class="btn-apply">Check Eligibility →</button>
                    <span class="submit-note">🔒 Secure &amp; Confidential</span>
                </div>
            </form>
        </div>

    </div><!-- /form-card -->

    <!-- Info Cards -->
    <div class="info-strip">
        <div class="info-card">
            <div class="ic-icon">⚡</div>
            <h3>Instant Decision</h3>
            <p>Get your loan eligibility result in seconds with no waiting period.</p>
        </div>
        <div class="info-card">
            <div class="ic-icon">🔒</div>
            <h3>100% Secure</h3>
            <p>Your personal and financial details are protected end-to-end.</p>
        </div>
        <div class="info-card">
            <div class="ic-icon">📋</div>
            <h3>Simple Criteria</h3>
            <p>Clear eligibility conditions — no hidden requirements or surprise fees.</p>
        </div>
    </div>

</div><!-- /container -->

<footer>
    &copy; 2026 LoanSphere &mdash; A demo JSP project. All rights reserved.
</footer>

<script>
    var initialLoanTab = '<%= selectedType != null ? selectedType : "home" %>';

    function activateTab(type) {
        document.querySelectorAll('.form-panel').forEach(p => p.classList.remove('active'));
        var panel = document.getElementById('panel-' + type);
        if (panel) {
            panel.classList.add('active');
        }

        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        var button = document.getElementById('tab-' + type);
        if (button) {
            button.classList.add('active');
        }
    }

    function switchTab(type) {
        activateTab(type);
    }

    window.addEventListener('DOMContentLoaded', function () {
        activateTab(initialLoanTab);
    });
</script>

</body>
</html>
