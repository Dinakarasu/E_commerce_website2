<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website \ Enter the OTP</title>
    <link rel="stylesheet" href="css/style1.css">
</head>
<body>
    <div id="container">
        <div class="form-wrap">
            <h1>Enter OTP</h1>
            <p> OTP send to your email address.</p>
            
            <c:if test="${not empty failedMsg }">
               <p class="text-center text-danger">${failedMsg}</p>
               <c:remove var="failedMsg" scope="session" />            
            </c:if>
            
            <form action="ValidateOtp" method="post">
                <div class="form-group">
                    <label for="otp">Enter the OTP</label>
                    <input type="otp" name="otp" id="otp" required title="Enter the OTP"/>
                </div>
                
                <button type="submit" class="btn">Submit</button>
                <a href=forgetpassword.jsp>Resent Otp</a>                
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