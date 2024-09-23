// var btn = document.querySelectorAll("nav>ul>li")
// var ol = document.querySelectorAll("nav>ul>li>ol")
//
//
// for (var i = 2; i < btn.length-1; i++) {
//     (function (i) {
//         btn[i].onmouseover = function () {
//             var str = "nav > ul > li > #n" + i + ">li";
//             var height = document.querySelectorAll(str).length * 3.5;
//             ol[i].style.height = height + "vw";
//         }
//         btn[i].onmouseout = function () {
//             ol[i].style.height = "3.5vw";
//         }
//     })(i);
// }


var gotop = document.querySelector('.gotop')
//绑定滚动事件
window.onscroll = function () {
    //获取滚动高度
    var height = document.documentElement.scrollTop || document.body.scrollTop
    //判断滚动状态
    if (height >= 400) {
        gotop.style.display = 'block'
    } else {
        gotop.style.display = 'none'
    }
}
//绑定点击事件
gotop.onclick = function () {
    //滚动到顶部
    window.scrollTo(
        {
            top: 0,
            behavior: 'smooth'
        }
    )
}