
var DeviceInfo = (function (ua) {
    var d = {
            os: '',
            // os_version: '',
            browser: '',
            // browser_version: '',
            browser_engine: '',
            device: '',  // device model
            width: '',
            ratio: '',
            type: '',  // pc || pad || mobile
            user_agent: ua
        },

        get_os = function () {
            if (ua.match(/(iphone|iPad|iPod)/i)) return 'ios';
            if (ua.match(/mac os x/i)) return 'osx';
            if (ua.match(/android/i)) return 'android';
            if (ua.match(/windows phone/i)) return 'wp';
            if (ua.match(/windows/i)) return 'windows';
            if (ua.match(/linux/i)) return 'linux';
            if (ua.match(/meego/i)) return 'meego';
            return '';
        },


        get_browser = function () {
            if (ua.match(/msie/i)) return 'ie';
            if (ua.match(/chrome/i)) return 'chrome';
            if (ua.match(/b360/i)) return '360browser';
            if (ua.match(/uc/i)) return 'uc';
            if (ua.match(/opera/i)) return 'opera';
            if (ua.match(/qq/i)) return 'qq';
            if (ua.match(/firefox/i)) return 'firefox';
            if (ua.match(/flyflow/i)) return 'baidu';
            if (ua.match(/M0\d0/)) return 'meizu';
            if (ua.match(/safari/i)) return 'safari';
            return '';
        },


        get_engine = function () {
            if (ua.match(/webkit/i)) return 'webkit';
            if (ua.match(/trident/i)) return 'trident';
            if (ua.match(/netfront/i)) return 'netfront';
            return '';
        },

        get_device = function () {
            if (ua.match(/ipad/i)) return 'ipad';
            if (ua.match(/iphone/i)) return 'iphone';
            if (ua.match(/ipod/i)) return 'ipod';
            return '';
        },

        _get_width = function () {
            var w = window, d = document, e = d.documentElement, g = d.getElementsByTagName('body')[0],
                x = w.innerWidth || e.clientWidth || g.clientWidth;
            // y=w.innerHeight||e.clientHeight||g.clientHeight;
            return x;
        },

        get_width = function () {
            var orientation = window.orientation || 0,
                ratio = window.devicePixelRatio || 1,
                browser = get_browser(),
                os = get_os(), client_width;
            if (os == 'ios') {
                client_width = screen.width * ratio;
            } else if (os == 'android') {
                if (browser == 'uc') {
                    client_width = _get_width();
                } else if (browser == 'chrome') {
                    client_width = screen.width;
                } else {
                    if (['opera', 'firefox'].indexOf(browser) > -1) {
                        client_width = screen.width < screen.height ? screen.width : screen.height;
                    } else if (orientation == 0) {
                        client_width = screen.width;
                    } else if (orientation == 90 || orientation == -90) {
                        client_width = screen.height;
                    }
                }
            } else if (ua.match(/(Macintosh|Windows)/i) && !ua.match(/Windows Phone/i)) {
                client_width = _get_width() * ratio;
            } else {
                client_width = screen.width;
            }
            return client_width;
        },

        get_ratio = function () {
            return window.devicePixelRatio || 1;
        },

        get_type = function () {
            var is_mobile = ua.match(/(iphone|iPod|blackberry|htc|lg|midp|mmp|nokia|opera mini|palm|pocket|psp|sgh|smartphone|symbian|treo mini|Playstation Portable|SonyEricsson|Samsung|MobileExplorer|PalmSource|Benq|Windows phone|Windows Mobile|IEMobile|Windows CE|Nintendo Wii|Googlebot|Baiduspider)/i) || (ua.match(/android/i) && ua.match(/mobile|mobi/i));
            if (is_mobile) return 'mobile';
            var is_pad = ua.match(/(iPad|SCH-I800|xoom|kindle|tf101)/i) || (ua.match(/android/i) && !ua.match(/mobile|mobi/i));
            if (is_pad) return 'pad';
            var os = get_os();
            if (['windows', 'osx', 'linux'].indexOf(os) > -1) return 'pc';
            return '';
        };

    d.os = get_os();
    d.width = get_width();
    d.type = get_type();
    d.ratio = get_ratio();
    d.browser = get_browser();
    d.browser_engine = get_engine();
    d.device = get_device();
    var str;
    str = "os=" + d.os + "\n";
    str += "width=" + d.width + "\n";
    str += "type=" + d.type + "\n";
    str += "ratio=" + d.ratio + "\n";
    str += "browser=" + d.browser + "\n";
    str += "browser_engine=" + d.browser_engine + "\n";
    str += "device=" + d.device + "\n";
    str += "user_agent=" + d.user_agent;
    // alert(str);

    return d;

})(window.navigator.userAgent);

// 设置cookie
var set_cookie = function(name, value, days, domain){
    if(!days) days = 10;
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + days);
    exdate = exdate.toGMTString();
    cookie_str = name + '=' + value + ';';
    cookie_str += 'path=/';
    if(domain) cookie_str += ';domain=' + domain;
    cookie_str += ";expires=" + exdate;
    document.cookie = cookie_str;
};

set_cookie('ratio', DeviceInfo.ratio, 365);
set_cookie('width', DeviceInfo.width, 365);