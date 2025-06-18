package com.controller;

import com.dao.BookingDao;
import com.dao.DestinationDao;
import com.entities.Booking;
import com.entities.Destination;
import com.entities.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.net.URLEncoder;
import java.net.URLDecoder;

@WebServlet(name = "BookingController", urlPatterns = {"/booking/create"})
public class BookingController extends HttpServlet {
    private final BookingDao bookingDao = new BookingDao();
    private final DestinationDao destinationDao = new DestinationDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String destinationName = request.getParameter("destinationName");
        String decodedDestinationName = destinationName != null ? URLDecoder.decode(destinationName, "UTF-8") : null;
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        int travelers = Integer.parseInt(request.getParameter("travelers"));
        String[] options = request.getParameterValues("options");
        String mobileNumber = request.getParameter("mobileNumber");

        System.out.println("BookingController: Processing booking for destination: '" + decodedDestinationName + "'");
        Destination destination = destinationDao.getDestinationByName(decodedDestinationName);
        if (destination == null) {
            System.out.println("BookingController: Destination not found: '" + decodedDestinationName + "' (original: '" + destinationName + "')");
            response.sendRedirect(request.getContextPath() + "/booking.jsp?name=" + URLEncoder.encode(destinationName, "UTF-8") + "&error=invalid");
            return;
        }

        // Calculate total price ($100 per day per traveler + $50 per option)
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);
        long days = ChronoUnit.DAYS.between(start, end);
        BigDecimal basePrice = new BigDecimal("100").multiply(BigDecimal.valueOf(days * travelers));
        BigDecimal optionsPrice = (options != null) ? new BigDecimal("50").multiply(BigDecimal.valueOf(options.length)) : BigDecimal.ZERO;
        BigDecimal totalPrice = basePrice.add(optionsPrice);

        Booking booking = new Booking();
        booking.setUser(user);
        booking.setDestination(destination);
        booking.setStartDate(start);
        booking.setEndDate(end);
        booking.setTravelers(travelers);
        booking.setOptions(options != null ? String.join(",", options) : null);
        booking.setTotalPrice(totalPrice);
        booking.setStatus("PENDING");
        booking.setMobileNumber(mobileNumber);

        bookingDao.saveBooking(booking);
        response.sendRedirect(request.getContextPath() + "/booking_confirmation.jsp?bookingId=" + booking.getId());
    }
}