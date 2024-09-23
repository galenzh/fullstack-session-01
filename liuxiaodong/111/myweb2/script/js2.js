//手风琴
var sfqimg = document.querySelectorAll("#SFQ>ul>li");
for (var i = 0; i < sfqimg.length; i++) {
    (function (i) {
        sfqimg[i].onmouseenter = function () {
            var sfqchhoose=document.querySelector("#SFQ>ul>li.choose");
            sfqchhoose.className="";
            sfqimg[i].className = 'choose';
        }
    })(i);
}