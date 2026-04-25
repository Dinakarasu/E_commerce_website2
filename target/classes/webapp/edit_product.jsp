<%@page import="java.util.*"%>
<%@page import="com.website.pojo.*" %>
<%@page import="com.website.seller.repository.*" %>
<%@page import="com.website.jdbc.JdbcConnection" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>


<%
Selleruser auth1 = (Selleruser) request.getSession().getAttribute("auth1");
if (auth1 != null) {
	 request.setAttribute("person", auth1);
}else{
	response.sendRedirect("sellerlogin.jsp");
}
%>
<%System.out.println("Edit product Login by -- "+auth1); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website | Edit Product</title>
    <%@include file="includes/header.jsp"%>
        <link rel="stylesheet" href="css/style3.css">
</head>
<body>

    <div class="container" > 
                <%@include file="includes/navbar2.jsp"%>                
               
            <div class="add-container">              
        <div class="form-wrap">
        <br>
            <h1 class="add">Edit Product</h1>
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
            
            <%
            int id=Integer.parseInt(request.getParameter("id"));
   			SellerProductRepository pr = new SellerProductRepository(JdbcConnection.dbGetconnection());
   			ProductDetails p =pr.getproductId(id);
            %>
            
            
            <br>
            <form action="editproduct" method="post" >
                <div class="form-group">
                    <label for="productname">Product Name</label>
                    <input type="text" name="productname" id="productname" value="<%=p.getName()%>"/>
                </div>
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="text" name="price" id="price" placeholder="Rs. " value="<%=p.getPrice()%>"/>
                </div>
                <div class="form-group">
                    <label for="Status">Status</label>
                    <select class="form-group" type="text" name="status" id="status">
                    <%
                    if("active".equals(p.getStatus())){
                    %>
                    <option value=active>Active</option>                    
                    <option value=inactive>Inactive</option>
                    <%
                    }else{
                    %>
                    <option value=active>Active</option>
                    <option value=inactive>Inactive</option>
                    <%
                    }
                    %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                     <input class="wrapper" spellcheck="false" name="description" id="description" placeholder=" Type the product details...."  value="<%=p.getDescription()%>">
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                     <input class="wrapper" spellcheck="false" name="address" id="address" placeholder=" Type your address...." value="<%=p.getAddress()%>">
                </div>
                <div> <p class="bottom-text">
                <input type="checkbox" name="check">
                    By Clicking the Update button, you agree to update !
                </div>
                <button type="submit" class="btn">Update Product</button>
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