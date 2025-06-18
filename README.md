# 🌍 Travel Instructor

**Travel Instructor is a comprehensive web application designed to help travelers discover new destinations, read authentic reviews, and book local guides seamlessly. It serves as a one-stop platform for planning your next adventure.**

---

## ✨ Features

*   **Secure User Authentication:** Safe and secure user registration and login system.
*   **Powerful Place Search:** Easily search for travel destinations by name, location, or category.
*   **User Reviews & Ratings:** Read authentic reviews from other travelers and leave your own to help the community.
*   **Guide Booking System:** Find and book experienced local guides to make your trip more insightful and memorable.
*   **User Profile Management:** Users can manage their profile, view their booking history, and track their reviews.

---

## 🛠️ Technology Stack

This project is built using a classic Java web application stack:

*   **Frontend:** HTML, CSS, JavaScript
*   **Backend:**
    *   **Core Logic:** Java
    *   **Web Layer:** Servlets, JSP (JavaServer Pages)
    *   **ORM:** Hibernate (for object-relational mapping)
*   **Database:** SQL (e.g., MySQL, PostgreSQL)
*   **Web Server:** Apache Tomcat

---

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

You need to have the following software installed on your machine:
*   JDK 8 or higher
*   Apache Tomcat 9 or higher
*   A Oracle SQL Database 
*   Apache Maven (for building the project)
*   Git

### Installation & Setup

1.  **Clone the repository**
    ```sh
    git clone https://github.com/[your-github-username]/travelInstructor.git
    ```
2.  **Navigate to the project directory**
    ```sh
    cd travelInstructor
    ```
3.  **Database Setup**
    *   Create a new database in your SQL server. For example, `travel_db`.
    *   Import the database schema if you have a `.sql` file, or run the SQL scripts to create the necessary tables.
    *   Update the database configuration in the Hibernate config file (`src/main/resources/hibernate.cfg.xml`).
      ```xml
      <property name="hibernate.connection.url">jdbc:mysql://localhost:3306/travel_db</property>
      <property name="hibernate.connection.username">your_db_username</property>
      <property name="hibernate.connection.password">your_db_password</property>
      ```

4.  **Build the Project**
    *   Use Maven to build the project. This will generate a `.war` file in the `target/` directory.
    ```sh
    mvn clean install
    ```

5.  **Deploy to Tomcat**
    *   Copy the generated `travelInstructor.war` file from the `target/` directory.
    *   Paste it into the `webapps/` directory of your Apache Tomcat installation.
    *   Start the Tomcat server.

6.  **Access the Application**
    *   Open your web browser and navigate to:
      ```
      http://localhost:8080/travelInstructor
      ```
    *(The port and context path may vary depending on your server configuration.)*

---

## 🏛️ Database Schema

The database consists of the following primary tables to support the application's features:

*   **`users`**: Stores user credentials and profile information.
    *   `id`, `username`, `email`, `password_hash`, `created_at`
*   **`places`**: Stores details about the travel destinations.
    *   `id`, `name`, `description`, `location`, `image_url`
*   **`reviews`**: Links users and places, storing ratings and comments.
    *   `id`, `user_id`, `place_id`, `rating`, `comment`, `created_at`
*   **`guides`**: Stores information about available tour guides.
    *   `id`, `name`, `specialty_area`, `rate`, `contact_info`
*   **`bookings`**: Manages the booking of guides by users for specific places.
    *   `id`, `user_id`, `guide_id`, `place_id`, `booking_date`, `status`

---


## 📧 Contact

Your Name – [your.email@example.com](mailto:your.email@example.com)

Project Link: [https://github.com/[your-github-username]/travelInstructor](https://github.com/[your-github-username]/travelInstructor)
