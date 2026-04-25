<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>website | product View</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
    <div class="container" >
        <div class="navbar">
            <div class="logo">
                <a href="home"><img src="images/log.png" width="125px"></a>
            </div>
            <div class="search" >
                <form action="productview" class="search-bar" style="background-color: white;">
                    <input type="text" placeholder="Search the product" name="q">
                    <button type="submit"><i class="fa fa-search"></i></button>
                </form>
                </div>      
            <nav>
                <ul id="MenuItems">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="orders.jsp">orders</a></li>
                    <li><a href="logout">logout</a></li>
                </ul>
            </nav>
            <a href="cart.jsp"><img src="images/cart.png" width="30px" height="30px"></a>
            <img src="images/menu.png" class="menu-icon" onclick="menutoggle()">
        </div>
    </div>
 <!----------single product details----------->
<div class="small-container single-product">
    <div class="row">
        <div class="col-2">
            <img src="images/gallery-1.jpg" width="100%" id="ProductImg">
            <div class="small-img-row">
                <div class="small-img-col">
                    <img src="images/gallery-1.jpg" width="100%" class="small-img">
                </div>
                <div class="small-img-col">
                    <img src="images/gallery-2.jpg" width="100%" class="small-img">
                </div>
                <div class="small-img-col">
                    <img src="images/gallery-3.jpg" width="100%" class="small-img">
                </div>
                <div class="small-img-col">
                    <img src="images/gallery-4.jpg" width="100%" class="small-img">
                </div>
            </div>

        </div>
        <div class="col-2">
            <p>Home / T-Shirt</p>
            <h1>Red printed T-Shirt</h1>
            <h3>Rs.<i class="fa fa-inr"></i>650</h3>
            <select>
                <option>Select size</option>
                <option>XXL</option>
                <option>XL</option>
                <option>Large</option>
                <option>Medium</option>
                <option>Small</option>
            </select>
            <input type="number" value="1">
            <a href="" class="btn">Add to cart</a> <a href="" class="btn">Buy</a>
            <h3>Product Details<i class="fa fa-indent"></i></h3>
            <br>
            <p>Give your summer wardrobe a style upgrade with the HRX
                Men's Active T-Shirt. Team it with a pair of shorts for
                your morning workout or a denims for an evening out with the guys.
            </p>
        </div>
    </div>
</div>
<!--------------title------------------>
<div class="small-container">
    <div class="row row-2">
        <h2>Related Products</h2>
        <a href="product"><p>View more</p></a>
    </div>
</div>
<!---------------products-------------------->
 <div class="small-container">
    <div class="row">
        <div class="col-4">
            <img src="images/product-1.jpg">
            <h4>Red Printed T-Shirt</h4>
            <h4 class="category">category: some</h4>
            <div class="rating">
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9734</i>
            <p>Rs.<i class="fa fa-inr"></i>650.00</p>
            <a href="cart" class="btn">Add cart</a>
            <a href="" class="btn">Buy</a>
        </div>
    </div>
    <div class="col-4">
        <img src="images/product-6.jpg">
        <h4>Black Printed T-Shirt</h4>
        <h4 class="category">category: some</h4>
        <div class="rating">
            <i class="star" >&#9733</i>
            <i class="star" >&#9733</i>
            <i class="star" >&#9733</i>
            <i class="star" >&#9733</i>
            <i class="star" >&#9734</i>
            <p>Rs.<i class="fa fa-inr"></i>255.00</p>
            <a href="" class="btn">Add cart</a>
            <a href="" class="btn">Buy</a>
    </div>
</div>
        <div class="col-4">
            <img src="images/product-3.jpg">
            <h4>Grey Trousers</h4>
            <h4 class="category">category: some</h4>
            <div class="rating">
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9734</i>
                <p>Rs.<i class="fa fa-inr"></i>450.00</p>
                <a href="" class="btn">Add cart</a>
                <a href="" class="btn">Buy</a>
        </div>
    </div>
        <div class="col-4">
            <img src="images/product-4.jpg">
            <h4>Blue T-Shirt</h4>
            <h4 class="category">category: some</h4>
            <div class="rating">
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9733</i>
                <i class="star" >&#9734</i>
                <p>Rs.<i class="fa fa-inr"></i>350.00</p>
                <a href="" class="btn">Add cart</a>
                <a href="" class="btn">Buy</a>
            </div>
        </div>
    </div>
</div>

<!-------footer------->
<%@include file="includes/footer.jsp"%>
<!---is for toggle menu-->
<!---is for product gallery--->
<script src="js/script.js"></script>
</body>
</html>