<%@ Page Title="Admin Profile" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="AdminProfilePage.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Admin.AdminProfilePage" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@400;500;600&display=swap');
    :root { --ink:#1e3444; --mid:#355872; --sky:#AED3EF; --paper:#F7F8F0; --mute:rgba(53,88,114,0.38); --line:rgba(53,88,114,0.1); }

    main { margin-top:0; background:#eaf2f9; min-height:100vh; width:calc(100% + 60px); margin-left:-30px; }

    .topbar { background:var(--ink); padding:2.5rem 3.5rem; display:flex; align-items:center; justify-content:space-between; }
    .topbar h1 { font-family:'Bebas Neue',sans-serif; font-size:clamp(2rem,4vw,3rem); color:var(--paper); margin:0; line-height:1; }
    .topbar p { font-family:'DM Sans',sans-serif; font-size:0.6rem; font-weight:600; letter-spacing:0.2em; text-transform:uppercase; color:rgba(174,211,239,0.4); margin:0 0 0.2rem; }

    .avatar-wrap { position:relative; cursor:pointer; }
    .avatar { width:48px; height:48px; border-radius:50%; background:var(--sky); border:2px solid rgba(174,211,239,0.3); display:flex; align-items:center; justify-content:center; font-family:'Bebas Neue',sans-serif; font-size:1.1rem; color:var(--ink); overflow:hidden; background-size:cover; background-position:center; transition:border-color 0.2s; }
    .avatar:hover { border-color:var(--sky); }
    .avatar-hint { position:absolute; inset:0; border-radius:50%; background:rgba(30,52,68,0.6); display:flex; align-items:center; justify-content:center; opacity:0; transition:opacity 0.2s; font-family:'DM Sans',sans-serif; font-size:0.5rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:#fff; pointer-events:none; }
    .avatar-wrap:hover .avatar-hint { opacity:1; }

    .pg-body { max-width:680px; margin:2rem auto 5rem; padding:0 2.5rem; display:flex; flex-direction:column; gap:1rem; }

    .card { background:var(--paper); border-radius:0.85rem; border:1px solid rgba(174,211,239,0.35); box-shadow:0 1px 3px rgba(30,52,68,0.04),0 4px 16px rgba(30,52,68,0.06); overflow:hidden; }
    .card-head { padding:1rem 1.5rem; border-bottom:1px solid var(--line); }
    .card-title { font-family:'DM Sans',sans-serif; font-size:0.58rem; font-weight:700; letter-spacing:0.2em; text-transform:uppercase; color:var(--mute); }
    .card-body { padding:1.5rem; }

    .field-list { display:flex; flex-direction:column; gap:0.85rem; }
    .field { display:flex; flex-direction:column; gap:0.28rem; }
    .flabel { font-family:'DM Sans',sans-serif; font-size:0.57rem; font-weight:700; letter-spacing:0.16em; text-transform:uppercase; color:var(--mute); }
    .fval { font-family:'DM Sans',sans-serif; font-size:0.88rem; font-weight:500; color:var(--ink); padding:0.55rem 0.75rem; background:rgba(174,211,239,0.1); border:1px solid var(--line); border-radius:0.5rem; }
    .fval.dim { color:var(--mute); font-weight:400; }

    .slist { display:flex; flex-direction:column; }
    .srow { display:flex; align-items:center; justify-content:space-between; padding:0.8rem 0; gap:1rem; border-bottom:1px solid var(--line); }
    .srow:last-child { border-bottom:none; }
    .srow:first-child { padding-top:0; }
    .srow-title { font-family:'DM Sans',sans-serif; font-size:0.84rem; font-weight:500; color:var(--ink); }
    .srow-desc { font-family:'DM Sans',sans-serif; font-size:0.7rem; color:var(--mute); margin-top:0.1rem; }
    .glabel { font-family:'DM Sans',sans-serif; font-size:0.57rem; font-weight:700; letter-spacing:0.18em; text-transform:uppercase; color:var(--mute); margin:0 0 0.65rem; }
    .ssec { display:flex; flex-direction:column; gap:1.25rem; }
    .ssec + .ssec { margin-top:1.25rem; padding-top:1.25rem; border-top:1px solid var(--line); }

    .toggle { position:relative; width:34px; height:19px; flex-shrink:0; }
    .toggle input { opacity:0; width:0; height:0; }
    .tslider { position:absolute; inset:0; background:rgba(53,88,114,0.15); border-radius:999px; cursor:pointer; transition:background 0.2s; }
    .tslider::before { content:''; position:absolute; width:13px; height:13px; left:3px; top:3px; background:#fff; border-radius:50%; transition:transform 0.2s; box-shadow:0 1px 3px rgba(0,0,0,0.12); }
    .toggle input:checked + .tslider { background:var(--mid); }
    .toggle input:checked + .tslider::before { transform:translateX(15px); }

    .btn-row { display:flex; justify-content:flex-end; padding-top:1rem; border-top:1px solid var(--line); margin-top:0.25rem; }
    .btn { font-family:'DM Sans',sans-serif; font-size:0.7rem; font-weight:600; letter-spacing:0.1em; text-transform:uppercase; padding:0.55rem 1.3rem; border-radius:0.45rem; border:1px solid transparent; cursor:pointer; transition:all 0.15s; background:var(--ink); color:var(--paper); border-color:var(--ink); }
    .btn:hover { background:var(--mid); border-color:var(--mid); }

    #toast { position:fixed; bottom:2rem; right:2rem; background:var(--ink); color:var(--paper); font-family:'DM Sans',sans-serif; font-size:0.78rem; font-weight:500; padding:0.7rem 1.1rem; border-radius:0.5rem; box-shadow:0 6px 20px rgba(30,52,68,0.22); display:flex; align-items:center; gap:0.45rem; opacity:0; transform:translateY(0.5rem); transition:opacity 0.22s,transform 0.22s; pointer-events:none; z-index:999; }
    #toast.show { opacity:1; transform:translateY(0); }
    #toast svg { width:13px; height:13px; stroke:var(--sky); fill:none; stroke-width:2.5; }
</style>

<main>
    <div class="topbar">
        <div>
            <p>Account Management</p>
            <h1>Admin Profile</h1>
        </div>
        <div class="avatar-wrap" onclick="document.getElementById('avatarInput').click()">
            <div class="avatar" id="avatarEl"><span id="avatarInitials">A</span></div>
            <div class="avatar-hint">Change</div>
        </div>
        <input type="file" id="avatarInput" accept="image/*" style="display:none" onchange="previewAvatar(event)" />
    </div>

    <div class="pg-body">

        <div class="card">
  <div class="card-head"><span class="card-title">Account Information</span></div>
       <div class="card-body">
              <div class="field-list">
               <div class="field">
               <span class="flabel">User ID</span>
              <div class="fval dim" id="dispUID">—</div>
       </div>
             <div class="field">
           <span class="flabel">Role</span>
                <div class="fval" id="dispRole">—</div>
           </div>
           </div>
         </div>
        </div>

       

<script>
    function previewAvatar(event) {
        var file = event.target.files[0];
        if (!file) return;
        var reader = new FileReader();
        reader.onload = function (e) {
            var el = document.getElementById('avatarEl');
            el.style.backgroundImage = 'url(' + e.target.result + ')';
            document.getElementById('avatarInitials').innerText = '';
        };
        reader.readAsDataURL(file);
    }
</script>

</asp:Content>
