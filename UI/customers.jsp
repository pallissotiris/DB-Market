<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>DB Market | Customers</title>
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
        </header>
        <br>
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "rest">
            SELECT customer_id, First_Name, Last_Name FROM customer;
        </sql:query>
        <form action="" class="all-elements">
            <label for="customer">Select customer:</label>
            <select id="customer" name="customer">
                <c:forEach var = "row" items="${rest.rows}">
                    <option value = "${row.customer_id}">${row.customer_id} ${row.first_name} ${row.last_name}</option>
                </c:forEach>
            </select>
            <input type="submit">
        </form>
        <%
            String param = request.getQueryString();
            String sql = "select *, count(*) as Times_Bought from (select Product_Name from Product,Transactions, (select Barcode, Transaction_ID from Consists_Of) as a where a.Transaction_ID = Transactions.Transaction_ID and customer_id = ? and product.Barcode = a.barcode) as b group by Product_Name order by Times_Bought desc limit 10 ";
            pageContext.setAttribute("sql", sql);
        %>
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "result" sql="${sql}">
            <sql:param value="${param.customer}" />
        </sql:query>
        <table class="all-center">
            <tr ><th colspan = "2">Top 10 Favorite Products</th></tr>
            <tr>
                <th>Product Name</th>
                <th>Times Bought</th>
            </tr>

            <c:forEach var = "row" items = "${result.rows}" >
                <tr>
                    <td><c:out value = "${row.Product_Name}"/></td>
                    <td><c:out value = "${row.Times_Bought}" /></td>
                </tr>
            </c:forEach>
        </table>
        <%
            String query = "select distinct store_id from transactions where customer_id = ? order by store_id;";
            pageContext.setAttribute("query", query);
        %>
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "results" sql="${query}">
            <sql:param value="${param.customer}" />
        </sql:query>
        <table class="all-center">
            <tr ><th>Stores Visited</th></tr>
            <tr>
                <th>Store ID</th>
            </tr>

            <c:forEach var = "row" items = "${results.rows}" >
                <tr>
                    <td><c:out value = "${row.Store_ID}"/></td>
                </tr>
            </c:forEach>
        </table>
        <br>
    </body>
</html>