<%@page import="java.util.*"%>
<%@page import="com.website.pojo.*" %>
<%@page import="com.website.buyer.repository.*" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.website.jdbc.JdbcConnection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
DecimalFormat dcf = new DecimalFormat("#.##");
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

// Group orders by date/time
LinkedHashMap<String, List<Order>> groupedOrders = new LinkedHashMap<>();
if (orders != null) {
    for (Order o : orders) {
        String key = o.getDate().toString();
        if (!groupedOrders.containsKey(key)) {
            groupedOrders.put(key, new ArrayList<>());
        }
        groupedOrders.get(key).add(o);
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website | orders</title>
    <%@include file="includes/header.jsp"%>
    <link rel="stylesheet" href="css/style3.css">
<style>
.order-group {
    border: 1px solid #ddd;
    border-radius: 8px;
    margin-bottom: 20px;
    overflow: hidden;
}
.order-group-header {
    background-color: #8b0000;
    color: white;
    padding: 10px 15px;
    font-weight: bold;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.order-group table {
    width: 100%;
    border-collapse: collapse;
}
.order-group table tr {
    border-bottom: 1px solid #eee;
}
.order-group table td {
    padding: 10px 15px;
    text-align: center;
}
.order-total {
    background-color: #f9f9f9;
    padding: 10px 15px;
    text-align: right;
    font-weight: bold;
    border-top: 2px solid #ddd;
}
.order-number {
    background-color: #f0f0f0;
    padding: 5px 10px;
    border-radius: 4px;
    font-size: 12px;
    color: #555;
}
</style>
</head>
<body>
<div class="container">
    <%@include file="includes/navbar.jsp"%>
    <div class="small-container">
    <br>
    <h1>ORDERS</h1>

    <%
    int orderNum = 1;
    for (Map.Entry<String, List<Order>> entry : groupedOrders.entrySet()) {
        String date = entry.getKey();
        List<Order> groupItems = entry.getValue();

        // Calculate total
        double total = 0;
        for (Order o : groupItems) {
            total += o.getPrice();
        }
    %>

    <div class="order-group">
        <div class="order-group-header">
            <span>&#128197; Order #<%=orderNum++%> &nbsp;&nbsp; <%=date%></span>
            <span class="order-number"><%=groupItems.size()%> item(s)</span>
        </div>

        <table>
            <tr style="background-color:#f5f5f5;">
                <th style="padding:10px;">Product Image</th>
                <th style="padding:10px;">Product Name</th>
                <th style="padding:10px;">Category</th>
                <th style="padding:10px;">Quantity</th>
                <th style="padding:10px;">Price</th>
                <th style="padding:10px;">Cancel</th>
            </tr>
            <%
            for (Order o : groupItems) {
            %>
            <tr>
                <td><img src="images/<%=o.getImage()%>"
                    style="width:60px; height:60px; object-fit:cover;"></td>
                <td><%=o.getName()%></td>
                <td><%=o.getCategory()%></td>
                <td><%=o.getQuantity()%></td>
                <td>&#8377;<%=dcf.format(o.getPrice())%></td>
                <td><a class="btn1 btn-sm btn-danger"
                    href="cancel-order?id=<%=o.getOrderId()%>"
                    style="background-color:#8b0000; color:white;
                    padding:5px 10px; border-radius:4px;
                    text-decoration:none;">cancel</a></td>
            </tr>
            <%
            }
            %>
        </table>

        <div class="order-total">
            Order Total: &#8377;<%=dcf.format(total)%>
        </div>
    </div>

    <%
    }
    %>

    <br><br><br>
    </div>
</div>
<br><br><br>
<%@include file="includes/footer.jsp"%>
<script src="js/script.js"></script>
</body>
</html>