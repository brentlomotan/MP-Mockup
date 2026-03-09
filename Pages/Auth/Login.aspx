<%@ Page Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Auth.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h1 style="text-align: center">LOGIN</h1>
    <p style="text-align: center">&nbsp;</p>
    <p style="text-align: center">
        <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" Height="35px" Width="300px"></asp:TextBox>
    </p>
    <p style="text-align: center">
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" Height="35px" Width="300px"></asp:TextBox>
    </p>
    <p style="text-align: center">
        <asp:Label ID="lblLoginMessage" runat="server" ForeColor="Red" Text="Invalid Username or Password." Visible="False"></asp:Label>
    </p>
    <p style="text-align: center">
        &nbsp;</p>
    <p style="text-align: center">
        <asp:Button ID="btnLogin" runat="server" Height="35px" Text="Login" Width="300px" OnClick="btnLogin_Click" />
    </p>
    
</asp:Content>