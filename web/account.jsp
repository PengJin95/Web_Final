<%-- 
Document   : account
Created on : 2017-12-10, 20:40:59
Author     : Think
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account</title>
        <link href="navbar.css" rel="stylesheet">
        <link href="footer.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600" rel="stylesheet">
        <link href="https://use.fontawesome.com/releases/v5.0.1/css/all.css" rel="stylesheet">
        <style>
            html,
            body {
                margin: 0;
                width: 100%;
                height: 100%;
                font-family: 'Raleway', sans-serif;
                text-align: center;
                background-image: url("http://subtlepatterns.com/patterns/scribble_light.png");
            }

            .card {
                width: 90%;
                margin: auto;
                height: 100%;
                border-radius: 2px;
                text-align: center;
                background-color: white;
                box-shadow: 0 3px 5px -1px rgba(0, 0, 0, .2), 0 6px 10px 0 rgba(0, 0, 0, .14), 0 1px 18px 0 rgba(0, 0, 0, .12);
            }

            #avatar {
                position: relative;
                top: 50px;
                left: -35.8%;
                border: 5px white;
                border-radius: 50%;
                width: 10%;
                box-shadow: 0 3px 5px -1px rgba(0, 0, 0, .2), 0 6px 10px 0 rgba(0, 0, 0, .14), 0 1px 18px 0 rgba(0, 0, 0, .12);
            }

            .tab {
                width: 20%;
                height: 100%;
                float: left;
                box-shadow: 4px 0px 5px -1px rgba(0, 0, 0, .2), 0 6px 10px 0 rgba(0, 0, 0, .14), 0 1px 18px 0 rgba(0, 0, 0, .12);
            }

            .tabcontent {
                width: 80%;
                height: 100%;
                float: right;
                overflow: auto;
            }

            .username {
                position: absolute;
                left: 21%;
                top: 18%;
                color: grey;
                font-size: 36px;
                font-weight: 400;
            }

            .blank {
                width: 100%;
                height: 14%;
            }

            .tablink {
                width: 100%;
                height: 15%;
                color: grey;
                -webkit-transition: background-color 0.2s;
                transition: background-color 0.2s;
                cursor: pointer;
            }

            .tablink-active {
                color: #5AAFA0;
                font-weight: 500;
            }

            .tablink:hover {
                background-color: #5AAFA0;
                color: white;
            }

            .tablink p {
                position: relative;
                top: 40%;
            }

            .input-wrapper {
                background-color: rgba(0, 0, 0, 0.03);
                padding: .75rem 1.25rem;
                border-radius: 3px;
            }

            .input-wrapper input {
                display: block;
            }

            .input-half {
                display: inline-block;
                width: 49%;
            }

            .input-half p,
            .input-full p {
                text-align: initial;
            }

            .input-half input,
            .input-full input {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                outline: none;
                width: 90%;
            }

            .input-full  {
                width: 100%;
                padding-left: 7px;
            }
            .input-full input {
                width: 93.5%;
            }

            .wrapper1 {
                height: 30%;
                width: 80%;
                margin: auto;
            }

            .wrapper2 {
                height: 18%;
                width: 80%;
                margin: auto;
            }

            .tabcontent h3 {
                text-align: initial;
                padding-left: 10%;
            }

            .btn-active {
                border: none;
                border-radius: 2px;
                width: 10%;
                padding: 6px;
                font-size: 16px;
                position: relative;
                right: -29.5%;
                height: 50px;
                top: 20px;
                color: white;
                background-color:#5AAFA0;
                cursor: pointer;
                -webkit-transition: background-color 0.3s;
                transition: background-color 0.3s;
            }

            .btn-active:hover {
                background-color:#3F8376;
            }

            .btn-active:disabled {
                background-color: #c3c3c3;
                cursor: default;
            }

            .message {
                display: inline;
                position: relative;
                left: -25%;
                color: red;
                visibility: hidden;
            }
            .checked {
                color: yellow;
            }
            table {
                border-collapse: collapse;
                border-spacing: 0;
                width: 85%;
                border: 1px solid #ddd;
                margin: auto;
            }
            th, td {
                text-align: left;
                padding: 16px;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2
            }
        </style>
    </head>

    <body>

                <div class="nav">
            <ul class="navbar">
                <li>
                    <a href="index.jsp" class="brand">iMovie</a>
                </li>
                <li>
                    <a href="index.jsp" class="nav-btn-left">Home</a>
                </li>
                <li>
                    <a href="recommendation.jsp" id="recommend_active" class="nav-btn-left">Recommendation</a>
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
                        <a href="account.jsp?page=setting" class="drop-btn">My profile</a>
                        <a href="account.jsp?page=setting" class="drop-btn">Rating history</a>
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
        <div class="space-nav"></div>

        <h1 class="username"><%=session.getAttribute("uname")%></h1>
        <img id="avatar" src="./image/avatar.png">
        <div class="card">
            <div class="tab">
                <div class="blank"></div>
                <div class="tablink" id="tab1">
                    <p><i class="fa fa-angle-right" aria-hidden="true"></i>&nbsp;Account Setting
                    <p>
                </div>
                <div class="tablink" id="tab2">
                    <p><i class="fa fa-angle-right" aria-hidden="true"></i>&nbsp;Rating History
                    <p>
                </div>
            </div>
            <div class="tabcontent" id="content1">
                <br><br>
                <h3><i class="fa fa-lock" aria-hidden="true"></i>Personal Details</h3>
                <div class="input-wrapper wrapper1">
                    <div class="input-half">
                        <p>First Name</p>
                        <input type="text" id="fname" />
                    </div>
                    <div class="input-half">
                        <p>Last Name</p>
                        <input type="text" id="lname" />
                    </div>
                    <div class="input-full">
                        <p>Email Address</p>
                        <input type="text" id="email" />
                    </div>
                </div>
                <p class="message" id="email_invalid">Invalid Email address.</p>
                <button disabled class="btn-active" id="btn1">Submit</button>
                <br><br>
                <h3><i class="fa fa-lock" aria-hidden="true"></i>Password Change</h3>
                <div class="input-wrapper wrapper2">
                    <div class="input-half">
                        <p>Password</p>
                        <input type="password" id="pwd" />
                    </div>
                    <div class="input-half">
                        <p>Confirm Password</p>
                        <input type="password" id="pwdr" />
                    </div>

                </div>
                <p class="message" id="pwd_invalid">Passwords not match</p>
                <button disabled class="btn-active" id="btn2">Submit</button>
            </div>
            <div class="tabcontent" id="content2">
                <br><br>
                <h3>Rating & Comment </h3>
                <br>
                <table id="history">
                    <tr>
                        <th>Movie Name</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th>Comment Date</th>
                    </tr>
                    <tbody id="table-body">
                        
                    </tbody>                    
                    
                </table>
                <h3 style="display: none" id="nohistory">No History Found. Let's find some movies</h3>
            </div>
        </div>

        <br><br><br><br><br><br>
        <div class="footer">

            <div id="look">
                <div class="section section-img">
                    <h3>Powered by</h3>
                    <img src="./image/tmdb.png">
                    <img src="./image/pixabay.png">
                    <img src="./image/twitflicks.png">
                </div>
                <div class="section">
                    <h3>Support</h3>
                    <a href="#">FAQs</a>
                    <a href="#">Contact Us</a>
                    <a href="#">User Service</a>
                    <a href="#">Help</a>
                </div>
                <div class="section">
                    <h3>Follow Us</h3>
                    <a href="#">Facebook</a>
                    <a href="#">Twitter</a>
                    <a href="#">Blog</a>
                    <a href="#">Github</a>
                    <a href="#">Forums</a>
                    <a href="#">Google+</a>
                </div>
                <div class="section">
                    <h3>About Us</h3>
                    <a href="#">About Project</a>
                    <a href="#">Testimonials</a>
                    <a href="#">The Team</a>
                </div>
                <div class="section">
                    <h3>Legal</h3>
                    <a href="#">Term of Use</a>
                    <a href="#">Privacy Policy</a>
                </div>
            </div>

        </div>
        <script>


            function get_info_ajax() {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        xmlDoc = this.responseXML;
                        var fname = xmlDoc.getElementsByTagName("fname")[0].childNodes[0].nodeValue;
                        var lname = xmlDoc.getElementsByTagName("lname")[0].childNodes[0].nodeValue;
                        var email = xmlDoc.getElementsByTagName("email")[0].childNodes[0].nodeValue;
                        document.getElementById("fname").value = fname;
                        document.getElementById("lname").value = lname;
                        document.getElementById("email").value = email;
                        document.getElementById("btn1").disabled = false;
                        get_history_ajax();

                    }
                };
                xhttp.open("GET", "Authentication?prepare=true", true);
                xhttp.send();
            }

            function get_history_ajax() {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        xmlDoc = this.responseXML;
                        var len = xmlDoc.getElementsByTagName("movie").length;
                        if (len == 0) {
                            document.getElementById("history").style.display = "none";
                            document.getElementById("nohistory").style.display = "block";
                        } else {
                            var name = xmlDoc.getElementsByTagName("name");
                            var rating = xmlDoc.getElementsByTagName("rating");
                            var date = xmlDoc.getElementsByTagName("date");
                            var comment = xmlDoc.getElementsByTagName("comment");
                            for (var i = 0; i < len; i++) {
                                var temp = `<tr><td>` + name[i].childNodes[0].nodeValue + `</td><td>`;
                                var star = "";
                                for (var j = 1; j < 6; j++) {
                                    if (j <= Number(rating[i].childNodes[0].nodeValue) / 2) {
                                        star += '<span class="fa fa-star checked"></span>';
                                    } else {
                                        star += '<span class="fa fa-star"></span>'
                                    }
                                }
                                star += '</td>';
                                temp += star;
                                temp += `<td>` + comment[i].childNodes[0].nodeValue + `</td><td>` + date[i].childNodes[0].nodeValue + `</td></tr>`;
                                document.getElementById("table-body").innerHTML += temp;
                            }
                        }
                    }
                };
                xhttp.open("GET", "History", true);
                xhttp.send();
            }

            document.getElementById("btn1").onclick = function () {
                document.getElementById("btn1").disabled = true;
                document.getElementById("btn1").innerText = "Processing..."
                setTimeout(update_info_ajax, 500);
            };

            document.getElementById("btn2").onclick = function () {
                document.getElementById("btn2").disabled = true;
                document.getElementById("btn2").innerText = "Processing..."
                setTimeout(update_pwd_ajax, 500);
            };

            function update_info_ajax() {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        xmlDoc = this.responseXML;
                        var result = xmlDoc.getElementsByTagName("result")[0].childNodes[0].nodeValue;
                        var btn = document.getElementById("btn1");
                        if (result == "0") {
                            btn.innerHTML = '<i class="fa fa-check" aria-hidden="true"></i><br>Succeeded!';
                            btn.disabled = false;
                            setTimeout(function () {
                                btn.innerText = "Submit";
                            }, 1000);
                        }
                    }
                };
                xhttp.open("POST", "Authentication", true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send("update=true&fname=" + document.getElementById("fname").value + "&lname=" + document.getElementById("lname").value
                        + "&email=" + document.getElementById("email").value);
            }

            function update_pwd_ajax() {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        xmlDoc = this.responseXML;
                        var result = xmlDoc.getElementsByTagName("result")[0].childNodes[0].nodeValue;
                        var btn = document.getElementById("btn2");
                        if (result == "0") {
                            btn.innerHTML = '<i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Succeeded!';
                            btn.disabled = false;
                            setTimeout(function () {
                                btn.innerText = "Submit";
                            }, 500);
                        }
                    }
                };
                xhttp.open("POST", "Authentication", true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send("update=true&pwd=" + document.getElementById("pwd").value);
            }


            var content1 = document.getElementById("content1");
            var content2 = document.getElementById("content2");
            var tab1 = document.getElementById("tab1");
            var tab2 = document.getElementById("tab2");

            window.onload = function () {
                if (getRequestParameter("page") == "setting") {
                    tab1.click();
                } else {
                    tab2.click();
                }
                get_info_ajax();
            };

            function getRequestParameter(paras) {
                var url = location.href;
                var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
                var paraObj = {}
                for (i = 0; j = paraString[i]; i++) {
                    paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
                }
                var returnValue = paraObj[paras.toLowerCase()];
                if (typeof (returnValue) == "undefined") {
                    return "";
                } else {
                    return returnValue;
                }
            }

            function hasClass(ele, cls) {
                return ele.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));
            }

            function addClass(ele, cls) {
                if (!this.hasClass(ele, cls))
                    ele.className += " " + cls;
            }

            function removeClass(ele, cls) {
                if (hasClass(ele, cls)) {
                    var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');
                    ele.className = ele.className.replace(reg, ' ');
                }
            }

            tab1.onclick = function () {
                addClass(tab1, "tablink-active");
                removeClass(tab2, "tablink-active");
                content1.style.display = "block";
                content2.style.display = "none";
            };
            tab2.onclick = function () {
                addClass(tab2, "tablink-active");
                removeClass(tab1, "tablink-active");
                content2.style.display = "block";
                content1.style.display = "none";
            };
        </script>
        <script>
            var pattern = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            var fname = document.getElementById("fname");
            var lname = document.getElementById("lname");
            var email = document.getElementById("email");
            var btn1 = document.getElementById("btn1");
            var btn2 = document.getElementById("btn2");

            var email_flag = false;
            document.onkeyup = function () {
                if (pattern.test(email.value) == true && fname.value != "" && lname.value != "") {
                    btn1.disabled = false;
                } else {
                    btn1.disabled = true;
                }
                if (pwd.value != "" && pwdr.value == pwd.value) {
                    btn2.disabled = false;
                } else {
                    btn2.disabled = true;
                }
            }

            pwdr.onkeyup = function () {
                pwd_flag = pwd.value == pwdr.value;
                if (pwdr.value == "" || pwd_flag == true)
                    document.getElementById("pwd_invalid").style.visibility = "hidden";
                else
                    document.getElementById("pwd_invalid").style.visibility = "visible";
            }

            email.onkeyup = function () {
                if (email.value == "" || (email_flag = pattern.test(email.value)) == true)
                    document.getElementById("email_invalid").style.visibility = "hidden";
                else
                    document.getElementById("email_invalid").style.visibility = "visible";
            }

        </script>
        <script>
            document.getElementById("search-bar").onfocus = function () {
                document.getElementById("search-btn").style.backgroundImage = "url('./image/search_active.png')";
            }
            document.getElementById("search-bar").onblur = function () {
                document.getElementById("search-btn").style.backgroundImage = "url('./image/search.png')";
            }
            if (<%=session.getAttribute("uid") != null%>) {
                document.getElementById("recommend_active").style.display = "initial";
                document.getElementById("recommend_inactive").style.display = "none";
                document.getElementById("dropdown").style.display = "initial";
                document.getElementById("login-btn").style.display = "none";
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

    </body>

</html>