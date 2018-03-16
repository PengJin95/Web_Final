<%-- 
    Document   : index
    Created on : Nov 24, 2017, 12:15:36 PM
    Author     : WY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="RecPageSS.css">
        <link href="navbar.css" rel="stylesheet">
        <link href="footer.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Recommendations</title>
        <% String UserId = (String) session.getAttribute("uid");%>
        <script type="text/javascript">
            var xmlhttp;

            function createXMLHttpObject() {
                if (window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                return xmlhttp;
            }

            function loadRecInfo() {
                xmlhttp = createXMLHttpObject();
                var url = "TestServlet?UserId=<%=UserId%>";
                xmlhttp.onreadystatechange = callback;
                xmlhttp.open("GET", url, true);
                xmlhttp.send();
            }

            function callback() {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    console.log("hi");
                    var mvlist = xmlhttp.responseXML.getElementsByTagName("movie");
                    for (var i = 0; i < mvlist.length; i++) {
                        var amv = mvlist[i];
                        var mid = mvlist[i].childNodes[0].innerHTML;
                        var mtitle = amv.childNodes[1].firstChild.nodeValue; //u
                        var myear = amv.childNodes[2].innerHTML; //u
                        var msrch = amv.childNodes[3].innerHTML; //u
                        var msrcv = amv.childNodes[4].innerHTML; //u
                        var psrc;
                        if (i % 2 == 0) {
                            psrc = msrch;
                        } else {
                            psrc = msrcv;
                        }
                        if (psrc == "N/A") {
                            psrc = "./image/noposter.png";
                        }
                        var mduration = amv.childNodes[5].innerHTML;
                        var moverview = amv.childNodes[6].innerHTML;
                        //poster+title+year+duration
                        var bx = document.createElement("div");
                        bx.setAttribute("class", "box");
                        var show = document.createElement("div");
                        show.setAttribute("class", "original");

                        var img = document.createElement("img"); //poster
                        img.setAttribute("src", psrc);

                        var mvtt = document.createElement("h4"); //title
                        var icon = document.createElement("i");
                        icon.setAttribute("class", "fa fa-film fa-lg");
                        mvtt.appendChild(icon);
                        mvtt.appendChild(document.createTextNode(" " + mtitle));
                        var mvinfo = document.createElement("p"); //yaer+duration
                        mvinfo.appendChild(document.createTextNode("Released: " + myear));
                        var md = document.createElement("p");
                        md.appendChild(document.createTextNode("Duration: " + mduration + " min"));
                        //overview+link
                        var hid = document.createElement("div");
                        hid.setAttribute("class", "overlay");
                        var hidbut = document.createElement("a");
                        hidbut.setAttribute("class", "btn");
                        hidbut.setAttribute("href", "movie.jsp?id=" + mid);
                        hidbut.appendChild(document.createTextNode("iMovie"));
                        hidbut.appendChild(document.createElement("span"));
                        var hidtx = document.createElement("span");
                        hidtx.setAttribute("class", "text");
                        hidtx.appendChild(document.createTextNode(moverview));
                        hid.appendChild(hidtx);
                        hid.appendChild(hidbut);
                        //attaching
                        show.appendChild(img);
                        show.appendChild(mvtt);
                        show.appendChild(mvinfo);
                        show.appendChild(md);
                        bx.appendChild(show);
                        bx.appendChild(hid);
                        document.getElementById("columns").appendChild(bx);
                    }
                } else
                    console.log("oh no");
            }
        </script>

    </head>

    <body onload="loadRecInfo()">
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
        <div class="header">
            <h1><span id="its">It's</span><span id="mvtime">Movie Time</span></h1>
        </div>
        <div id="wrapper">
            <div id="columns"></div>
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