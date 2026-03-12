<%@ Page Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Auth.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    @keyframes fadeIn {
        from { opacity: 0; }
        to   { opacity: 1; }
    }

    .fade-container {
        animation: fadeIn 0.6s ease forwards;
    }

    .rounded-input {
        border-radius: 8px;
        border: 1px solid #ccc;
        padding: 0 10px;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    .rounded-input:focus {
        border-color: #33CCFF;
        box-shadow: 0 0 6px rgba(51, 204, 255, 0.5);
        outline: none;
    }

    .rounded-btn {
        border-radius: 8px;
        background-color: #33CCFF;
        border: none;
        color: white;
        cursor: pointer;
        font-weight: bold;
        transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
    }

    .rounded-btn:hover {
        background-color: #00BBEE;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(51, 204, 255, 0.4);
    }

    .rounded-btn:active {
        transform: translateY(0);
        box-shadow: none;
    }
</style>

<div style="text-align: center" class="fade-container">
    <h1>LOGIN</h1>
    <p>&nbsp;</p>
    <p>
        <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" Height="50px" Width="300px" CssClass="rounded-input"></asp:TextBox>
    </p>
    <p>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" Height="50px" Width="300px" CssClass="rounded-input"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="lblLoginMessage" runat="server" ForeColor="Red" Text="Invalid Username or Password." Visible="False"></asp:Label>
    </p>
    <p>&nbsp;</p>
    <p>
        <asp:Button ID="btnLogin" runat="server" Height="50px" Text="Login" Width="300px" OnClick="btnLogin_Click" CssClass="rounded-btn" />
    </p>
    <p>Don&#39;t have an account? <a href="Signup.aspx">Sign up</a></p>
</div>

</asp:Content>