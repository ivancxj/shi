//底层方法
//fast_button
MI = {};
MI.clickbuster = {};
MI.fast_button = function(element, handler, capture) {
  this.element = element;
  this.handler = handler;
  this.capture = capture || false;
  this.hasTouch = 'ontouchstart' in window;
  this.hasTouch ? element.addEventListener('touchstart', this, this.capture) : element.addEventListener('click', this, this.capture);
};

MI.fast_button.prototype.remove = function(){
  this.hasTouch ? this.element.removeEventListener('touchstart', this, this.capture) : this.element.removeEventListener('click', this, this.capture);
};


MI.fast_button.prototype.handleEvent = function(event) {

  switch (event.type) {
    case 'touchstart': this.onTouchStart(event); break;
    case 'touchmove': this.onTouchMove(event); break;
    case 'touchend': this.onClick(event); break;
    case 'click': this.onClick(event); break;
  }
};
MI.fast_button.prototype.onTouchStart = function(event) {

  this.element.addEventListener('touchend', this, this.capture);
  document.body.addEventListener('touchmove', this, this.capture);

  this.startX = event.touches[0].clientX;
  this.startY = event.touches[0].clientY;
};

MI.fast_button.prototype.onTouchMove = function(event) {
  if (Math.abs(event.touches[0].clientX - this.startX) > 10 ||
      Math.abs(event.touches[0].clientY - this.startY) > 10) {
    this.reset();
  }
};

MI.fast_button.prototype.onClick = function(event) {
  event.stopPropagation();
  this.reset();
  this.handler(event);

  if (event.type == 'touchend') {
    MI.clickbuster.preventGhostClick(this.startX, this.startY);
  }
};

MI.fast_button.prototype.reset = function() {
  this.element.removeEventListener('touchend', this, this.capture);
  document.body.removeEventListener('touchmove', this, this.capture);
};
MI.clickbuster.preventGhostClick = function(x, y) {
  MI.clickbuster.coordinates.push(x, y);
  window.setTimeout(MI.clickbuster.pop, 2500);
};

MI.clickbuster.pop = function() {
  MI.clickbuster.coordinates.splice(0, 2);
};
MI.clickbuster.onClick = function(event) {
  for (var i = 0; i < MI.clickbuster.coordinates.length; i += 2) {
    var x = MI.clickbuster.coordinates[i];
    var y = MI.clickbuster.coordinates[i + 1];
    if (Math.abs(event.clientX - x) < 25 && Math.abs(event.clientY - y) < 25) {
      event.stopPropagation();
      event.preventDefault();
    }
  }
};

document.addEventListener('click', MI.clickbuster.onClick, true);

MI.clickbuster.coordinates = [];

//itap事件扩展
$.event.special.itap = {
  setup: function(){
    var elem = this;
    this.evnt = new MI.fast_button(elem, function(e){
      e.preventDefault();
      e.stopPropagation();
      $(elem).trigger('itap');
    });
  },

  teardown: function(){
    if(this.evnt){this.evnt.remove();}
  }
};

$.fn.itap = function(callback){
  return this.bind('itap', callback);
};
