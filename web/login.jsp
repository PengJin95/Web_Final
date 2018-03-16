<%-- 
    Document   : login
    Created on : 2017-11-7, 12:52:31
    Author     : Think
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign in</title>
        <link href="login.css" rel="stylesheet">
        <link href="navbar.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600" rel="stylesheet">
        <link href="https://use.fontawesome.com/releases/v5.0.1/css/all.css" rel="stylesheet">

    </head>

    <body>
        <%

            //If already logged in, jump to home page
            if (session.getAttribute("uid") != null) {
                response.sendRedirect("index.jsp");
                return;
            }

        %>

        <div class="nav">
            <ul class="navbar">
                <li>
                    <a href="#" class="brand">iMovie</a>
                </li>
                <li>
                    <a href="index.jsp" class="nav-btn-left">Home</a>
                </li>
                <li>
                    <a href="#" id="recommend_active" class="nav-btn-left">Recommendation</a>
                    <p id="recommend_inactive" class="nav-btn-left">Recommendation
                        <span class="tooltip">please log in</span>
                    </p>
                </li>
                <li id="login-btn">
                    <a href="login.jsp" class="nav-btn">Log in</a>
                </li>
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

        <div class="card">
            <img src="./image/login_icon.png" id="login_icon" alt="login icon">
            <form>
                <input type="hidden" name="login">
                <input type="text" class="input" id="uname" name="username" placeholder="Username">
                <br>
                <br>
                <input type="password" class="input" id="pwd" name="password" placeholder="Password">
                <br>
                <br>
                <button class="button" type="button" id="btn" disabled="true">
                    Sign in
                </button>
            </form>
            <p class="message" id="message"></p>
            <a href="register.jsp" alt="create an account" id="register">Create an account</a>
        </div>

        <script>
            document.getElementById("search-bar").onfocus = function () {
                document.getElementById("search-btn").style.backgroundImage = "url('./image/search_active.png')";
            };
            document.getElementById("search-bar").onblur = function () {
                document.getElementById("search-btn").style.backgroundImage = "url('./image/search.png')";
            };

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
            var uname = document.getElementById("uname");
            var pwd = document.getElementById("pwd");
            var btn = document.getElementById("btn");
            var message = document.getElementById("message");

            document.onready = function () {
                if (uname.value != "" && pwd.value != "")
                    btn.disabled = false;
                else
                    btn.disabled = true;
            }

            document.onkeyup = function () {
                if (uname.value != "" && pwd.value != "")
                    btn.disabled = false;
                else
                    btn.disabled = true;
            };

            pwd.onkeydown = function (event) {
                if (uname.value != "" && pwd.value != "" && event.keyCode == 13) {
                    message.innerText = "";
                    btn.disabled = true;
                    btn.innerText = "Processing..."
                    setTimeout(authen_ajax, 500);
                }
            };

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
                        if (result == "0" || result == "2") {
                            btn.innerHTML = '<i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Succeeded!';
                            btn.disabled = false;
                            setTimeout(function () {
                                if (result == "0") {
                                    window.location.href = "index.jsp";
                                } else {
                                    window.location.href="recommendbase.jsp";
                                }
                            }, 500);
                        } else {
                            message.innerHTML = "Please enter a correct username and password.";
                            btn.innerText = "Sign in";
                            btn.disabled = false;
                        }
                    }
                };
                xhttp.open("POST", "Authentication", true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send("login=true&username=" + uname.value + "&password=" + pwd.value);
            }
        </script>
    </body>

</html>