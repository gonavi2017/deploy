(function() {
  var classNames = [ document.documentElement.className, 'ua-js' ];
  var ie = false;
  /*@cc_on
   ie = true;
   @if (@_jscript_version <= 10) classNames.push('ua-ie10-below') @end
   @if (@_jscript_version <= 9) classNames.push('ua-ie9-below') @end
   @if (@_jscript_version < 9) classNames.push('ua-ie8-below') @end
   @*/

  ie = ie || !!document.documentMode; // catch IE 11, escaped from conditional comments
  ie && classNames.push('ua-ie');

  var ua = window.navigator.userAgent.toLowerCase();

  if (ua.indexOf('mac') > -1) {
    classNames.push('ua-mac');
  } else if (ua.indexOf('windows') !== -1 && ua.indexOf('chrome') !== -1) {
    classNames.push('ua-win-chrome');
  }
  document.documentElement.className = classNames.join(' ');
})();
