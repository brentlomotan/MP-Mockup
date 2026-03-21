<%@ Page Title="Process Payment" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ProcessTransaction.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Users.ProcessTransaction" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .footer { display: none !important; }

        .pt-wrap {
            margin-top: 0;
            width: calc(100% + 60px);
            margin-left: -30px;
            background: #AED3EF;
            min-height: 100vh;
            padding: 40px 32px 60px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
            color: #355872;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .breadcrumb {
            width: 100%;
            max-width: 640px;
            margin-bottom: 20px;
            font-size: 13px;
            color: #7a9bb5;
        }
        .breadcrumb a {
            color: #2f6fa3;
            text-decoration: none;
            font-weight: 600;
        }
        .breadcrumb a:hover { text-decoration: underline; }
        .breadcrumb span { margin: 0 6px; }

        .pt-card {
            background: #F7F8F0;
            border-radius: 14px;
            border: 1px solid #dde8f0;
            width: 100%;
            max-width: 640px;
            overflow: hidden;
        }

        .pt-card-header {
            background: #2f6fa3;
            padding: 22px 28px;
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .pt-card-header-icon {
            width: 44px; height: 44px;
            background: rgba(255,255,255,0.18);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .pt-card-header-icon svg { width: 22px; height: 22px; stroke: white; fill: none; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; }
        .pt-card-header h2 { font-size: 17px; font-weight: 700; color: white; margin: 0 0 2px; }
        .pt-card-header p  { font-size: 12px; color: rgba(255,255,255,0.75); margin: 0; }

        .pt-card-body { padding: 24px 28px; }

        .pt-field { margin-bottom: 16px; }
        .pt-field-label {
            font-size: 11px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 0.5px;
            color: #7a9bb5; margin-bottom: 5px;
        }
        .pt-field-value { font-size: 15px; font-weight: 600; color: #355872; }
        .pt-field-value.large { font-size: 26px; font-weight: 700; color: #355872; }

        .pt-divider { height: 1px; background: #dde8f0; margin: 18px 0; }

        .status-badge {
            display: inline-block;
            font-size: 10px; font-weight: 700;
            padding: 3px 9px; border-radius: 20px;
            text-transform: uppercase; letter-spacing: 0.3px;
        }
        .badge-paid    { background: #d4f0e2; color: #1a6e40; }
        .badge-unpaid  { background: #fde8e8; color: #a32d2d; }
        .badge-partial { background: #feecd4; color: #8a4c10; }

        .method-row { display: flex; gap: 10px; margin-top: 6px; }
        .method-opt {
            flex: 1; padding: 12px 10px;
            border-radius: 10px;
            border: 2px solid #dde8f0;
            background: transparent;
            cursor: pointer;
            text-align: center;
            transition: all 0.15s;
            font-family: Arial, sans-serif;
        }
        .method-opt:hover { border-color: #7AAACE; background: #EBF5FF; }
        .method-opt.selected { border-color: #2f6fa3; background: #EBF5FF; }
        .method-opt-icon { font-size: 20px; margin-bottom: 4px; }
        .method-opt-label { font-size: 13px; font-weight: 700; color: #355872; }
        .method-opt-sub   { font-size: 11px; color: #7a9bb5; margin-top: 1px; }

        .card-info-box {
            background: #EBF5FF;
            border-radius: 8px;
            border-left: 3px solid #7AAACE;
            padding: 12px 14px;
            margin-top: 14px;
            display: none;
        }
        .card-info-box.show { display: block; }
        .card-info-label { font-size: 11px; font-weight: 700; color: #2f6fa3; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.4px; }
        .card-info-num  { font-size: 15px; font-weight: 700; color: #355872; letter-spacing: 1px; }
        .card-info-meta { font-size: 12px; color: #7a9bb5; margin-top: 2px; }

        .confirm-btn {
            width: 100%;
            background: #2d9e5f;
            color: white;
            border: none;
            padding: 14px 0;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 6px;
            transition: background 0.2s;
            font-family: Arial, sans-serif;
        }
        .confirm-btn:hover { background: #247a4a; }

        .error-box {
            background: #fde8e8;
            border-left: 3px solid #e24b4a;
            border-radius: 8px;
            padding: 12px 14px;
            font-size: 13px;
            color: #a32d2d;
            margin-bottom: 16px;
            font-weight: 600;
        }

        .receipt-card {
            background: #F7F8F0;
            border-radius: 14px;
            border: 1px solid #dde8f0;
            width: 500px;
            overflow: hidden;
        }

        .receipt-header {
            background: #2d9e5f;
            padding: 28px;
            text-align: center;
        }
        .receipt-check {
            width: 56px; height: 56px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 12px;
        }
        .receipt-check svg { width: 28px; height: 28px; stroke: white; fill: none; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; }
        .receipt-header h2 { font-size: 20px; font-weight: 700; color: white; margin: 0 0 4px; }
        .receipt-header p  { font-size: 13px; color: rgba(255,255,255,0.8); margin: 0; }

        .receipt-body { padding: 24px 28px; }

        .receipt-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 11px 0;
            border-bottom: 1px solid #dde8f0;
            font-size: 14px;
        }
        .receipt-row:last-of-type { border-bottom: none; }
        .receipt-row-label { color: #7a9bb5; font-weight: 600; font-size: 13px; }
        .receipt-row-value { font-weight: 700; color: #355872; }
        .receipt-row-value.big { font-size: 20px; color: #2d9e5f; }

        .receipt-divider { height: 1px; background: #dde8f0; margin: 8px 0; }

        .receipt-ref {
            background: #EBF5FF;
            border-radius: 8px;
            padding: 12px 16px;
            text-align: center;
            margin: 16px 0;
        }
        .receipt-ref-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: #7a9bb5; margin-bottom: 4px; }
        .receipt-ref-num   { font-size: 18px; font-weight: 700; color: #2f6fa3; letter-spacing: 1px; }

        .back-btn {
            display: block;
            width: 100%;
            background: #2f6fa3;
            color: white;
            border: none;
            padding: 14px 0;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            text-align: center;
            text-decoration: none;
            margin-top: 20px;
            box-sizing: border-box;
            transition: background 0.2s;
            font-family: Arial, sans-serif;
            cursor: pointer;
        }
        .back-btn:hover { background: #245a87; color: white; text-decoration: none; }

        @media (max-width: 680px) {
            .pt-wrap { padding: 24px 16px 40px; width: calc(100% + 32px); margin-left: -16px; }
        }
    </style>

    <div class="pt-wrap">

        <div class="breadcrumb">
            <a href="/Pages/Users/Bills.aspx">My Bills</a>
            <span>&rsaquo;</span>
            Process Payment
        </div>

        <asp:Panel ID="pnlError" runat="server" Visible="false">
            <div class="pt-card" style="max-width:640px; width:100%;">
                <div class="pt-card-header" style="background:#e24b4a;">
                    <div class="pt-card-header-icon">
                        <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    </div>
                    <div>
                        <h2>Payment Unavailable</h2>
                        <p><asp:Label ID="lblError" runat="server" Text="" /></p>
                    </div>
                </div>
                <div class="pt-card-body">
                    <a href="/Pages/Users/Bills.aspx" class="back-btn">&larr; Back to Bills</a>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlPayForm" runat="server">
            <div class="pt-card">

                <div class="pt-card-header">
                    <div class="pt-card-header-icon">
                        <svg viewBox="0 0 24 24"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
                    </div>
                    <div>
                        <h2>Process Payment</h2>
                        <p>Review your invoice and select a payment method</p>
                    </div>
                </div>

                <div class="pt-card-body">
                    <div class="pt-field">
                        <div class="pt-field-label">Invoice</div>
                        <div class="pt-field-value">Bill #<asp:Label ID="lblBillID" runat="server" Text="" /></div>
                    </div>
                    <div class="pt-field">
                        <div class="pt-field-label">Period</div>
                        <div class="pt-field-value"><asp:Label ID="lblPeriod" runat="server" Text="" /></div>
                    </div>
                    <div class="pt-field">
                        <div class="pt-field-label">Due Date</div>
                        <div class="pt-field-value"><asp:Label ID="lblDueDate" runat="server" Text="" /></div>
                    </div>
                    <div class="pt-field">
                        <div class="pt-field-label">Current Status</div>
                        <div class="pt-field-value">
                            <span class="status-badge <asp:Literal ID="litBadgeClass" runat="server" />">
                                <asp:Label ID="lblStatus" runat="server" Text="" />
                            </span>
                        </div>
                    </div>

                    <div class="pt-divider"></div>

                    <div class="pt-field">
                        <div class="pt-field-label">Amount Due</div>
                        <div class="pt-field-value large">₱<asp:Label ID="lblAmountDue" runat="server" Text="" /></div>
                    </div>

                    <div class="pt-divider"></div>

                    <div class="pt-field">
                        <div class="pt-field-label">Payment Method</div>
                        <div class="method-row">
                            <button type="button" class="method-opt selected" id="optCard" onclick="selectMethod('Card')">
                                <div class="method-opt-icon">💳</div>
                                <div class="method-opt-label">Card</div>
                                <div class="method-opt-sub">Debit / Credit</div>
                            </button>
                            <button type="button" class="method-opt" id="optCash" onclick="selectMethod('Cash')">
                                <div class="method-opt-icon">💵</div>
                                <div class="method-opt-label">Cash</div>
                                <div class="method-opt-sub">Pay at counter</div>
                            </button>
                        </div>

                        <div class="card-info-box show" id="cardInfoBox">
                            <div class="card-info-label">Card on File</div>
                            <div class="card-info-num" id="cardNum">—</div>
                            <div class="card-info-meta" id="cardMeta">—</div>
                        </div>
                    </div>

                    <asp:HiddenField ID="hdnMethod" runat="server" Value="Card" />
                    <asp:HiddenField ID="hdnBillID" runat="server" Value="" />

                    <asp:Button ID="btnPay" runat="server"
                        Text="Confirm Payment →"
                        CssClass="confirm-btn"
                        OnClick="btnPay_Click" />
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlReceipt" runat="server" Visible="false">
            <div class="receipt-card">

                <div class="receipt-header">
                    <div class="receipt-check">
                        <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
                    </div>
                    <h2>Payment Successful!</h2>
                    <p>Your invoice has been settled.</p>
                </div>

                <div class="receipt-body">

                    <div class="receipt-ref">
                        <div class="receipt-ref-label">Transaction Reference</div>
                        <div class="receipt-ref-num">#<asp:Label ID="lblTxnID" runat="server" Text="" /></div>
                    </div>

                    <div class="receipt-row">
                        <span class="receipt-row-label">Bill</span>
                        <span class="receipt-row-value">Bill #<asp:Label ID="lblRcptBillID" runat="server" Text="" /></span>
                    </div>
                    <div class="receipt-row">
                        <span class="receipt-row-label">Period</span>
                        <span class="receipt-row-value"><asp:Label ID="lblRcptPeriod" runat="server" Text="" /></span>
                    </div>
                    <div class="receipt-row">
                        <span class="receipt-row-label">Payment Method</span>
                        <span class="receipt-row-value"><asp:Label ID="lblRcptMethod" runat="server" Text="" /></span>
                    </div>
                    <div class="receipt-row">
                        <span class="receipt-row-label">Payment Date</span>
                        <span class="receipt-row-value"><asp:Label ID="lblRcptDate" runat="server" Text="" /></span>
                    </div>
                    <div class="receipt-row">
                        <span class="receipt-row-label">Status</span>
                        <span class="receipt-row-value"><span class="status-badge badge-paid">Paid</span></span>
                    </div>

                    <div class="receipt-divider"></div>

                    <div class="receipt-row">
                        <span class="receipt-row-label">Amount Paid</span>
                        <span class="receipt-row-value big">₱<asp:Label ID="lblRcptAmount" runat="server" Text="" /></span>
                    </div>

                    <a href="/Pages/Users/Bills.aspx" class="back-btn"><<< Back to Bills</a>
                </div>
            </div>
        </asp:Panel>

    </div>

    <asp:HiddenField ID="hdnCardJson" runat="server" Value="" />

    <script>
        var currentMethod = 'Card';
        var cardData = {};
        try { cardData = JSON.parse(document.getElementById('<%= hdnCardJson.ClientID %>').value || '{}'); } catch(e){}

        function selectMethod(method) {
            currentMethod = method;
            document.getElementById('optCard').classList.toggle('selected', method === 'Card');
            document.getElementById('optCash').classList.toggle('selected', method === 'Cash');
            document.getElementById('<%= hdnMethod.ClientID %>').value = method;

            var box = document.getElementById('cardInfoBox');
            if (box) box.classList.toggle('show', method === 'Card' && !!cardData.number);
        }

        (function () {
            if (cardData.number) {
                document.getElementById('cardNum').textContent = '**** **** **** ' + String(cardData.number).slice(-4);
                document.getElementById('cardMeta').textContent = cardData.bank + '  |  Exp: ' + cardData.expMonth + '/' + cardData.expYear;
            } else {
                var box = document.getElementById('cardInfoBox');
                if (box) box.classList.remove('show');
            }
        })();
    </script>

</asp:Content>