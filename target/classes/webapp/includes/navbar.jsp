<div class="navbar">
            <div class="logo">
                <a href="index.jsp"><img src="images/log.png" width="125px"></a>
            </div>
             <div class="search" >
                <form id="productForm"  class="search-bar" style="background-color: white;">
                    <input type="text" placeholder="Search the product" name="q">
                    <button type="submit"><i class="fa fa-search"></i></button>
                </form>
                </div>      
            <nav>
                <ul id="MenuItems">
                    <li><a href="index.jsp">Home</a></li>
                    <%
				if (auth!= null) {
				%>
                    <li><a href="orders.jsp">Orders</a></li>
                    <li><a href="logout" >Logout</a></li> 
                  <%
				} else {
				%>
				   <li class="nav-item"><a class="nav-link"
					href="login.jsp">Login</a></li>
					                    <li><a href="sellerlogin.jsp">Seller Login</a></li>
					
				<%
				}
				%>          
                </ul>
            </nav>
            <a href="cart.jsp"><img src="images/cart.png" class="img" width="30px" height="30px"></a>
                        <span class="badge badge-danger">${cart_list.size() }</span>
            
            <img src="images/menu.png" class="menu-icon" onclick="menutoggle()">
        </div>