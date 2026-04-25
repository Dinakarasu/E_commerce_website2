<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %><%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website \ seller New account register</title>
    <link rel="icon" href="img/sun.jpg">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div id="container">
        <div class="form-wrap">
            <h1>Create</h1>
            <h1>Seller Account</h1>
            <p>It's free and only takes a minute</p>
            
            <!-- message on screen -->
            <c:if test="${not empty successMsg }">
               <p class="text-center text-safer">${successMsg}</p>
               <c:remove var="successMsg" scope="session" />            
            </c:if>
            <c:if test="${not empty failedMsg }">
               <p class="text-center text-danger">${failedMsg}</p>
               <c:remove var="failedMsg" scope="session" />            
            </c:if>
            
            <form action="sellerregister" method="post">
                <div class="form-group">
                    <label for="firstname">First Name</label>
                    <input type="text" name="firstname" id="firstname"/>
                </div>
                <div class="form-group">
                    <label for="lastname">Last Name</label>
                    <input type="text" name="lastname" id="lastname"/>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" name="email" id="email"/>
                </div>
                <div class="form-group">
                    <label for="contact">Contact</label>
                    <input type="number" name="contact" id="contact"/>
                </div>
                <div class="form-group">
                    <label for="password1">Password</label>
                    <input type="password" name="password" id="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                    required title=" use 8 character minimum,1-special character(!@#$%^&*()),1-Capital letter(A-Z),1-Number(0-9)"/>
                </div>
                <div class="form-group">
                    <label for="password2">Confirm Password</label>
                    <input type="password" name="password2" id="password2" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                    required title="Repeat same password"/>
                </div>
                <div> <p class="bottom-text">
                <input type="checkbox" name="check">
                    By Clicking the sign Up button, you agree to our
                    <a href="#">Terms & conitions</a> and
                    <a href="#">Privacy Policy</a></label>  </p>
                </div>
                <button type="submit" class="btn">Sign Up</button>
            </div>
        </form>
        <div>
            <footer>
                <p>Already have an account?  <a class="p" href="sellerlogin">Seller Login here</a></p>
            </footer>
        </div>
    </div>
    <div>
        <footer>
            <p1>	&#xA9 Copyright - 2023</p1>
        </footer>
    </div>
</div>
</body>
</html>