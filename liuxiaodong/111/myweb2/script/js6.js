var btn = document.querySelector("#BOX > .container > .BOTTOM > input");

document.querySelector("#BOX > .container > .BOTTOM > textarea").onkeyup = function (e) {
    if (e.keyCode === 13) {
        ENTER()
    }
}

btn.onclick = function () {
    ENTER()
}
function ENTER() {
    var text = document.querySelector("#BOX > .container > .BOTTOM > textarea").value;
    document.querySelector("#BOX > .container > .BOTTOM > textarea").value = "";
    if (text == "") {
        alert("输入内容不能为空");
    } else {
        var NR = document.querySelector("#BOX > .container > .NR");
        var right = document.createElement('div');
        var div = document.createElement('div');
        var span = document.createElement('span');
        var p = document.createElement('p');
        var img = document.createElement('img');
        span.innerHTML = "老子高启强";
        p.innerHTML = text;
        div.appendChild(span);
        div.appendChild(p);
        right.className = 'right';
        right.appendChild(div);
        img.src = "./images/KB4.png";
        img.style = "background: #af6238;";
        right.appendChild(img);
        NR.appendChild(right);
        var NR_height = NR.scrollHeight;
        NR.scroll(0, NR_height);
    }
}






