<%@ Page Title="My Transactions" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Users.Transactions" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .footer { display: none !important; }

        .txn-wrap {
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

        .page-header { margin-bottom: 22px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; }
        .page-header-left h1 { font-size: 22px; font-weight: 700; color: #355872; margin: 0 0 4px; }
        .page-header-left p  { font-size: 13px; color: #7a9bb5; margin: 0; }
        .back-link {
            font-size: 13px; font-weight: 600; color: #2f6fa3;
            text-decoration: none; padding: 7px 16px;
            border: 1.5px solid #7AAACE; border-radius: 8px;
            background: #F7F8F0; transition: all 0.15s; white-space: nowrap;
        }
        .back-link:hover { background: #2f6fa3; color: #fff; border-color: #2f6fa3; }

        .stat-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 14px; margin-bottom: 20px; }
        .stat-card { background: #F7F8F0; border-radius: 12px; padding: 16px 18px; border: 1px solid #dde8f0; position: relative; overflow: hidden; }
        .stat-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px; border-radius: 12px 12px 0 0; }
        .stat-card.blue::before   { background: #2f6fa3; }
        .stat-card.green::before  { background: #2d9e5f; }
        .stat-card.purple::before { background: #7c3aed; }
        .stat-card.orange::before { background: #e9900c; }
        .stat-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: #7a9bb5; margin-bottom: 6px; }
        .stat-value { font-size: 24px; font-weight: 700; color: #355872; line-height: 1; }
        .stat-unit  { font-size: 12px; color: #7a9bb5; margin-top: 4px; }

        .main-grid { display: grid; grid-template-columns: 1fr 300px; gap: 16px; align-items: start; }

        .card { background: #F7F8F0; border-radius: 12px; padding: 20px; border: 1px solid #dde8f0; }
        .card-title { font-size: 14px; font-weight: 700; color: #355872; margin: 0 0 16px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 8px; }
        .card-title span { font-size: 12px; font-weight: 500; color: #7a9bb5; }

        .filter-bar { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 16px; }
        .filter-btn { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; border: 1.5px solid #dde8f0; background: transparent; color: #7a9bb5; cursor: pointer; transition: all 0.15s; font-family: Arial, sans-serif; }
        .filter-btn:hover  { background: #AED3EF; border-color: #7AAACE; color: #355872; }
        .filter-btn.active { background: #2f6fa3; border-color: #2f6fa3; color: #fff; }
        .filter-btn.f-card { border-color: #2f6fa3; color: #2f6fa3; }
        .filter-btn.f-card:hover, .filter-btn.f-card.active { background: #2f6fa3; border-color: #2f6fa3; color: #fff; }
        .filter-btn.f-cash { border-color: #2d9e5f; color: #2d9e5f; }
        .filter-btn.f-cash:hover, .filter-btn.f-cash.active { background: #2d9e5f; border-color: #2d9e5f; color: #fff; }

        .txn-table { width: 100%; border-collapse: collapse; }
        .txn-table thead th { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: #7a9bb5; padding: 0 12px 10px; text-align: left; border-bottom: 1.5px solid #dde8f0; }
        .txn-table thead th:last-child { text-align: right; }
        .txn-table tbody tr { border-bottom: 1px solid #dde8f0; transition: background 0.12s; }
        .txn-table tbody tr:last-child { border-bottom: none; }
        .txn-table tbody tr:hover { background: #EBF5FF; }
        .txn-table tbody td { padding: 13px 12px; font-size: 13px; color: #355872; vertical-align: middle; }
        .txn-table tbody td:last-child { text-align: right; }
        .txn-ref  { font-size: 11px; color: #7a9bb5; font-weight: 600; }
        .txn-bill { font-weight: 700; font-size: 13px; color: #355872; }
        .txn-amt  { font-weight: 700; font-size: 14px; color: #355872; }
        .method-badge { display: inline-block; font-size: 11px; font-weight: 700; padding: 3px 9px; border-radius: 20px; white-space: nowrap; }
        .method-card  { background: #EBF5FF; color: #2f6fa3; }
        .method-cash  { background: #d4f0e2; color: #1a6e40; }
        .no-data { font-size: 13px; color: #7a9bb5; text-align: center; padding: 32px 0; }

        .sidebar { display: flex; flex-direction: column; gap: 16px; }
        .chart-wrap { position: relative; width: 100%; height: 180px; }
        .breakdown-row { display: flex; align-items: center; justify-content: space-between; padding: 9px 0; border-bottom: 1px solid #dde8f0; }
        .breakdown-row:last-child { border-bottom: none; }
        .breakdown-label { display: flex; align-items: center; gap: 8px; font-size: 13px; font-weight: 600; color: #355872; }
        .breakdown-dot { width: 10px; height: 10px; border-radius: 3px; flex-shrink: 0; }
        .breakdown-val { font-weight: 700; color: #355872; font-size: 13px; }
        .breakdown-sub { font-size: 11px; color: #7a9bb5; margin-top: 1px; text-align: right; }

        .bill-txn-row { padding: 11px 0; border-bottom: 1px solid #dde8f0; }
        .bill-txn-row:last-child { border-bottom: none; }
        .bill-txn-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 3px; }
        .bill-txn-name { font-size: 13px; font-weight: 700; color: #355872; }
        .bill-txn-amt  { font-size: 14px; font-weight: 700; color: #355872; }
        .bill-txn-meta { font-size: 11px; color: #7a9bb5; }

        @media (max-width: 1024px) {
            .stat-row  { grid-template-columns: repeat(2, 1fr); }
            .main-grid { grid-template-columns: 1fr; }
            .txn-wrap  { padding: 20px 16px 40px; width: calc(100% + 32px); margin-left: -16px; }
        }
    </style>

    <div class="txn-wrap">
        <div class="page-header">
            <div class="page-header-left">
                <h1>My Transactions</h1>
                <p>Full payment history on your account.</p>
            </div>
            <a href="/Pages/Users/Bills.aspx" class="back-link"><<< View Bills</a>
        </div>

        <div class="stat-row">
            <div class="stat-card blue">
                <div class="stat-label">Total Transactions</div>
                <div class="stat-value"><asp:Label ID="lblTotalTxn" runat="server" Text="0" /></div>
                <div class="stat-unit">all time</div>
            </div>
            <div class="stat-card green">
                <div class="stat-label">Total Amount Paid</div>
                <div class="stat-value"><asp:Label ID="lblTotalPaid" runat="server" Text="&#8369;0.00" /></div>
                <div class="stat-unit">cumulative</div>
            </div>
            <div class="stat-card purple">
                <div class="stat-label">Paid by Card</div>
                <div class="stat-value"><asp:Label ID="lblCardCount" runat="server" Text="0" /></div>
                <div class="stat-unit"><asp:Label ID="lblCardAmt" runat="server" Text="&#8369;0.00" /></div>
            </div>
            <div class="stat-card orange">
                <div class="stat-label">Paid by Cash</div>
                <div class="stat-value"><asp:Label ID="lblCashCount" runat="server" Text="0" /></div>
                <div class="stat-unit"><asp:Label ID="lblCashAmt" runat="server" Text="&#8369;0.00" /></div>
            </div>
        </div>

        <div class="main-grid">
            <div class="card">
                <div class="card-title">
                    All Transactions
                    <span><asp:Label ID="lblTxnCount" runat="server" Text="0 records" /></span>
                </div>

                <div class="filter-bar">
                    <button type="button" class="filter-btn active" onclick="filterTxn('all', this)">All</button>
                    <button type="button" class="filter-btn f-card" onclick="filterTxn('Card', this)">Card</button>
                    <button type="button" class="filter-btn f-cash" onclick="filterTxn('Cash', this)">Cash</button>
                </div>

                <table class="txn-table" id="txnTable">
                    <thead>
                        <tr>
                            <th>Reference</th>
                            <th>Bill</th>
                            <th>Date</th>
                            <th>Method</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptTxn" runat="server">
                            <ItemTemplate>
                                <tr data-method='<%# Eval("PaymentMethod") %>'>
                                    <td><div class="txn-ref">#<%# Eval("TransactionID") %></div></td>
                                    <td>
                                        <div class="txn-bill">Bill #<%# Eval("BillID") %></div>
                                        <div class="txn-ref"><%# Eval("BillPeriod") %></div>
                                    </td>
                                    <td><%# Eval("PaymentDate") %></td>
                                    <td><span class="method-badge <%# Eval("MethodClass") %>"><%# Eval("PaymentMethod") %></span></td>
                                    <td class="txn-amt">&#8369;<%# Eval("AmountPaid") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <asp:Panel ID="pnlNoTxn" runat="server" Visible="false">
                    <div class="no-data">No transactions found.</div>
                </asp:Panel>
                <div id="filterEmptyMsg" class="no-data" style="display:none;">No transactions found.</div>
            </div>

            <div class="sidebar">
                <div class="card">
                    <div class="card-title">Payment Methods</div>
                    <div class="chart-wrap">
                        <canvas id="methodChart"></canvas>
                    </div>
                    <div style="margin-top:12px;">
                        <div class="breakdown-row">
                            <div class="breakdown-label">
                                <div class="breakdown-dot" style="background:#2f6fa3;"></div>Card
                            </div>
                            <div style="text-align:right;">
                                <div class="breakdown-val"><asp:Label ID="lblCardBreakAmt" runat="server" Text="&#8369;0.00" /></div>
                                <div class="breakdown-sub"><asp:Label ID="lblCardBreakCount" runat="server" Text="0 transactions" /></div>
                            </div>
                        </div>
                        <div class="breakdown-row">
                            <div class="breakdown-label">
                                <div class="breakdown-dot" style="background:#2d9e5f;"></div>Cash
                            </div>
                            <div style="text-align:right;">
                                <div class="breakdown-val"><asp:Label ID="lblCashBreakAmt" runat="server" Text="&#8369;0.00" /></div>
                                <div class="breakdown-sub"><asp:Label ID="lblCashBreakCount" runat="server" Text="0 transactions" /></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-title">Payments per Bill</div>
                    <asp:Repeater ID="rptBillSummary" runat="server">
                        <ItemTemplate>
                            <div class="bill-txn-row">
                                <div class="bill-txn-top">
                                    <div class="bill-txn-name">Bill #<%# Eval("BillID") %></div>
                                    <div class="bill-txn-amt">&#8369;<%# Eval("TotalPaid") %></div>
                                </div>
                                <div class="bill-txn-meta"><%# Eval("BillPeriod") %> &nbsp;&middot;&nbsp; <%# Eval("TxnCount") %> payment(s)</div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Panel ID="pnlNoBillSummary" runat="server" Visible="false">
                        <div class="no-data">No data yet.</div>
                    </asp:Panel>
                </div>

            </div>
        </div>
    </div>

    <asp:HiddenField ID="hdnMethodData" runat="server" Value="" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
    <script>
        var raw = document.getElementById('<%= hdnMethodData.ClientID %>').value;
        var d = [0, 0];
        try { d = JSON.parse(raw); } catch(e){}
        var isEmpty = d[0] === 0 && d[1] === 0;

        new Chart(document.getElementById('methodChart'), {
            type: 'doughnut',
            data: {
                labels: ['Card', 'Cash'],
                datasets: [{
                    data: isEmpty ? [1, 1] : d,
                    backgroundColor: isEmpty ? ['#dde8f0', '#dde8f0'] : ['#2f6fa3', '#2d9e5f'],
                    borderWidth: 2,
                    borderColor: '#F7F8F0',
                    hoverOffset: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '62%',
                plugins: {
                    legend: { display: false },
                    tooltip: { callbacks: { label: function(ctx){ return isEmpty ? 'No data' : ' ' + ctx.label + ': ' + ctx.raw + ' txn(s)'; } } }
                }
            }
        });

        function filterTxn(method, btn) {
            document.querySelectorAll('.filter-btn').forEach(function(b){ b.classList.remove('active'); });
            btn.classList.add('active');

            var count = 0;
            document.querySelectorAll('#txnTable tbody tr').forEach(function(r){
                if (method === 'all' || r.dataset.method === method) {
                    r.style.display = ''; count++;
                } else {
                    r.style.display = 'none';
                }
            });

            document.getElementById('filterEmptyMsg').style.display = count === 0 ? 'block' : 'none';
        }
    </script>

</asp:Content>