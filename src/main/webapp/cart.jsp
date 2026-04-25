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
if (auth != null) {
	 request.setAttribute("person", auth);
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductRepository pDao = new ProductRepository(JdbcConnection.dbGetconnection());
	cartProduct = pDao.getCartProducts(cart_list);
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);
}
%>
<%System.out.println("cart Login by -- "+auth); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website | Cart</title>
    <%@include file="includes/header.jsp"%>
        <link rel="stylesheet" href="css/style3.css">
</head>
<body>

    <div class="container" >
            
            <%@include file="includes/navbar.jsp"%>                
<br>
<br>
<br>
 <div class="small-container">
 <br>
 <h1>CART</h1>
    <div class="row1 row-2">
            <table>            
				<tr>
					<th scope="col">Product Image</th>
					<th scope="col">Product Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Quantity</th>
					<th scope="col">Buy Now</th>
					<th scope="col">Cancel</th>
				</tr>
				<%
				if (cart_list != null) {
					for (Cart c : cartProduct) {
				%>
				<tr>
					<td><img src="images/<%=c.getImage()%>" style="width:50px; height:50px"></td>					
					<td><%=c.getName()%></td>
					<td><%=c.getCategory()%></td>
					<td><i class="fa fa-inr"></i><%=dcf.format(c.getPrice())%></td>
					<td>
						<form action="order-now" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%=c.getId()%>"
								class="form-input">
							<div class="form-group d-flex justify-content-between">
								<a class="btn2 bnt-sm btn-decre"
									href="quantity-inc-dec?action=dec&id=<%=c.getId()%>"><i
									class="fa fa-minus-square"></i></a> <input type="text"
									name="quantity" class="form-control"
									value="<%=c.getQuantity()%>" readonly> <a
									class="btn2 btn-sm btn-incre"
									href="quantity-inc-dec?action=inc&id=<%=c.getId()%>"><i
									class="fa fa-plus-square"></i></a>
					</td>
					<td>				
							<button type="submit" class="btn1 btn-primary btn-sm">Buy</button>

							</div>
						</form>
					</td>
					<td><a href="remove-from-cart?id=<%=c.getId()%>"
						class="btn1 btn-sm btn-danger">Remove</a></td>
				</tr>
				<%
				}
				}
				%>
		</table>
		</div>
		<div class="d-flex py-3">
			<h3>Total Price: Rs. <i class="fa fa-inr"></i>${ (total>0)?dcf.format(total):0 }</h3>
			<a class="btn btn-primary" href="check-out">Check Out</a>
		</div>
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