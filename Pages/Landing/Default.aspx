<style>
    body {
        background: #F7F8F0;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    main {
        margin-top: 60px;
        position: relative;
        z-index: 1;
        background: #F7F8F0;
    }

    .container {
        padding: 0rem;
        flex: 1;
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

    .slider-nav a {
        width: 0.5rem;
        height: 0.5rem;
        border-radius: 50%;
        background-color: #fff;
        opacity: 0.75;
        transition: opacity ease-out 250ms;
    }

    .slider-nav a:hover { 
        opacity: 1; }

   
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
        margin-bottom: 20rem;
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
        margin-top: 5rem;
        text-align: center;
        margin-left: -1rem;
        position: sticky;
    }

    .footer-moreofus {
        display: flex;
        align-items: center;
        justify-content: center;
        padding-top: 1.5rem;
        border-top: 1px solid rgba(247, 248, 240, 0.2);
        margin-top: 1rem;
    }

    .footer-moreofus img {
        width: 7rem;
        height: auto;
        object-fit: contain;
        display: block;
        padding-right: 2rem;
    }

    .footer-divider {
        width: 1px;
        height: 6rem;
        background: rgba(247, 248, 240, 0.4);
        flex-shrink: 0;
    }

    .footer-nav-links {
        display: flex;
        flex-direction: column;
        gap: 0.4rem;
        padding-left: 2rem;
    }

    .footer-nav-links p {
        margin: 0;
    }

    .footer-nav-links p span {
        color: rgba(247, 248, 240, 0.85);
        font-size: 0.95rem;
        font-weight: 500;
        letter-spacing: 0.04em;
        text-transform: uppercase;
        cursor: pointer;
        transition: color 0.2s ease, letter-spacing 0.2s ease;
    }

    .footer-nav-links p span:hover {
        color: #fff;
        letter-spacing: 0.08em;
    }
</style>

<main>

    <section class="container">

        <div class="slider-wrapper">
            <div class="slider">

                <img id="slide-1" src="https://images.unsplash.com/photo-1468581264429-2548ef9eb732?q=80&w=1470&auto=format&fit=crop" alt="Ocean"/>

                <img id="slide-2" src="https://images.unsplash.com/photo-1460501501851-d5946a18e552?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Water"/>

                <img id="slide-3" src="https://images.unsplash.com/photo-1610891015188-5369212db097?q=80&w=1829&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Factory" />

                <img id="slide-4" src="https://images.unsplash.com/photo-1513828583688-c52646db42da?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="More Factory" />

                <img id="slide-5" src="https://images.unsplash.com/photo-1669991504272-19c28fd98c15?q=80&w=1522&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Philippines" />
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

    </section>

</main>

<footer class="footer">

    <div class="footer-inner">
        <p class="footer-name">Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.</p>
        
        <p class="footer-bio">About Us</p>

    </div>


    <div class="footer-moreofus">

        <img id="logo-1" src="https://scontent.fmnl16-1.fna.fbcdn.net/v/t1.15752-9/642803628_4185124805132628_5870511885440428509_n.png?stp=dst-png_s2048x2048&_nc_cat=110&ccb=1-7&_nc_sid=9f807c&_nc_ohc=QobXhHPwDkQQ7kNvwG1ud_e&_nc_oc=Adkp0sdB-fbaTg8N0oP-7ax2ZJ2esBjj57mZVZ0u6r2Dq35zMqkY7-G0KFn0Btsu95c&_nc_zt=23&_nc_ht=scontent.fmnl16-1.fna&_nc_ss=8&oh=03_Q7cD4wGpHoD75yKmzcH8RSygGuJ2JJc9ZIhp3yGTXHJkB-vS7w&oe=69D71D78" alt="Logo Example" />

        <div class="footer-divider"></div>

        <div class="footer-nav-links">
            <p><span>Our Projects</span></p>

            <p><span>Register</span></p>

            <p><span>Learn More</span></p>

            <p><span>Contact Us</span></p>


        </div>
    </div>

</footer>
