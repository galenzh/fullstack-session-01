var imgs = document.querySelectorAll("#pop > .list > .item")
for (var i = 0; i < imgs.length; i++) {
    (function (i) {
        if (i < imgs.length / 2) {
            imgs[i].onmouseover = function () {
                var s1 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > img";
                var s2 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > .box";
                var s3 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > .box>p";
                document.querySelector(s1).style = "transform: translateX(-50%) translateY(0.5vw); z-index: 2;transition: all 0.2s linear;"
                document.querySelector(s2).style = "width: 210%;top: 0;left: 0;transition: all 0.6s 0.2s linear;"
                document.querySelector(s3).style = "font-size:2vw;transition: all 0s 0.8s linear;"
            }
            imgs[i].onmouseout = function () {
                var s1 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > img";
                var s2 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > .box";
                var s3 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > .box>p";
                document.querySelector(s1).style = "transform: translateX(0) translateY(0); "
                document.querySelector(s2).style = "width:0;top: 0;left: 0;"
                document.querySelector(s3).style = "font-size:0;"
            }
        } else {
            imgs[i].onmouseover = function () {
                var s1 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > img";
                var s2 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > .box";
                var s3 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > .box>p";
                document.querySelector(s1).style = "transform: translateX(50%) translateY(0.5vw); z-index: 2;transition: all 0.2s linear;"
                document.querySelector(s2).style = "width: 210%;top: 0;right: 0;transition: all 0.6s 0.2s linear;"
                document.querySelector(s3).style = "font-size:2vw;transition: all 0s 0.8s linear;"
            }
            imgs[i].onmouseout = function () {
                var s1 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > img";
                var s2 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > .box";
                var s3 = "#pop > .list > .item:nth-child(" + (i + 1) + ") > .box>p";
                document.querySelector(s1).style = "transform: translateX(0) translateY(0); "
                document.querySelector(s2).style = "width:0;top: 0;right: 0;"
                document.querySelector(s3).style = "font-size:0;"
            }
        }
    }(i))
}



