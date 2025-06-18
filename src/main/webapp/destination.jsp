```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.DestinationDao, com.entities.Destination, com.dao.ReviewDao, com.entities.Review, java.util.List, java.net.URLEncoder, java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Destination Details</title>
<link rel="stylesheet" href="css/style.css?v=<%=System.currentTimeMillis()%>">
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
        <%
        String destinationName = request.getParameter("name");
        String decodedDestinationName = destinationName != null ? URLDecoder.decode(destinationName, "UTF-8") : null;
        DestinationDao destinationDao = new DestinationDao();
        ReviewDao reviewDao = new ReviewDao();
        Destination destination = null;

        if (decodedDestinationName != null && !decodedDestinationName.isEmpty()) {
            destination = destinationDao.getDestinationByName(decodedDestinationName);
        }

        if (destination == null) {
        %>
        <section class="destination-error">
            <h2>Destination Not Found</h2>
            <p>
                Sorry, the destination "<%=decodedDestinationName != null ? decodedDestinationName : ""%>"
                is not available.
            </p>
            <p>
                Please check the spelling or try <a href="home.jsp">searching for another destination</a>.
            </p>
        </section>
        <% } else { %>
        <section class="destination-details">
            <h2><%=destination.getName()%>, <%=destination.getCountry()%></h2>
            <img src="<%=destination.getImageUrl()%>" alt="<%=destination.getName()%>">
            <p><%=destination.getDescription()%></p>
            <a href="<%=request.getContextPath()%>/booking.jsp?name=<%=URLEncoder.encode(destination.getName(), "UTF-8")%>" class="book-now-btn">Book Now</a>
            <h3>Highlights</h3>
            <ul>
                <%
                if (destination.getHighlights() != null && !destination.getHighlights().isEmpty()) {
                    String[] highlights = destination.getHighlights().split(",");
                    for (String highlight : highlights) {
                        String[] parts = highlight.split("\\|");
                        String text = parts[0].trim();
                        String url = parts.length > 1 ? parts[1].trim() : "#";
                %>
                <li><a href="<%=url%>"><%=text%></a></li>
                <% } } else { %>
                <li>No highlights available for this destination.</li>
                <% } %>
            </ul>
        </section>

        <section class="reviews">
            <h3>Reviews</h3>
            <div class="reviews-list">
                <%
                List<Review> reviews = reviewDao.getReviewsByDestinationId(destination.getId());
                if (reviews != null && !reviews.isEmpty()) {
                    for (Review review : reviews) {
                %>
                <div class="review-item">
                    <p>
                        <strong><%=review.getUser().getName()%></strong>
                        <div class="rating-stars">
                            <% for(int i=1; i<=5; i++) { %>
                                <span><%= i <= review.getRating() ? "★" : "☆" %></span>
                            <% } %>
                        </div>
                    </p>
                    <% if(review.getComment() != null && !review.getComment().isEmpty()) { %>
                        <p><%= review.getComment() %></p>
                    <% } %>
                    <small>Posted on <%=review.getCreatedAt()%></small>
                </div>
                <% } } else { %>
                <p>No reviews yet. Be the first to review!</p>
                <% } %>
            </div>

            <h4>Add a Review</h4>
            <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
                <div class="error-message">
                    <% if ("invalid_input".equals(error)) { %>
                        Please provide a valid destination and rating.
                    <% } else if ("invalid_rating".equals(error)) { %>
                        Rating must be between 1 and 5.
                    <% } else if ("comment_too_long".equals(error)) { %>
                        Comment cannot exceed 500 characters.
                    <% } else if ("invalid_destination".equals(error)) { %>
                        Invalid destination. Please try again.
                    <% } else if ("server_error".equals(error)) { %>
                        An error occurred while saving your review. Please try again.
                    <% } else { %>
                        An unexpected error occurred. Please try again.
                    <% } %>
                </div>
            <% } %>
            <form action="<%=request.getContextPath()%>/review" method="post" class="review-form">
                <input type="hidden" name="destinationName" value="<%=URLEncoder.encode(destination.getName(), "UTF-8")%>">
                <label for="rating">Rating (1-5):</label>
                <input type="number" id="rating" name="rating" min="1" max="5" required>
                <label for="comment">Comment:</label>
                <textarea id="comment" name="comment"></textarea>
                <button type="submit">Submit Review</button>
            </form>
        </section>
        <% } %>
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
    <script src="js/auth.js"></script>
</body>
</html>
```