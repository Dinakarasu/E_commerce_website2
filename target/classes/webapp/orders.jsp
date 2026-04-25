<%@page import="java.util.*"%>
<%@page import="com.website.pojo.*" %>
<%@page import="com.website.buyer.repository.*" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.website.jdbc.JdbcConnection" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
List<Order> orders = null;
if (auth != null) {
	request.setAttribute("person", auth);
	orders = new OrderRepo(JdbcConnection.dbGetconnection()).userOrder(auth.getId());
} else {
	response.sendRedirect("login.jsp");
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<%System.out.println("Login by -- "+auth); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website | orders</title>
    <%@include file="includes/header.jsp"%>
    <link rel="stylesheet" href="css/style3.css">
</head>
<body>

    <div class="container" >
            
            <%@include file="includes/navbar.jsp"%>                

 <div class="small-container">
 <br>
  <h1>ORDERS</h1>
    <div class="row1 row-2">
            <table>
				<tr>
					<th scope="col">Date | Time</th>
					<th scope="col">Product Image</th>
					<th scope="col">Product Name</th>
					<th scope="col">Category</th>
					<th scope="col">Quantity</th>
					<th scope="col">Price</th>
					<th scope="col">Cancel</th>
				</tr>
				<%
				if (orders != null) {
					for (Order o : orders) {
				%>
				<tr>
					<td><%=o.getDate()%></td>
					<td><img src="images/<%=o.getImage()%>" style="width:50px; height:50px"></td>					
					<td><%=o.getName()%></td>
					<td><%=o.getCategory()%></td>
					<td><%=o.getQuantity()%></td>
					<td><i class="fa fa-inr"></i><%=dcf.format(o.getPrice())%></td>
					<td><a class="btn1 btn-sm btn-danger"
						href="cancel-order?id=<%=o.getOrderId()%>">cancel</a></td>
				</tr>
				<%
				}
				}
				%>
		</table>
		</div>
		
	
	<br>
	<br>
	<br>
	<br>
</div>
    </div>
<br>
<br>
<br>
<!-------footer------->
<%@include file="includes/footer.jsp"%>
<!---is for toggle menu-->
<script src="js/script.js"></script>
</body>
</html>