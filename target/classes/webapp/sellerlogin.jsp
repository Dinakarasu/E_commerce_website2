<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website \ seller Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div id="container">
        <div class="form-wrap">
            <h1>seller</h1>
            <h1>Login Account</h1>
            <p>Welcome happy to see you &#128578</p>
                        <!-- message on screen -->
            <c:if test="${not empty failedMsg }">
               <p class="text-center text-danger">${failedMsg}</p>
               <c:remove var="failedMsg" scope="session" />            
            </c:if>
            <form action="sellerlogin" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="user" name="email" id="email"/>
                </div>
                <div class="form-group">
                    <label for="password1">Password</label>
                    <input type="password" name="password" id="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                    required title=" use 8 character minimum,1-special character(!@#$%^&*()),1-Capital letter(A-Z),1-Number(0-9)"/>
                </div>
                <button type="submit" class="btn">Login</button>
                <p class="bottom-text"><a class="forget" href="sellerforgetpassword.jsp">forget-password?</a></p>
            </div>
        </form>
        <div>
            <footer>
                <p>Don't have an account?  <a class="p" href="sellerregister">Create Seller Account</a></p>
                <br>
                                <a class="p" href="index.jsp">Back to Home Page</a>
            </footer>
        </div>
    </div>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div>
        <footer>
            <p1>	&#xA9 Copyright - 2023</p1>
        </footer>
    </div>
</div>
</body>
</html>