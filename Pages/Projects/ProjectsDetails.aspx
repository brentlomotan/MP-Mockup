<%@ Page Title="Project Details" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ProjectsDetails.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Projects.ProjectsDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<asp:HiddenField ID="hdnProjectID" runat="server" Value="0" />
<asp:HiddenField ID="hdnFormOpen" runat="server" Value="0" />

    <style>
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /*BADGES*/
        .proj-badge {
            font-family: Verdana, sans-serif;
            font-size: 12px;
            font-weight: 600;
            padding: 3px 11px;
            border-radius: 6px;
            display: inline-block;
        }
        .proj-badge-ongoing   { background: #0d7a5a; color: #fff; }
        .proj-badge-completed { background: #1a6fa0; color: #fff; }
        .proj-badge-cancelled { background: #e24b4a; color: #fff; }
        .proj-cat-1 { background: #e8f4fd; color: #1a6fa0; }
        .proj-cat-2 { background: #e8f9f4; color: #0d7a5a; }
        .proj-cat-3 { background: #fdeef6; color: #9b2d6e; }
        .proj-cat-4 { background: #edf7ee; color: #2d7a38; }
        .proj-cat-5 { background: #fdf3e8; color: #a06010; }
        .proj-cat-6 { background: #f0eeff; color: #5a38a0; }

        /*PROGRESS*/
        .proj-progress-track {
            width: 75vw;
            height: 8px;
            background: #e5e7eb;
            border-radius: 99px;
            overflow: hidden;
            margin-left: 12vw;
        }
        .proj-progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #0d7a5a, #14b88a);
            border-radius: 99px;
            transition: width 1s cubic-bezier(0.4,0,0.2,1);
            width: 0;
        }

        /*ADMIN EDIT BUTTON*/
        .btn-admin-edit {
            background: #2f6fa3;
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            font-family: Verdana, sans-serif;
            transition: background 0.2s;
        }
        .btn-admin-edit:hover { background: #245a87; }

        /*EDIT FORM*/
        .proj-form-wrap {
            display: none;
            background: #eef4fa;
            border-radius: 12px;
            padding: 24px;
            margin: 0 12vw 24px;
            border: 1px solid #dde8f0;
        }
        .proj-form-wrap.open { display: block; }
        .proj-form-title {
            font-family: Georgia, serif;
            font-style: italic;
            font-size: 18px;
            color: #355872;
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
            color: #355872;
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
        .PDPanel.BannerPanel 
        {
            width: 100vw;
            height: 300px;
            margin: 0;
            margin-left: calc(-30px);
            width: calc(100% + 60px);
            padding: 0;
            background-image: url('../../Images/ProjectDetailsBanner.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .PDPanel 
        {
            width: 100%;
            position: relative;
        }

        .content 
        {
            padding: 0 !important;
        }
        .header
        {
            margin-top: 0 !important;

        }
    </style>
    <section class="PDPanel BannerPanel" ID="Panel1" runat="server">
    </section>
    <section class="PDPanel TextPanel" style="
        position: relative;
        z-index: 2;
        margin-top: 0;
        min-height: 100vh;
        background-color: rgb(174, 211, 239);
        width: 100%;
        padding: 40px 0;
        box-shadow: 0px -7px 15px 8px #E6E6E6;">        <a href="Projects.aspx">
            <div style="font-size: 0.8vw; margin-left: 12vw; animation: fadeUp 0.6s ease both">
                < Back to previous page
            </div>
        </a>
        <br />
        <br />
        <!--ADMIN EDIT BUTTON-->
        <asp:Panel ID="pnlAdminEdit" runat="server" Visible="false">
            <div style="margin-left: 12vw; margin-bottom: 16px;">
                <button type="button" class="btn-admin-edit" onclick="openEditForm()">Edit Project</button>
            </div>
        </asp:Panel>

        <!--EDIT FORM-->
        <div class="proj-form-wrap" id="projFormWrap">
            <div class="proj-form-title">Edit Project</div>
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
                <asp:Button ID="btnSaveProject" runat="server" CssClass="btn-save" Text="Save Changes" OnClick="btnSaveProject_Click" />
                <button type="button" class="btn-cancel" onclick="closeEditForm()">Cancel</button>
            </div>
            <asp:Label ID="lblFormMsg" runat="server" ForeColor="Red" Text="" style="font-size:12px; margin-top:8px; display:block;" />
        </div>

        <!--PROJECT TITLE-->
        <div style="font-size: 2vw; font-weight: bolder; margin-left: 12vw; animation: fadeUp 0.6s ease both">
            <asp:Label ID="lblTitle" runat="server" Text="Project Title" />
        </div>
        <br />

        <!--BADGES-->
        <div style="margin-left: 12vw; display: flex; gap: 8px; animation: fadeUp 0.65s ease both">
            <asp:Label ID="lblStatusBadge" runat="server" />
            <asp:Label ID="lblCategoryBadge" runat="server" />
        </div>
        <br />

        <!--DATE ADDED-->
        <div style="font-size: 0.8vw; margin-left: 12vw; color: rgb(153, 153, 153); animation: fadeUp 0.7s ease both">
            Added: <asp:Label ID="lblDateAdded" runat="server" Text="" />
        </div>
        <br />

        <!--PROGRESS-->
        <div style="margin-left: 12vw; font-size: 0.8vw; color: #355872; margin-bottom: 6px; animation: fadeUp 0.75s ease both">
            Progress: <asp:Label ID="lblProgress" runat="server" Text="0" />%
        </div>
        <div class="proj-progress-track">
            <div class="proj-progress-fill" id="progressFill" data-width="0"></div>
        </div>
        <br />
        <br />

        <!--DESCRIPTION-->
        <div style="margin-left: 12vw; font-size: 1vw; width: 75vw; animation: fadeUp 0.8s ease both">
            <asp:Label ID="lblDescription" runat="server" Text="" />
        </div>
        <br />
        <br />
        <script>
            function openEditForm() {
                document.getElementById('projFormWrap').classList.add('open');
                document.getElementById('<%= hdnFormOpen.ClientID %>').value = '1';
                document.getElementById('projFormWrap').scrollIntoView({ behavior: 'smooth' });
            }

            function closeEditForm() {
                document.getElementById('projFormWrap').classList.remove('open');
                document.getElementById('<%= hdnFormOpen.ClientID %>').value = '0';
            }

            window.onload = function () {
                if (document.getElementById('<%= hdnFormOpen.ClientID %>').value === '1') {
                    document.getElementById('projFormWrap').classList.add('open');
                }
                var fill = document.getElementById('progressFill');
                if (fill) {
                    setTimeout(function () {
                        fill.style.width = fill.dataset.width + '%';
                    }, 100);
                }
            };
        </script>
    </section>
</asp:Content>