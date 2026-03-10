<%@ Page Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Auth.Signup" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div style="text-align: center">
        <h1>CREATE AN ACCOUNT</h1>
        <p>
        &nbsp;</p>
        <p>
            <asp:TextBox ID="txtSignupUsername" runat="server" Height="35px" Width="300px" placeholder="Username"></asp:TextBox>
        </p>
        <p>
            <asp:TextBox ID="txtSignupPassword" runat="server" Height="35px" Width="300px" placeholder="Password" TextMode="Password"></asp:TextBox>
        </p>
        <p>
            <asp:TextBox ID="txtConfirmPassword" runat="server" Height="35px" placeholder="Confirm Password" Width="300px" TextMode="Password"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="lblSignupMessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="btnSignup" runat="server" Height="35px" Text="Sign Up" Width="300px" OnClick="btnSignup_Click" />
        </p>
        <p>
            Account already exists? <a href="Login.aspx">Login</a></p>
    </div>

</asp:Content>