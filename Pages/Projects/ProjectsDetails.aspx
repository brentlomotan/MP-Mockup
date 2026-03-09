<%@ Page Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ProjectsDetails.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Projects.ProjectsDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel class="BannerPanel" ID="Panel1" runat="server" 
    style="width: 100vw; height: 300px; 
           position: relative; left: 50%; margin-left: -50vw;
           background-image: url('../../Images/ProjectDetailsBanner.png');
           background-size: cover; background-position: center;
           box-shadow: inset 0px -25px 20px -10px rgb(30, 30, 30);">
    </asp:Panel>
    <br />
    <a href="Projects.aspx">
        <div style="font-family: Verdana; font-size: 0.8vw; margin-left: 12vw">
            < Back to previous page
        </div>
    </a>
    <br />
    <br />
    <div style="font-family: Verdana; font-size: 2vw; font-weight: bolder; margin-left: 12vw">
    Project Title
    </div>
    <br />
    <div style="font-family: Verdana; font-size: 0.8vw; margin-left: 12vw; color: lightgray">
    Project Publish Date
    </div>
    <br />
    <br />
    <div style="margin-left: 12vw; font-family: Verdana; font-size: 1vw; width: 75vw">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    </div>

</asp:Content>