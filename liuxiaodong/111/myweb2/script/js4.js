var imgs = document.querySelectorAll("#GN>div")//获取图片盒子——结果为数组
var len = imgs.length//图片数量

var current = 0//初始主图片下标

change()
bind()

//改变主图片函数
function change() {
    //将图片分为左右两边两组——每组数量
    var mlen = Math.floor(len / 2)
    for (var i = 0; i < mlen; i++) {
        //获取主图片左右两边的图片的下标
        //注：当图片数为偶数时会出现一个limg=rimg的情况
        var limg = len + current - i - 1
        var rimg = current + i + 1
        if (limg >= len) {
            limg -= len
        }
        if (rimg >= len) {
            rimg -= len
        }

        //给主图片左右两边的图片设置transform
        if (rimg != limg) {
            imgs[limg].style.transform = 'translateX(' + (-9) * (i + 1) + 'vw) translateZ(' + (4 - i) + 'vw) rotateY(30deg) scale(' + (1 - (0.1 * (i + 1))) + ')'
            imgs[rimg].style.transform = 'translateX(' + (9) * (i + 1) + 'vw) translateZ(' + (4 - i) + 'vw) rotateY(-30deg) scale(' + (1 - (0.1 * (i + 1))) + ')'
        } else {
            //给当rimg=limg这种特殊情况下的transform
            imgs[limg].style.transform = 'translateZ(0)'
        }
        //设置主图片的transform
        imgs[current].style.transform = 'translateZ(10vw)'

    }
}

//设置绑定
function bind() {
    //获取点击图片的下标——并赋值给current（主图片下标）然后调用change函数
    for (var i = 0; i < len; i++) {
        (function (i) {
            imgs[i].onclick = function () {
                current = i;
                change();
            }
        })(i);
    }
}