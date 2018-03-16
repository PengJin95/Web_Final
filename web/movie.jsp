<%-- 
    Document   : moviecomments
    Created on : Dec 4, 2017, 3:39:32 PM
    Author     : wangshuang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Movie Comments</title>
        <link href="moviecomments.css" rel="stylesheet" type="text/css"/>
        <link href="stars.css" rel="stylesheet" type="text/css"/>
        <link href="navbar.css" rel="stylesheet">
        <link href="footer.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600" rel="stylesheet">
    </head>

    <body onload="loadmovieinfo();stars();">
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


        <script type="text/javascript">
            var mid = <%=request.getParameter("id")%>

            //   if (document.getElementById("comment-self") != null) {
            //     console.log("comment-self exits")
            //     document.getElementById('addbtn').innerHTML = 'Edit Comment';  document.getElementById('addbtn').innerHTML = 'Edit Comment';
            // }


            var xmlhttp;
            function createXMLHttpObject() {
                if (window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                return xmlhttp;
            }
            function getP() {

                var commentN = document.getElementById("addC").value;

                xmlhttp = createXMLHttpObject();
                var queryString = "?MovieId=" + mid  + "&case=3";
                var url = "loadCurrentUserComment" + queryString;
                xmlhttp.onreadystatechange = cccc;
                xmlhttp.open("GET", url, true);
                xmlhttp.send();

            }

            function cccc() {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var comS = xmlhttp.responseXML.getElementsByTagName("commentS");
                    //console.log("comS " + comS);
                    var userS = xmlhttp.responseXML.getElementsByTagName("usernameS");//username where to get
                    //console.log("userS " + userS)
                    var dateS = xmlhttp.responseXML.getElementsByTagName("dateS");
                    var x = document.getElementById("commentBox-self");
                    var b = document.getElementById("comment-self");
                    var c = document.getElementById("username-self");
                    var d = document.getElementById("date-self");
                    b.className = "CommendC";
                    c.className = "usernameC";
                    d.className = "DateC";
                    var e = comS[0].childNodes[0].nodeValue;
                    var f = userS[0].childNodes[0].nodeValue;
                    var g = dateS[0].childNodes[0].nodeValue;
                    b.innerHTML = e;
                    c.innerHTML = f;
                    d.innerHTML = g;
                    if (b !== null) {
                        //  var h=document.getElementById("addC");
                        //  h.value=e;
                        //  console.log(h);
                        document.getElementById('addbtn').innerHTML = 'Edit Comment';
                        // var hrC = document.createElement('hr');
                        //hrC.className="hrS";
                        //x.appendChild(hrC);
                    }
                }
            }


        </script>   
        <%--<button id="addbtn" type="button" onclick="document.getElementById('CoverLr').style.display = 'block';document.getElementById('addC').value = '';textareaContent();">Add commend</button>
        --%>        
        <script type="text/javascript">
            function textareaContent() {
                var h = document.getElementById("comment-self");
                var f = h.innerHTML;
                var g = document.getElementById("addC");
                if (f != null) {
                    g.value = f;
                }
            }
        </script>
        <p id="check"></p>
        <div id="CoverLr">
            <div id="commendBx"> 
                <textarea type="text" id="addC" autocomplete="off" maxlength="100" placeholder="Commend..." <%--onkeyup="keyUp()--%>">
                </textarea>
                <%--<span id="textCount">0/100</span>--%>
                <div class="btns">
                    <button  type="button" onclick="document.getElementById('CoverLr').style.display = 'none'"  id="cancelbtn">Cancel</button>
                    <button type="submit"  id="signupbtn" onclick="submit()" >Submit</button>

                </div>
            </div>
            <script type="text/javascript">
                //try to add a onkeyup event to count commend input number
            </script>

            <script type="text/javascript">
                var mid = <%=request.getParameter("id")%>
                function stars() {
                    var input;
                    var s = document.getElementById("pingStar"),
                            m = document.getElementById('dir'),
                            n = s.getElementsByTagName("li");

                    clearAll = function () {
                        for (var i = 0; i < n.length; i++) {
                            n[i].className = '';
                            m.innerHTML = '';
                        }
                    }
                    for (var i = 0; i < n.length; i++) {
                        n[i].onclick = function () {
                            var q = this.getAttribute("rel");
                            clearAll();//？？？
                            input = q * 2;//？？？   
                            document.getElementById('startP').value = input;
                            //console.log(document.getElementById('startP').value);
                            for (var i = 0; i < q; i++) {
                                n[i].className = 'on';
                            }
                            m.innerHTML = this.getAttribute("title");
                            //console.log(input);
                            submitR();
                        }

                        n[i].onmouseover = function () {
                            var q = this.getAttribute("rel");
                            clearAll();
                            m.innerHTML = this.getAttribute("title");
                            for (var i = 0; i < q; i++) {
                                n[i].className = 'on';
                            }
                        }

                        n[i].onmouseout = function () {
                            clearAll();
                            for (var i = 0; i < input / 2; i++) {
                                n[i].className = 'on';
                                //console.log(input);
                            }
                        }
                    }
                }
                var xmlhttp;
                function createXMLHttpObject() {
                    if (window.XMLHttpRequest) {
                        xmlhttp = new XMLHttpRequest();
                    } else if (window.ActiveXObject) {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    return xmlhttp;
                }
                function submitR() {
                    var commentN = document.getElementById("addC").value;
                    var ratingN = document.getElementById("startP").value;
                    //var r = document.getElementById("startP").getAttribute('rel');

                    xmlhttp = createXMLHttpObject();
                    var queryString1 = "?MovieId=" + mid  + "&ratingN=" + ratingN + "&case=1" + "&commentN=" + commentN;
                    var url = "addNewComment" + queryString1;
                    xmlhttp.onreadystatechange = bbbb;
                    xmlhttp.open("GET", url, true);
                    xmlhttp.send();
                }
                function bbbb() {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var ratingV = xmlhttp.responseXML.getElementsByTagName("rating");//S-self user and comment that are displayed 
                        var x = document.getElementById("startP");
                        //x.value=parseInt(ratingV, 10);//mightbug:type need to be convert to int
                        // function stars();//mightbug: do I need to invoke it or it self-invoked
                    }
                }
            </script> 

            <script type="text/javascript">
                var mid = <%=request.getParameter("id")%>
                var xmlhttp;
                function createXMLHttpObject() {
                    if (window.XMLHttpRequest) {
                        xmlhttp = new XMLHttpRequest();
                    } else if (window.ActiveXObject) {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    return xmlhttp;
                }
                function submit() {

                    var commentN = document.getElementById("addC").value;
                    // console.log(commentN);
                    var ratingN = document.getElementById("startP").value;
                    //console.log("origin:" + ratingN);
                    if (ratingN == "") {
                        ratingN = 0;
                    }
                    // console.log("after:" + ratingN);

                    xmlhttp = createXMLHttpObject();
                    var queryString = "?MovieId=" + mid + "&commentN=" + commentN + "&case=2" + "&ratingN=" + ratingN;
                    var url = "addNewComment" + queryString;
                    //console.log(url);
                    xmlhttp.onreadystatechange = aaaa;
                    xmlhttp.open("GET", url, true);
                    xmlhttp.send();
                    document.getElementById('CoverLr').style.display = 'none';
                    document.getElementById('addbtn').innerHTML = 'Edit Comment';
                    document.getElementById('addbtn').onclick = function () {
                        document.getElementById('CoverLr').style.display = 'block';
                    }
                }
                function aaaa() {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var comS = xmlhttp.responseXML.getElementsByTagName("commentS");//S-self user and comment that are displayed 
                        // console.log("comS " + comS);
                        var userS = xmlhttp.responseXML.getElementsByTagName("usernameS");//username where to get
                        //console.log("userS " + userS)
                        var dateS = xmlhttp.responseXML.getElementsByTagName("dateS")
                        var b = document.getElementById("comment-self");
                        var c = document.getElementById("username-self");
                        var d = document.getElementById("date-self");
                        b.className = "CommendC";
                        c.className = "usernameC";
                        d.className = "dateC";
                        var e = comS[0].childNodes[0].nodeValue;
                        var f = userS[0].childNodes[0].nodeValue;
                        var g = dateS[0].childNodes[0].nodeValue;
                        b.innerHTML = e;
                        c.innerHTML = f;
                        d.innerHTML = g;
                        //var here=document.getElementById("hr");
                        //var hr = document.createElement("hr");
                        // here.appendChilld(hr);
                    }
                }






            </script>

        </div>
        <script type="text/javascript">
            var CoverLr = document.getElementById('CoverLr');
            window.onclick = function (event) {
                if (event.target == CoverLr) {
                    CoverLr.style.display = "none";
                }
            }
        </script>



        <!--//complete here-->
        <div>
            <div class="header"></div>
            <div class="maincontent">

                <div id="poster">
                    <img src="" id="movie" alt="movieimg"/>
                </div>

                <div id="profilebox" class="sameRow">
                    <img src="" id="profile" alt="movieimg1"/>
                </div>
                <div id="rightBox" class="sameRow">
                    <div id="rightTopBox">
                        <div id="basicInfo">

                            <div>
                                <span id="title"></span>
                            </div>
                            <div>
                                <b>Release Date:</b>
                                <span id="releasedate"></span>
                            </div>
                            <div >
                                <b>Director:</b>
                                <span id="director"></span>
                            </div>
                            <div id="textS">
                                <b>Main Cast:</b>
                                <span id="actor"></span>
                            </div>

                            <div>
                                <b>Running Time:</b>
                                <span id="runningtime"></span>
                            </div>
                        </div>
                    </div>     
                    <div id="rightBottomBox">
                        <div id="description">
                            <div>
                                <b>Overview:</b>
                                <span id="intro"></span>
                            </div>
                            <div id="rating"></div>
                        </div>
                        <div id="starsarea">

                            <div class="starts">
                                <div id="check"></div>
                                <ul id="pingStar">

                                    <li rel="1"  title="If I recommend it to you means I hate you">&#9733;</li>
                                    <li rel="2"  title="Totally a waste of time">&#9733;</li>
                                    <li rel="3"  title="It's fine but I could do something else">&#9733;</li>
                                    <li rel="4"  title="I decided to be picky to show my taste">&#9733;</li>
                                    <li rel="5"  title="Excellent">&#9733;</li>

                                    <span id="dir"></span>
                                </ul>
                                <input type="hidden" value="0"  id="startP"/>
                                <div id="check"></div>
                            </div>
                        </div>

                    </div>
                </div> 

                <div id="userOPRT">
                    <button id="addbtn" type="button" onclick="document.getElementById('CoverLr').style.display = 'block';document.getElementById('addC').value = '';textareaContent();">Add commend</button>


                </div> 
                <div id="nextBx">
                    <div id="reviewT">
                        <b>Reviews:</b><hr/>
                    </div>


                    <div id="comment">
                        <%--<b>Reviews:</b><hr/>--%>
                        <p id="CommendA"></p>
                        <div id="commend-list">
                            <div id="commentBox-self">
                                <div id="username-self"></div>
                                <div id="date-self"></div>
                                <div id="comment-self"></div>

                                <div class="hrS"></div>
                            </div>

                            <div class="CommendC"></div>
                            <div class="usernameC"></div>
                            <div class="DateC"></div>
                            <div class="hr"></div>


                        </div>

                    </div>
                </div>
            </div>
            <button id="trailBtn" type="button" onclick="document.getElementById('coverLr2').style.display = 'block'">Watch Trailer</button>
            <div id="coverLr2"> 
                <div id="videoBx">
                    <!-- <iframe width="560" height="315" src="https://www.youtube.com/embed/1HJkmKODN4Y" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
                    -->
                    <iframe id="iframe" src="https://youtu.be/k-OOfW6wWyQ?html5=1"  gesture="media" ></iframe>

                </div>
            </div>
            <script type="text/javascript">
                var CoverLr2 = document.getElementById('coverLr2');
                window.onclick = function (event) {
                    if (event.target == coverLr2) {
                        CoverLr2.style.display = "none";
                    }
                }
            </script>
        </div>
    </div>            
    <script type="text/javascript">
        var mid = <%=request.getParameter("id")%>
        var xmlhttp;
        function createXMLHttpObject() {
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            return xmlhttp;
        }
        function loadmovieinfo() {
            //console.log("loadmovie info");
            xmlhttp = createXMLHttpObject();
            var url = "getMovieInfo?MovieId=" + mid;
            //console.log(url);
            xmlhttp.onreadystatechange = callback;
            xmlhttp.open("GET", url, true);
            xmlhttp.send();
        }
        function callback() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.getElementById("movie").src = xmlhttp.responseXML.getElementsByTagName("postervert")[0].childNodes[0].nodeValue;
                document.getElementById("profile").src = xmlhttp.responseXML.getElementsByTagName("postervert")[0].childNodes[0].nodeValue;
                document.getElementById("title").innerHTML = xmlhttp.responseXML.getElementsByTagName("name")[0].childNodes[0].nodeValue;
                document.getElementById("director").innerHTML = xmlhttp.responseXML.getElementsByTagName("director")[0].childNodes[0].nodeValue;
                document.getElementById("releasedate").innerHTML = xmlhttp.responseXML.getElementsByTagName("releasedate")[0].childNodes[0].nodeValue;
                document.getElementById("runningtime").innerHTML = xmlhttp.responseXML.getElementsByTagName("duration")[0].childNodes[0].nodeValue;
                document.getElementById("intro").innerHTML = xmlhttp.responseXML.getElementsByTagName("overview")[0].childNodes[0].nodeValue;
                //here document.getElementById("iframe").src = xmlhttp.responseXML.getElementsByTagName("trailer")[0].childNodes[0].nodeValue;

                var act = xmlhttp.responseXML.getElementsByTagName("actor");
                var an = "<span>";
                for (var i = 0; i < act.length - 1; i++) {
                    an = an + act[i].childNodes[0].nodeValue + ", ";
                }
                an = an + act[i].childNodes[0].nodeValue + "</span>";
                document.getElementById("actor").innerHTML = an;

                // console.log("this is callback")
                var com = xmlhttp.responseXML.getElementsByTagName("comment");
                var userN = xmlhttp.responseXML.getElementsByTagName("username");
                var dateN = xmlhttp.responseXML.getElementsByTagName("date");
                var x = document.getElementById("commend-list");
                // console.log("commentlength:" + com.length);
                for (var j = 0; j < com.length; j++) {
                    var a = document.createElement("div");//a need another child c: username
                    a.className = "CommendC";
                    var b = document.createTextNode(com[j].childNodes[0].nodeValue);
                    var c = document.createElement("div");
                    c.className = "usernameC";
                    var d = document.createTextNode(userN[j].childNodes[0].nodeValue);
                    var e = document.createElement("div");//a need another child c: username
                    e.className = "DateC";
                    var f = document.createTextNode(dateN[j].childNodes[0].nodeValue);
                    var hrC = document.createElement('hr');
                    hrC.className = "hr";
                    x.appendChild(hrC);
                    a.appendChild(b);
                    c.appendChild(d);
                    e.appendChild(f);
                    x.appendChild(c);
                    x.appendChild(e);
                    x.appendChild(a);

                    getP();

                }
            }
        }
    </script>





    <%--
    back here?
    <script type="text/javascript">
     function stars() {
          var input=4;
          var s = document.getElementById("pingStar"),
          m = document.getElementById('dir'),
          n = s.getElementsByTagName("li");
        // document.getElementById('startP').setAttribute("value",input);
    //function()是什么
          clearAll = function () {
               for (var i = 0; i < n.length; i++) {
                   n[i].className = '';
                   m.innerHTML ='';
               }
            }
          for (var i = 0; i < n.length; i++) {
               n[i].onclick = function () {
                   var q = this.getAttribute("rel");
                   clearAll();//？？？
                   input = q*2;//？？？   
                   document.getElementById('startP').value=input;
                   console.log(document.getElementById('startP').value);
                   for (var i = 0; i < q; i++) {
                      n[i].className = 'on';
                   }
                   m.innerHTML = this.getAttribute("title");
                   //console.log(input);
                   }
                 
                    n[i].onmouseover = function () {
                        var q = this.getAttribute("rel");
                        clearAll();
                        m.innerHTML = this.getAttribute("title");
                        for (var i = 0; i < q; i++) {
                            n[i].className = 'on';
     }
    }
    //mouse leave element: If mouse have clicked, take input value, CSS before it stil with 'on'
    n[i].onmouseout = function () {
     clearAll();
     for (var i = 0; i < input/2; i++) {
      n[i].className = 'on';
       //console.log(input);
     }
    }
   }
   
      //保存所选值
  }
     </script> 
    --%>
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