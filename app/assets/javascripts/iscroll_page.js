/**
 * Created with JetBrains WebStorm.
 * User: robin
 * Date: 13-7-22
 * Time: PM2:30
 * To change this template use File | Settings | File Templates.
 */



var myScroll, pullDownEl, pullDownOffset, pullUpEl, pullUpOffset;
function pullDownAction() {

    var index =idss.indexOf(current_id);

    $.getJSON('/home/next.json?id='+idss[index-1], function(data) {
        myScroll.refresh();
        current_id = data.id
        var albums = data.goods_albums;
        var sale_price = data.sale_price;
        var old_price = data.old_price;
        var photo_pic = data.shop.photo;
        var photos = [];
        photos.push(data.detail_photo);
        for(var i=0; i<albums.length; i++){
            var photo = albums[i].photo;
            photos.push(photo);
        }
        var albums = $('#albums');
        var albums_str = "";
        var active_str = '<li class="active"></li>';
        for (var i = 0; i < photos.length; i++) {
            var obj = photos[i];
            albums_str += ' <a class="slide_a slide_width slide_height"><img class="slide_width slide_height" src="'+obj+'"></a>';
            if(i < photos.length-1){
                active_str += ' <li></li>';
            }
        }
        albums.html(albums_str);
        $('#active_slide').html(active_str);
        $('#sale_price').text("MM价:" + sale_price);
        if(old_price == null) {
            $('#old_price').text("");
        }else{
        $('#old_price').text("原价:" + old_price);
        }
        $('#photo_pic').attr("src", photo_pic);
    });
}

function pullUpAction() {
    var index =idss.indexOf(current_id);

    $.getJSON('/home/next.json?id='+idss[index+1], function(data) {
        myScroll.refresh();
        current_id = data.id
        var albums = data.goods_albums;
        var sale_price = data.sale_price;
        var old_price = data.old_price;
        var photo_pic = data.shop.photo;
        var photos = [];
        photos.push(data.detail_photo);
        for(var i=0; i<albums.length; i++){
            var photo = albums[i].photo;
            photos.push(photo);
        }
        var albums = $('#albums');
        var albums_str = "";
        var active_str = '<li class="active"></li>';
        for (var i = 0; i < photos.length; i++) {
            var obj = photos[i];
            albums_str += ' <a class="slide_a slide_width slide_height"><img class="slide_width slide_height" src="'+obj+'"></a>';
            if(i < photos.length-1){
                active_str += ' <li></li>';
            }
        }
        albums.html(albums_str);
        $('#active_slide').html(active_str);
        $('#sale_price').text("MM价:" + sale_price);
        if(old_price == null) {
            $('#old_price').text("");
        }else{
            $('#old_price').text("原价:" + old_price);
        }


        $('#photo_pic').attr("src", photo_pic);
    });
}

function getData(){

}

function loaded() {
    pullDownEl = document.getElementById('pullDown');
    pullDownOffset = pullDownEl.offsetHeight;
    pullUpEl = document.getElementById('pullUp');
    pullUpOffset = pullUpEl.offsetHeight;
    myScroll = new iScroll("wrapper",
        {
            hScrollbar: false,
            vScrollbar: false,
            topOffset: pullDownOffset,
            onBeforeScrollStart: function ( e ) {
                if ( this.absDistX > (this.absDistY + 5 ) ) {
                    // user is scrolling the x axis, so prevent the browsers' native scrolling
                    e.preventDefault();
                }
            },
            //解决第一次无法滑动的问题
            onTouchEnd: function () {
                var self = this;
                if (self.touchEndTimeId) {
                    clearTimeout(self.touchEndTimeId);
                }
                self.touchEndTimeId = setTimeout(function () {
                    self.absDistX = 0;
                    self.absDistY = 0;
                }, 600);
            },
            onRefresh: function () {
                if (pullDownEl.className.match('loading')) {
                    pullDownEl.className = '';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新';
                } else if (pullUpEl.className.match('loading')) {
                    pullUpEl.className = '';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉刷新';
                }
            },
            onScrollMove: function () {
                if (this.y > 5 && !pullDownEl.className.match('flip')) {
                    pullDownEl.className = 'flip';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '松手加载';
                    this.minScrollY = 0;
                } else if (this.y < 5 && pullDownEl.className.match('flip')) {
                    pullDownEl.className = '';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '松手加载上一页';
                    this.minScrollY = -pullDownOffset;
                } else if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
                    pullUpEl.className = 'flip';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '松手加载';
                    this.maxScrollY = this.maxScrollY;
                } else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
                    pullUpEl.className = '';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '松手加载下一页';
                    this.maxScrollY = pullUpOffset;
                }
            },
            onScrollEnd: function () {
                if (pullDownEl.className.match('flip')) {
                    pullDownEl.className = 'loading';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '加载中...';
                    pullDownAction();	// Execute custom function (ajax call?)
                } else if (pullUpEl.className.match('flip')) {
                    pullUpEl.className = 'loading';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载中...';
                    pullUpAction();	// Execute custom function (ajax call?)
                }
            }}
    );
}

document.addEventListener('touchmove', function (e) {
    e.preventDefault();
}, false);

document.addEventListener('DOMContentLoaded', function () {
    setTimeout(loaded, 200);
}, false);
