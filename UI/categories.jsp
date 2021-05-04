<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>DB Market | Product Categories</title>
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
    </header>
      <main><section class="products-sections">
        <a href="products.jsp?category_name=none"><div class="products-boxlink-7">
          <h3>All products</h3>
        </div></a>
        <a href="products.jsp?category_name=Alcohol"><div class="products-boxlink-3">
          <h3>Alcohol</h3>
        </div></a>
        <a href="products.jsp?category_name=Fresh"><div class="products-boxlink-1">
          <h3>Fresh</h3>
        </div></a>
        <a href="products.jsp?category_name=Home"><div class="products-boxlink-5">
          <h3>Home</h3>
        </div></a>
        <a href="products.jsp?category_name=Pet"><div class="products-boxlink-6">
          <h3>Pet</h3>
        </div></a>      
        <a href="products.jsp?category_name=Refrigerated"><div class="products-boxlink-2">
          <h3>Refrigerated</h3>
        </div></a>
        <a href="products.jsp?category_name=SelfCare"><div class="products-boxlink-4">
          <h3>Self care</h3>
        </div></a>
      </section></main>
  </body>
</html>