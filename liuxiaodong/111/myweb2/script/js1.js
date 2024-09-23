 // 获取背景对象
    const bg = document.querySelector('#banner')
    // 监听滚轮事件
    document.addEventListener("scroll", function () {
        // 获取当前滚轮的位置
        const scrollY = window.scrollY;
        if (scrollY != 0) {
            // 滚轮位置不等于0时，修改背景的定位加上滚轮的值
            bg.style.backgroundPosition = "calc(50% + " + scrollY + "px) calc(50% + " + scrollY + "px)";

        } else {
            // 否则清空背景的定位
            bg.style.backgroundPosition='';
        }
    })