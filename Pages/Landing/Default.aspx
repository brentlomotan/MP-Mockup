<style>
    body {
        background: #F7F8F0;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    main {
        position: relative;
        z-index: 1;
        background: #F7F8F0;
    }

    .container {
        padding: 2rem;
        flex: 1;
    }

    .slider-wrapper {
        position: relative;
        max-width: 48rem;
        margin: 0 auto;
    }

    .slider {
        display: flex;
        aspect-ratio: 21/12;
        overflow-x: auto;
        scroll-snap-type: x mandatory;
        scroll-behavior: smooth;
        box-shadow: 0 1.5rem 3rem -0.75rem hsla(0, 0%, 0%, 0.25);
        border-radius: 0.5rem;
        object-position: center 30%;
        scrollbar-width: none;
    }

    .slider::-webkit-scrollbar { 
        display: none; }

    .slider img {
        flex: 1 0 100%;
        scroll-snap-align: start;
        object-fit: fill;
        width: 48rem;
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

    .slider-nav a {
        width: 0.5rem;
        height: 0.5rem;
        border-radius: 50%;
        background-color: #fff;
        opacity: 0.75;
        transition: opacity ease 250ms;
    }

    .slider-nav a:hover { opacity: 1; }

    .footer {
        background: #355872;
        color: #fff;
        
        display: flex;
        flex-direction: column;
        justify-content: center;
        position: sticky;
        bottom: 0;
        z-index: -1;
        padding: 1rem 2rem;
    }

    .footer-inner {
        max-width: 48rem;
        margin: 0 auto;
        text-align: center;
    }

  .footer-name {
    font-style: italic;
    font-size: 1.5rem;
    margin: 0;
    position: sticky;
    top: 15rem;
}

    .footer-bio {
        font-style: oblique;
        font-size: 10rem;
        color: #F7F8F0;
        line-height: 2.0;
        margin-top: 40vh;
        text-align: center;
        margin-left: -1rem;
    }

    .footer img {
        width: 8rem;
        margin-top: -20vh;
    }   
</style>

<main>
    <section class="container">
        <div class="slider-wrapper">
            <div class="slider">
                <img id="slide-1" src="https://images.unsplash.com/photo-1468581264429-2548ef9eb732?q=80&w=1470&auto=format&fit=crop" alt="Ocean"/>
                <img id="slide-2" src="https://images.unsplash.com/photo-1533077162801-86490c593afb?q=80&w=1074&auto=format&fit=crop" alt="Water"/>
            </div>
            <div class="slider-nav">
                <a href="#slide-1"></a>
                <a href="#slide-2"></a>
            </div>
        </div>
    </section>
</main>

<footer class="footer">
    <div class="footer-inner">
        <p class="footer-name">Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.</p>
        <p class="footer-bio">About Us</p>
        <img id ="logo-1" src="https://scontent.fmnl16-1.fna.fbcdn.net/v/t1.15752-9/642803628_4185124805132628_5870511885440428509_n.png?stp=dst-png_s2048x2048&_nc_cat=110&ccb=1-7&_nc_sid=9f807c&_nc_ohc=QobXhHPwDkQQ7kNvwG1ud_e&_nc_oc=Adkp0sdB-fbaTg8N0oP-7ax2ZJ2esBjj57mZVZ0u6r2Dq35zMqkY7-G0KFn0Btsu95c&_nc_zt=23&_nc_ht=scontent.fmnl16-1.fna&_nc_ss=8&oh=03_Q7cD4wGpHoD75yKmzcH8RSygGuJ2JJc9ZIhp3yGTXHJkB-vS7w&oe=69D71D78" alt="Logo Example" />
    </div>
</footer>