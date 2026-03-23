<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Landing.Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
    @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@300;400;500;600&display=swap');

    main {
        margin-top: -30px;
        position: relative;
        z-index: 1;
        background: #AED3EF;
        width: calc(100% + 60px);
        margin-left: -30px;
    }

    .slider-wrapper { 
        position: relative; 
        width: 100%; 
    }
    
    @keyframes bannerChange {
        0%, 45%  { transform: translateX(0%); }
        50%, 95% { transform: translateX(-100%); }
        100%     { transform: translateX(0%); }
    }

    .slider {
        display: flex; height: 500px;
        overflow-x: hidden; scroll-snap-type: x mandatory;
        scroll-behavior: smooth;
        box-shadow: 0 1.5rem 3rem -0.75rem hsla(0,0%,0%,0.25);
        scrollbar-width: none; width: 100%;
    }
    .slider::-webkit-scrollbar { display: none; }
    .slider img {
        flex: 1 0 100%; scroll-snap-align: start;
        object-fit: cover; width: 100%;
        animation: bannerChange 20s infinite ease-out;
    }

    .slider-nav {
        display: flex; column-gap: 1rem;
        position: absolute; bottom: 1.25rem; left: 50%;
        transform: translateX(-50%); z-index: 1;
    }

    .slider-text {
        position: absolute; top: 50%; left: 50%;
        transform: translate(-50%, -50%);
        color: white; text-align: center; z-index: 3;
        text-shadow: 0 2px 8px rgba(0,0,0,0.5);
    }
    .slider-text h1 { font-size: clamp(2rem, 5vw, 4rem); margin: 0; color: #b9e0fe; }
    .slider-text h2 { font-size: clamp(1.5rem, 4vw, 3rem); margin: 0; margin-top: 20px; }

    .slider-logo {
        position: absolute; top: 2rem; left: 50%;
        transform: translateX(-50%); z-index: 4;
        max-width: 500px; height: auto; pointer-events: none;
    }

    @keyframes bounceDown {
        0%, 100% { transform: translateX(-50%) translateY(0); opacity: 0.8; }
        50%      { transform: translateX(-50%) translateY(6px); opacity: 1; }
    }

    .scroll-down {
        position: absolute; bottom: 3rem; left: 50%;
        transform: translateX(-50%);
        display: flex; flex-direction: column; align-items: center; gap: 0.3rem;
        color: #F7F8F0; font-size: 0.75rem; letter-spacing: 0.1em;
        animation: bounceDown 5s ease-in-out infinite;
        pointer-events: none; z-index: 2;
        text-shadow: 0 1px 4px rgba(0,0,0,0.4);
    }

    .projects-section {
        background: #AED3EF;
        padding: 3rem 2rem 4rem;
        width: calc(100% + 60px);
        margin-left: -30px;
    }

    .projects-inner {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 30px;
    }

    .projects-header {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        margin-bottom: 2rem;
        flex-wrap: wrap;
        gap: 1rem;
    }

    .projects-title {
        font-family: 'Bebas Neue', sans-serif;
        font-size: clamp(2.5rem, 5vw, 4.5rem);
        color: #355872;
        line-height: 1;
        text-transform: uppercase;
        letter-spacing: -0.02em;
        margin: 0;
        opacity: 0;
        transform: translateY(20px);
        transition: opacity 0.5s ease, transform 0.5s ease;
    }

    .projects-link {
        font-family: 'DM Sans', sans-serif;
        font-size: 0.78rem;
        font-weight: 600;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        color: #355872;
        text-decoration: none;
        border-bottom: 2px solid #355872;
        padding-bottom: 2px;
        transition: opacity 0.2s;
        white-space: nowrap;
        opacity: 0;
        transform: translateY(20px);
        transition: opacity 0.5s ease 0.1s, transform 0.5s ease 0.1s;
    }
    .projects-link:hover { opacity: 0.6; }

    .projects-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 1.25rem;
    }

    .project-card {
        background: #F7F8F0;
        border-radius: 1rem;
        padding: 1.75rem;
        box-shadow: 0 2px 6px rgba(53,88,114,0.08), 0 8px 24px rgba(53,88,114,0.06);
        border: 1px solid rgba(53,88,114,0.08);
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
        opacity: 0;
        transform: translateY(24px);
        transition: opacity 0.5s ease, transform 0.5s ease, box-shadow 0.25s ease;
    }

    .project-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 6px 20px rgba(53,88,114,0.13), 0 16px 40px rgba(53,88,114,0.09);
    }

    .project-card.visible {
        opacity: 1;
        transform: translateY(0);
    }

    .projects-title.visible,
    .projects-link.visible {
        opacity: 1;
        transform: translateY(0);
    }

    .project-status {
        font-family: 'DM Sans', sans-serif;
        font-size: 0.58rem;
        font-weight: 700;
        letter-spacing: 0.15em;
        text-transform: uppercase;
        color: #F7F8F0;
        background: #355872;
        padding: 0.2rem 0.7rem;
        border-radius: 999px;
        width: fit-content;
    }

    .project-title {
        font-family: 'Bebas Neue', sans-serif;
        font-size: 1.4rem;
        color: #1e3444;
        letter-spacing: 0.02em;
        line-height: 1.1;
        margin: 0;
    }

    .project-desc {
        font-family: 'DM Sans', sans-serif;
        font-size: 0.83rem;
        color: rgba(53,88,114,0.6);
        line-height: 1.6;
        margin: 0;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .projects-empty {
        font-family: 'DM Sans', sans-serif;
        font-size: 0.9rem;
        color: rgba(53,88,114,0.5);
        font-style: italic;
    }

    .about-section {
        background: #355872;
        color: #fff;
        display: flex;
        flex-direction: column;
        padding: 4rem 2rem 2rem;
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
        color: rgba(247,248,240,0.6);
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
            <img id="slide-2" src="https://images.unsplash.com/photo-1460501501851-d5946a18e552?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0" alt="Water"/>
            <img id="slide-3" src="https://images.unsplash.com/photo-1610891015188-5369212db097?q=80&w=1829&auto=format&fit=crop&ixlib=rb-4.1.0" alt="Factory"/>
            <img id="slide-4" src="https://images.unsplash.com/photo-1513828583688-c52646db42da?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0" alt="More Factory"/>
            <img id="slide-5" src="https://images.unsplash.com/photo-1669991504272-19c28fd98c15?q=80&w=1522&auto=format&fit=crop&ixlib=rb-4.1.0" alt="Philippines"/>
        </div>

        <img src="/Images/LogoFull.png" alt="LogoFull" class="slider-logo" />

        <div class="slider-text">
            <h1>Cabuyao Water District</h1>
            <h2>Customer Portal</h2>
        </div>

        <div class="slider-nav">
            <a href="#slide-1"></a>
            <a href="#slide-2"></a>
            <a href="#slide-3"></a>
            <a href="#slide-4"></a>
            <a href="#slide-5"></a>
        </div>

        <div class="scroll-down">Scroll down for more info</div>
    </div>
</main>

<section class="projects-section">
    <div class="projects-inner">
        <div class="projects-header">
            <p class="projects-title">Ongoing Projects</p>
            <a href="/Pages/Projects/Projects.aspx" class="projects-link">View all projects →</a>
        </div>
        <div class="projects-grid" id="projectsGrid">
            <p class="projects-empty">Loading projects...</p>
        </div>
    </div>
</section>

<section class="about-section">
    <div class="about-inner">
        <p class="about-bio">About Us</p>
        <p class="about-tagline">
            The year is 2003. Thirty years after Presidential Decree 198 was passed into law, Cabuyao Water District was formed amidst the growing need for a sustainable supply of potable and reasonably priced water.   The formation of CABWAD could not come in a much better time.  The demand for potable water is at its peak and the clamor for an efficient water service provider is being voiced out by every sector of the society.  Consequently, CABWAD was formed.
        </p>
    </div>
</section>

<script>
    window.addEventListener('DOMContentLoaded', function () {
        var grid = document.getElementById('projectsGrid');
        var projects = window.ongoingProjects;

        if (!projects || projects.length === 0) {
            grid.innerHTML = '<p class="projects-empty">No ongoing projects at the moment.</p>';
        } else {
            grid.innerHTML = '';
            projects.forEach(function (p) {
                var card = document.createElement('div');
                card.className = 'project-card';
                card.innerHTML =
                    '<span class="project-status">Ongoing</span>' +
                    '<h3 class="project-title">' + p.title + '</h3>' +
                    '<p class="project-desc">' + p.desc + '</p>';
                grid.appendChild(card);
            });
        }

        var observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.15 });

        document.querySelectorAll('.projects-title, .projects-link, .project-card').forEach(function (el, i) {
            if (el.classList.contains('project-card')) {
                el.style.transitionDelay = (0.05 + i * 0.07) + 's';
            }
            observer.observe(el);
        });
    });
</script>

</asp:Content>
