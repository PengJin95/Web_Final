<%-- 
    Document   : search
    Created on : 2017-11-27, 18:40:34
    Author     : Think
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            <%=request.getParameter("name")%> - Search Result</title>
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

            a {
                text-decoration: none;
                color: #5AAFA0;
            }

            p {
                margin: 0;
            }

            #noresult {
                width: 100%;
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                background-image: url("./image/noresult.jpg");
                background-size: cover;
                display: none;
            }

            #noresult-title {
                margin: 0;
                color: white;
                font-size: 76px;
            }

            #container {
                width: 100%;
                margin: auto;
                padding-top: 50px;
                text-align: initial;
                font-size: 36px;
                color: #83898D;
            }

            #container>p {
                padding-left: 10%;
            }

            #results {
                width: 80%;
                margin: auto;
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
                align-items: flex-start;
                justify-content: flex-start;
                padding-top: 30px;
                background-color: transparent;
            }

            .poster {
                width: 20%;
                margin: 0 20px 20px 20px;
                text-align: center;
                font-size: 36px;
                padding: 10px;
                line-height: 120%;
                border-radius: 2px;
                background-color: white;
                box-shadow: 0 0 10px 4px rgba(0, 0, 0, .2);
            }

            .poster-img {
                width: 100%;
                display: block;
            }

            .poster p {
                color: rgb(138, 138, 138);
                margin-top: 10px;
                font-size: 24px;
                line-height: 110%;
            }

            .poster span {
                font-size: 16px;
            }

            #pagination {
                text-align: center;
                padding-top: 20px;
                padding-bottom: 100px;
            }

            #pagination span {
                font-size: 24px;
                padding: 10px 16px;
                -webkit-transition: background-color 0.2s;
                transition: background-color 0.2s;
                cursor: pointer;
            }

            .active,
            #pagination span:hover {
                background-color: #5AAFA0;
                color: white;
            }
        </style>
    </head>

    <body>
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


        <div id="noresult">
            <p id="noresult-title">Oops, we found no movies for your words.</p>
        </div>
        <div class="space-nav"></div>
        <div id="container">
            <p>Search Results for "
                <%=request.getParameter("name")%>"</p>
            <div id="results"></div>
            <div id="pagination" style="text-align: center"></div>
        </div>
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
            window.onload = search_ajax();

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

            function search_ajax() {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        xmlDoc = this.responseXML;
                        if (xmlDoc.getElementsByTagName("empty").length == 1) {
                            document.getElementById("container").style.display = "none";
                            document.getElementById("noresult").style.display = "flex";
                            document.getElementsByClassName("space-nav")[0].style.display = "none";
                            document.getElementsByClassName("footer")[0].style.display  = "none";
                        } else {
                            console.log("test");
                            var len = xmlDoc.getElementsByTagName("movie").length;
                            var id = xmlDoc.getElementsByTagName("id");
                            var name = xmlDoc.getElementsByTagName("name");
                            var poster = xmlDoc.getElementsByTagName("poster");
                            var date = xmlDoc.getElementsByTagName("date");
                            var result = document.getElementById("results");
                            for (var i = 0; i < len; i++) {
                                var poster_url = (poster[i].childNodes[0].nodeValue == "N/A") ? "./image/noposter.png" : poster[i].childNodes[0].nodeValue;
                                var newHtml = `
                                <a href="movie.jsp?id=` + id[i].childNodes[0].nodeValue + `" class="poster">
                                    <img class="poster-img" src="` + poster_url + `">
                                    <p>
                                        <i class="fa fa-film" aria-hidden="true"></i>&nbsp;` + name[i].childNodes[0].nodeValue + `
                                        <br><span>(` + date[i].childNodes[0].nodeValue + `)</span>
                                    </p>
                                </a>
                            `;
                                result.innerHTML += newHtml;
                            }

                            var totalpage = Number(xmlDoc.getElementsByTagName("tpage")[0].childNodes[0].nodeValue);
                            var currentpage = Number(xmlDoc.getElementsByTagName("page")[0].childNodes[0].nodeValue);
                            var page = document.getElementById("pagination");
                            for (var i = (parseInt((currentpage - 1) / 5) * 5 + 1); i < totalpage + 1 && i < (parseInt((currentpage - 1) / 5) * 5 + 6); i++) {
                                console.log("i is " + i);
                                if (currentpage != 1 && i == (parseInt((currentpage - 1) / 5) * 5 + 1)) {
                                    page.innerHTML += `
                                    <a href=search.jsp?name=` + getRequestParameter("name") + `&page=` + (currentpage - 1) + `>
                                        <span>&laquo;</span>
                                    </a>
                                `;
                                }

                                if (currentpage == i) {
                                    page.innerHTML += `
                                    <a href=search.jsp?name=` + getRequestParameter("name") + `&page=` + i + `>
                                        <span class="active">` + i + `</span>
                                    </a>
                                `;
                                } else {
                                    page.innerHTML += `
                                    <a href=search.jsp?name=` + getRequestParameter("name") + `&page=` + i + `>
                                        <span>` + i + `</span>
                                    </a>
                                `;
                                }

                                if (currentpage != totalpage && i == (parseInt((currentpage - 1) / 5) * 5 + 5)) {
                                    page.innerHTML += `
                                    <a href=search.jsp?name=` + getRequestParameter("name") + `&page=` + (currentpage + 1) + `>
                                        <span> &raquo;</span>
                                    </a>
                                `;
                                }
                            }

                        }
                    }
                };
                xhttp.open("GET", "Search?name=" + getRequestParameter("name") + "&page=" + getRequestParameter("page"), true);
                xhttp.send();
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