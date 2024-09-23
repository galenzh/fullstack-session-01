// JavaScript Document
      //制造厂
      var CYK_index5 = 0;
      $("#four_flash .but_right img").click(function () {
        CYK_index5++;
        var CYK_len = $(".flashBg ul.mobile li").length;
        if (CYK_index5 + 5 > CYK_len) {
          $("#four_flash .flashBg ul.mobile")
            .stop()
            .append($("ul.mobile").html());
        }
        $("#four_flash .flashBg ul.mobile")
          .stop()
          .animate({ left: -CYK_index5 * 326 }, 1000);
      });

      $("#four_flash .but_left img").click(function () {
        if (CYK_index5 == 0) {
          $("ul.mobile").prepend($("ul.mobile").html());
          $("ul.mobile").css("left", "-1380px");
          CYK_index5 = 6;
        }
        CYK_index5--;
        $("#four_flash .flashBg ul.mobile")
          .stop()
          .animate({ left: -CYK_index5 * 326 }, 1000);
      });