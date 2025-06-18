```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.DestinationDao, com.entities.Destination, java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="css/style.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
    <div class="home-wrapper">
        <nav class="new-navbar navbar-animate">
            <div class="navbar-brand">
                <h2>Travelling</h2>
            </div>
            <input type="checkbox" id="menu-toggle" class="menu-toggle">
            <label for="menu-toggle" class="hamburger">☰</label>
            <div class="navbar-menu">
                <div class="navbar-links">
                    <a href="#hero-section" class="nav-link">Home</a>
                    <a href="#about-section" class="nav-link">About</a>
                    <a href="#footer" class="nav-link">Contact</a>
                </div>
                <form action="logout" method="get" class="logout-form">
                    <button type="submit" class="logout-btn">Logout</button>
                </form>
            </div>
        </nav>
        <div class="hero-section" id="hero-section">
            <div class="slider">
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1519681393784-d120267933ba');"></div>
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e');"></div>
                <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1449824913935-59a10b8d2000');"></div>
                <button class="slider-arrow left-arrow">❮</button>
                <button class="slider-arrow right-arrow">❯</button>
            </div>
            <div class="hero-content">
                <span class="hero-label">Journey</span>
                <h1>Exploring The World</h1>
                <p>Embark on unforgettable adventures with seamless travel experiences and breathtaking destinations.</p>
            </div>
        </div>

        <!-- Destinations Section -->
        <section class="destinations-section">
            <h2>Popular Destinations</h2>
            <p>Discover some of the most amazing places to visit around the world.</p>
            <div class="search-filter">
                <form action="home.jsp" method="get">
                    <input type="text" name="search" placeholder="Search destinations..." value="<%=request.getParameter("search") != null ? request.getParameter("search") : ""%>">
                    <select name="country">
                        <option value="">All Countries</option>
                        <option value="France">France</option>
                        <option value="USA">USA</option>
                        <option value="Japan">Japan</option>
                        <option value="Australia">Australia</option>
                        <option value="South Africa">South Africa</option>
                        <option value="Italy">Italy</option>
                    </select>
                    <button type="submit">Search</button>
                </form>
            </div>
            <div class="destinations-grid" id="destinations-grid">
                <%
                DestinationDao dao = new DestinationDao();
                String search = request.getParameter("search");
                String country = request.getParameter("country");
                List<Destination> destinations = dao.searchDestinations(search != null ? search : "", country != null ? country : "");
                if (destinations != null && !destinations.isEmpty()) {
                    for (Destination dest : destinations) {
                %>
                <a href="destination.jsp?name=<%=dest.getName()%>" class="destination-card">
                    <img src="<%=dest.getImageUrl()%>" alt="<%=dest.getName()%>">
                    <h3><%=dest.getName()%>, <%=dest.getCountry()%></h3>
                    <p><%=dest.getDescription().length() > 100 ? dest.getDescription().substring(0, 100) + "..." : dest.getDescription()%></p>
                </a>
                <%
                }
                } else {
                %>
                <div class="error-message">
                    <h3>No Destinations Found</h3>
                    <p>No destinations match your search criteria. Try different keywords or select another country.</p>
                </div>
                <%
                }
                %>
            </div>
        </section>

        <!-- About Us Section -->
        <section class="about-section" id="about-section">
            <h2>About Us</h2>
            <p>Welcome to Travelling, your trusted partner in exploring the world’s most breathtaking destinations. Founded in 2010, we are a passionate travel company dedicated to crafting unforgettable experiences tailored to your wanderlust. Our mission is to inspire and empower travelers to discover new cultures, embrace adventure, and create lifelong memories.</p>
            <p>With a team of seasoned travel experts, we offer personalized itineraries, exclusive guided tours, and seamless booking services. Whether you're seeking the vibrant streets of Tokyo, the serene beaches of Italy, or the majestic wildlife of South Africa, we’re here to make your journey extraordinary. Our commitment to sustainable tourism ensures that we support local communities and preserve the beauty of our planet for future generations.</p>
        </section>

        <!-- Footer -->
        <footer class="main-footer" id="footer">
            <div class="footer-content">
                <div class="footer-section footer-contact">
                    <h3>Contact Us</h3>
                    <p>Email: <a href="mailto:info@travelling.com">info@travelling.com</a></p>
                    <p>Phone: <a href="tel:+15551234567">+1 (555) 123-4567</a></p>
                </div>
                <div class="footer-section footer-links">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="#hero-section">Home</a></li>
                        <li><a href="#about-section">About</a></li>
                        <li><a href="#footer">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-section footer-social">
                    <h3>Follow Us</h3>
                    <div class="social-links">
                        <a href="https://www.instagram.com" class="social-icon" title="Instagram">📸</a>
                        <a href="https://www.linkedin.com" class="social-icon" title="LinkedIn">💼</a>
                        <a href="https://www.twitter.com" class="social-icon" title="Twitter">🐦</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>© 2025 Travel Instructor. All rights reserved.</p>
                <p>Images by <a href="https://unsplash.com/@simon_english">Simon English</a>, 
                <a href="https://unsplash.com/@jeremybishop">Jeremy Bishop</a>, 
                <a href="https://unsplash.com/@denysnevozhai">Denys Nevozhai</a> on 
                <a href="https://unsplash.com">Unsplash</a>.</p>
            </div>
        </footer>
    </div>
    <script src="js/auth.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
```