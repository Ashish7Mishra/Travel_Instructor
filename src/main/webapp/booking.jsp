<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.DestinationDao, com.entities.Destination, java.net.URLEncoder, java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Destination</title>
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
        <section class="booking-section">
            <%
            String destinationName = request.getParameter("name");
            String decodedDestinationName = destinationName != null ? URLDecoder.decode(destinationName, "UTF-8") : null;
            DestinationDao destinationDao = new DestinationDao();
            Destination destination = null;

            if (decodedDestinationName != null && !decodedDestinationName.isEmpty()) {
                destination = destinationDao.getDestinationByName(decodedDestinationName);
            }

            if (destination == null) {
            %>
            <div class="error-message">
                <h2>Destination Not Found</h2>
                <p>Sorry, the destination "<%=decodedDestinationName != null ? decodedDestinationName : ""%>" is not available.</p>
                <p>Please try <a href="home.jsp">searching for another destination</a>.</p>
            </div>
            <% } else { %>
            <h2>Book Your Trip to <%=destination.getName()%>, <%=destination.getCountry()%></h2>
            <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
                <div class="error-message">
                    <% if ("invalid".equals(error)) { %>
                        Invalid destination. Please select a valid destination and try again.
                    <% } else { %>
                        An unexpected error occurred. Please try again.
                    <% } %>
                </div>
            <% } %>
            <form id="booking-form" action="<%=request.getContextPath()%>/booking/create" method="post">
                <input type="hidden" name="destinationName" value="<%=URLEncoder.encode(destination.getName(), "UTF-8")%>">
                <div class="form-group">
                    <label for="startDate">Start Date</label>
                    <input type="date" id="startDate" name="startDate" required>
                </div>
                <div class="form-group">
                    <label for="endDate">End Date</label>
                    <input type="date" id="endDate" name="endDate" required>
                </div>
                <div class="form-group">
                    <label for="travelers">Number of Travelers</label>
                    <input type="number" id="travelers" name="travelers" min="1" max="10" required>
                </div>
                <div class="form-group">
                    <label for="mobileNumber">Mobile Number</label>
                    <input type="tel" id="mobileNumber" name="mobileNumber" pattern="[0-9]{10}" placeholder="1234567890" required>
                </div>
                <div class="form-group">
                    <label>Additional Options</label>
                    <div class="checkbox-group">
                        <label><input type="checkbox" name="options" value="guided_tour"> Guided Tour ($50)</label>
                        <label><input type="checkbox" name="options" value="car_rental"> Car Rental ($50)</label>
                    </div>
                </div>
                <div class="form-group">
                    <p>Total Price: <span id="total-price">$0.00</span></p>
                </div>
                <button type="submit" class="submit-btn">Confirm Booking</button>
            </form>
            <% } %>
        </section>
    </main>
    <footer>
        <p>© 2025 Travel Instructor. All rights reserved.</p>
    </footer>
    <script>
        document.getElementById('booking-form')?.addEventListener('change', () => {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);
            const travelers = parseInt(document.getElementById('travelers').value) || 0;
            const options = document.querySelectorAll('input[name="options"]:checked').length;

            if (startDate && endDate && travelers) {
                const days = (endDate - startDate) / (1000 * 60 * 60 * 24);
                const basePrice = days * travelers * 100;
                const optionsPrice = options * 50;
                const totalPrice = basePrice + optionsPrice;
                document.getElementById('total-price').textContent = `$${totalPrice.toFixed(2)}`;
            }
        });
    </script>
</body>
</html>