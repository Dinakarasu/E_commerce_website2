<%@page import="java.util.*"%>
<%@page import="com.website.pojo.*" %>
<%@page import="com.website.buyer.repository.*" %>
<%@page import="com.website.jdbc.JdbcConnection" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("person", auth);
}
ProductRepository pd = new ProductRepository(JdbcConnection.dbGetconnection());
List<ProductDetails> products = pd.getAllProducts();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website | home</title>
    <%@include file="includes/header.jsp"%>    
</head>
<body>
<%
String cartMsg = (String) session.getAttribute("cart_msg");
if (cartMsg != null) {
    session.removeAttribute("cart_msg");
%>
<div id="cart-toast" style="position:fixed; top:20px; right:20px;
    background:#8b0000; color:white; padding:15px 25px;
    border-radius:8px; z-index:9999; font-size:16px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);">
    <%=cartMsg%>
</div>
<script>
    setTimeout(function() {
        document.getElementById('cart-toast').style.display = 'none';
    }, 3000);
</script>
<%
}
%>
    <div class="header">
    <div class="container" form="home">
                    <%@include file="includes/navbar.jsp"%>                
    <div class="responsive_search_container">
        <form action="product" class="search-bar2" style="background-color: white;">
            <input type="text" placeholder="Search the product" name="q">
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
        </div>
        <div class="row">
            <div class="col-2">
                <h1>Shopping in online<br>Safer and faster!!!</h1>
                <p>Success isn't always about greatness. It's about
                    consistency.<br>hard work gains success. greatness
                    will come.
                </p>
                <a href="" class="btn">Explore Now &#8594</a>
            </div>
            <div class="col-2">
                <img src="images/s1.jpg">
            </div>
        </div>
    </div>
</div>
<div class="small-container">
    <div class="row row-2">
        <h2>All Products</h2>
        <select >
            <option >Default shorting</option>
            <option >Short by price</option>
            <option >Short by popularity</option>
            <option >Short by rating</option>
        </select>
    </div>
    <div class="row">
    			<%
			if (!products.isEmpty()) {
				for (ProductDetails p : products) {
			%>
        <div class="col-4">
            <img src="images/<%=p.getImage()%>">
            <h4> Product Name : <%=p.getName()%></h4>
            <h6 class="category">Category : <%=p.getCategory()%></h6>
                      <div><%=p.getStars()%></div>
                        <h4>MRP : Rs.<%=p.getPrice()%></h4>
            <a href="add-to-cart?id=<%=p.getId()%>" class="btn">Add Cart</a>
            <!-- <a href="order-now?quantity=1&id=<%=p.getId()%>'" class="btn">Buy</a>-->          </div>
        <%
			}
			}
			%>
    </div>        
</div>
<!----Brands----->
<div class="brands">
    <div class="small-container">
        <div class="row">
            <div class="col-5">
                <img src="images/logo-godrej.png" alt="">
            </div>
            <div class="col-5">
                <img src="images/logo-coca-cola.png" alt="">
            </div>
            <div class="col-5">
                <img src="images/logo-oppo.png" alt="">
            </div>
            <div class="col-5">
                <img src="images/logo-paypal.png" alt="">
            </div>
            <div class="col-5">
                <img src="images/logo-philips.png" alt="">
            </div>
        </div>
    </div>
</div>
<!-------footer------->
<%@include file="includes/footer.jsp"%>
<!---is for toggle menu-->

<script src="js/script.js"></script>
</body>
</html>
