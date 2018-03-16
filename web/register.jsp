<%-- 
    Document   : register
    Created on : 2017-11-7, 21:06:40
    Author     : Think
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up</title>
        <link href="login.css" rel="stylesheet">
        <link href="navbar.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600" rel="stylesheet">
        <style>
            .card {
                padding-top: 40px;
                position: relative;
            }

            .half {
                width: 137px;
                margin-left: initial;
                margin-right: initial;
            }

            #fname {
                position: absolute;
                left: 39px;
            }

            #lname {
                position: absolute;
                right: 39px;
            }

            #login {
                text-decoration: none;
                color: rgb(86, 174, 247);
            }

            .message {
                margin: 0;
            }
        </style>
    </head>

    <body>
        <%

            //If already logged in, jump to home page
            if (session.getAttribute("uid") != null) {
                response.sendRedirect("index.jsp");
                return;
            }

        %>

        <!--NAVBAR!-->

        <div class="nav">
            <ul class="navbar">
                <li><a href="#" class="brand">iMovie</a></li>
                <li><a href="index.jsp" class="nav-btn-left">Home</a></li>
                <li><a href="#" id="recommend_active" class="nav-btn-left">Recommendation</a>
                    <p id="recommend_inactive" class="nav-btn-left">Recommendation<span class="tooltip">please log in</span></p>
                </li>
                <li id="login-btn"><a href="login.jsp" class="nav-btn">Log in</a></li>
                <li id="dropdown">
                    <img src="./image/avatar.png" class="avatar">
                    <div class="drop-content">
                        <a href="#" class="drop-btn">My profile</a>
                        <a href="#" class="drop-btn">Rating history</a>
                        <form action="Authentication" method="GET">
                            <input type="submit" value="Logout" class="drop-btn" id="logout">
                            <input type="hidden" name="logout">
                        </form>
                    </div>
                </li>
                <li class="search-section">
                    <form id="search-form" action="search.jsp" method="GET">
                        <input id="search-bar" name="name" type="text" placeholder="Search" onkeypress="checkInput()">
                        <input type="text" style="display:none">
                        <input id="search-btn" type="button" value="" onclick="checkForSearch()">
                    </form>
                    <span id="hintForSearch">please enter the name of movie</span>
                </li>
            </ul>
        </div>

        <!--NAVBAR!-->



        <div class="card">
            <form>
                <input type="hidden" name="register">
                <input type="text" name="first_name" class="input half" id="fname" placeholder="First Name">
                <input type="text" name="last_name" class="input half" id="lname" placeholder="Last Name">
                <br><br><br>
                <input type="text" name="username" class="input" id="uname" placeholder="Username">
                <br><br>
                <input type="text" name="email" class="input" id="email" placeholder="Email Address">
                <br><br>
                <input type="password" name="password" class="input" id="pwd" placeholder="Password">
                <br><br>
                <input type="password" name="password_re" class="input" id="pwdr" placeholder="Confirm Password">
                <br><br>
                <button class="button" type="button" id="btn" disabled="true">
                    Sign up
                </button>
            </form>
            <p class="message" id="email_invalid"></p>
            <p class="message" id="pwd_invalid"></p>
            <p class="message" id="message"></p>
            <br>
            <a href="login.jsp" alt="already have an account?" id="login">Already have an account?</a>
        </div>

        <script>
            document.getElementById("search-bar").onfocus = function () {
                document.getElementById("search-btn").style.backgroundImage = "url('./image/search_active.png')";
            }
            document.getElementById("search-bar").onblur = function () {
                document.getElementById("search-btn").style.backgroundImage = "url('./image/search.png')";

            }

            function checkForSearch() {
                var pattern = /\S+/;
                if (pattern.test(document.getElementById("search-bar").value) == false) {
                    document.getElementById("hintForSearch").style.opacity = "1";
                    window.setTimeout(function () {
                        document.getElementById("hintForSearch").style.opacity = "0";
                    }, 1000);
                } else {
                    document.getElementById("search-form").submit();
                }
            }

            function checkInput() {
                if (event.keyCode == 13) {
                    checkForSearch();
                }
            }
        </script>

        <script>
            var fname = document.getElementById("fname");
            var lname = document.getElementById("lname");
            var uname = document.getElementById("uname");
            var email = document.getElementById("email");
            var pwd = document.getElementById("pwd");
            var pwdr = document.getElementById("pwdr");
            var btn = document.getElementById("btn");
            var message = document.getElementById("message");
            var email_flag = false;
            var pwd_flag = false;
            var pattern = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            var status = 0;

            btn.onclick = function () {
                message.innerText = "";
                btn.disabled = true;
                btn.innerText = "Processing..."
                setTimeout(authen_ajax, 500);
            };

            function authen_ajax() {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        xmlDoc = this.responseXML;
                        var result = xmlDoc.getElementsByTagName("result")[0].childNodes[0].nodeValue;
                        if (result == "0") {
                            btn.innerHTML = '<i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Succeeded!';
                            btn.disabled = false;
                            setTimeout(function () {
                                window.location.href = "recommendbase.jsp";
                            }, 500);
                        } else {
                            message.innerHTML = "Username already exists.";
                            btn.innerText = "Sign up";
                            btn.disabled = false;
                        }
                    }
                };
                xhttp.open("POST", "Authentication", true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send("register=true&first_name=" + fname.value + "&last_name=" + lname.value + "&username=" + uname.value + "&email=" + email.value + "&password=" + pwd.value);
            }

            email.onkeyup = function () {
                if (email.value == "" || (email_flag = pattern.test(email.value)) == true)
                    document.getElementById("email_invalid").innerHTML = "";
                else
                    document.getElementById("email_invalid").innerHTML = "Invalid Email address.";
            }

            email.onchange = function () {
                if (email.value == "" || (email_flag = pattern.test(email.value)) == true)
                    document.getElementById("email_invalid").innerHTML = "";
                else
                    document.getElementById("email_invalid").innerHTML = "Invalid Email address.";
            }

            pwdr.onkeyup = function () {
                pwd_flag = pwd.value == pwdr.value;
                if (pwdr.value == "" || pwd_flag == true)
                    document.getElementById("pwd_invalid").innerHTML = "";
                else
                    document.getElementById("pwd_invalid").innerHTML = "Passwords don't match.";
            }

            document.onkeyup = function () {
                message.innerHTML = "";
                if (email_flag == false || pwd_flag == false) {
                    btn.disabled = true;
                    return;
                }
                if (email.value != "" && pwd.value != "" && pwdr.value != "" && fname.value != "" && lname.value != "" && uname.value != "")
                    btn.disabled = false;
                else
                    btn.disabled = true;
            }
        </script>
    </body>

</html>