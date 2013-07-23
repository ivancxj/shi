/**
 * Created with JetBrains WebStorm.
 * User: robin
 * Date: 13-7-22
 * Time: PM1:16
 * To change this template use File | Settings | File Templates.
 */
(function () {
    var
        $wrapper = $('.scroll_box'),
        $slide = $wrapper.children('.slide'),
        $left = $('.left.arrow'),
        $right = $('.right.arrow'),
        auto_slide,
        $body = $('body'),
        direction = 'landscape',

        scroll = new iScroll($wrapper[0], {
            snap: true,
            momentum: false,
            vScroll: false,
            hScrollbar: false,
            onBeforeScrollStart: function () {
            },
            onBeforeScrollMove: function () {
                if (direction == 'portrait') {
                    this._unbind('touchmove', window);
                    this._unbind('touchend', window);
                    this._unbind('touchcancel', window);
                    return;
                }
            },
            onScrollMove: function (e) {
                if (this.dirY == 0) e.preventDefault();
            },
            onScrollEnd: function () {
                indicator_update(this.currPageX + 1);
            }
        });

    $body.bind('touchstart', function (e) {
        var point = e.touches[0],
            startPageX = point.pageX,
            startPageY = point.pageY;
        $body.bind('touchmove', function (e) {
            var point = e.touches[0],
                movePageX = point.pageX,
                movePageY = point.pageY;
            if (Math.abs(movePageX - startPageX) < Math.abs(movePageY - startPageY)) {
                direction = 'portrait';
            } else {
                direction = 'landscape';
            }
            $body.unbind('touchmove');
        });
    });

    //幻灯提示点同步
    function indicator_update(x) {
        $slide.children('.active').removeClass('active');
        $slide.find('li:nth-child(' + x + ')').addClass('active');
        $left.toggleClass('hide', x == 1);
        $right.toggleClass('hide', x == 4);
    };

    function scroll_to(x) {
        var pageX = scroll.currPageX + x;
        scroll.scrollToPage(pageX, 0, 500);
    };

    $left.bind('itap', function () {
        scroll_to(-1);
    });

    $right.bind('itap', function () {
        scroll_to(1);
    });

    $wrapper.bind('touchstart', function () {
        if (auto_slide) clearInterval(auto_slide);
    });

    $wrapper.bind('touchend', function () {
        interval();
    });

    $('.slide_a').bind('itap', function (e) {
        var $this = $(this);
        window.location.href = $this.data('href');
    });

    function interval() {
//      if(auto_slide) clearInterval(auto_slide);
//      auto_slide = setInterval(function(){
//        scroll.scrollToPage((scroll.currPageX + 1) % 4, 0 , 500)
//      }, 2000);
    };
    interval();
})();

/**
 * 幻灯宽高设定
 * User: robin
 * Date: 13-7-22
 * Time: PM1:14
 */
(function(){
    var slide_style = function(){
        // var width = DeviceInfo.width / DeviceInfo.ratio - 8;
        var width = $(window).width() * 0.63;
        var height = 96 * width / 72;
//            alert("width="+width+"  height="+height);
        var style = [
            '<style type="text/css">',
            '.slide_width{width:' + width + 'px !important;}',
            '.slide_height{height:' + height + 'px !important;}',
            '.slide_scroll_width{width:' + width * 4 + 'px !important;}',
            '</style>'
        ]
        $('head').append(style.join(' '));
    };

    var add_ratio_class = function(){
        var class_name = 'ratio' + DeviceInfo.ratio;
        $('body').removeClass('ratio1').addClass(class_name.replace('.', '_'));
    };

    if(!(DeviceInfo.browser == 'firefox' || (DeviceInfo.os == 'wp' && DeviceInfo.browser == 'ie'))){
        slide_style();
    }else{
        $(function(){
            DeviceInfo.ratio = DeviceInfo.width / window.innerWidth;
            // 设置样式
            slide_style();
            // 更新cookie
            set_cookie('ratio', DeviceInfo.ratio, 365);
            // body上添加class
            add_ratio_class();
        });
    }

})();
