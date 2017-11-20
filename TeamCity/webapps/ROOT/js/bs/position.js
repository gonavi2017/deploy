/**
 *
 * Note: this is based on Yahoo's getXY method, which is
 * Copyright (c) 2006, Yahoo! Inc.
 * All rights reserved.
 *
 * Redistribution and use of this software in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above
 *   copyright notice, this list of conditions and the
 *   following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above
 *   copyright notice, this list of conditions and the
 *   following disclaimer in the documentation and/or other
 *   materials provided with the distribution.
 *
 * * Neither the name of Yahoo! Inc. nor the names of its
 *   contributors may be used to endorse or promote products
 *   derived from this software without specific prior
 *   written permission of Yahoo! Inc.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *
 *
 * Explanation of the code:
 * http://code.google.com/p/doctype/wiki/ArticlePageOffset
 *
 * @deprecated
 */
BS.getPosition = function(el) {
  el = $(el);
  var doc = el.ownerDocument;

  // Gecko browsers normally use getBoxObjectFor to calculate the position.
  // When invoked for an element with an implicit absolute position though it
  // can be off by one. Therefor the recursive implementation is used in those
  // (relatively rare) cases.
  var BUGGY_GECKO_BOX_OBJECT = BS.Browser.mozilla && doc.getBoxObjectFor &&
                               el.getStyle('position') == 'absolute' &&
                               (el.style.top == '' || el.style.left == '');

  // NOTE: If element is hidden (display none or disconnected or any the
  // ancestors are hidden) we get (0,0) by default but we still do the
  // accumulation of scroll position.

  var pos = [];

  var parent = null;
  var box;

  var scroll = document.viewport.getScrollOffsets();
  var viewportElement = document.documentElement || document.body;

  if (el.getBoundingClientRect) { // IE
    box = el.getBoundingClientRect();
    var scrollTop = scroll.top;
    var scrollLeft = scroll.left;

    pos.x = box.left + scrollLeft;
    pos.y = box.top + scrollTop;

  } else if (doc.getBoxObjectFor && !BUGGY_GECKO_BOX_OBJECT) { // gecko
    // Gecko ignores the scroll values for ancestors, up to 1.9.  See:
    // https://bugzilla.mozilla.org/show_bug.cgi?id=328881 and
    // https://bugzilla.mozilla.org/show_bug.cgi?id=330619

    box = doc.getBoxObjectFor(el);
    var vpBox = doc.getBoxObjectFor(viewportElement);
    pos.x = box.screenX - vpBox.screenX;
    pos.y = box.screenY - vpBox.screenY;

  } else { // safari/opera
    pos.x = el.offsetLeft;
    pos.y = el.offsetTop;
    parent = el.offsetParent;
    if (parent != el) {
      while (parent) {
        pos.x += parent.offsetLeft;
        pos.y += parent.offsetTop;
        parent = parent.offsetParent;
      }
    }

    // opera & (safari absolute) incorrectly account for body offsetTop
    if (BS.Browser.opera || (BS.Browser.webkit && el.getStyle('position') == 'absolute')) {
      pos.y -= doc.body.offsetTop;
    }

    // accumulate the scroll positions for everything but the body element
    parent = el.offsetParent;
    while (parent && parent != doc.body) {
      pos.x -= parent.scrollLeft;
      // see https://bugs.opera.com/show_bug.cgi?id=249965
      if (!BS.Browser.opera || parent.tagName != 'TR') {
        pos.y -= parent.scrollTop;
      }
      parent = parent.offsetParent;
    }
  }

  var res = [pos.x, pos.y];
  res.left = pos.x;
  res.top = pos.y;

  return res;
};