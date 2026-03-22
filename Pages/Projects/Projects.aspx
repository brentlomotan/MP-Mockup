<%@ Page Title="Projects" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Projects.Projects" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hdnProjectsData" runat="server" Value="" />
    <asp:HiddenField ID="hdnIsAdmin" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFormOpen" runat="server" Value="0" />
    <asp:HiddenField ID="hdnDeleteID" runat="server" Value="0" />

    <style>
        :root {
            --navy: #355872;
            --navy-light: #7AAACE;
            --green: #0d7a5a;
            --green-light: #14b88a;
            --gray-bg: #F7F8F0;
            --gray-border: #e5e7eb;
            --gray-text: #6b7280;
            --body-text: #374151;
            --dark-text: #111827;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        /*HERO*/
        .proj-hero {
            background: var(--navy);
            padding: 64px 48px 88px;
            position: relative;
            overflow: hidden;
            width: 100vw;
            left: 50%;
            margin-left: -50vw;
            margin-top: -30px;
        }
        .proj-hero::before {
            content: '';
            position: absolute;
            top: -80px; right: -80px;
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(13,122,90,0.18) 0%, transparent 70%);
            pointer-events: none;
        }
        .proj-hero h1 {
            font-family: Georgia, serif;
            font-style: italic;
            font-size: clamp(36px, 5vw, 56px);
            font-weight: 400;
            color: #fff;
            line-height: 1.1;
            margin-bottom: 18px;
            animation: fadeUp 0.6s ease both;
        }
        .proj-hero p {
            max-width: 560px;
            font-family: Verdana, sans-serif;
            font-size: 15px;
            color: #9db4cc;
            line-height: 1.75;
            font-style: oblique;
            animation: fadeUp 0.6s 0.1s ease both;
        }

        /*STATS BAR*/
        .proj-stats {
            background: var(--navy-light);
            border-top: 1px solid rgba(255,255,255,0.08);
            padding: 20px 48px;
            display: flex;
            gap: 48px;
            width: 100vw;
            position: relative;
            left: 50%;
            margin-left: -50vw;
        }
        .proj-stat { display: flex; flex-direction: column; gap: 2px; }
        .proj-stat-value {
            font-family: Georgia, serif;
            font-style: italic;
            font-size: 24px;
            color: #355872;
        }
        .proj-stat-label {
            font-family: Verdana, sans-serif;
            font-size: 12px;
            color: #355872;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            font-style: oblique;
        }

        /*BUTTON FILTERS*/
        .proj-filters {
            padding: 28px 0 0;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
        }
        .proj-filter-group { display: flex; gap: 10px; flex-wrap: wrap; }
        .proj-filter-btn {
            background: #fff;
            border: 1px solid var(--gray-border);
            color: var(--gray-text);
            font-family: Verdana, sans-serif;
            font-size: 13px;
            font-weight: 500;
            font-style: oblique;
            padding: 7px 16px;
            border-radius: 99px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .proj-filter-btn:hover { border-color: var(--navy); color: var(--navy); }
        .proj-filter-btn.active {
            background: var(--navy);
            border-color: var(--navy);
            color: #fff;
        }

        /*GRID*/
        .proj-grid {
            padding: 28px 0 64px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 24px;
            align-items: start;
        }

        /*CARDS*/
        .proj-card {
            background: #F7F8F0;
            border: 1px solid var(--gray-border);
            border-radius: 14px;
            padding: 28px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            transition: box-shadow 0.25s, transform 0.25s;
            animation: fadeUp 0.5s ease both;
        }
        .proj-card:hover {
            box-shadow: 0 10px 32px rgba(0,0,0,0.10);
            transform: translateY(-3px);
        }
        .proj-card-title {
            font-family: Georgia, serif;
            font-style: italic;
            font-size: 18px;
            font-weight: 400;
            color: var(--dark-text);
            line-height: 1.3;
        }
        .proj-badges { display: flex; gap: 8px; flex-wrap: wrap; }
        .proj-badge {
            font-family: Verdana, sans-serif;
            font-size: 12px;
            font-weight: 600;
            padding: 3px 11px;
            border-radius: 6px;
        }
        .proj-badge-ongoing   { background: var(--green); color: #fff; }
        .proj-badge-planning  { background: #6b7280; color: #fff; }
        .proj-badge-completed { background: #1a6fa0; color: #fff; }
        .proj-badge-cancelled { background: #e24b4a; color: #fff; }
        .proj-badge-cat { font-weight: 500; }
        .proj-cat-1 { background: #e8f4fd; color: #1a6fa0; }
        .proj-cat-2 { background: #e8f9f4; color: #0d7a5a; }
        .proj-cat-3 { background: #fdeef6; color: #9b2d6e; }
        .proj-cat-4 { background: #edf7ee; color: #2d7a38; }
        .proj-cat-5 { background: #fdf3e8; color: #a06010; }
        .proj-cat-6 { background: #f0eeff; color: #5a38a0; }

        .proj-card-desc {
            font-family: Verdana, sans-serif;
            font-size: 14px;
            color: #4b5563;
            line-height: 1.65;
            font-style: oblique;
            flex-grow: 1;
        }

        /*PROGRESS*/
        .proj-progress-wrap { width: 100%; }
        .proj-progress-label {
            display: flex;
            justify-content: space-between;
            font-family: Verdana, sans-serif;
            font-size: 12px;
            color: var(--gray-text);
            font-style: oblique;
            margin-bottom: 6px;
        }
        .proj-progress-label span:last-child { font-weight: 600; color: var(--body-text); }
        .proj-progress-track {
            width: 100%;
            height: 6px;
            background: #e5e7eb;
            border-radius: 99px;
            overflow: hidden;
        }
        .proj-progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--green), var(--green-light));
            border-radius: 99px;
            transition: width 1s cubic-bezier(0.4,0,0.2,1);
            width: 0;
        }

        /*TOGGLE*/
        .proj-toggle-btn {
            background: none;
            border: none;
            cursor: pointer;
            align-self: flex-end;
            color: var(--gray-text);
            font-size: 16px;
            padding: 2px 4px;
            transition: color 0.2s, transform 0.25s;
            line-height: 1;
        }
        .proj-toggle-btn:hover { color: var(--navy); }
        .proj-toggle-btn.open { transform: rotate(180deg); }

        /*DETAILS*/
        .proj-card-details {
            border-top: 1px solid #f3f4f6;
            padding-top: 0;
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow: hidden;
            max-height: 0;
            opacity: 0;
            transition: max-height 0.35s ease, opacity 0.3s ease, padding-top 0.3s;
        }
        .proj-card-details.open { max-height: 300px; opacity: 1; padding-top: 16px; }
        .proj-card-details p {
            font-family: Verdana, sans-serif;
            font-size: 14px;
            color: var(--body-text);
            line-height: 1.7;
            font-style: italic;
        }
        .proj-card-dates {
            display: flex;
            gap: 20px;
            font-family: Verdana, sans-serif;
            font-size: 13px;
            color: var(--gray-text);
            font-style: oblique;
        }
        .proj-card-dates strong { color: var(--body-text); }

        /*VIEW DETAILS LINK*/
        .proj-view-link {
            font-family: Verdana, sans-serif;
            font-size: 13px;
            color: var(--navy);
            text-decoration: none;
            font-weight: 600;
            align-self: flex-start;
            transition: color 0.2s;
        }
        .proj-view-link:hover { color: var(--navy-light); }

        /*ANIMATIONS*/
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /*MOBILE FUNCTION*/
        @media (max-width: 640px) {
            .proj-hero, .proj-stats { padding-left: 20px; padding-right: 20px; }
            .proj-stats { gap: 24px; flex-wrap: wrap; }
            .proj-grid { grid-template-columns: 1fr; }
        }

        /*ADMIN BUTTONS*/
        .btn-admin-add {
            background: var(--navy);
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            font-family: Verdana, sans-serif;
            transition: background 0.2s;
        }
        .btn-admin-add:hover { background: #2a4560; }
        .btn-admin-edit {
            background: #2f6fa3;
            color: #fff;
            border: none;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
            font-family: Verdana, sans-serif;
            transition: background 0.2s;
            margin-right: 4px;
        }
        .btn-admin-edit:hover { background: #245a87; }
        .btn-admin-delete {
            background: #e24b4a;
            color: #fff;
            border: none;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
            font-family: Verdana, sans-serif;
            transition: background 0.2s;
        }
        .btn-admin-delete:hover { background: #b83332; }

        /*ADD/EDIT FORM*/
        .proj-form-wrap {
            display: none;
            background: #eef4fa;
            border-radius: 12px;
            padding: 24px;
            margin: 20px 0 0;
            border: 1px solid #dde8f0;
        }
        .proj-form-wrap.open { display: block; }
        .proj-form-title {
            font-family: Georgia, serif;
            font-style: italic;
            font-size: 18px;
            color: var(--navy);
            margin-bottom: 16px;
        }
        .proj-form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 12px;
        }
        .proj-form-group { display: flex; flex-direction: column; gap: 4px; }
        .proj-form-group label {
            font-family: Verdana, sans-serif;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            color: #7a9bb5;
        }
        .proj-form-group input,
        .proj-form-group select,
        .proj-form-group textarea {
            padding: 8px 10px;
            border-radius: 6px;
            border: 1px solid #dde8f0;
            font-size: 13px;
            color: var(--navy);
            font-family: Verdana, sans-serif;
            background: #F7F8F0;
            box-sizing: border-box;
            width: 100%;
        }
        .proj-form-group textarea { height: 80px; resize: vertical; }
        .proj-form-full { grid-column: 1 / -1; }
        .proj-form-actions { display: flex; gap: 10px; margin-top: 4px; }
        .btn-save {
            background: #2d9e5f;
            color: #fff;
            border: none;
            padding: 8px 20px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            font-family: Verdana, sans-serif;
        }
        .btn-cancel {
            background: #e24b4a;
            color: #fff;
            border: none;
            padding: 8px 20px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            font-family: Verdana, sans-serif;
        }

        /*ADMIN CARD ACTIONS*/
        .proj-card-admin-actions {
            display: flex;
            gap: 8px;
            padding-top: 8px;
            border-top: 1px solid #f3f4f6;
        }
    </style>

    <!--HERO-->
    <div class="proj-hero">
        <h1>Our Projects</h1>
        <p>Explore our ongoing and completed initiatives aimed at improving water supply, expanding coverage, and enhancing service quality for our community. Each project highlights our commitment to providing safe, reliable, and sustainable water for all residents.</p>
    </div>

    <!--STATS BAR-->
    <div class="proj-stats">
        <div class="proj-stat">
            <span class="proj-stat-value"><asp:Label ID="lblTotal" runat="server" Text="0" /></span>
            <span class="proj-stat-label">Total Projects</span>
        </div>
        <div class="proj-stat">
            <span class="proj-stat-value"><asp:Label ID="lblOngoing" runat="server" Text="0" /></span>
            <span class="proj-stat-label">Ongoing</span>
        </div>
        <div class="proj-stat">
            <span class="proj-stat-value"><asp:Label ID="lblAvgProgress" runat="server" Text="0%" /></span>
            <span class="proj-stat-label">Avg. Progress</span>
        </div>
        <div class="proj-stat">
            <span class="proj-stat-value"><asp:Label ID="lblCompleted" runat="server" Text="0" /></span>
            <span class="proj-stat-label">Completed</span>
        </div>
    </div>

    <!--FILTERS+GRID-->
    <div style="padding: 0 12vw;">

        <div class="proj-filters">
            <div class="proj-filter-group">
                <button type="button" class="proj-filter-btn active" data-filter="0">All</button>
                <button type="button" class="proj-filter-btn" data-filter="1">Category 1</button>
                <button type="button" class="proj-filter-btn" data-filter="2">Category 2</button>
                <button type="button" class="proj-filter-btn" data-filter="3">Category 3</button>
                <button type="button" class="proj-filter-btn" data-filter="4">Category 4</button>
                <button type="button" class="proj-filter-btn" data-filter="5">Category 5</button>
                <button type="button" class="proj-filter-btn" data-filter="6">Category 6</button>
            </div>
            <div id="adminAddBtn" style="display:none;">
                <button type="button" class="btn-admin-add" onclick="openAddForm()">+ Add Project</button>
            </div>
        </div>

        <!--ADMIN FORM-->
        <div class="proj-form-wrap" id="projFormWrap">
            <div class="proj-form-title" id="projFormTitle">Add New Project</div>
            <asp:HiddenField ID="hdnEditID" runat="server" Value="0" />
            <div class="proj-form-grid">
                <div class="proj-form-group">
                    <label>Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" placeholder="Project title" />
                </div>
                <div class="proj-form-group">
                    <label>Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server">
                        <asp:ListItem Value="Ongoing" Text="Ongoing" />
                        <asp:ListItem Value="Completed" Text="Completed" />
                        <asp:ListItem Value="Cancelled" Text="Cancelled" />
                    </asp:DropDownList>
                </div>
                <div class="proj-form-group">
                    <label>Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server">
                        <asp:ListItem Value="1" Text="Category 1" />
                        <asp:ListItem Value="2" Text="Category 2" />
                        <asp:ListItem Value="3" Text="Category 3" />
                        <asp:ListItem Value="4" Text="Category 4" />
                        <asp:ListItem Value="5" Text="Category 5" />
                        <asp:ListItem Value="6" Text="Category 6" />
                    </asp:DropDownList>
                </div>
                <div class="proj-form-group">
                    <label>Progress (0-100)</label>
                    <asp:TextBox ID="txtProgress" runat="server" placeholder="e.g. 45" />
                </div>
                <div class="proj-form-group">
                    <label>Start Date</label>
                    <asp:TextBox ID="txtStartDate" runat="server" placeholder="e.g. 2023-01-01" />
                </div>
                <div class="proj-form-group">
                    <label>Expected Date</label>
                    <asp:TextBox ID="txtExpectedDate" runat="server" placeholder="e.g. 2026-12-31" />
                </div>
                <div class="proj-form-group proj-form-full">
                    <label>Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" placeholder="Project description" />
                </div>
            </div>
            <div class="proj-form-actions">
                <asp:Button ID="btnSaveProject" runat="server" CssClass="btn-save" Text="Save Project" OnClick="btnSaveProject_Click" />
                <button type="button" class="btn-cancel" onclick="closeForm()">Cancel</button>
            </div>
            <asp:Label ID="lblFormMsg" runat="server" ForeColor="Red" Text="" style="font-size:12px; margin-top:8px; display:block;" />
        </div>

        <!--DELETE CONFIRM-->
        <asp:Button ID="btnDeleteConfirm" runat="server" Style="display:none;"
            OnClick="btnDeleteConfirm_Click"
            OnClientClick="return confirm('Are you sure you want to delete this project?');" />

        <div class="proj-grid" id="projGrid"></div>

    </div>

    <script>
        var isAdmin = document.getElementById('<%= hdnIsAdmin.ClientID %>').value === '1';
        var projects = JSON.parse(document.getElementById('<%= hdnProjectsData.ClientID %>').value || '[]');

        var catNames = { 1: 'Category 1', 2: 'Category 2', 3: 'Category 3', 4: 'Category 4', 5: 'Category 5', 6: 'Category 6' };
        var statusClass = { 'Ongoing': 'proj-badge-ongoing', 'Completed': 'proj-badge-completed', 'Cancelled': 'proj-badge-cancelled' };

        if (isAdmin) {
            document.getElementById('adminAddBtn').style.display = 'block';
        }

        function openAddForm() {
            document.getElementById('projFormTitle').innerText = 'Add New Project';
            document.getElementById('<%= hdnEditID.ClientID %>').value = '0';
            document.getElementById('<%= hdnFormOpen.ClientID %>').value = '1';
            document.getElementById('projFormWrap').classList.add('open');
            document.getElementById('projFormWrap').scrollIntoView({ behavior: 'smooth' });
        }

        function closeForm() {
            document.getElementById('projFormWrap').classList.remove('open');
            document.getElementById('<%= hdnFormOpen.ClientID %>').value = '0';
        }

        function editProject(btn) {
            var card = btn.closest('.proj-card');
            var id = card.dataset.id;
            var title = card.dataset.title;
            var desc = card.dataset.desc;
            var category = card.dataset.category;
            var progress = card.dataset.progress;
            var status = card.dataset.status;

            document.getElementById('projFormTitle').innerText = 'Edit Project';
            document.getElementById('<%= hdnEditID.ClientID %>').value = id;
            document.getElementById('<%= txtTitle.ClientID %>').value = title;
            document.getElementById('<%= txtDescription.ClientID %>').value = desc;
            document.getElementById('<%= txtProgress.ClientID %>').value = progress;
            document.getElementById('<%= ddlCategory.ClientID %>').value = category;
            document.getElementById('<%= ddlStatus.ClientID %>').value = status;
            document.getElementById('<%= hdnFormOpen.ClientID %>').value = '1';
            document.getElementById('projFormWrap').classList.add('open');
            document.getElementById('projFormWrap').scrollIntoView({ behavior: 'smooth' });
            document.getElementById('<%= txtStartDate.ClientID %>').value = card.dataset.startdate;
            document.getElementById('<%= txtExpectedDate.ClientID %>').value = card.dataset.expecteddate;
        }

        function deleteProject(id) {
            document.getElementById('<%= hdnDeleteID.ClientID %>').value = id;
            document.getElementById('<%= btnDeleteConfirm.ClientID %>').click();
        }

        function renderCards(filter) {
            var grid = document.getElementById('projGrid');
            var filtered = filter == 0 ? projects : projects.filter(function (p) { return p.Category == filter; });
            grid.innerHTML = '';

            filtered.forEach(function (p, i) {
                var card = document.createElement('div');
                card.className = 'proj-card';
                card.style.animationDelay = (i * 0.07) + 's';
                card.dataset.id = p.ProjectID;
                card.dataset.title = p.Title;
                card.dataset.desc = p.Description;
                card.dataset.category = p.Category;
                card.dataset.progress = p.Progress;
                card.dataset.status = p.Status;
                card.dataset.startdate = p.StartDate;
                card.dataset.expecteddate = p.ExpectedDate;

                var adminBtns = isAdmin ? `
                    <div class="proj-card-admin-actions">
                        <button type="button" class="btn-admin-edit" onclick="editProject(this)">
                            Edit
                        </button>
                        <button type="button" class="btn-admin-delete" onclick="deleteProject(${p.ProjectID})">
                            Delete
                        </button>
                    </div>` : '';

                card.innerHTML = `
                    <div class="proj-card-title">${p.Title}</div>
                    <div class="proj-badges">
                        <span class="proj-badge ${statusClass[p.Status] || 'proj-badge-planning'}">${p.Status}</span>
                        <span class="proj-badge proj-badge-cat proj-cat-${p.Category}">${catNames[p.Category]}</span>
                    </div>
                    <p class="proj-card-desc">${p.Description}</p>
                    <div class="proj-progress-wrap">
                        <div class="proj-progress-label"><span>Progress</span><span>${p.Progress}%</span></div>
                        <div class="proj-progress-track"><div class="proj-progress-fill" data-width="${p.Progress}"></div></div>
                    </div>
                    <button type="button" class="proj-toggle-btn" aria-label="Toggle details">▼</button>
                    <div class="proj-card-details">
                        <p>${p.Description}</p>
                        <div class="proj-card-dates">
                            <span><strong>Start:</strong> ${p.StartDate}</span>
                            <span><strong>Expected:</strong> ${p.ExpectedDate}</span>
                        </div>
                        ${isAdmin ? `
                         <div class="proj-card-dates" style="margin-top:4px;">
                            <span><strong>Added:</strong> ${p.DateAdded}</span>
                        </div>` : ''}
                        <a class="proj-view-link" href="ProjectsDetails.aspx?id=${p.ProjectID}">View Details →</a>
                    </div>
                    ${adminBtns}
                `;

                var btn = card.querySelector('.proj-toggle-btn');
                var details = card.querySelector('.proj-card-details');
                btn.addEventListener('click', function () {
                    var open = details.classList.toggle('open');
                    btn.classList.toggle('open', open);
                });

                grid.appendChild(card);
            });

            requestAnimationFrame(function () {
                document.querySelectorAll('.proj-progress-fill').forEach(function (el) {
                    el.style.width = el.dataset.width + '%';
                });
            });
        }

        document.querySelectorAll('.proj-filter-btn').forEach(function (btn) {
            btn.addEventListener('click', function () {
                document.querySelectorAll('.proj-filter-btn').forEach(function (b) { b.classList.remove('active'); });
                btn.classList.add('active');
                renderCards(btn.dataset.filter);
            });
        });

        window.onload = function () {
            if (document.getElementById('<%= hdnFormOpen.ClientID %>').value === '1') {
                document.getElementById('projFormWrap').classList.add('open');
            }
            renderCards(0);
        };
    </script>

</asp:Content>