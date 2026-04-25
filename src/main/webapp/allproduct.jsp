<%@page import="java.util.*"%>
<%@page import="com.website.pojo.*" %>
<%@page import="com.website.seller.repository.*" %>

<%@page import="java.text.DecimalFormat"%>
<%@page import="com.website.jdbc.JdbcConnection" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<%
Selleruser auth1 = (Selleruser) request.getSession().getAttribute("auth1");
if (auth1 != null) {
	 request.setAttribute("person", auth1);
	} else {
		response.sendRedirect("sellerlogin.jsp");
	}
%>
<%System.out.println("all product Login by -- "+auth1); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website | All Products</title>
    <%@include file="includes/header.jsp"%>
        <link rel="stylesheet" href="css/style3.css">
</head>
<body>

    <div class="container" >            
            <%@include file="includes/navbar2.jsp"%>
            <br>
  <div class="small-container">
<br>
 <h1>All Products</h1>
    <div class="row1 row-2">
    <!-- message on screen -->
            <c:if test="${not empty successMsg }">
               <p class="text-center text-safer">${successMsg}</p>
               <c:remove var="successMsg" scope="session" />            
            </c:if>
            <c:if test="${not empty failedMsg }">
               <p class="text-center text-danger">${failedMsg}</p>
               <c:remove var="failedMsg" scope="session" />            
            </c:if>

            <table>            
					<th scope="col">id</th>
					<th scope="col">Image</th>
					<th scope="col">Product Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">status</th>
					<th scope="col">Product Added Date and time</th>
					<th scope="col">Edit</th>
       			<%
       			SellerProductRepository pr = new SellerProductRepository(JdbcConnection.dbGetconnection());
       			List<ProductDetails> sellerproducts = pr.getAllproduct();
				for (ProductDetails p : sellerproducts) {
			%>	
			<tr>
					<td><%=p.getId()%></td>					
					<td><img src="product_images/<%=p.getImage()%>" style="width:50px; height:50px"></td>
					<td><%=p.getName()%></td>
					<td><%=p.getCategory()%></td>
					<td><%=p.getPrice()%></td>
					<td><%=p.getStatus()%></td>
					<td><%=p.getDate()%></td>
					<td>
					<a href="edit_product.jsp?id=<%=p.getId()%>" class="btn1 btn-primary btn-e">Edit</a>
					<a href="" class="btn1 btn-primary btn-sm">Delete</a>
					</td>
			 <%
			}
			%>
				</tr>

		</table>
		</div>
		<br>
</div>
    </div>
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