<%@ Page Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Landing.Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    main {
        margin-top: 0;
        position: relative;
        z-index: 1;
        background: #AED3EF;
        min-height: 100vh;

        width: calc(100% + 60px);
        margin-left: -30px;
    }

    .slider-wrapper {
        position: relative;
        width: 100%;
    }

    @keyframes bannerChange{
        0%, 45% {transform: translateX(0%);}
        50%, 95% {transform: translateX(-100%);}
        100% {transform: translateX(0%);}
    }

    .slider {
        display: flex;
        height: 500px;
        overflow-x: hidden; 
        scroll-snap-type: x mandatory;
        scroll-behavior: smooth;
        box-shadow: 0 1.5rem 3rem -0.75rem hsla(0, 0%, 0%, 0.25);
        border-radius: 0rem;
        object-position: center top;
        scrollbar-width: none;
        width: 100%;
        min-width: 100%;
    }

    .slider::-webkit-scrollbar { 
        display: none; }

    .slider img {
        flex: 1 0 100%;
        scroll-snap-align: start;
        object-fit: cover;
        width: 100%;
        animation: bannerChange 20s infinite ease-out;
    }

    .slider-nav {
        display: flex;
        column-gap: 1rem;
        position: absolute;
        bottom: 1.25rem;
        left: 50%;
        transform: translateX(-50%);
        z-index: 1;
    }

    .slider-text {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: white;
        text-align: center;
        z-index: 3;
        text-shadow: 0 2px 8px rgba(0,0,0,0.5);
    }

    .slider-text h1 {
        font-size: clamp(2rem, 5vw, 4rem);
        margin: 0;
    }

    .slider-text p {
        font-size: clamp(1rem, 2vw, 1.3rem);
        margin-top: 0.5rem;
    }

    .slider-logo {
        position: absolute;
        top: 2rem;
        left: 50%;
        transform: translateX(-50%);
        z-index: 4;
        max-width: 200px;
        height: auto;
        pointer-events: none;
    }

    @keyframes bounceDown {
        0%, 100% { transform: translateX(-50%) translateY(0); opacity: 0.8; }

        50% { transform: translateX(-50%) translateY(6px); opacity: 1; }
    }

    .scroll-down {
        position: absolute;
        bottom: 3rem;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 0.3rem;
        color: #F7F8F0;
        font-size: 0.75rem;
        letter-spacing: 0.1em;
      
        opacity: 1;
        animation: bounceDown 5s ease-in-out infinite;
        pointer-events: none;
        z-index: 2;
        text-shadow: 0 1px 4px rgba(0,0,0,0.4);
    }

    .about-section {
        background: #355872;
        color: #fff;
        display: flex;
        flex-direction: column;
        padding: 4rem 2rem 2rem;
        z-index: 0;
        width: calc(100% + 60px);
        margin-left: -30px;
    }

    .about-inner {
        max-width: 1200px;
        margin: 0 auto;
        width: 100%;
        padding: 0 30px;
    }

    .about-bio {
        font-size: clamp(3rem, 7vw, 6rem);
        font-weight: 900;
        color: #F7F8F0;
        line-height: 1.0;
        text-transform: uppercase;
        letter-spacing: -0.02em;
        margin: 0 0 1.5rem 0;
    }

    .about-tagline {
        font-size: clamp(0.85rem, 1.3vw, 1rem);
        color: rgba(247, 248, 240, 0.6);
        font-weight: 400;
        line-height: 1.7;
        max-width: 32rem;
        margin: 0 0 3rem 0;
        border-left: 3px solid #F7F8F0;
        padding-left: 1rem;
    }
</style>

<main>
    <div class="slider-wrapper">

        <div class="slider">
            <img id="slide-1" src="https://images.unsplash.com/photo-1468581264429-2548ef9eb732?q=80&w=1470&auto=format&fit=crop" alt="Ocean"/>
            <img id="slide-2" src="https://images.unsplash.com/photo-1460501501851-d5946a18e552?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Water"/>
            <img id="slide-3" src="https://images.unsplash.com/photo-1610891015188-5369212db097?q=80&w=1829&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Factory" />
            <img id="slide-4" src="https://images.unsplash.com/photo-1513828583688-c52646db42da?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="More Factory" />
            <img id="slide-5" src="https://images.unsplash.com/photo-1669991504272-19c28fd98c15?q=80&w=1522&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Philippines" />
        </div>

        <img src="/Images/LogoFull.png" alt="LogoFull" class="slider-logo" />

        <div class="slider-text">
            <h1>Water for the people.</h1>
        </div>

        <div class="slider-nav">
            <a href="#slide-1"></a>
            <a href="#slide-2"></a>
            <a href="#slide-3"></a>
            <a href="#slide-4"></a>
            <a href="#slide-5"></a>
        </div>
          
        <div class="scroll-down">
            Scroll down for more info
        </div>

    </div>
</main>

<section class="about-section">
    <div class="about-inner">

        <p class="about-bio">About Us</p>

        <p class="about-tagline">
            Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.
        </p>

    </div>
</section>

</asp:Content>