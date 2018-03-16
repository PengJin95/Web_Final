var input;
var ratinglst = [];
var mvidlst = [];
var y = 0;
function rating(obj) {
    var q = obj.getAttribute("rel");
    initializestars();
    input = q*2;
    var star = obj.parentNode.childNodes;
    for (var i = 0; i < q; i++) {
        star[i].setAttribute("class", "on");
    }
    ratinglst.push(input);
    var index = obj.parentNode.getAttribute("rel");
    mvidlst.push(a1[index]);
    y++;
    console.log(y);
    var num = document.getElementById("num");
    num.replaceChild(document.createTextNode(y+"/10"),num.childNodes[0]);
    cover(obj);
    if(ratinglst.length==10){
        console.log("submit");
        submitrating();
    }
}
function mouseover(obj){
    var q = obj.getAttribute("rel");
    initializestars();
    var star = obj.parentNode.childNodes;
    for (var i = 0; i < q; i++) {
        star[i].setAttribute("class", "on");
    }
}
function mouseout(obj){
    initializestars();
}
function cover(obj){
    var overlay = obj.parentNode.parentNode;
    var shield = document.createElement("div");
    var thank = document.createElement("span");
    thank.appendChild(document.createTextNode("Thanks"));
    thank.setAttribute("class","thank");
    shield.appendChild(thank);
    shield.setAttribute("class","shield");
    overlay.replaceChild(shield,obj.parentNode);
}
var xmlhttp1;
var flag;
function submitrating(){
    var qstr = "";
    for(var i=0;i<9;i++){
        qstr+="mvid"+i+"="+mvidlst[i]+"&rating"+i+"="+ratinglst[i]+"&";
        console.log(qstr);
    }
    qstr+="mvid9="+mvidlst[9]+"&rating9="+ratinglst[9];
    xmlhttp1 =  new XMLHttpRequest();
    var url = "rating?"+qstr;
    console.log(url);
    flag=true;
    xmlhttp1.onreadystatechange = callback1;
    xmlhttp1.open("GET", url, true);
    xmlhttp1.send();
}
function callback1(){
    if (flag&&xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        console.log("success!");
        alert("Success!");
        flag=false;
        window.location.href = "index.jsp";
    }
}
function refresh(){
    var oldcolumn = document.getElementById("columns");
    var newcolumn = document.createElement("div");
    newcolumn.setAttribute("id","columns");
    var wrapper = document.getElementById("wrapper");
    wrapper.removeChild(oldcolumn);
    wrapper.appendChild(newcolumn);
    loadmovie();
}