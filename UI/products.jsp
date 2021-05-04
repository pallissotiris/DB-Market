<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*,java.net.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>DB Market | Products</title>
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
      <% 
          String param = request.getQueryString();
          if ((param.contains("none")) && (!param.contains("ours"))){
      %>
      
      <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "result">
          SELECT * FROM product ORDER BY category_name;
      </sql:query>
      
        <%
            }
            else if (!param.contains("ours")){
            String sql = "SELECT * FROM product WHERE category_name =  ? ORDER BY category_name;";
            pageContext.setAttribute("sql", sql);
        %>
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "result" sql="${sql}">
            <sql:param value="${param.category_name}" />
        </sql:query>
        <%
            }
            else{
        %>
            <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "result">
                SELECT * FROM product WHERE store_label = true ORDER BY category_name;
            </sql:query>
        <%    }

        %>
        <table class="all-center">
            <tr>
                <th>Name</th>
                <th>Our product</th>
                <th>Barcode</th>
                <th>Category</th>
            </tr>
            <c:forEach var = "row" items = "${result.rows}" >
                <tr>
                    <td><c:out value = "${row.product_name}"/></td>
                    <td><c:choose>
                            <c:when test = "${row.store_label == 'true'}">Yes</c:when>
                            <c:when test = "${row.store_label == 'false'}">No</c:when>
                        </c:choose>
                    </td>
                    <td><c:out value = "${row.barcode}" /></td>
                    <td><c:out value = "${row.category_name}"/></td>             
                </tr>
            </c:forEach>
        </table>        
    </header>
  </body>
</html>