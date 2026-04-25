<%@page import="java.util.*"%>
<%@page import="com.website.pojo.*" %>
<%@page import="com.website.seller.repository.*" %>
<%@page import="com.website.jdbc.JdbcConnection" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
Selleruser auth1 = (Selleruser) request.getSession().getAttribute("auth1");
if (auth1 != null) {
	request.setAttribute("person", auth1);
}else{
	response.sendRedirect("sellerhome.jsp");
}
%>
<%System.out.println("Seller Login by -- "+auth1); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website | Seller Home</title>
    <%@include file="includes/header.jsp"%>    
</head>
<body>
    <div class="header">
    <div class="container" form="home">
                    <%@include file="includes/navbar2.jsp"%>                
    <div class="responsive_search_container">
        <form action="product" class="search-bar2" style="background-color: white;">
            <input type="text" placeholder="Search the product" name="q">
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
        </div>
        <div class="row">
            <div class="col-2">
                <h1>Selling in online<br>Safer and faster!!!</h1>
                <p>Success isn't always about greatness. It's about
                    consistency.<br>hard work gains success. greatness
                    will come.
                </p>
                <a href="" class="btn">Explore Now <i class="fa fa-long-arrow-down"></i></a>
            </div>
            <div class="col-2">
                <img src="images/s1.jpg">
            </div>
        </div>
    </div>
</div>
<div class="small-container">
    <div class="row-pro">
    <div class="sell-pro">    
        <i class="fa fa-plus-square-o "></i><br>
        <a href="addproduct.jsp" class="pro">Add Products</a>
    </div>   
    <div class="sell-pro">
        <i class="fa fa-inbox "></i><br>        
        <a href="allproduct.jsp" class="pro">All Products</a>
    </div> 
    <div class="sell-pro">
        <i class="fa fa-archive "></i><br>    
        <a href="" class="pro">Orders</a>
    </div>  
</div>
</div>
<br>
<br>
<br>
<br>
<br>
<br>

<!-------footer------->
<%@include file="includes/footer.jsp"%>
<!---is for toggle menu-->

<script src="js/script.js"></script>
</body>
</html>
