<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Users.UserDashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .dash-wrap {
            margin-top: 0;
            width: calc(100% + 60px);
            margin-left: -30px;
            background: #AED3EF;
            min-height: 100vh;
            padding: 28px 32px 48px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
            color: #355872;
        }

        .dash-header { margin-bottom: 22px; display: flex; align-items: flex-start; justify-content: space-between; flex-wrap: wrap; gap: 12px; }
        .dash-header h1 {
            font-size: 22px;
            font-weight: 700;
            color: #355872;
            margin: 0 0 4px;
        }
        .dash-header p {
            font-size: 13px;
            color: #4a7a96;
            margin: 0;
        }

        .stat-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
            margin-bottom: 20px;
        }
        .stat-card {
            background: #F7F8F0;
            border-radius: 12px;
            padding: 16px 18px;
            border: 1px solid #dde8f0;
            position: relative;
            overflow: hidden;
        }
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            border-radius: 12px 12px 0 0;
        }
        .stat-card.blue::before   { background: #2f6fa3; }
        .stat-card.red::before    { background: #e24b4a; }
        .stat-card.orange::before { background: #e9900c; }
        .stat-card.green::before  { background: #2d9e5f; }
        .stat-label {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #7a9bb5;
            margin-bottom: 6px;
        }
        .stat-value {
            font-size: 26px;
            font-weight: 700;
            color: #355872;
            line-height: 1;
        }
        .stat-value.md { font-size: 18px; padding-top: 4px; }
        .stat-unit {
            font-size: 12px;
            color: #7a9bb5;
            margin-top: 4px;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 16px;
            margin-bottom: 16px;
        }
        .grid-3 {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }

        .card {
            background: #F7F8F0;
            border-radius: 12px;
            padding: 20px;
            border: 1px solid #dde8f0;
        }
        .card-title {
            font-size: 14px;
            font-weight: 700;
            color: #355872;
            margin: 0 0 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .card-title span {
            font-size: 12px;
            font-weight: 500;
            color: #7a9bb5;
        }

        .chart-wrap { position: relative; width: 100%; height: 220px; }
        .donut-wrap {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 200px;
        }

        .legend { display: flex; gap: 12px; flex-wrap: wrap; justify-content: center; margin-top: 10px; }
        .legend-item { display: flex; align-items: center; gap: 5px; font-size: 11px; color: #7a9bb5; font-weight: 600; }
        .legend-dot { width: 9px; height: 9px; border-radius: 2px; flex-shrink: 0; }

        .bill-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #dde8f0;
        }
        .bill-row:last-of-type { border-bottom: none; }
        .bill-name { font-size: 13px; font-weight: 600; color: #355872; }
        .bill-date { font-size: 11px; color: #7a9bb5; margin-top: 1px; }
        .bill-amount { font-size: 14px; font-weight: 700; color: #355872; }
        .bill-right { display: flex; align-items: center; gap: 10px; }

        .status-badge {
            font-size: 10px;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }
        .badge-paid     { background: #d4f0e2; color: #1a6e40; }
        .badge-unpaid   { background: #fde8e8; color: #a32d2d; }
        .badge-partial  { background: #feecd4; color: #8a4c10; }

        .action-box {
            margin-top: 14px;
            padding: 12px 14px;
            border-radius: 8px;
            border-left: 3px solid #e9900c;
            background: #fff8ed;
        }
        .action-box-label {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            color: #8a4c10;
            margin-bottom: 3px;
        }
        .action-box p { font-size: 12px; color: #8a4c10; margin: 0 0 8px; }
        .pay-btn {
            display: inline-block;
            text-decoration: none;
            background: #2f6fa3;
            color: white;
            border: none;
            padding: 7px 18px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            letter-spacing: 0.2px;
            transition: background 0.2s;
        }
        .pay-btn:hover { background: #245a87; }

        .usage-row {
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #dde8f0;
            gap: 12px;
        }
        .usage-row:last-of-type { border-bottom: none; }
        .usage-month { font-size: 13px; font-weight: 600; color: #355872; width: 70px; flex-shrink: 0; }
        .usage-bar-bg {
            flex: 1;
            height: 8px;
            border-radius: 4px;
            background: #AED3EF;
            overflow: hidden;
        }
        .usage-bar-fill {
            height: 100%;
            border-radius: 4px;
            background: #7AAACE;
        }
        .usage-val { font-size: 13px; font-weight: 700; color: #2f6fa3; width: 56px; text-align: right; flex-shrink: 0; }

        .usage-summary {
            margin-top: 14px;
            padding: 10px 14px;
            background: #EBF5FF;
            border-radius: 8px;
            border-left: 3px solid #7AAACE;
        }
        .usage-summary-label { font-size: 12px; font-weight: 600; color: #2f6fa3; }
        .usage-summary-val { font-size: 19px; font-weight: 700; color: #355872; }
        .usage-summary-val small { font-size: 12px; font-weight: 500; color: #7a9bb5; }

        .ann-item {
            padding: 12px 0;
            border-bottom: 1px solid #dde8f0;
        }
        .ann-item:last-of-type { border-bottom: none; }
        .ann-cat {
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-bottom: 3px;
        }
        .ann-cat.important { color: #e24b4a; }
        .ann-cat.regular   { color: #2f6fa3; }
        .ann-title { font-size: 13px; font-weight: 700; color: #355872; margin-bottom: 2px; }
        .ann-desc  { font-size: 12px; color: #7a9bb5; }
        .ann-date  { font-size: 11px; color: #7a9bb5; margin-top: 4px; }

        .no-data { font-size: 13px; color: #7a9bb5; text-align: center; padding: 20px 0; }

        @media (max-width: 1024px) {
            .stat-row  { grid-template-columns: repeat(2, 1fr); }
            .grid-2    { grid-template-columns: 1fr; }
            .grid-3    { grid-template-columns: 1fr; }
            .dash-wrap { padding: 20px 16px 40px; width: calc(100% + 32px); margin-left: -16px; }
        }
    </style>

    <div class="dash-wrap">
        <div class="dash-header">
            <div>
                <h1>Welcome back, <asp:Label ID="lblFirstName" runat="server" Text="User" /></h1>
                <p>
                    <asp:Label ID="lblBarangayName" runat="server" Text="" /> &nbsp;&middot;&nbsp;
                    <asp:Label ID="lblAddress" runat="server" Text="" /> &nbsp;&middot;&nbsp;
                    Member since <asp:Label ID="lblMemberSince" runat="server" Text="" />
                </p>
            </div>
            <a href="/Pages/Users/Transactions.aspx" style="font-size:13px; font-weight:600; color:#2f6fa3; text-decoration:none; padding:7px 16px; border:1.5px solid #7AAACE; border-radius:8px; background:#F7F8F0; transition:all 0.15s; white-space:nowrap; display:inline-block;"
               onmouseover="this.style.background='#2f6fa3';this.style.color='#fff';this.style.borderColor='#2f6fa3';"
               onmouseout="this.style.background='#F7F8F0';this.style.color='#2f6fa3';this.style.borderColor='#7AAACE';">
                View Transactions >>>
            </a>
        </div>

        <div class="stat-row">
            <div class="stat-card blue">
                <div class="stat-label">Current Usage</div>
                <div class="stat-value"><asp:Label ID="lblUsageValue" runat="server" Text="—" /></div>
                <div class="stat-unit"><asp:Label ID="lblUsagePeriod" runat="server" Text="No readings yet" /></div>
            </div>
            <div class="stat-card red">
                <div class="stat-label">Amount Due</div>
                <div class="stat-value"><asp:Label ID="lblAmountDue" runat="server" Text="₱0.00" /></div>
                <div class="stat-unit"><asp:Label ID="lblDueDate" runat="server" Text="" /></div>
            </div>
            <div class="stat-card orange">
                <div class="stat-label">Bill Status</div>
                <div class="stat-value md"><asp:Label ID="lblBillStatus" runat="server" Text="—" /></div>
                <div class="stat-unit"><asp:Label ID="lblBillPeriod" runat="server" Text="" /></div>
            </div>
            <div class="stat-card green">
                <div class="stat-label">Account Status</div>
                <div class="stat-value md"><asp:Label ID="lblApprovalStatus" runat="server" Text="—" /></div>
                <div class="stat-unit">User ID: <asp:Label ID="lblUserID" runat="server" Text="" /></div>
            </div>
        </div>

        <div class="grid-2">

            <div class="card">
                <div class="card-title">Monthly Water Usage <span>cubic meters (m³)</span></div>
                <div class="chart-wrap">
                    <canvas id="barChart"></canvas>
                </div>
                <asp:Button ID="btnViewAnalytics" runat="server" Text="View Analytics →"
                    CssClass="pay-btn" OnClick="btnViewAnalytics_Click"
                    style="margin-top:12px; font-size:12px; padding:6px 14px;" />
            </div>

            <div class="card">
                <div class="card-title">Invoice Status</div>
                <div class="donut-wrap">
                    <canvas id="donutChart" style="max-width:160px; max-height:160px;"></canvas>
                </div>
                <div class="legend">
                    <div class="legend-item">
                        <div class="legend-dot" style="background:#e24b4a;"></div>Unpaid
                        (<asp:Label ID="lblCountUnpaid" runat="server" Text="0" />)
                    </div>
                    <div class="legend-item">
                        <div class="legend-dot" style="background:#e9900c;"></div>Partially Paid
                        (<asp:Label ID="lblCountPartial" runat="server" Text="0" />)
                    </div>
                    <div class="legend-item">
                        <div class="legend-dot" style="background:#2d9e5f;"></div>Paid
                        (<asp:Label ID="lblCountPaid" runat="server" Text="0" />)
                    </div>
                </div>
            </div>

        </div>

        <div class="grid-3">
            <div class="card">
                <div class="card-title">Usage Log <span>m³ per month</span></div>
                <asp:Repeater ID="rptUsage" runat="server">
                    <ItemTemplate>
                        <div class="usage-row">
                            <div class="usage-month"><%# Eval("MonthLabel") %></div>
                            <div class="usage-bar-bg">
                                <div class="usage-bar-fill" style="width:<%# Eval("BarPct") %>%;"></div>
                            </div>
                            <div class="usage-val"><%# Eval("ConsumptionValue") %> m³</div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoUsage" runat="server" Visible="false">
                    <div class="no-data">No usage data on record yet.</div>
                </asp:Panel>
                <div class="usage-summary">
                    <div class="usage-summary-label">Latest Reading</div>
                    <div class="usage-summary-val">
                        <asp:Label ID="lblLatestUsage" runat="server" Text="—" /> m³
                        <small><asp:Label ID="lblLatestPeriod" runat="server" Text="" /></small>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-title">
                    Recent Bills
                    <a href="/Pages/Users/Bills.aspx" style="font-size:12px; font-weight:600; color:#2f6fa3; text-decoration:none;">View All >>></a>
                </div>
                <asp:Repeater ID="rptBills" runat="server">
                    <ItemTemplate>
                        <div class="bill-row">
                            <div>
                                <div class="bill-name"><%# Eval("BillLabel") %></div>
                                <div class="bill-date">Due: <%# Eval("DueDateStr") %></div>
                            </div>
                            <div class="bill-right">
                                <div class="bill-amount">₱<%# Eval("AmountDue") %></div>
                                <span class="status-badge <%# Eval("BadgeClass") %>"><%# Eval("Status") %></span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoBills" runat="server" Visible="false">
                    <div class="no-data">No bills on record yet.</div>
                </asp:Panel>
                <asp:Panel ID="pnlActionBox" runat="server" Visible="false">
                    <div class="action-box">
                        <div class="action-box-label">Action Required</div>
                        <p>You have an outstanding balance. Please settle your bill before the due date to avoid penalties.</p>
                        <a href="/Pages/Users/Bills.aspx" class="pay-btn">Pay Now &rarr;</a>
                    </div>
                </asp:Panel>
            </div>

            <div class="card">
                <div class="card-title">Announcements</div>
                <asp:Repeater ID="rptAnnouncements" runat="server">
                    <ItemTemplate>
                        <div class="ann-item">
                            <div class="ann-cat <%# Eval("CategoryClass") %>"><%# Eval("Category") %></div>
                            <div class="ann-title"><%# Eval("Title") %></div>
                            <div class="ann-desc"><%# Eval("Description") %></div>
                            <div class="ann-date"><%# Eval("DateStr") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoAnnouncements" runat="server" Visible="false">
                    <div class="no-data">No announcements at this time.</div>
                </asp:Panel>
            </div>

        </div>
    </div>

    <asp:HiddenField ID="hdnChartData" runat="server" Value="" />
    <asp:HiddenField ID="hdnDonutData" runat="server" Value="" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
    <script>
        (function () {
            var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

            var rawBar = document.getElementById('<%= hdnChartData.ClientID %>').value;
            var barData = rawBar ? JSON.parse(rawBar) : new Array(12).fill(0);

            new Chart(document.getElementById('barChart'), {
                type: 'bar',
                data: {
                    labels: months,
                    datasets: [{
                        label: 'Usage (m³)',
                        data: barData,
                        backgroundColor: '#7AAACE',
                        borderColor: '#2f6fa3',
                        borderWidth: 1,
                        borderRadius: 4,
                        hoverBackgroundColor: '#2f6fa3'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            callbacks: { label: function(ctx){ return ' ' + ctx.raw + ' m³'; } }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(174,211,239,0.45)' },
                            ticks: { color: '#7a9bb5', font: { size: 11 } }
                        },
                        x: {
                            grid: { display: false },
                            ticks: { color: '#7a9bb5', font: { size: 11 }, autoSkip: false }
                        }
                    }
                }
            });

            var rawDonut = document.getElementById('<%= hdnDonutData.ClientID %>').value;
            var donutData = rawDonut ? JSON.parse(rawDonut) : [0, 0, 0];
            var total = donutData[0] + donutData[1] + donutData[2];
            if (total === 0) donutData = [1, 0, 0];

            new Chart(document.getElementById('donutChart'), {
                type: 'doughnut',
                data: {
                    labels: ['Unpaid', 'Partially Paid', 'Paid'],
                    datasets: [{
                        data: donutData,
                        backgroundColor: ['#e24b4a', '#e9900c', '#2d9e5f'],
                        borderWidth: 2,
                        borderColor: '#F7F8F0',
                        hoverOffset: 6
                    }]
                },
                options: {
                    responsive: false,
                    cutout: '62%',
                    plugins: {
                        legend: { display: false },
                        tooltip: { callbacks: { label: function (ctx) { return ' ' + ctx.label + ': ' + ctx.raw; } } }
                    }
                }
            });
        })();
    </script>

</asp:Content>