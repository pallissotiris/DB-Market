<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>DB Market | Transactions</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
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
        
        <div class="all-forms">
          <form action="" class="all-forms">
              <div class = "mylabel">
            <label for="store">Store:</label>
            <select id="store" name="store">
              <option value="1">All stores</option>
              <option value="1">1. Athens - Sevastoupoleos</option>
              <option value="2">2. Athens - Hollywood</option>
              <option value="3">3. Xanthi - Stalingrad</option>
              <option value="4">4. Nafplio - Ntua</option>
              <option value="5">5. Nafplio - Madclip</option>
              <option value="6">6. Tripoli - Agias Paraskevis</option>
              <option value="7">7. Thessaloniki - Stalingrad</option>
              <option value="8">8. Xanthi - Thermopylae</option>
              <option value="9">9. Athens - Ch.Trikoupi</option>
              <option value="10">10. Giannena - Stalingrad</option>
            </select>
            </div>
            <br>
            <div class = "mylabel">
            <label for="payment">Payment method:</label>
            <select id="payment" name="payment" >
              <option value="">All methods</option>
              <option value="Cash">Cash</option>
              <option value="Card">Card</option>
              <option value="Cheque">Cheque</option>
            </select>
            </div>
            <br>
            <div class = "mylabel">
            <label>(Date) From:</label>
            <input type="date" name = "from" >
            </div>
            <br>
            <div class = "mylabel">
            <label>(Date) Until:</label>
            <input type="date" name = "until">
            </div>
            <br>
            <div class = "mylabel">
            <label>Minimum price:</label>
            <input type="text" name="minprice" size = "16">
            </div>
            <br>
            <div class = "mylabel">
            <label>Maximum price:</label>
            <input type="text" name="maxprice" size = "16">
            </div>
            <br>
            <div class = "mylabel">
            <label>Min. num. of products:</label>
            <input type="text" name="minprod" size = "10">
            </div>
            <br>
            <div class = "mylabel">
            <label>Max. num. of products:</label>
            <input type="text" name="maxprod" size = "10">
            </div>
            <br>
            <input type="submit">
          </form>
            
        </div>
        
        <% 
            String store_id = request.getParameter("store");
            String  category = request.getParameter("category");
            String  payment  = request.getParameter("payment");
            String  from = request.getParameter("from");
            String  until = request.getParameter("until");
            String  minprice = request.getParameter("minprice");
            String  maxprice = request.getParameter("maxprice");
            String  minprod = request.getParameter("minprod");
            String  maxprod = request.getParameter("maxprod");
            String query = "SELECT * FROM Transactions ";
            if ((((payment != null && !"".equalsIgnoreCase(payment)) || (from != null && !"".equalsIgnoreCase(from))) || (until != null && !"".equalsIgnoreCase(until))
                    || (minprice != null && !"".equalsIgnoreCase(minprice)) || (maxprice != null && !"".equalsIgnoreCase(maxprice)) ||
                    (minprod != null && !"".equalsIgnoreCase(minprod)) || (maxprod != null && !"".equalsIgnoreCase(maxprod))) && !(store_id != null && !"".equalsIgnoreCase(store_id))){
                query = query.concat("WHERE Store_ID = 1");
            }
            if (store_id != null && !"".equalsIgnoreCase(store_id)) {
                query = query.concat("WHERE Store_ID = " + store_id);
            }
            if (payment != null && !"".equalsIgnoreCase(payment)) {
                query = query.concat(" and payment_method = \"" + payment + "\"");
            }
            if (from != null && !"".equalsIgnoreCase(from)) {
                query = query.concat(" and Transaction_Date > \"" + from + "\"");
            }
            if (until != null && !"".equalsIgnoreCase(until)) {
                query = query.concat(" and Transaction_Date < \"" + until + "\"");
            }
            if (minprice != null && !"".equalsIgnoreCase(minprice)) {
                query = query.concat(" and Total_Price > " + minprice);
            }
            if (maxprice != null && !"".equalsIgnoreCase(maxprice)) {
                query = query.concat(" and Total_Price < " + maxprice);
            }
            if (minprod != null && !"".equalsIgnoreCase(minprod)) {
                query = query.concat(" and Number_of_Products > " + minprod);
            }
            if (maxprod != null && !"".equalsIgnoreCase(maxprod)) {
                query = query.concat(" and Number_of_Products < " + maxprod);
            }
            pageContext.setAttribute("query", query);
        %>
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "result" sql="${query}"/> 
        <table class="transactions"> 
            <tr>
                <th>Store ID</th>
                <th>Transaction ID</th>
                <th>Customer ID</th>
                <th>Payment <br> Method</th>
                <th>Number of Products</th>
                <th>Total Price</th>
                <th>Points Worth</th>
                <th>Transaction Date</th>
                <th>Transaction Time</th>
            </tr>
            <c:forEach var = "row" items = "${result.rows}" >
                <tr>
                    <td><c:out value = "${row.Store_ID}"/></td>
                    <td><c:out value = "${row.Transaction_ID}" /></td>
                    <td><c:out value = "${row.Customer_ID}"/></td>
                    <td><c:out value = "${row.Payment_Method}"/></td>
                    <td><c:out value = "${row.Number_of_Products}"/></td>
                    <td><c:out value = "${row.Total_Price}"/></td>
                    <td><c:out value = "${row.Points_Worth}"/></td>
                    <td><c:out value = "${row.Transaction_Date}"/></td>
                    <td><c:out value = "${row.Transaction_Time}"/></td>
                </tr>
            </c:forEach>
        </table>        
    </header>
  </body>
</html>
