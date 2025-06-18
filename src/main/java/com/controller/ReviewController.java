package com.controller;

import com.dao.ReviewDao;
import com.dao.DestinationDao;
import com.entities.Review;
import com.entities.Destination;
import com.entities.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.net.URLEncoder;
import java.net.URLDecoder;

@WebServlet(name = "ReviewController", urlPatterns = {"/review"})
public class ReviewController extends HttpServlet {
    private final ReviewDao reviewDao = new ReviewDao();
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
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        // Validate inputs
        if (decodedDestinationName == null || ratingStr == null) {
            System.out.println("ReviewController: Invalid input - destinationName: '" + decodedDestinationName + "', rating: '" + ratingStr + "'");
            response.sendRedirect(request.getContextPath() + "/destination.jsp?name=" + 
                URLEncoder.encode(destinationName != null ? destinationName : "", "UTF-8") + "&error=invalid_input");
            return;
        }

        int rating;
        try {
            rating = Integer.parseInt(ratingStr);
            if (rating < 1 || rating > 5) {
                throw new NumberFormatException("Rating out of range");
            }
        } catch (NumberFormatException e) {
            System.out.println("ReviewController: Invalid rating: '" + ratingStr + "' for destination: '" + decodedDestinationName + "'");
            response.sendRedirect(request.getContextPath() + "/destination.jsp?name=" + 
                URLEncoder.encode(destinationName, "UTF-8") + "&error=invalid_rating");
            return;
        }

        if (comment != null && comment.length() > 500) {
            System.out.println("ReviewController: Comment too long for destination: '" + decodedDestinationName + "'");
            response.sendRedirect(request.getContextPath() + "/destination.jsp?name=" + 
                URLEncoder.encode(destinationName, "UTF-8") + "&error=comment_too_long");
            return;
        }

        System.out.println("ReviewController: Processing review for destination: '" + decodedDestinationName + "'");
        Destination destination = destinationDao.getDestinationByName(decodedDestinationName);
        if (destination == null) {
            System.out.println("ReviewController: Destination not found: '" + decodedDestinationName + "' (original: '" + destinationName + "')");
            response.sendRedirect(request.getContextPath() + "/destination.jsp?name=" + 
                URLEncoder.encode(destinationName, "UTF-8") + "&error=invalid_destination");
            return;
        }

        try {
            Review review = new Review();
            review.setDestination(destination);
            review.setUser(user);
            review.setRating(rating);
            review.setComment(comment != null && !comment.isEmpty() ? comment : null);
            review.setCreatedAt(LocalDateTime.now());

            reviewDao.saveReview(review);
            response.sendRedirect(request.getContextPath() + "/destination.jsp?name=" + 
                URLEncoder.encode(destinationName, "UTF-8"));
        } catch (Exception e) {
            System.out.println("ReviewController: Error saving review for destination: '" + decodedDestinationName + "'");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/destination.jsp?name=" + 
                URLEncoder.encode(destinationName, "UTF-8") + "&error=server_error");
        }
    }
}