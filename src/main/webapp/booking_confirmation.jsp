```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.BookingDao, com.entities.Booking, com.entities.User, com.entities.Destination"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
    <link rel="stylesheet" href="css/booking.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
    <header>
        <h1>Travel Instructor</h1>
        <nav>
            <a href="home.jsp">Home</a>
            <form action="logout" method="get" class="logout-form">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </nav>
    </header>
    <main>
        <section class="confirmation-section">
            <%
            String bookingId = request.getParameter("bookingId");
            BookingDao bookingDao = new BookingDao();
            Booking booking = null;

            try {
                booking = bookingDao.getBookingById(Long.parseLong(bookingId));
            } catch (NumberFormatException e) {
                booking = null;
            }

            if (booking == null) {
            %>
            <div class="error-message">
                <h2>Booking Not Found</h2>
                <p>Invalid booking ID. Please try again.</p>
                <a href="home.jsp" class="return-btn">Return to Home</a>
            </div>
            <% } else { %>
            <div class="confirmation-card">
                <div class="confirmation-header">
                    <span class="checkmark">✔</span>
                    <h2>Booking Confirmed!</h2>
                </div>
                <p class="confirmation-message">Thank you for your booking! Below are the details of your trip.</p>
                <div class="booking-details">
                    <div class="detail-item">
                        <span class="detail-label">Destination:</span>
                        <span class="detail-value"><%=booking.getDestination().getName()%>, <%=booking.getDestination().getCountry()%></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Travel Dates:</span>
                        <span class="detail-value"><%=booking.getStartDate()%> to <%=booking.getEndDate()%></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Travelers:</span>
                        <span class="detail-value"><%=booking.getTravelers()%></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Mobile Number:</span>
                        <span class="detail-value"><%=booking.getMobileNumber()%></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Options:</span>
                        <span class="detail-value"><%=booking.getOptions() != null ? booking.getOptions() : "None"%></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Total Price:</span>
                        <span class="detail-value">$<%=booking.getTotalPrice()%></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Status:</span>
                        <span class="detail-value"><%=booking.getStatus()%></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Booking Date:</span>
                        <span class="detail-value"><%=booking.getCreatedAt()%></span>
                    </div>
                </div>
                <a href="home.jsp" class="return-btn">Return to Home</a>
            </div>
            <% } %>
        </section>
    </main>
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
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="home.jsp#about-section">About</a></li>
                    <li><a href="home.jsp#footer">Contact</a></li>
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
</body>
</html>
```