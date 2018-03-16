<%-- 
    Document   : recommendbase
    Created on : Nov 27, 2017, 9:43:18 AM
    Author     : chracyc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My account</title>
        <link href="recommend.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
        <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600" rel="stylesheet" />
        <script type="text/javascript" src="randommovie.js"></script>
        <script type="text/javascript" src="star.js"></script>
        
    </head>
    <body onload="loadmovie()">
        <div>
            <div id="bar"></div>
            <div class="header">
                <span id="mvtime"><span id="create">Create</span><span> my own</span></span><br />
                <span id="mvtime1">Profile</span>
            </div>
            <div id="tip">
                <span>Please rate 10 movies you have watched before to acquire your own recommendation.</span>
                <p>Tip: using refresh button in the lower right to show other movies </p>
                <p id="num">0/10</p>
            </div>
            <div id="wrapper">
                <div id="refresh">
                    <a onclick="refresh()">
                        <i class="fa fa-refresh fa-4x" aria-hidden="true"></i>
                    </a>
                </div>
                <div id="columns">
                    <!--
                    <div class="box">
                        <div class="original"></div>
                        <div class="overlay">
                            <ul class="stars">
                                <li rel="1"></li>
                                <li rel="2"></li>
                                <li rel="3"></li>
                                <li rel="4"></li>
                                <li rel="5"></li>
                            </ul>
                        </div>
                    -->
                </div>
            </div>
        </div>
        
    </body>
</html>