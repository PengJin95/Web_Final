var xmlhttp;
function createXMLHttpObject() {
    if (window.XMLHttpRequest) {
        xmlhttp = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xmlhttp;
}
function loadmovie() {
    xmlhttp = createXMLHttpObject();
    var url = "recommendbase";
    xmlhttp.onreadystatechange = callback;
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}
var a1 = [];
function callback() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        var mvlist = xmlhttp.responseXML.getElementsByTagName("movie");
        var mvid = xmlhttp.responseXML.getElementsByTagName("mid");
        var mvliname = xmlhttp.responseXML.getElementsByTagName("name");
        var mvlidirector = xmlhttp.responseXML.getElementsByTagName("director");
        var mvlisrcv = xmlhttp.responseXML.getElementsByTagName("postervert");
        for (var i = 0; i < mvlist.length; i++) {
            a1[i] = mvid[i].childNodes[0].nodeValue;
            var mtitle = mvliname[i].childNodes[0].nodeValue;
            var mdirector = mvlidirector[i].childNodes[0].nodeValue;
            var msrcv = mvlisrcv[i].childNodes[0].nodeValue;
            if (msrcv == "" || msrcv == "N/A") {
                msrcv = "./image/noposter.png";
            }
            var bx = document.createElement("div");
            bx.setAttribute("class", "box");
            var show = document.createElement("div");//all info
            show.setAttribute("class", "original");
            var img = document.createElement("img");//poster
            img.setAttribute("src", msrcv);
            var mvtt = document.createElement("h4");//title
            mvtt.appendChild(document.createTextNode(mtitle));
            var mvinfo = document.createElement("p");//director
            mvinfo.appendChild(document.createTextNode("Director: " + mdirector));
            show.appendChild(img);
            show.appendChild(mvtt);
            show.appendChild(mvinfo);
            var hid = document.createElement("div");//ratingstars
            hid.setAttribute("class", "overlay");
            var hidtx = document.createElement("ul");
            hidtx.setAttribute("class", "stars");
            hidtx.setAttribute("rel", i);
            var ul1 = document.createElement("li");
            ul1.setAttribute("rel", "1");
            ul1.setAttribute("onclick","rating(this)");
            ul1.setAttribute("onmouseover","mouseover(this)");
            ul1.setAttribute("onmouseout","mouseout(this)");
            ul1.innerHTML = "&#9733;";
            var ul2 = document.createElement("li");
            ul2.setAttribute("rel", "2");
            ul2.setAttribute("onclick","rating(this)");
            ul2.setAttribute("onmouseover","mouseover(this)");
            ul2.setAttribute("onmouseout","mouseout(this)");
            ul2.innerHTML = "&#9733;";
            var ul3 = document.createElement("li");
            ul3.setAttribute("rel", "3");
            ul3.setAttribute("onclick","rating(this)");
            ul3.setAttribute("onmouseover","mouseover(this)");
            ul3.setAttribute("onmouseout","mouseout(this)");
            ul3.innerHTML = "&#9733;";
            var ul4 = document.createElement("li");
            ul4.setAttribute("rel", "4");
            ul4.setAttribute("onclick","rating(this)");
            ul4.setAttribute("onmouseover","mouseover(this)");
            ul4.setAttribute("onmouseout","mouseout(this)");
            ul4.innerHTML = "&#9733;";
            var ul5 = document.createElement("li");
            ul5.setAttribute("rel", "5");
            ul5.setAttribute("onclick","rating(this)");
            ul5.setAttribute("onmouseover","mouseover(this)");
            ul5.setAttribute("onmouseout","mouseout(this)");
            ul5.innerHTML = "&#9733;";
            hidtx.appendChild(ul1);
            hidtx.appendChild(ul2);
            hidtx.appendChild(ul3);
            hidtx.appendChild(ul4);
            hidtx.appendChild(ul5);
            hid.appendChild(hidtx);
            bx.appendChild(show);
            bx.appendChild(hid);
            document.getElementById("columns").appendChild(bx);
        }
        initializestars();
    }
}
function initializestars() {
    var star = document.getElementsByTagName("li");
    for (var i = 0; i < star.length; i++) {
        star[i].setAttribute("class", "");
    }
}
