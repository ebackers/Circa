<%-- 
    Document   : Login
    Created on : 03 22, 15, 7:35:36 PM
    Author     : Arces
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Circa - Login or Sign up </title>
        <link rel ="shortcut icon" href="img/CircaLogoIcon.ico">
        <link rel="stylesheet" type="text/css" 	media="all" href="css/Login.css" />
        <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src ="js/login.js"></script>
    </head>

    <body>
        <div id = "background">
            <img id = "backgroundImage" src="img/login/img1.jpg" alt="background-image">
        </div>

        <div id = "header">
            <div id = "headerElements">
                <img id = "circaLogo" src="img/login/CircaLogo.png" alt="Circa Logo">
                <form id = "logIn" action = "Login" method = "post">
                    <input type="text" placeholder = "email / username" name = "inputUser"/>
                    <input type="password" placeholder = "password" name = "inputPassword"/>
                    <input type="submit" id = "logInButton" value = "log-in" class = "clickableButton"/>
                    <br>
                    <%
                        HttpSession reqSession = request.getSession();
                        Boolean isCorrect = (Boolean) reqSession.getAttribute("isCorrect");

                        if (isCorrect != null) {
                            if (!isCorrect) {
                    %>
                    <font color ="white" face ="arial" size=2>Incorrect E-mail / Password! Please try again.</font>
                    <%
                            }
                        }
                    %>
                </form>
            </div>
        </div>

        <div id = "welcomeDiv">
            <header>
                <h1 id = "welcomeCirca" class = "welcomeMessage">welcome to circa.</h1>
            </header>
            <blockquote id = "welcomeQuote" class = "welcomeMessage">
                Your social planning buddy! See the beauty of socialization through the power of faster event sharing.
            </blockquote>
            <button id = "signUpButton" class = "clickableButton">Sign Up!</button>
        </div>

        <div id = "signUpDiv">
            <h1 id = "signUpCircaLabel" class = "centeredSignUp">circa</h1>
            <form id = "signUpForm" class = "centeredSignUp" action = "Signup" method = "post">
                <input type="text" name ="first_name" placeholder = "First Name" class = "signUpNameFields" required/>
                <input type="text" name ="last_name" placeholder = "Last Name" class = "signUpNameFields" required/>
                <input type="date" name ="birthday" id = "birthday" class = "signUpDateField" required/>
                <input type="email" name ="email_address" placeholder = "Email" class = "signUpOtherFields" required/>
                <input type="text" name ="username" placeholder = "Username" class = "signUpOtherFields" required/>
                <input type="password" name = "password" placeholder = "Password" class = "signUpOtherFields" required/>
                <input type="password" name = "confirmpassword" placeholder = "Confirm Password" class = "signUpOtherFields" required/>
                <input type ="submit" id = "signUpForCircaButton" class = "clickableButton" value="Sign up for Circa!"/>
            </form>
        </div>
    </body>
</html>