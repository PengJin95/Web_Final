<%-- 
    Document   : home
    Created on : 2017-11-7, 20:55:27
    Author     : Think
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link href="navbar.css" rel="stylesheet">
        <link href="home.css" rel="stylesheet">
        <link href="footer.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600" rel="stylesheet">
        <link href="https://use.fontawesome.com/releases/v5.0.1/css/all.css" rel="stylesheet">

    </head>

    <body>
        <%

            //If already logged in, jump to home page
            if (session.getAttribute("uid") != null && (session.getAttribute("already") == null)) {
                response.sendRedirect("recommendbase.jsp");
                return;
            }

        %>


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

        <a href="#nowplaying" class="arrow" id="arrow1" onclick="jumpToAncher(event)"></a>
        <div id="welcome">
            <p id="welcome-title">Just enjoy the movies!</p>
        </div>

        <div id="nowplaying">
            <div id="blank1"></div>
            <div id="blank2"></div>
            <div id="slides">
                <div class="slide fade">
                    <a href="#">
                        <img class="slide-img" src="./image/1.jpg">
                    </a>
                    <p class="slide-name">Justice League</p>
                </div>
                <div class="slide fade">
                    <a href="#">
                        <img class="slide-img" src="./image/2.jpg">
                    </a>
                    <p class="slide-name">Beauty and the Beast</p>
                </div>
                <div class="slide fade">
                    <a href="#">
                        <img class="slide-img" src="./image/3.jpg">
                    </a>
                    <p class="slide-name">Geostorm</p>
                </div>
            </div>
            <div id="blank3"></div>
            <div id="caption">
                <div id="cap-txt1">Popular Movies
                    <br> in 2017</div>
                <div id="cap-txt2">&#38;</div>
                <div id="cap-txt3">Movies
                    <br> Now Playing</div>
            </div>
            <img src="./image/icon.png" id="movie-icon">
            <a href="#blank4" class="arrow" id="arrow2" onclick="jumpToAncher(event)"></a>
        </div>

        <div id="blank4">
            <p>Movies you may be interested in</p>
        </div>
        <div id="recommend">
            <div id="recommend1">
                <div id="recommend-title">
                    <p>Have interest? <br><br>Click the poster <br><br> to explore it!
                    </p>
                </div>
                <a href="movie.jsp?id=53" class="poster">
                    <img class="poster-img" src="https://image.tmdb.org/t/p/w640/eduBDZvRNGxvqsBgfzxyBgWMKlE.jpg">
                    <p>
                        <i class="fa fa-film" aria-hidden="true"></i>&nbsp;Battle: Los Angeles
                        <br><span>(2011-03-08)</span>
                    </p>

                </a>
                <a href="movie.jsp?id=62" class="poster">
                    <img class="poster-img" src="https://image.tmdb.org/t/p/w640/nkFTbA1XjKWo9LCTaV1hV2Lsgr1.jpg">
                    <p>
                        <i class="fa fa-film" aria-hidden="true"></i>&nbsp;The King's Speech
                        <br><span>(2010-09-06)</span>
                    </p>
                </a>
                <a href="movie.jsp?id=54" class="poster">
                    <img class="poster-img" src="https://image.tmdb.org/t/p/w640/afxRbCwwKjrWgGJtsVNs1BW1Dk5.jpg">
                    <p>
                        <i class="fa fa-film" aria-hidden="true"></i>&nbsp;Rango
                        <br><span>(2011-03-02)</span>
                    </p>
                </a>
                <a href="movie.jsp?id=1965" class="poster">
                    <img class="poster-img" src="https://image.tmdb.org/t/p/w640/yTtx2ciqk4XdN1oKhMMDy3f5ue3.jpg">
                    <p>
                        <i class="fa fa-film" aria-hidden="true"></i>&nbsp;Divergent
                        <br><span>(2014-03-14)</span>
                    </p>
                </a>


            </div>
            <div id="recom-wrapper">
                <div id="recommend2">
                    <a href="movie.jsp?id=2582" class="poster">
                        <img class="poster-img" src="https://image.tmdb.org/t/p/w640/ckrTPz6FZ35L5ybjqvkLWzzSLO7.jpg">
                        <p>
                            <i class="fa fa-film" aria-hidden="true"></i>&nbsp;Warcraft
                            <br><span>(2016-05-25)</span>
                        </p>
                    </a>

                    <a href="movie.jsp?id=294" class="poster">
                        <img class="poster-img" src="https://image.tmdb.org/t/p/w640/7SSm7BfzFoVzmd6fCDccj7qRxc8.jpg">
                        <p>
                            <i class="fa fa-film" aria-hidden="true"></i>&nbsp;X-Men: First Class
                            <br><span>(2011-05-24)</span>
                        </p>
                    </a>
                    <a href="movie.jsp?id=319" class="poster">
                        <img class="poster-img" src="https://image.tmdb.org/t/p/w640/AblhtULOVtrkSnFxRPQ8gBemxw9.jpg">
                        <p>
                            <i class="fa fa-film" aria-hidden="true"></i>&nbsp;Cars 2
                            <br><span>(2011-06-11)</span>
                        </p>
                    </a>
                    <a href="movie.jsp?id=185" class="poster">
                        <img class="poster-img" src="https://image.tmdb.org/t/p/w640/i7hS3kyv7EeoLhCDz3I7MjJ2iEN.jpg">
                        <p>
                            <i class="fa fa-film" aria-hidden="true"></i>&nbsp;Source Code
                            <br><span>(2011-03-30)</span>
                        </p>
                    </a>
                    <div id="recommend-more">
                        <a href="#" id="more-to-recommend">Wanna see more?
                            <br>
                            <br>
                            <span>Click here!</span>
                        </a>
                        <a href="register.jsp" id="more-to-register">Wanna see<br> more choices?
                            <br>
                            <br>
                            <span>Join us!</span>
                        </a>
                    </div>
                </div>
            </div>
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
            function get_recom_ajax() {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        xmlDoc = this.responseXML;
                        var len = xmlDoc.getElementsByTagName("movie").length;
                        var poster = document.getElementsByClassName("poster");
                        var posterv = xmlDoc.getElementsByTagName("posterh");
                        var movieId = xmlDoc.getElementsByTagName("movieid");
                        var title = xmlDoc.getElementsByTagName("title");
                        var date = xmlDoc.getElementsByTagName("year");

                        for (var i = 0; i < len; i++) {
                            poster[i].setAttribute("href", "movie.jsp?id=" + movieId[i].childNodes[0].nodeValue);
                            var img_url = (posterv[i].childNodes[0].nodeValue == "N/A") ? "./image/noposter.png" : posterv[i].childNodes[0].nodeValue;
                            var temp = `
                                <img class="poster-img" src="` + img_url + `">
                                <p>
                                    <i class="fa fa-film" aria-hidden="true"></i>&nbsp;` + title[i].childNodes[0].nodeValue + `
                                    <br><span>(` + date[i].childNodes[0].nodeValue + `)</span>
                                </p>
                                `;
                            poster[i].innerHTML = temp;
                        }
                    }
                };
                xhttp.open("GET", "homePageRec?howmany=8", true);
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
            if (<%= session.getAttribute("uid") != null%>) {
                document.getElementById("recommend_active").style.display = "initial";
                document.getElementById("recommend_inactive").style.display = "none";
                document.getElementById("dropdown").style.display = "initial";
                document.getElementById("login-btn").style.display = "none";
                document.getElementById("more-to-recommend").style.display = "initial";
                document.getElementById("more-to-register").style.display = "none";
            } else {
                document.getElementById("more-to-recommend").style.display = "none";
                document.getElementById("more-to-register").style.display = "initial";
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
                    return;
                }
            }
        </script>

        <script>
            var slides = document.getElementsByClassName("slide");
            var length = slides.length;
            var index = 0;

            changeToSlide(index);
            window.setInterval("changeIndex(1)", 3000);

            function changeIndex(n) {
                changeToSlide(index + n);
            }

            function changeToSlide(n) {
                if (n == length) {
                    index = 0;
                } else if (n < 0) {
                    index = length - 1;
                } else {
                    index = n;
                }
                for (var i = 0; i < length; i++) {
                    if (i != index) {
                        slides[i].style.display = "none";
                    } else {
                        slides[i].style.display = "block";
                    }
                }
            }

            window.onload = function () {
                document.getElementById("recommend-title").style.height = document.body.clientWidth * 0.2 / 2 * 3.2 + "px";
                document.getElementById("recommend-more").style.height = document.body.clientWidth * 0.2 / 2 * 3.2 + "px";
                document.getElementById("caption").style.height = document.body.clientWidth * 0.6 / 16 * 9 + "px";
                document.getElementById("welcome").style.height = document.body.clientHeight - 60 + "px";
                if (<%= session.getAttribute("uid") != null%>) {
                    get_recom_ajax();
                }
            }

            window.onresize = function () {
                document.getElementById("recommend-title").style.height = document.body.clientWidth * 0.2 / 2 * 3.2 + "px";
                document.getElementById("recommend-more").style.height = document.body.clientWidth * 0.2 / 2 * 3.2 + "px";
                document.getElementById("caption").style.height = document.body.clientWidth * 0.6 / 16 * 9 + "px";
                document.getElementById("welcome").style.height = document.body.clientHeight - 60 + "px";
            }

            function jumpToAncher(event) {
                body = document.body;
                targetOffset = document.getElementById(event.target.hash.substr(1)).offsetTop;
                currentPosition = window.pageYOffset;
                body.classList.add('tran');
                body.style.WebkitTransform = "translate(0, -" + (targetOffset - currentPosition) + "px)";
                body.style.MozTransform = "translate(0, -" + (targetOffset - currentPosition) + "px)";
                body.style.transform = "translate(0, -" + (targetOffset - currentPosition) + "px)";

                window.setTimeout(function () {
                    body.classList.remove('tran');
                    body.style.cssText = "";
                    window.scrollTo(0, targetOffset);
                }, 950);

                event.preventDefault();
            }
        </script>

    </body>

</html>