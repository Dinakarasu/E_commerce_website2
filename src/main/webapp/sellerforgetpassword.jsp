<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %><%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Website \ Seller Forget-password</title>
<link rel="stylesheet" href="css/style1.css">
</head>
<body>
    <div id="container">
        <div class="form-wrap">
            <h1>Seller</h1>
            <h1>Forget password</h1>
            <p> It's take only few minutes</p>
            <div class="dk">
            <p>Step:1 Enter the correct email address</p>
            <p>Step:2 After you get a OTP on your email</p>
            <p>Step:3 Enter OTP as well as set new password</p>
            </div>
            <!-- message on screen -->
            <c:if test="${not empty failedMsg }">
               <p class="text-center text-danger">${failedMsg}</p>
               <c:remove var="failedMsg" scope="session" />            
            </c:if>
            <form action="sellerForgetPassword" method="post">
                <div class="form-group">
                    <label for="email">Enter the Email</label>
                    <input type="email" name="email" id="email" />
                </div>
                <br>
                <button type="submit" class="btn">Get the OTP</button>
                <a href="sellerlogin">back to login</a>
                
                <p class="bottom-text">
                </p>
            </div>
        </form>
    </div>
    <br>
    <br>
    <br>
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
    <br>
</div>
</body>
</html>