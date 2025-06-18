document.addEventListener('DOMContentLoaded', () => {
    // Existing IntersectionObserver for visibility animations
    const elements = document.querySelectorAll('.hero-section, .destinations-section, .about-section, .main-footer, .destination-card');

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.2
    });

    elements.forEach(element => {
        observer.observe(element);
    });

    // Smooth scrolling for navbar links
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80, // Adjust for navbar height
                    behavior: 'smooth'
                });
                // Close mobile menu after clicking a link
                const menuToggle = document.getElementById('menu-toggle');
                if (menuToggle) {
                    menuToggle.checked = false;
                }
            }
        });
    });

    // Close mobile menu on logout button click
    const logoutBtn = document.querySelector('.logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', () => {
            const menuToggle = document.getElementById('menu-toggle');
            if (menuToggle) {
                menuToggle.checked = false;
            }
        });
    }

    // Navbar transparency toggle on scroll
    const navbar = document.querySelector('.new-navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
            navbar.classList.remove('navbar-animate'); // Remove animation on scroll
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Slider functionality
    const slider = document.querySelector('.slider');
    const slides = document.querySelectorAll('.slide');
    const leftArrow = document.querySelector('.left-arrow');
    const rightArrow = document.querySelector('.right-arrow');
    let currentIndex = 0;
    let isSliding = false;
    const totalSlides = slides.length;

    function updateSlider() {
        slider.style.transform = `translateX(-${currentIndex * 100}%)`;
        slides.forEach((slide, index) => {
            slide.classList.toggle('active', index === currentIndex);
        });
    }

    function nextSlide() {
        if (isSliding) return;
        isSliding = true;
        currentIndex = (currentIndex + 1) % totalSlides;
        updateSlider();
    }

    function prevSlide() {
        if (isSliding) return;
        isSliding = true;
        currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
        updateSlider();
    }

    function enableArrows() {
        isSliding = false;
        leftArrow.classList.remove('disabled');
        rightArrow.classList.remove('disabled');
    }

    slider.addEventListener('transitionend', enableArrows);

    rightArrow.addEventListener('click', () => {
        if (!isSliding) {
            leftArrow.classList.add('disabled');
            rightArrow.classList.add('disabled');
            nextSlide();
        }
    });

    leftArrow.addEventListener('click', () => {
        if (!isSliding) {
            leftArrow.classList.add('disabled');
            rightArrow.classList.add('disabled');
            prevSlide();
        }
    });

    // Automatic sliding every 5 seconds
    let autoSlide = setInterval(nextSlide, 5000);

    // Pause auto-slide on arrow click and resume after 10 seconds
    function resetAutoSlide() {
        clearInterval(autoSlide);
        autoSlide = setInterval(nextSlide, 5000);
    }

    leftArrow.addEventListener('click', resetAutoSlide);
    rightArrow.addEventListener('click', resetAutoSlide);

    // Pause auto-slide on hover
    slider.addEventListener('mouseenter', () => clearInterval(autoSlide));
    slider.addEventListener('mouseleave', () => {
        resetAutoSlide();
    });
});