<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>DB Market | Home</title>
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
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "results">
            SELECT * FROM popular_pairs order by purchases desc limit 10;
        </sql:query>
        <table class="all-center">
            <tr ><th colspan="3">Top 10 Popular Pairs</th></tr>
            <tr>
                <th>Product 1</th>
                <th>Product 2</th>
                <th>Purchases</th>
            </tr>
            <c:forEach var = "row" items = "${results.rows}" >
                <tr>
                    <td><c:out value = "${row.first}"/></td>
                    <td><c:out value = "${row.second}"/></td>
                    <td><c:out value = "${row.purchases}"/></td>
                </tr>
            </c:forEach>
        </table>
        
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "rests">
            select c.aisle_number, c.shelf_number,
            count(*) as d from
            (select aisle_number, shelf_number from offers,
            (select barcode, store_ID from Transactions ,
            (select transaction_ID, barcode from Consists_of) as a
            where a.transaction_ID = transactions.transaction_ID) as b
            where offers.store_ID = b.store_ID and b.barcode = offers.barcode) as c
            group by aisle_number
            order by d desc
            limit 10;
        </sql:query>
        <table class="all-center">
            <tr ><th colspan="3">Top 10 Positions in Stores</th></tr>
            <tr>
                <th>Aisle Number</th>
                <th>Shelf Number</th>
                <th>Times bought from this aisle and shelf</th>
            </tr>
            <c:forEach var = "row" items = "${rests.rows}" >
                <tr>
                    <td><c:out value = "${row.aisle_number}"/></td>
                    <td><c:out value = "${row.shelf_number}"/></td>
                    <td><c:out value = "${row.d}"/></td>
                </tr>
            </c:forEach>
        </table>

        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "apot">
            SELECT category_name from category;
        </sql:query>
        <table class="all-center">
            <tr ><th colspan="2">Customers' Preference of our Products per Category</th></tr>
            <tr>
                <th>Category</th>
                <th>Percentage</th>
            </tr>
            <c:forEach var = "row" items = "${apot.rows}" >
                
                <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "apo">
                    select  
(select count(*) from 
(select p.barcode, store_label, category_name from product as p,
(select c.barcode, tr.transaction_ID from consists_of as c,
(select t.transaction_ID from transactions as t ) as tr
where tr.transaction_ID = c.transaction_ID) as cons
where p.barcode = cons.barcode and category_name = "${row.category_name}" and store_label = "true") as fin
) / (select count(*) from 
(select p.barcode, store_label, category_name from product as p,
(select c.barcode, tr.transaction_ID from consists_of as c,
(select t.transaction_ID from transactions as t ) as tr
where tr.transaction_ID = c.transaction_ID) as cons
where p.barcode = cons.barcode and category_name = "${row.category_name}") as fin
) as perc;
                </sql:query>

                <tr>
                    <td><c:out value = "${row.category_name}"/></td>
                    <c:forEach var = "ro" items = "${apo.rows}">
                    <td><c:out value = "${ro.perc}"/></td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>

        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "apotelesma">
            select sum(total_price) as s, hour(transaction_time) as h from transactions group by h order by s desc limit 10;
        </sql:query>
        <table class="all-center">
            <tr ><th colspan="2">Top 10 Popular Hours</th></tr>
            <tr>
                <th>Hour</th>
                <th>Total Income this Hour</th>
            </tr>
            <c:forEach var = "row" items = "${apotelesma.rows}" >
                <tr>
                    <td><c:out value = "${row.h}:00"/></td>
                    <td><c:out value = "${row.s}"/></td>
                </tr>
            </c:forEach>
        </table>
            
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "ap">
            select customer_id, first_name, last_name, total_points from Customer order by total_points desc limit 3;
        </sql:query>
        <table class="all-center">
            <tr ><th colspan="4">Top 3 Customers in terms of Points</th></tr>
            <tr>
                <th>Customer ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Points</th>
            </tr>
            <c:forEach var = "row" items = "${ap.rows}" >
                <tr>
                    <td><c:out value = "${row.customer_id}"/></td>
                    <td><c:out value = "${row.first_name}"/></td>
                    <td><c:out value = "${row.last_name}"/></td>
                    <td><c:out value = "${row.total_points}"/></td>
                </tr>
            </c:forEach>
        </table>    
        
        <sql:query dataSource = "jdbc/ergasia_baseis_supermarketDB" var = "apotele">
            select store_ID, sum(total_price) as s from transactions group by store_id order by s desc limit 3;
        </sql:query>
        <table class="all-center">
            <tr ><th colspan="2">Stores with most overall income</th></tr>
            <tr>
                <th>Store ID</th>
                <th>Overall Income</th>
            </tr>
            <c:forEach var = "row" items = "${apotele.rows}" >
                <tr>
                    <td><c:out value = "${row.store_id}"/></td>
                    <td><c:out value = "${row.s}"/></td>
                </tr>
            </c:forEach>
        </table>      
            <br>    
    </body>
</html>
