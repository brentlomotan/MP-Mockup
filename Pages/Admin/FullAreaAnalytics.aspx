<%@ Page Title="Full Area Analytics" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="FullAreaAnalytics.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Admin.FullAreaAnalytics" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@300;400;500;600&display=swap');

    :root {
        --ink:   #1e3444;
        --mid:   #355872;
        --sky:   #AED3EF;
        --paper: #F7F8F0;
        --mute:  rgba(53,88,114,0.42);
        --line:  rgba(53,88,114,0.1);
        --bg:    #eaf2f9;
    }

    main { margin-top:0; background:var(--bg); min-height:100vh; width:calc(100% + 60px); margin-left:-30px; }

  
    .topbar { background:var(--ink); padding:2.5rem 3.5rem; }
    .topbar p { font-family:'DM Sans',sans-serif; font-size:0.6rem; font-weight:600; letter-spacing:0.22em; text-transform:uppercase; color:rgba(174,211,239,0.4); margin:0 0 0.2rem; }
    .topbar h1 { font-family:'Bebas Neue',sans-serif; font-size:clamp(2rem,4vw,3.2rem); color:var(--paper); margin:0; line-height:1; }

  
    .pg { max-width:1100px; margin:2rem auto 5rem; padding:0 2.5rem; display:flex; flex-direction:column; gap:1.25rem; }

  
    .card { background:var(--paper); border-radius:0.9rem; border:1px solid rgba(174,211,239,0.35); box-shadow:0 1px 3px rgba(30,52,68,0.04),0 4px 16px rgba(30,52,68,0.06); overflow:hidden; }
    .card-head { padding:1rem 1.5rem; border-bottom:1px solid var(--line); }
    .card-title { font-family:'DM Sans',sans-serif; font-size:0.6rem; font-weight:700; letter-spacing:0.2em; text-transform:uppercase; color:var(--mute); }
    .card-body { padding:1.5rem; }

 
    .kpi-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:1rem; }

    .kpi {
        background:var(--paper); border-radius:0.9rem;
        border:1px solid rgba(174,211,239,0.35);
        box-shadow:0 1px 3px rgba(30,52,68,0.04),0 4px 16px rgba(30,52,68,0.06);
        padding:1.4rem 1.5rem;
        opacity:0; transform:translateY(12px);
        animation:fadeUp 0.4s ease forwards;
    }

    .kpi:nth-child(1) { animation-delay:0.05s; }
    .kpi:nth-child(2) { animation-delay:0.1s; }
    .kpi:nth-child(3) { animation-delay:0.15s; }
    .kpi:nth-child(4) { animation-delay:0.2s; }
    .kpi:nth-child(5) { animation-delay:0.25s; }
    .kpi:nth-child(6) { animation-delay:0.3s; }

    @keyframes fadeUp {
        to { opacity:1; transform:translateY(0); }
    }

    .kpi-label {
        font-family:'DM Sans',sans-serif; font-size:0.58rem; font-weight:700;
        letter-spacing:0.16em; text-transform:uppercase; color:var(--mute);
        margin-bottom:0.5rem; display:block;
    }

    .kpi-value {
        font-family:'Bebas Neue',sans-serif; font-size:2.8rem;
        color:var(--ink); line-height:1; margin-bottom:0.35rem;
    }

    .kpi-sub {
        font-family:'DM Sans',sans-serif; font-size:0.72rem; color:var(--mute);
        display:flex; align-items:center; gap:0.4rem; flex-wrap:wrap;
    }

    .kpi-badge {
        font-family:'DM Sans',sans-serif; font-size:0.65rem; font-weight:600;
        color:var(--mid); background:rgba(53,88,114,0.09);
        padding:0.15rem 0.55rem; border-radius:999px;
        white-space:nowrap;
    }

    
    .chart-row { display:grid; grid-template-columns:2fr 1fr; gap:1.25rem; }
    canvas { max-width:100%; }

    
    .hm-wrap { overflow-x:auto; padding-bottom:0.5rem; }
    .hm-container { display:grid; gap:4px; width:max-content; }
    .hm-header { font-family:'DM Sans',sans-serif; font-size:0.55rem; font-weight:600; color:var(--mute); display:flex; align-items:center; justify-content:center; }
    .hm-row-label { font-family:'DM Sans',sans-serif; font-size:0.65rem; color:var(--mute); display:flex; align-items:center; padding-right:4px; }
    .hm-cell {
        width:32px; height:32px; border-radius:5px;
        display:flex; align-items:center; justify-content:center;
        font-family:'DM Sans',sans-serif; font-size:0.6rem; font-weight:600;
        color:var(--paper); cursor:default; position:relative;
        transition:transform 0.15s, box-shadow 0.15s;
    }
    .hm-cell:hover { transform:scale(1.15); box-shadow:0 2px 8px rgba(30,52,68,0.2); z-index:1; }
    .hm-cell[title]:hover::after {
        content:attr(title);
        position:absolute; bottom:115%; left:50%; transform:translateX(-50%);
        background:var(--ink); color:var(--paper);
        font-size:0.6rem; padding:4px 8px; border-radius:5px;
        white-space:nowrap; pointer-events:none; z-index:10;
        box-shadow:0 2px 8px rgba(30,52,68,0.2);
    }
    .hm-legend { display:flex; align-items:center; gap:0.5rem; margin-top:1rem; font-family:'DM Sans',sans-serif; font-size:0.65rem; color:var(--mute); }
    .hm-legend-bar { display:flex; gap:3px; }
    .hm-swatch { width:18px; height:18px; border-radius:4px; }

    @media(max-width:700px) {
        .kpi-grid { grid-template-columns:1fr 1fr; }
        .chart-row { grid-template-columns:1fr; }
        .topbar { padding:2rem 1.5rem; }
        .pg { padding:0 1.25rem; }
    }
</style>

<main>
    <div class="topbar">
        <p>Admin Dashboard</p>
        <h1>Full Area Analytics</h1>
    </div>

    <div class="pg">

      
        <div class="kpi-grid">
            <div class="kpi">
                <span class="kpi-label">Total Users</span>
                <div class="kpi-value" id="kTotalUsers">—</div>
                <div class="kpi-sub">
                    <span class="kpi-badge" id="kApproved">—</span> approved
                    <span class="kpi-badge" id="kPending">—</span> pending
                </div>
            </div>
            <div class="kpi">
                <span class="kpi-label">Total Consumption</span>
                <div class="kpi-value" id="kConsumption">—</div>
                <div class="kpi-sub">cubic meters logged</div>
            </div>
            <div class="kpi">
                <span class="kpi-label">Billed Amount</span>
                <div class="kpi-value" id="kBilled">—</div>
                <div class="kpi-sub"><span class="kpi-badge" id="kCollected">—</span> collected</div>
            </div>
            <div class="kpi">
                <span class="kpi-label">Projects</span>
                <div class="kpi-value" id="kProjects">—</div>
                <div class="kpi-sub">
                    <span class="kpi-badge" id="kOngoing">—</span> ongoing
                    <span class="kpi-badge" id="kCompleted">—</span> done
                </div>
            </div>
            <div class="kpi">
                <span class="kpi-label">Collection Rate</span>
                <div class="kpi-value" id="kRate">—</div>
                <div class="kpi-sub">of total billed amount</div>
            </div>
            <div class="kpi">
                <span class="kpi-label">Avg Consumption</span>
                <div class="kpi-value" id="kAvg">—</div>
                <div class="kpi-sub">m³ per user</div>
            </div>
        </div>

        <div class="card">
            <div class="card-head"><span class="card-title">Consumption Heatmap — User &amp; Month</span></div>
            <div class="card-body">
                <div class="hm-wrap">
                    <div class="hm-container" id="heatmapContainer"></div>
                </div>
                <div class="hm-legend">
                    <span>Low</span>
                    <div class="hm-legend-bar" id="hmLegend"></div>
                    <span>High</span>
                </div>
            </div>
        </div>

       
        <div class="chart-row">
            <div class="card">
                <div class="card-head"><span class="card-title">Consumption by Barangay</span></div>
                <div class="card-body"><canvas id="chartBarangay" height="200"></canvas></div>
            </div>
            <div class="card">
                <div class="card-head"><span class="card-title">Bill Status</span></div>
                <div class="card-body"><canvas id="chartBill" height="200"></canvas></div>
            </div>
        </div>

        <div class="card">
            <div class="card-head"><span class="card-title">Projects by Category</span></div>
            <div class="card-body"><canvas id="chartProjects" height="90"></canvas></div>
        </div>

    </div>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
<script>
    window.addEventListener('DOMContentLoaded', function () {
        var d = window.analyticsData;
        if (!d) return;

        var k = d.kpi;

        document.getElementById('kTotalUsers').innerText = k.totalUsers;
        document.getElementById('kApproved').innerText = k.approvedUsers;
        document.getElementById('kPending').innerText = k.pendingUsers;
        document.getElementById('kConsumption').innerText = k.totalConsumption;
        document.getElementById('kBilled').innerText = '₱' + Number(k.totalBilled).toLocaleString('en-PH', { minimumFractionDigits: 2 });
        document.getElementById('kCollected').innerText = '₱' + Number(k.totalCollected).toLocaleString('en-PH', { minimumFractionDigits: 2 });
        document.getElementById('kProjects').innerText = k.totalProjects;
        document.getElementById('kOngoing').innerText = k.ongoingProj;
        document.getElementById('kCompleted').innerText = k.completedProj;
        document.getElementById('kRate').innerText = (k.totalBilled > 0 ? Math.round((k.totalCollected / k.totalBilled) * 100) : 0) + '%';
        document.getElementById('kAvg').innerText = k.totalUsers > 0 ? Math.round(k.totalConsumption / k.totalUsers) : 0;

        Chart.defaults.font.family = "'DM Sans', sans-serif";
        Chart.defaults.color = 'rgba(53,88,114,0.6)';

     
        new Chart(document.getElementById('chartBarangay'), {
            type: 'bar',
            data: {
                labels: d.barangayLabels,
                datasets: [{
                    data: d.barangayValues,
                    backgroundColor: d.barangayValues.map(function (v) {
                        return v > 0 ? 'rgba(53,88,114,0.7)' : 'rgba(174,211,239,0.3)';
                    }),
                    borderRadius: 4, borderSkipped: false
                }]
            },
            options: {
                responsive: true, indexAxis: 'y',
                plugins: { legend: { display: false }, tooltip: { callbacks: { label: function (c) { return ' ' + c.raw + ' m³'; } } } },
                scales: {
                    x: { grid: { color: 'rgba(53,88,114,0.06)' }, ticks: { font: { size: 11 }, color: 'rgba(53,88,114,0.55)' } },
                    y: { grid: { display: false }, ticks: { font: { size: 11 }, color: 'rgba(53,88,114,0.55)' } }
                }
            }
        });

        new Chart(document.getElementById('chartBill'), {
            type: 'doughnut',
            data: {
                labels: ['Paid', 'Not Paid', 'Partially Paid'],
                datasets: [{
                    data: d.billStatus,
                    backgroundColor: ['#355872', 'rgba(174,211,239,0.5)', 'rgba(53,88,114,0.28)'],
                    borderWidth: 2, borderColor: '#F7F8F0', hoverOffset: 5
                }]
            },
            options: {
                responsive: true, cutout: '70%',
                plugins: { legend: { position: 'bottom', labels: { font: { size: 11 }, padding: 14, color: 'rgba(53,88,114,0.7)' } } }
            }
        });

       
        new Chart(document.getElementById('chartProjects'), {
            type: 'bar',
            data: {
                labels: d.catLabels,
                datasets: [{
                    data: d.catValues,
                    backgroundColor: 'rgba(53,88,114,0.6)',
                    borderRadius: 5, borderSkipped: false
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    x: { grid: { display: false }, ticks: { font: { size: 11 }, color: 'rgba(53,88,114,0.55)' } },
                    y: { grid: { color: 'rgba(53,88,114,0.06)' }, ticks: { stepSize: 1, font: { size: 11 }, color: 'rgba(53,88,114,0.55)' } }
                }
            }
        });

        buildHeatmap(d.heatmap);
    });

    function buildHeatmap(rows) {
        var container = document.getElementById('heatmapContainer');
        if (!rows || rows.length === 0) {
            container.innerText = 'No data available.';
            return;
        }

        var users = [], months = [], lookup = {};
        rows.forEach(function (r) {
            if (users.indexOf(r.uid) === -1) users.push(r.uid);
            var key = r.year + '-' + r.month;
            if (months.indexOf(key) === -1) months.push(key);
            lookup[r.uid + '_' + key] = r.val;
        });
        users.sort(function (a, b) { return a - b; });
        months.sort();

        var maxVal = Math.max.apply(null, rows.map(function (r) { return r.val; }));

        function hmColor(val) {
            if (!val) return 'rgba(174,211,239,0.18)';
            var t = val / maxVal;
            return 'rgba(53,88,' + Math.round(114 + t * 30) + ',' + (0.2 + t * 0.8) + ')';
        }

        function monthLabel(key) {
            var p = key.split('-');
            return new Date(p[0], p[1] - 1).toLocaleString('default', { month: 'short' }) + " '" + String(p[0]).slice(-2);
        }

        container.style.gridTemplateColumns = '64px repeat(' + months.length + ', 34px)';

        
        container.appendChild(document.createElement('div'));
        months.forEach(function (m) {
            var h = document.createElement('div');
            h.className = 'hm-header';
            h.innerText = monthLabel(m);
            container.appendChild(h);
        });

      
        users.forEach(function (uid) {
            var lbl = document.createElement('div');
            lbl.className = 'hm-row-label';
            lbl.innerText = 'ID ' + uid;
            container.appendChild(lbl);

            months.forEach(function (m) {
                var val = lookup[uid + '_' + m] || 0;
                var cell = document.createElement('div');
                cell.className = 'hm-cell';
                cell.style.background = hmColor(val);
                cell.title = 'User ' + uid + ' · ' + monthLabel(m) + ': ' + val + ' m³';
                cell.innerText = val > 0 ? val : '';
                container.appendChild(cell);
            });
        });

     
        var legend = document.getElementById('hmLegend');
        for (var i = 0; i <= 6; i++) {
            var sw = document.createElement('div');
            sw.className = 'hm-swatch';
            sw.style.background = hmColor(Math.round((i / 6) * maxVal));
            legend.appendChild(sw);
        }
    }
</script>

</asp:Content>
