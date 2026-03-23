<%@ Page Title="Water Usage Analytics" Language="C#" MasterPageFile="~/MasterPages/Site.Master"
    AutoEventWireup="true" CodeBehind="UserAnalytics.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Users.UserAnalytics" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .analytics-wrap {
            padding: 28px 32px;
            font-family: Arial, sans-serif;
            color: #355872;
            background: #EBF5FF;
            min-height: 100vh;
        }

        .analytics-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 12px;
        }

        .analytics-header h1 {
            margin: 0;
            font-size: 22px;
            font-weight: 700;
        }

        .btn-theme {
            font-family: 'DM Sans', sans-serif;
            font-weight: 600;
            text-transform: uppercase;
            background-color: #355872;
            color: #F7F8F0;
            border: none;
            border-radius: 6px;
            padding: 8px 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-theme:hover { background-color: #2f6fa3; }

        .chart-container {
            margin-bottom: 32px;
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            border: 1px solid #dde8f0;
        }

        .chart-container h2 {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 12px;
            color: #2f6fa3;
        }

        .chart-container canvas {
            width: 100% !important;
            height: 350px !important;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }
        th, td { padding: 6px; }
        th { text-align: left; background: #2f6fa3; color: white; }
        td { text-align: right; background: #F7F8F0; border-bottom: 1px solid #dde8f0; }
    </style>

    <div class="analytics-wrap">
        <div class="analytics-header">
            <h1>Monthly Water Usage Analytics</h1>
            <asp:Button ID="btnBackDashboard" runat="server" Text="← Back to Dashboard" CssClass="btn-theme" OnClick="btnBackDashboard_Click" />
        </div>

        <div class="chart-container">
            <h2>Yearly Water Usage (Bar Chart)</h2>
            <canvas id="analyticsBarChart"></canvas>
        </div>

        <div class="chart-container">
            <h2>Monthly Trends Table</h2>
            <asp:Repeater ID="rptMonthlyTrends" runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th>Month</th>
                            <th>Consumption (m³)</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                        <tr>
                            <td style="text-align:left;"><%# Eval("Month") %></td>
                            <td><%# Eval("Consumption") %></td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>

    <asp:HiddenField ID="hdnAnalyticsBarData" runat="server" Value="" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
    <script>
        (function () {
            var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
            var barData = JSON.parse(document.getElementById('<%= hdnAnalyticsBarData.ClientID %>').value || '[0,0,0,0,0,0,0,0,0,0,0,0]');

            new Chart(document.getElementById('analyticsBarChart'), {
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
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: { color: '#7a9bb5', font: { size: 11 } },
                            grid: { color: 'rgba(174,211,239,0.45)' }
                        },
                        x: {
                            ticks: { color: '#7a9bb5', font: { size: 11 } },
                            grid: { display: false }
                        }
                    }
                }
            });
        })();
    </script>

</asp:Content>