<%@ Page Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Auth.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div style="text-align: center">
        <h1>LOGIN</h1>
        <p>
            &nbsp;</p>
        <p>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" Height="35px" Width="300px"></asp:TextBox>
        </p>
        <p>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" Height="35px" Width="300px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="lblLoginMessage" runat="server" ForeColor="Red" Text="Invalid Username or Password." Visible="False"></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="btnLogin" runat="server" Height="35px" Text="Login" Width="300px" OnClick="btnLogin_Click" />
        </p>
        <p>
            Don&#39;t have an account? <a href="Signup.aspx">Sign up</a></p>
    </div>
    
</asp:Content>