// JavaScript Document
 //tab切换
      $(".tab-button").click(function () {
        var CYK_tab = $(this).data("tab");
        $(this).addClass("cur").siblings(".tab-button").removeClass("cur");
        $("#tab-" + CYK_tab + "")
          .addClass("active")
          .siblings(".tab-item")
          .removeClass("active");
      });
      //新闻列表切换
      $(".information-tab .article-list").hover(
        function () {
          $(this)
            .addClass("current")
            .siblings(".article-list")
            .removeClass("current");
        },
        function () {
          $(this)
            .parent(".information-right")
            .find(".article-list:first-of-type")
            .addClass("current")
            .siblings(".article-list")
            .removeClass("current");
        }
      );