<%@ Page Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ProjectsDetails.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Projects.ProjectsDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }
    </style>

    <section class="PDPanel BannerPanel" ID="Panel1" runat="server" 
    style="width: 100vw; height: 300px; margin-top: -10px;
           position: fixed; left: 0; height: 300px; z-index: 1;
           background-image: url('../../Images/ProjectDetailsBanner.png');
           background-size: cover; background-position: center">
    </section>
    <br />

    <section class ="PDPanel TextPanel" style ="position: relative; z-index: 2; margin-top: 275px; min-height: 100vh; background-color: rgb(174, 211, 239); width: 100vw; padding: 40px 0; left: 50%; right: 50%; margin-left: -50vw; margin-right: -50%; box-shadow: 0px -7px 15px 8px #E6E6E6;">
        <a href="Projects.aspx">
            <div style="font-size: 0.8vw; margin-left: 12vw; animation: fadeUp 0.6s ease both">
                < Back to previous page
            </div>
        </a>
        <br />
        <br />

        <div style="font-size: 2vw; font-weight: bolder; margin-left: 12vw; animation: fadeUp 0.6s ease both">
        Project Title
        </div>
        <br />

        <div style="font-size: 0.8vw; margin-left: 12vw; color: rgb(153, 153, 153); animation: fadeUp 0.7s ease both">
        Project Publish Date
        </div>
        <br />
        <br />

        <div style="margin-left: 12vw; font-size: 1vw; width: 75vw; animation: fadeUp 0.8s ease both">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        </div>
        <br />
        <br />

        <div style="margin-left: 12vw; font-size: 1vw; width: 75vw; animation: fadeUp 0.9s ease both">
        Lorem ipsum dolor sit amet consectetur adipiscing elit. Urna tempor pulvinar vivamus fringilla lacus nec metus. Conubia nostra inceptos himenaeos orci varius natoque penatibus. Purus est efficitur laoreet mauris pharetra vestibulum fusce. Ligula congue sollicitudin erat viverra ac tincidunt nam. Cras eleifend turpis fames primis vulputate ornare sagittis. Cubilia curae hac habitasse platea dictumst lorem ipsum. Tempus leo eu aenean sed diam urna tempor. 
        </div>
        <br />
        <br />

        <div style="margin-left: 12vw; font-size: 1vw; width: 75vw; animation: fadeUp 1s ease both">
        Taciti sociosqu ad litora torquent per conubia nostra. Maximus eget fermentum odio phasellus non purus est. Finibus facilisis dapibus etiam interdum tortor ligula congue. Nullam volutpat porttitor ullamcorper rutrum gravida cras eleifend. Senectus netus suscipit auctor curabitur facilisi cubilia curae. Cursus mi pretium tellus duis convallis tempus leo. Ut hendrerit semper vel class aptent taciti sociosqu. Eros lobortis nulla molestie mattis scelerisque maximus eget. Ante condimentum neque at luctus nibh finibus facilisis. Arcu dignissim velit aliquam imperdiet mollis nullam volutpat. Accumsan maecenas potenti ultricies habitant morbi senectus netus. Vitae pellentesque sem placerat in id cursus mi. Nisl malesuada lacinia integer nunc posuere ut hendrerit. Montes nascetur ridiculus mus donec rhoncus eros lobortis. Suspendisse aliquet nisi sodales consequat magna ante condimentum. Euismod quam justo lectus commodo augue arcu dignissim.
        </div>
    </section>
</asp:Content>