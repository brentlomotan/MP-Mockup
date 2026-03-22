<%@ Page Title="My Bills" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Bills.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Users.Bills" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .footer { display: none !important; }

        .bills-wrap {
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

        .page-header { margin-bottom: 22px; }
        .page-header h1 { font-size: 22px; font-weight: 700; color: #355872; margin: 0 0 4px; }
        .page-header p  { font-size: 13px; color: #7a9bb5; margin: 0; }

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
        .stat-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: #7a9bb5; margin-bottom: 6px; }
        .stat-value { font-size: 24px; font-weight: 700; color: #355872; line-height: 1; }
        .stat-unit  { font-size: 12px; color: #7a9bb5; margin-top: 4px; }

        .main-grid {
            display: grid;
            grid-template-columns: 1fr 320px;
            gap: 16px;
            align-items: start;
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
            flex-wrap: wrap;
            gap: 8px;
        }

        .filter-bar {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 16px;
        }
        .filter-btn {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            border: 1.5px solid #dde8f0;
            background: transparent;
            color: #7a9bb5;
            cursor: pointer;
            transition: all 0.15s;
        }
        .filter-btn:hover     { background: #AED3EF; border-color: #7AAACE; color: #355872; }
        .filter-btn.active    { background: #2f6fa3; border-color: #2f6fa3; color: #fff; }
        .filter-btn.f-unpaid  { border-color: #e24b4a; color: #e24b4a; }
        .filter-btn.f-unpaid:hover,
        .filter-btn.f-unpaid.active { background: #e24b4a; border-color: #e24b4a; color: #fff; }
        .filter-btn.f-partial { border-color: #e9900c; color: #e9900c; }
        .filter-btn.f-partial:hover,
        .filter-btn.f-partial.active { background: #e9900c; border-color: #e9900c; color: #fff; }
        .filter-btn.f-paid    { border-color: #2d9e5f; color: #2d9e5f; }
        .filter-btn.f-paid:hover,
        .filter-btn.f-paid.active { background: #2d9e5f; border-color: #2d9e5f; color: #fff; }

        /* ── Bill Table ── */
        .bill-table { width: 100%; border-collapse: collapse; }
        .bill-table thead th {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #7a9bb5;
            padding: 0 12px 10px;
            text-align: left;
            border-bottom: 1.5px solid #dde8f0;
        }
        .bill-table thead th:last-child { text-align: right; }
        .bill-table tbody tr {
            border-bottom: 1px solid #dde8f0;
            transition: background 0.12s;
            cursor: pointer;
        }
        .bill-table tbody tr:last-child { border-bottom: none; }
        .bill-table tbody tr:hover { background: #EBF5FF; }
        .bill-table tbody td {
            padding: 13px 12px;
            font-size: 13px;
            color: #355872;
            vertical-align: middle;
        }
        .bill-table tbody td:last-child { text-align: right; }

        .bill-id    { font-size: 11px; color: #7a9bb5; font-weight: 600; }
        .bill-month { font-weight: 700; font-size: 13px; color: #355872; }
        .bill-amt   { font-weight: 700; font-size: 14px; color: #355872; }

        .status-badge {
            display: inline-block;
            font-size: 10px;
            font-weight: 700;
            padding: 3px 9px;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            white-space: nowrap;
        }
        .badge-paid    { background: #d4f0e2; color: #1a6e40; }
        .badge-unpaid  { background: #fde8e8; color: #a32d2d; }
        .badge-partial { background: #feecd4; color: #8a4c10; }

        .no-data { font-size: 13px; color: #7a9bb5; text-align: center; padding: 32px 0; }

        .pay-link {
            font-size: 12px;
            font-weight: 700;
            color: #2f6fa3;
            text-decoration: none;
            padding: 5px 12px;
            border: 1.5px solid #7AAACE;
            border-radius: 6px;
            background: transparent;
            cursor: pointer;
            transition: all 0.15s;
            white-space: nowrap;
        }
        .pay-link:hover { background: #2f6fa3; color: #fff; border-color: #2f6fa3; }

        .sidebar { display: flex; flex-direction: column; gap: 16px; }

        .detail-panel { display: none; }
        .detail-panel.visible { display: block; }

        .detail-field { margin-bottom: 12px; }
        .detail-field-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.4px; color: #7a9bb5; margin-bottom: 3px; }
        .detail-field-value { font-size: 14px; font-weight: 600; color: #355872; }
        .detail-field-value.big { font-size: 22px; font-weight: 700; }
        .detail-divider { height: 1px; background: #dde8f0; margin: 14px 0; }

        .pay-btn-full {
            width: 100%;
            background: #2f6fa3;
            color: white;
            border: none;
            padding: 11px 0;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 4px;
        }
        .pay-btn-full:hover { background: #245a87; }
        .pay-btn-full:disabled { background: #7AAACE; cursor: default; }

        .txn-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #dde8f0;
            font-size: 13px;
        }
        .txn-row:last-child { border-bottom: none; }
        .txn-date   { color: #7a9bb5; font-size: 12px; }
        .txn-method {
            font-size: 10px; font-weight: 700; padding: 2px 8px;
            border-radius: 10px; background: #EBF5FF; color: #2f6fa3;
        }
        .txn-method.cash { background: #d4f0e2; color: #1a6e40; }
        .txn-amt    { font-weight: 700; color: #355872; }

        .hint-box {
            background: #EBF5FF;
            border-radius: 8px;
            border-left: 3px solid #7AAACE;
            padding: 12px 14px;
            font-size: 12px;
            color: #2f6fa3;
        }
        .hint-box strong { font-weight: 700; display: block; margin-bottom: 3px; }

        @media (max-width: 1024px) {
            .stat-row  { grid-template-columns: repeat(2, 1fr); }
            .main-grid { grid-template-columns: 1fr; }
            .bills-wrap { padding: 20px 16px 40px; width: calc(100% + 32px); margin-left: -16px; }
        }
    </style>

    <div class="bills-wrap">
        <div class="page-header" style="display:flex; align-items:flex-start; justify-content:space-between; flex-wrap:wrap; gap:12px;">
            <div>
                <h1>My Bills</h1>
                <p>View, track, and pay your water utility invoices.</p>
            </div>
            <a href="/Pages/Users/Transactions.aspx" style="font-size:13px; font-weight:600; color:#2f6fa3; text-decoration:none; padding:7px 16px; border:1.5px solid #7AAACE; border-radius:8px; background:#F7F8F0; transition:all 0.15s; white-space:nowrap; display:inline-block;"
               onmouseover="this.style.background='#2f6fa3';this.style.color='#fff';this.style.borderColor='#2f6fa3';"
               onmouseout="this.style.background='#F7F8F0';this.style.color='#2f6fa3';this.style.borderColor='#7AAACE';">
                View Transactions >>>
            </a>
        </div>

        <div class="stat-row">
            <div class="stat-card blue">
                <div class="stat-label">Total Bills</div>
                <div class="stat-value"><asp:Label ID="lblTotalBills" runat="server" Text="0" /></div>
                <div class="stat-unit">all time</div>
            </div>
            <div class="stat-card red">
                <div class="stat-label">Outstanding Balance</div>
                <div class="stat-value"><asp:Label ID="lblOutstanding" runat="server" Text="₱0.00" /></div>
                <div class="stat-unit">unpaid + partially paid</div>
            </div>
            <div class="stat-card green">
                <div class="stat-label">Total Paid</div>
                <div class="stat-value"><asp:Label ID="lblTotalPaid" runat="server" Text="₱0.00" /></div>
                <div class="stat-unit">all time payments</div>
            </div>
            <div class="stat-card orange">
                <div class="stat-label">Next Due Date</div>
                <div class="stat-value" style="font-size:16px; padding-top:5px;"><asp:Label ID="lblNextDue" runat="server" Text="—" /></div>
                <div class="stat-unit"><asp:Label ID="lblNextDueAmt" runat="server" Text="" /></div>
            </div>
        </div>

        <div class="main-grid">

            <div class="card">
                <div class="card-title">
                    All Invoices
                    <span><asp:Label ID="lblBillCount" runat="server" Text="0 records" /></span>
                </div>

                <div class="filter-bar">
                    <button type="button" class="filter-btn active" onclick="filterBills('all', this)">All</button>
                    <button type="button" class="filter-btn f-unpaid" onclick="filterBills('Not Paid', this)">Unpaid</button>
                    <button type="button" class="filter-btn f-partial" onclick="filterBills('Partially Paid', this)">Partially Paid</button>
                    <button type="button" class="filter-btn f-paid" onclick="filterBills('Paid', this)">Paid</button>
                </div>

                <table class="bill-table" id="billTable">
                    <thead>
                        <tr>
                            <th>Invoice</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Amount</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptBills" runat="server"
                            OnItemDataBound="rptBills_ItemDataBound">
                            <ItemTemplate>
                                <tr data-billid='<%# Eval("BillID") %>'
                                    data-status='<%# Eval("Status") %>'
                                    onclick="selectBill(this, <%# Eval("BillID") %>)">
                                    <td>
                                        <div class="bill-id">Bill #<%# Eval("BillID") %></div>
                                        <div class="bill-month"><%# Eval("MonthLabel") %></div>
                                    </td>
                                    <td><%# Eval("DueDateStr") %></td>
                                    <td>
                                        <span class="status-badge <%# Eval("BadgeClass") %>">
                                            <%# Eval("Status") %>
                                        </span>
                                    </td>
                                    <td class="bill-amt">₱<%# Eval("AmountDue") %></td>
                                    <td>
                                        <asp:Panel ID="pnlPayBtn" runat="server">
                                            <a class="pay-link" href="/Pages/Users/ProcessTransaction.aspx?billID=<%# Eval("BillID") %>" onclick="event.stopPropagation();">Pay</a>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <asp:Panel ID="pnlNoBills" runat="server" Visible="false">
                    <asp:Label runat="server" class="no-data">No bills found on your account.</asp:Label>
                </asp:Panel>
            </div>

            <div class="sidebar">

                <div class="card" id="hintCard">
                    <div class="hint-box">
                        <strong>Select an invoice</strong>
                        Click any row in the table to view full details and payment options.
                    </div>
                </div>

                <div class="card detail-panel" id="detailCard">
                    <div class="card-title">Invoice Detail</div>

                    <div class="detail-field">
                        <div class="detail-field-label">Invoice</div>
                        <div class="detail-field-value" id="dBillID">—</div>
                    </div>
                    <div class="detail-field">
                        <div class="detail-field-label">Period</div>
                        <div class="detail-field-value" id="dPeriod">—</div>
                    </div>
                    <div class="detail-field">
                        <div class="detail-field-label">Due Date</div>
                        <div class="detail-field-value" id="dDueDate">—</div>
                    </div>
                    <div class="detail-field">
                        <div class="detail-field-label">Status</div>
                        <div class="detail-field-value" id="dStatus">—</div>
                    </div>
                    <div class="detail-divider"></div>
                    <div class="detail-field">
                        <div class="detail-field-label">Amount Due</div>
                        <div class="detail-field-value big" id="dAmount">—</div>
                    </div>

                    <button type="button" class="pay-btn-full" id="dPayBtn" onclick="goToPayment()">
                        Pay Now >>>
                    </button>
                </div>

                <div class="card">
                    <div class="card-title">Payment History <span><asp:Label ID="lblTxnCount" runat="server" Text="0 records" /></span></div>

                    <asp:Repeater ID="rptTransactions" runat="server">
                        <ItemTemplate>
                            <div class="txn-row">
                                <div>
                                    <div style="font-weight:600; font-size:13px; color:#355872;">Bill #<%# Eval("BillID") %></div>
                                    <div class="txn-date"><%# Eval("PaymentDate") %></div>
                                </div>
                                <span class="txn-method <%# Eval("MethodClass") %>"><%# Eval("PaymentMethod") %></span>
                                <div class="txn-amt">₱<%# Eval("AmountPaid") %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoTxn" runat="server" Visible="false">
                        <div class="no-data">No payment records yet.</div>
                    </asp:Panel>
                </div>

            </div>
        </div>
    </div>


    <asp:HiddenField ID="hdnBillData" runat="server" Value="" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
    <script>
        var billData = {};
        try { billData = JSON.parse(document.getElementById('<%= hdnBillData.ClientID %>').value || '{}'); } catch (e) { }

        var currentBillID = null;
        var currentAmount = null;

        function selectBill(row, billID) {
            document.querySelectorAll('#billTable tbody tr').forEach(function (r) {
                r.style.background = '';
                r.style.fontWeight = '';
            });
            row.style.background = '#d6eaf8';
            row.style.fontWeight = '700';

            var b = billData[billID];
            if (!b) return;

            currentBillID = billID;
            currentAmount = b.amount;

            document.getElementById('dBillID').textContent = 'Bill #' + billID;
            document.getElementById('dPeriod').textContent = b.period;
            document.getElementById('dDueDate').textContent = b.dueDate;

            var statusEl = document.getElementById('dStatus');
            statusEl.innerHTML = '<span class="status-badge ' + b.badgeClass + '">' + b.status + '</span>';

            document.getElementById('dAmount').textContent = '₱' + b.amount;

            var payBtn = document.getElementById('dPayBtn');
            if (b.status === 'Paid') {
                payBtn.disabled = true;
                payBtn.textContent = 'Already Paid';
            } else {
                payBtn.disabled = false;
                payBtn.innerHTML = 'Pay Now &rarr;';
            }

            document.getElementById('hintCard').style.display = 'none';
            document.getElementById('detailCard').classList.add('visible');
        }

        function filterBills(status, btn) {
            document.querySelectorAll('.filter-btn').forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');

            var visibleCount = 0;
            document.querySelectorAll('#billTable tbody tr').forEach(function (r) {
                if (status === 'all' || r.dataset.status === status) {
                    r.style.display = '';
                    visibleCount++;
                } else {
                    r.style.display = 'none';
                }
            });

            document.getElementById('filterEmptyMsg').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function goToPayment() {
            if (currentBillID) {
                window.location.href = '/Pages/Users/ProcessTransaction.aspx?billID=' + currentBillID;
            }
        }
    </script>

</asp:Content>