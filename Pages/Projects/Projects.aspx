<%@ Page Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="GROUP01_MP_Mockup.Pages.Projects.Projects" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
  :root {
    --navy: #355872;
    --navy-light: #7AAACE;
    --green: #0d7a5a;
    --green-light: #14b88a;
    --gray-bg: #F7F8F0;
    --gray-border: #e5e7eb;
    --gray-text: #6b7280;
    --body-text: #374151;
    --dark-text: #111827;
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  /*HERO*/
  .proj-hero {
    background: var(--navy);
    padding: 64px 48px 88px;
    position: relative;
    overflow: hidden;
    width: 100vw;
    position: relative;
    left: 50%;
    margin-left: -50vw;
  }
  .proj-hero::before {
    content: '';
    position: absolute;
    top: -80px; right: -80px;
    width: 400px; height: 400px;
    background: radial-gradient(circle, rgba(13,122,90,0.18) 0%, transparent 70%);
    pointer-events: none;
  }
  .proj-hero h1 {
    font-family: Georgia, serif;
    font-style: italic;
    font-size: clamp(36px, 5vw, 56px);
    font-weight: 400;
    color: #fff;
    line-height: 1.1;
    margin-bottom: 18px;
    animation: fadeUp 0.6s ease both;
  }
  .proj-hero p {
    max-width: 560px;
    font-family: Verdana, sans-serif;
    font-size: 15px;
    color: #9db4cc;
    line-height: 1.75;
    font-style: oblique;
    animation: fadeUp 0.6s 0.1s ease both;
  }

  /*STATS BAR*/
  .proj-stats {
    background: var(--navy-light);
    border-top: 1px solid rgba(255,255,255,0.08);
    padding: 20px 48px;
    display: flex;
    gap: 48px;
    width: 100vw;
    position: relative;
    left: 50%;
    margin-left: -50vw;
  }
  .proj-stat { display: flex; flex-direction: column; gap: 2px; }
  .proj-stat-value {
    font-family: Georgia, serif;
    font-style: italic;
    font-size: 24px;
    color: #355872;
  }
  .proj-stat-label {
    font-family: Verdana, sans-serif;
    font-size: 12px;
    color: #355872;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    font-style: oblique;
  }

  /*BUTTON FILTERS*/
  .proj-filters {
    padding: 28px 0 0;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }
  .proj-filter-btn {
    background: #fff;
    border: 1px solid var(--gray-border);
    color: var(--gray-text);
    font-family: Verdana, sans-serif;
    font-size: 13px;
    font-weight: 500;
    font-style: oblique;
    padding: 7px 16px;
    border-radius: 99px;
    cursor: pointer;
    transition: all 0.2s;
  }
  .proj-filter-btn:hover { border-color: var(--green); color: var(--green); }
  .proj-filter-btn.active {
    background: var(--navy);
    border-color: var(--navy);
    color: #fff;
  }

  /*GRID*/
  .proj-grid {
    padding: 28px 0 64px;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 24px;
    align-items: start;
  }

  /*CARDS*/
  .proj-card {
    background: #F7F8F0;
    border: 1px solid var(--gray-border);
    border-radius: 14px;
    padding: 28px;
    display: flex;
    flex-direction: column;
    gap: 14px;
    transition: box-shadow 0.25s, transform 0.25s;
    animation: fadeUp 0.5s ease both;
  }
  .proj-card:hover {
    box-shadow: 0 10px 32px rgba(0,0,0,0.10);
    transform: translateY(-3px);
  }
  .proj-card-title {
    font-family: Georgia, serif;
    font-style: italic;
    font-size: 18px;
    font-weight: 400;
    color: var(--dark-text);
    line-height: 1.3;
  }
  .proj-badges { display: flex; gap: 8px; flex-wrap: wrap; }
  .proj-badge {
    font-family: Verdana, sans-serif;
    font-size: 12px;
    font-weight: 600;
    padding: 3px 11px;
    border-radius: 6px;
  }
  .proj-badge-active   { background: var(--green); color: #fff; }
  .proj-badge-planning { background: #6b7280;     color: #fff; }
  .proj-badge-done     { background: #1a6fa0;     color: #fff; }
  .proj-badge-cat { font-weight: 500; }
  .proj-cat-Category1 { background: #e8f4fd; color: #1a6fa0; }
  .proj-cat-Category2 { background: #e8f9f4; color: #0d7a5a; }
  .proj-cat-Category3 { background: #fdeef6; color: #9b2d6e; }
  .proj-cat-Category4 { background: #edf7ee; color: #2d7a38; }
  .proj-cat-Category5 { background: #fdf3e8; color: #a06010; }
  .proj-cat-Category6 { background: #f0eeff; color: #5a38a0; }

  .proj-card-desc {
    font-family: Verdana, sans-serif;
    font-size: 14px;
    color: #4b5563;
    line-height: 1.65;
    font-style: oblique;
    flex-grow: 1;
  }

  /*PROGRESS*/
  .proj-progress-wrap { width: 100%; }
  .proj-progress-label {
    display: flex;
    justify-content: space-between;
    font-family: Verdana, sans-serif;
    font-size: 12px;
    color: var(--gray-text);
    font-style: oblique;
    margin-bottom: 6px;
  }
  .proj-progress-label span:last-child { font-weight: 600; color: var(--body-text); }
  .proj-progress-track {
    width: 100%;
    height: 6px;
    background: #e5e7eb;
    border-radius: 99px;
    overflow: hidden;
  }
  .proj-progress-fill {
    height: 100%;
    background: linear-gradient(90deg, var(--green), var(--green-light));
    border-radius: 99px;
    transition: width 1s cubic-bezier(0.4,0,0.2,1);
    width: 0;
  }

  /*TOGGLE*/
  .proj-toggle-btn {
    background: none;
    border: none;
    cursor: pointer;
    align-self: flex-end;
    color: var(--gray-text);
    font-size: 16px;
    padding: 2px 4px;
    transition: color 0.2s, transform 0.25s;
    line-height: 1;
  }
  .proj-toggle-btn:hover { color: var(--green); }
  .proj-toggle-btn.open { transform: rotate(180deg); }

  /*DETAILS*/
  .proj-card-details {
    border-top: 1px solid #f3f4f6;
    padding-top: 0;
    display: flex;
    flex-direction: column;
    gap: 10px;
    overflow: hidden;
    max-height: 0;
    opacity: 0;
    transition: max-height 0.35s ease, opacity 0.3s ease, padding-top 0.3s;
  }
  .proj-card-details.open { max-height: 300px; opacity: 1; padding-top: 16px; }
  .proj-card-details p {
    font-family: Verdana, sans-serif;
    font-size: 14px;
    color: var(--body-text);
    line-height: 1.7;
    font-style: italic;
  }
  .proj-card-dates {
    display: flex;
    gap: 20px;
    font-family: Verdana, sans-serif;
    font-size: 13px;
    color: var(--gray-text);
    font-style: oblique;
  }
  .proj-card-dates strong { color: var(--body-text); }

  /*VIEW DETAILS LINK*/
  .proj-view-link {
    font-family: Verdana, sans-serif;
    font-size: 13px;
    color: var(--navy);
    text-decoration: none;
    font-weight: 600;
    align-self: flex-start;
    transition: color 0.2s;
  }
  .proj-view-link:hover { color: var(--navy-light); }
  /*ANIMATIONS*/
  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(16px); }
    to   { opacity: 1; transform: translateY(0); }
  }
  /*MOBILE FUNCTION*/
  @media (max-width: 640px) {
    .proj-hero, .proj-stats { padding-left: 20px; padding-right: 20px; }
    .proj-stats { gap: 24px; flex-wrap: wrap; }
    .proj-grid { grid-template-columns: 1fr; }
  }
</style>

<!--HERO-->
<div class="proj-hero">
  <h1>Our Projects</h1>
  <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.</p>
</div>

<!--STATS BAR-->
<div class="proj-stats">
  <div class="proj-stat"><span class="proj-stat-value">6</span><span class="proj-stat-label">Total Projects</span></div>
  <div class="proj-stat"><span class="proj-stat-value">5</span><span class="proj-stat-label">Active</span></div>
  <div class="proj-stat"><span class="proj-stat-value">67%</span><span class="proj-stat-label">Avg. Progress</span></div>
  <div class="proj-stat"><span class="proj-stat-value">$6.7B</span><span class="proj-stat-label">Total Budget</span></div>
</div>

<!--FILTERS+GRID-->
<div style="padding: 0 12vw;">

  <div class="proj-filters">
      <button type="button" class="proj-filter-btn active" data-filter="All">All</button>
      <button type="button" class="proj-filter-btn" data-filter="Category1">Category 1</button>
      <button type="button" class="proj-filter-btn" data-filter="Category2">Category 2</button>
      <button type="button" class="proj-filter-btn" data-filter="Category3">Category 3</button>
      <button type="button" class="proj-filter-btn" data-filter="Category4">Category 4</button>
      <button type="button" class="proj-filter-btn" data-filter="Category5">Category 5</button>
      <button type="button" class="proj-filter-btn" data-filter="Category6">Category 6</button>
  </div>

  <div class="proj-grid" id="projGrid"></div>

</div>

<script>
  const projects = [
    { title: "Project 1", status: "Active", category: "Category1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.", progress: 42, details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", start: "January 2023", expected: "December 2026" },
    { title: "Project 2", status: "Active", category: "Category2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.", progress: 69, details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", start: "March 2023", expected: "June 2026" },
    { title: "Project 3", status: "Active", category: "Category3", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.", progress: 48, details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", start: "June 2024", expected: "March 2027" },
    { title: "Project 4", status: "Active", category: "Category4", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.", progress: 33, details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", start: "September 2024", expected: "December 2028" },
    { title: "Project 5", status: "Active", category: "Category5", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.", progress: 67, details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", start: "January 2024", expected: "August 2026" },
    { title: "Project 6", status: "Planning", category: "Category6", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.", progress: 12, details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", start: "April 2025", expected: "October 2027" }
  ];

  const statusClass = { Active: "proj-badge-active", Planning: "proj-badge-planning", Completed: "proj-badge-done" };

  function renderCards(filter) {
    const grid = document.getElementById("projGrid");
    const filtered = filter === "All" ? projects : projects.filter(p => p.category === filter);
    grid.innerHTML = "";

    filtered.forEach((p, i) => {
      const card = document.createElement("div");
      card.className = "proj-card";
      card.style.animationDelay = `${i * 0.07}s`;

      card.innerHTML = `
        <div class="proj-card-title">${p.title}</div>
        <div class="proj-badges">
          <span class="proj-badge ${statusClass[p.status] || 'proj-badge-planning'}">${p.status}</span>
          <span class="proj-badge proj-badge-cat proj-cat-${p.category}">${p.category}</span>
        </div>
        <p class="proj-card-desc">${p.description}</p>
        <div class="proj-progress-wrap">
          <div class="proj-progress-label"><span>Progress</span><span>${p.progress}%</span></div>
          <div class="proj-progress-track"><div class="proj-progress-fill" data-width="${p.progress}"></div></div>
        </div>
        <button type="button" class="proj-toggle-btn" aria-label="Toggle details">▼</button>
        <div class="proj-card-details">
          <p>${p.details}</p>
          <div class="proj-card-dates">
            <span><strong>Start:</strong> ${p.start}</span>
            <span><strong>Expected:</strong> ${p.expected}</span>
          </div>
          <a class="proj-view-link" href="ProjectsDetails.aspx">View Details →</a>
        </div>
      `;

      const btn = card.querySelector(".proj-toggle-btn");
      const details = card.querySelector(".proj-card-details");
      btn.addEventListener("click", () => {
        const open = details.classList.toggle("open");
        btn.classList.toggle("open", open);
      });

      grid.appendChild(card);
    });

    requestAnimationFrame(() => {
      document.querySelectorAll(".proj-progress-fill").forEach(el => {
        el.style.width = el.dataset.width + "%";
      });
    });
  }

  document.querySelectorAll(".proj-filter-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".proj-filter-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      renderCards(btn.dataset.filter);
    });
  });

  renderCards("All");
</script>

</asp:Content>
