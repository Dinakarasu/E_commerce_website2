<%@page import="java.util.*"%>
<%@page import="com.website.pojo.*" %>
<%@page import="com.website.seller.repository.*" %>
<%@page import="com.website.jdbc.JdbcConnection" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %><%@page isELIgnored="false" %>


<%
Selleruser auth1 = (Selleruser) request.getSession().getAttribute("auth1");
if (auth1 != null) {
	 request.setAttribute("person", auth1);
}else{
	response.sendRedirect("sellerlogin.jsp");
}
%>
<%System.out.println("add product Login by -- "+auth1); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website | Add Product</title>
    <%@include file="includes/header.jsp"%>
        <link rel="stylesheet" href="css/style3.css">
</head>
<body>

    <div class="container" > 
                <%@include file="includes/navbar2.jsp"%>                
               
            <div class="add-container">              
        <div class="form-wrap">
        <br>
            <h1 class="add">Add Product</h1>
            <p>It's free and only takes a minute</p>
            <br>
            <!-- message on screen -->
            <c:if test="${not empty successMsg }">
               <p class="text-center text-safer">${successMsg}</p>
               <c:remove var="successMsg" scope="session" />            
            </c:if>
            <c:if test="${not empty failedMsg }">
               <p class="text-center text-danger">${failedMsg}</p>
               <c:remove var="failedMsg" scope="session" />            
            </c:if>
            <br>
            <form action="Addproduct" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="productname">Product Name</label>
                    <input type="text" name="productname" id="productname"/>
                </div>
                <div class="form-group">
                    <label for="image">Image</label>
                    <input type="file" name="image" id="image"/>
                </div>
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="text" name="price" id="price" placeholder="Rs. "/>
                </div>
                <div class="form-group">
                    <label for="category">Category</label>
                    <select class="form-group" type="text" name="category" id="category">
                     <option>--Select--</option>
                    <option>Shirt</option>
                    <option>T-shirt</option>
                    <option>Pant</option>
                    <option>Watch</option>
                    <option>Shoe</option>
                    <option>Watch Band</option>
                    <option>Socks</option>
                    <option>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="Status">Status</label>
                    <select class="form-group" type="text" name="status" id="status">
                    <option>--Select--</option>
                    <option value=active>Active</option>
                    <option value=inactive>InActive</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                     <textarea class="wrapper" spellcheck="false" name="description" id="description" placeholder=" Type the product details...." ></textarea>
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                     <textarea class="wrapper" spellcheck="false" name="address" id="address" placeholder=" Type your address...." ></textarea>
                </div>
                <div> <p class="bottom-text">
                <input type="checkbox" name="check">
                    By Clicking the Add product button, you agree to our
                    <a href="#">Terms and conditions</a> and
                    <a href="#">Privacy Policy</a>  </p>
                </div>
                <button type="submit" class="btn">Add Product</button>
            </form>
            </div>
        </div>
        <br>
        <br>
        <br>
        </div>
<!-------footer------->
<%@include file="includes/footer.jsp"%>
<!---is for toggle menu-->
<script src="js/script.js"></script>
</body>
</html>