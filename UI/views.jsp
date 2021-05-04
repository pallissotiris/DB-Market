<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
  <head>
        <meta charset="utf-8">
        <title>DB Market | Views</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=IM+Fell+French+Canon+SC&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Catamaran:wght@300;900&display=swap" rel="stylesheet">
    </head>
    <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "res">
        SELECT * FROM category;
    </sql:query>
    <body>
        <header>
            <a href="home.jsp" class="header-br">DB Market</a>
            <nav>
                <ul>
                    <li><a href="categories.jsp" class="index-links">Products</a>
                    <ul  class="store-links">
                        <li><a href="products.jsp?category_name=none">All products</a></li>
                        <c:forEach var = "row" items = "${res.rows}">
                            <li><a href="products.jsp?category_name=${row.category_name}">${row.category_name}</a></li>
                        </c:forEach>
                    </ul>
                    </li>
                    <li><a href="transactions.jsp" class="index-links">Transactions</a>
                    <li><a href="customers.jsp" class="index-links">Customers</a></li>
                    <li><a href="stores.jsp" class="index-links">Stores</a>
                    <ul   class="store-links">
                        <li><a href="athens.html">Athens</a></li>
                        <li><a href="thessaloniki.html">Thessaloniki</a></li>
                        <li><a href="nafplio.html">Nafplio</a></li>
                        <li><a href="giannena.html">Giannena</a></li>
                        <li><a href="tripoli.html">Tripoli</a></li>
                        <li><a href="xanthi.html">Xanthi</a></li>
                    </ul>
                </li>
                <li><a href="statistics.jsp" class="index-links">Statistics</a></li>
                <li><a href="views.jsp">Views</a></li>

            </ul>
        </nav>
        <br>
        <br>
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "result">
            SELECT * FROM customer_info;
        </sql:query>
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "rest">
            SELECT * FROM sales_per_store_per_cat_view;
        </sql:query>

        <table class="all-center">
            <tr><th colspan = "14">Customers Info</th></tr>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Date of Birth</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Marriage Status</th>
                <th>Number of Children</th>
                <th>Email Address</th>
                <th>Phone Number</th>
                <th>Total Points</th>
                <th>City</th>
                <th>Street</th>
                <th>St. Number</th>
                <th>Post Code</th>
            </tr>
            <c:forEach var = "row" items = "${result.rows}" >
                <tr>
                    <td><c:out value = "${row.first_name}"/></td>
                    <td><c:out value = "${row.last_name}"/></td>
                    <td><c:out value = "${row.date_of_birth}"/></td>
                    <td><c:out value = "${row.age}"/></td>
                    <td><c:out value = "${row.gender}" /></td>
                    <td><c:choose>
                            <c:when test = "${row.marriage_status == 'true'}">Married</c:when>
                            <c:when test = "${row.marriage_status == 'false'}">Single</c:when>
                        </c:choose>
                    </td>
                    <td><c:out value = "${row.number_of_children}"/></td>
                    <td><c:out value = "${row.email_address}"/></td>
                    <td><c:out value = "${row.phone_number}"/></td>
                    <td><c:out value = "${row.total_points}"/></td>
                    <td><c:out value = "${row.city}"/></td>
                    <td><c:out value = "${row.street}"/></td>
                    <td><c:out value = "${row.st_number}"/></td>
                    <td><c:out value = "${row.post_code}"/></td>
                </tr>
            </c:forEach>
        </table>
                <table class="all-center">
                    <tr><th colspan="3">Transactions per Category per Store</th></tr>
                <tr>
                    <th>Store</th>
                    <th>Category</th>
                    <th>No. of Purchases</th>
                </tr>
                <c:forEach var = "row" items = "${rest.rows}" >
                <tr>
                    <td><c:out value = "${row.store_id}"/></td>
                    <td><c:out value = "${row.category_name}"/></td>
                    <td><c:out value = "${row.purchases}"/></td>
                </tr>
            </c:forEach>
        </table>
    </header>
  </body>
</html>
