//获取元素
var btn = document.querySelectorAll('#XXK>ul>li')
var tab = document.querySelectorAll('#XXK>ol>li')
//给btn里所有按钮添加点击事件
btn.forEach(function (item, index) {
    item.onmouseover = function () {
        // 2-1. 给 btns 和 tabs 里面的所有内容取消 active 类名
        btn.forEach(function (t, i) {
            t.className = ''
            tab[i].className = ''
        })
        // 2-2. 当前点击的按钮和索引对应的盒子添加 active 类名
        item.className = 'active'
        tab[index].className = 'active'
    }
})