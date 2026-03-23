<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="UserProfilePage.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Users.UserProfilePage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@400;500;600&display=swap');

:root{
    --ink:#1e3444;
    --mid:#355872;
    --sky:#AED3EF;
    --paper:#F7F8F0;
    --line:rgba(53,88,114,0.1);
}

main{
    margin-top:0;
    background:#AED3EF;
    min-height:100vh;
    width:calc(100% + 60px);
    margin-left:-30px;
}

/* TOP BAR */

.topbar{
    background:var(--ink);
    padding:3rem 4rem;
    display:flex;
    align-items:center;
}

.topbar h1{
    font-family:'Bebas Neue',sans-serif;
    font-size:3.5rem;
    color:var(--paper);
    margin:0;
}

.topbar p{
    font-family:'DM Sans',sans-serif;
    font-size:0.8rem;
    font-weight:600;
    letter-spacing:0.25em;
    text-transform:uppercase;
    color:rgba(174,211,239,0.5);
    margin:0;
}

/* PAGE BODY */

.pg-body{
    max-width:1100px;
    margin:3rem auto 6rem;
    padding:0 3rem;
}

/* CARD */

.card{
    background:var(--paper);
    border-radius:1rem;
    border:1px solid rgba(174,211,239,0.35);
    overflow:hidden;
}

.card-head{
    padding:1.3rem 2rem;
    border-bottom:1px solid var(--line);
}

.card-title{
    font-family:'DM Sans',sans-serif;
    font-size:0.75rem;
    font-weight:700;
    letter-spacing:0.25em;
    text-transform:uppercase;
    color:var(--ink);
}

.card-body{
    padding:2rem;
}

/* GRID LAYOUT */

.field-list{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:1.5rem;
}

/* FIELD */

.field{
    display:flex;
    flex-direction:column;
    gap:0.4rem;
}

.flabel{
    font-family:'DM Sans',sans-serif;
    font-size:0.65rem;
    font-weight:700;
    letter-spacing:0.15em;
    text-transform:uppercase;
    color:var(--ink);
}

.fval{
    font-family:'DM Sans',sans-serif;
    font-size:1rem;
    padding:0.65rem 0.9rem;
    border-radius:0.5rem;
    border:1px solid var(--line);
    background:rgba(53,88,114,0.08);
    color:var(--ink);
}

.finput{
    font-family:'DM Sans',sans-serif;
    font-size:1rem;
    padding:0.65rem 0.9rem;
    border-radius:0.5rem;
    border:1px solid var(--line);
}

/* ADDRESS FULL WIDTH */

.field-full{
    grid-column:span 2;
}

/* BUTTON */

.btn-row{
    display:flex;
    justify-content:flex-end;
    padding-top:1.5rem;
    border-top:1px solid var(--line);
    margin-top:2rem;
}

.btn{
    font-family:'DM Sans',sans-serif;
    font-size:0.8rem;
    font-weight:600;
    letter-spacing:0.12em;
    text-transform:uppercase;
    padding:0.7rem 1.8rem;
    border-radius:0.5rem;
    border:none;
    cursor:pointer;
    background:var(--ink);
    color:var(--paper);
}

.btn:hover{
    background:var(--mid);
}

/* TOAST NOTIFICATIONS */
#toast {
    position: fixed;
    bottom: 2rem;
    right: 2rem;
    background: var(--ink);
    color: var(--paper);
    font-family: 'DM Sans',sans-serif;
    font-size: 0.8rem;
    font-weight: 500;
    padding: 0.7rem 1.2rem;
    border-radius: 0.5rem;
    box-shadow: 0 6px 20px rgba(30,52,68,0.22);
    opacity: 0;
    transform: translateY(0.5rem);
    transition: opacity 0.25s, transform 0.25s;
    pointer-events: none;
    z-index: 999;
}
#toast.show { opacity: 1; transform: translateY(0); }

/* ERROR BORDER */
.input-error { border-color: #c0392b !important; }
</style>

<main>
    <div class="topbar">
        <div>
            <p>Account Management</p>
            <h1>User Profile</h1>
        </div>
    </div>

    <div class="pg-body">

        <div class="card">
            <div class="card-head">
                <span class="card-title">Profile Information</span>
            </div>

            <div class="card-body">
                <div class="field-list">

                    <!-- Fields -->
                    <div class="field" style="display:none;">
                        <span class="flabel">Profile ID</span>
                        <asp:Label ID="lblProfileID" runat="server" CssClass="fval"></asp:Label>
                    </div>

                    <div class="field">
                        <span class="flabel">User ID</span>
                        <asp:Label ID="lblUserID" runat="server" CssClass="fval"></asp:Label>
                    </div>

                    <div class="field">
                        <span class="flabel">Date Registered</span>
                        <asp:Label ID="lblDateRegistered" runat="server" CssClass="fval"></asp:Label>
                    </div>

                    <div class="field">
                        <span class="flabel">First Name</span>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="finput"></asp:TextBox>
                    </div>

                    <div class="field">
                        <span class="flabel">Last Name</span>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="finput"></asp:TextBox>
                    </div>

                    <div class="field">
                        <span class="flabel">Barangay</span>
                        <asp:DropDownList ID="ddlBarangay" runat="server" CssClass="finput">
                            <asp:ListItem Text="Select Barangay" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="field field-full">
                        <span class="flabel">Address</span>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="finput" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>

                </div>

                <div class="btn-row">
                    <asp:Button ID="btnUpdateProfile"
                                runat="server"
                                Text="Update Profile"
                                CssClass="btn"
                                OnClick="btnUpdateProfile_Click"/>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Notification -->
    <div id="toast"></div>

</main>

<script>
function showToast(message) {
    var t = document.getElementById('toast');
    t.innerText = message;
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 3000);
}

// Optional: highlight invalid fields
function markInvalidField(fieldId) {
    var field = document.getElementById(fieldId);
    if (field) field.classList.add('input-error');
}
</script>

</asp:Content>