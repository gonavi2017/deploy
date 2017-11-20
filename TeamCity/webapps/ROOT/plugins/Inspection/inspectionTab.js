var xOp7Up,xOp6Dn,xIE4Up,xIE4,xIE5,xNN4,xUA=navigator.userAgent.toLowerCase();if(window.opera){var i=xUA.indexOf('opera');if(i!=-1){var v=parseInt(xUA.charAt(i+6));xOp7Up=v>=7;xOp6Dn=v<7;}}else if(navigator.vendor!='KDE' && document.all && xUA.indexOf('msie')!=-1){xIE4Up=parseFloat(navigator.appVersion)>=4;xIE4=xUA.indexOf('msie 4')!=-1;xIE5=xUA.indexOf('msie 5')!=-1;}else if(document.layers){xNN4=true;}xMac=xUA.indexOf('mac')!=-1;function xBackground(e,c,i){if(!(e=xGetElementById(e))) return '';var bg='';if(e.style) {if(xStr(c)) {if(!xOp6Dn) e.style.backgroundColor=c;else e.style.background=c;}if(xStr(i)) e.style.backgroundImage=(i!='')? 'url('+i+')' : null;if(!xOp6Dn) bg=e.style.backgroundColor;else bg=e.style.background;}return bg;}function xClientHeight(){var h=0;if(xOp6Dn) h=window.innerHeight;else if(document.compatMode == 'CSS1Compat' && !window.opera && document.documentElement && document.documentElement.clientHeight)h=document.documentElement.clientHeight;else if(document.body && document.body.clientHeight)h=document.body.clientHeight;else if(xDef(window.innerWidth,window.innerHeight,document.width)) {h=window.innerHeight;if(document.width>window.innerWidth) h-=16;}return h;}function xClientWidth(){var w=0;if(xOp6Dn) w=window.innerWidth;else if(document.compatMode == 'CSS1Compat' && !window.opera && document.documentElement && document.documentElement.clientWidth)w=document.documentElement.clientWidth;else if(document.body && document.body.clientWidth)w=document.body.clientWidth;else if(xDef(window.innerWidth,window.innerHeight,document.height)) {w=window.innerWidth;if(document.height>window.innerHeight) w-=16;}return w;}function xClip(e,t,r,b,l){if(!(e=xGetElementById(e))) return;if(e.style) {if (xNum(l)) e.style.clip='rect('+t+'px '+r+'px '+b+'px '+l+'px)';else e.style.clip='rect(0 '+parseInt(e.style.width)+'px '+parseInt(e.style.height)+'px 0)';}}function xColor(e,s){if(!(e=xGetElementById(e))) return '';var c='';if(e.style && xDef(e.style.color)) {if(xStr(s)) e.style.color=s;c=e.style.color;}return c;}function xDef(){for(var i=0; i<arguments.length; ++i){if(typeof(arguments[i])=='undefined') return false;}return true;}function xDisplay(e,s){if(!(e=xGetElementById(e))) return null;if(e.style && xDef(e.style.display)) {if (xStr(s)) e.style.display = s;return e.style.display;}return null;}function xGetComputedStyle(oEle, sProp, bInt){var s, p = 'undefined';var dv = document.defaultView;if(dv && dv.getComputedStyle){s = dv.getComputedStyle(oEle,'');if (s) p = s.getPropertyValue(sProp);}else if(oEle.currentStyle) {var a = sProp.split('-');sProp = a[0];for (var i=1; i<a.length; ++i) {var c = a[i].charAt(0);sProp += a[i].replace(c, c.toUpperCase());}   p = oEle.currentStyle[sProp];}else return null;return bInt ? (parseInt(p) || 0) : p;}function xGetElementById(e){if(typeof(e)!='string') return e;if(document.getElementById) e=document.getElementById(e);else if(document.all) e=document.all[e];else e=null;return e;}function xHasPoint(e,x,y,t,r,b,l){if (!xNum(t)){t=r=b=l=0;}else if (!xNum(r)){r=b=l=t;}else if (!xNum(b)){l=r; b=t;}var eX = xPageX(e), eY = xPageY(e);return (x >= eX + l && x <= eX + xWidth(e) - r &&y >= eY + t && y <= eY + xHeight(e) - b );}function xHeight(e,h){if(!(e=xGetElementById(e))) return 0;if (xNum(h)) {if (h<0) h = 0;else h=Math.round(h);}else h=-1;var css=xDef(e.style);if (e == document || e.tagName.toLowerCase() == 'html' || e.tagName.toLowerCase() == 'body') {h = xClientHeight();}else if(css && xDef(e.offsetHeight) && xStr(e.style.height)) {if(h>=0) {var pt=0,pb=0,bt=0,bb=0;if (document.compatMode=='CSS1Compat') {var gcs = xGetComputedStyle;pt=gcs(e,'padding-top',1);if (pt !== null) {pb=gcs(e,'padding-bottom',1);bt=gcs(e,'border-top-width',1);bb=gcs(e,'border-bottom-width',1);}else if(xDef(e.offsetHeight,e.style.height)){e.style.height=h+'px';pt=e.offsetHeight-h;}}h-=(pt+pb+bt+bb);if(isNaN(h)||h<0) return;else e.style.height=h+'px';}h=e.offsetHeight;}else if(css && xDef(e.style.pixelHeight)) {if(h>=0) e.style.pixelHeight=h;h=e.style.pixelHeight;}return h;}function xHide(e){return xVisibility(e,0);}function xLeft(e, iX){if(!(e=xGetElementById(e))) return 0;var css=xDef(e.style);if (css && xStr(e.style.left)) {if(xNum(iX)) e.style.left=iX+'px';else {iX=parseInt(e.style.left);if(isNaN(iX)) iX=0;}}else if(css && xDef(e.style.pixelLeft)) {if(xNum(iX)) e.style.pixelLeft=iX;else iX=e.style.pixelLeft;}return iX;}function xMoveTo(e,x,y){xLeft(e,x);xTop(e,y);}function xNum(){for(var i=0; i<arguments.length; ++i){if(isNaN(arguments[i]) || typeof(arguments[i])!='number') return false;}return true;}function xOffsetLeft(e){if (!(e=xGetElementById(e))) return 0;if (xDef(e.offsetLeft)) return e.offsetLeft;else return 0;}function xOffsetTop(e){if (!(e=xGetElementById(e))) return 0;if (xDef(e.offsetTop)) return e.offsetTop;else return 0;}function xPageX(e){if (!(e=xGetElementById(e))) return 0;var x = 0;while (e) {if (xDef(e.offsetLeft)) x += e.offsetLeft;e = xDef(e.offsetParent) ? e.offsetParent : null;}return x;}function xPageY(e){if (!(e=xGetElementById(e))) return 0;var y = 0;while (e) {if (xDef(e.offsetTop)) y += e.offsetTop;e = xDef(e.offsetParent) ? e.offsetParent : null;}return y;}function xParent(e, bNode){if (!(e=xGetElementById(e))) return null;var p=null;if (!bNode && xDef(e.offsetParent)) p=e.offsetParent;else if (xDef(e.parentNode)) p=e.parentNode;else if (xDef(e.parentElement)) p=e.parentElement;return p;}function xResizeTo(e,w,h){xWidth(e,w);xHeight(e,h);}function xScrollLeft(e, bWin){var offset=0;if (!xDef(e) || bWin || e == document || e.tagName.toLowerCase() == 'html' || e.tagName.toLowerCase() == 'body') {var w = window;if (bWin && e) w = e;if(w.document.documentElement && w.document.documentElement.scrollLeft) offset=w.document.documentElement.scrollLeft;else if(w.document.body && xDef(w.document.body.scrollLeft)) offset=w.document.body.scrollLeft;}else {e = xGetElementById(e);if (e && xNum(e.scrollLeft)) offset = e.scrollLeft;}return offset;}function xScrollTop(e, bWin){var offset=0;if (!xDef(e) || bWin || e == document || e.tagName.toLowerCase() == 'html' || e.tagName.toLowerCase() == 'body') {var w = window;if (bWin && e) w = e;if(w.document.documentElement && w.document.documentElement.scrollTop) offset=w.document.documentElement.scrollTop;else if(w.document.body && xDef(w.document.body.scrollTop)) offset=w.document.body.scrollTop;}else {e = xGetElementById(e);if (e && xNum(e.scrollTop)) offset = e.scrollTop;}return offset;}function xShow(e) {return xVisibility(e,1);}function xStr(s){for(var i=0; i<arguments.length; ++i){if(typeof(arguments[i])!='string') return false;}return true;}function xTop(e, iY){if(!(e=xGetElementById(e))) return 0;var css=xDef(e.style);if(css && xStr(e.style.top)) {if(xNum(iY)) e.style.top=iY+'px';else {iY=parseInt(e.style.top);if(isNaN(iY)) iY=0;}}else if(css && xDef(e.style.pixelTop)) {if(xNum(iY)) e.style.pixelTop=iY;else iY=e.style.pixelTop;}return iY;}function xVisibility(e, bShow){if(!(e=xGetElementById(e))) return null;if(e.style && xDef(e.style.visibility)) {if (xDef(bShow)) e.style.visibility = bShow ? 'visible' : 'hidden';return e.style.visibility;}return null;}function xWidth(e,w){if(!(e=xGetElementById(e))) return 0;if (xNum(w)) {if (w<0) w = 0;else w=Math.round(w);}else w=-1;var css=xDef(e.style);if (e == document || e.tagName.toLowerCase() == 'html' || e.tagName.toLowerCase() == 'body') {w = xClientWidth();}else if(css && xDef(e.offsetWidth) && xStr(e.style.width)) {if(w>=0) {var pl=0,pr=0,bl=0,br=0;if (document.compatMode=='CSS1Compat') {var gcs = xGetComputedStyle;pl=gcs(e,'padding-left',1);if (pl !== null) {pr=gcs(e,'padding-right',1);bl=gcs(e,'border-left-width',1);br=gcs(e,'border-right-width',1);}else if(xDef(e.offsetWidth,e.style.width)){e.style.width=w+'px';pl=e.offsetWidth-w;}}w-=(pl+pr+bl+br);if(isNaN(w)||w<0) return;else e.style.width=w+'px';}w=e.offsetWidth;}else if(css && xDef(e.style.pixelWidth)) {if(w>=0) e.style.pixelWidth=w;w=e.style.pixelWidth;}return w;}function xZIndex(e,uZ){if(!(e=xGetElementById(e))) return 0;if(e.style && xDef(e.style.zIndex)) {if(xNum(uZ)) e.style.zIndex=uZ;uZ=parseInt(e.style.zIndex);}return uZ;}

var TrimPath;
(function() {
    if (TrimPath == null)
        TrimPath = new Object();
    if (TrimPath.evalEx == null)
        TrimPath.evalEx = function(src) { return eval(src); };
    var UNDEFINED;
    if (Array.prototype.pop == null)
        Array.prototype.pop = function() {
            if (this.length === 0) {return UNDEFINED;}
            return this[--this.length];
        };
    if (Array.prototype.push == null)
        Array.prototype.push = function() {
            for (var i = 0; i < arguments.length; ++i) {this[this.length] = arguments[i];};
            return this.length;
        };
    TrimPath.parseTemplate = function(tmplContent, optTmplName, optEtc) {
        if (optEtc == null)
            optEtc = TrimPath.parseTemplate_etc;
        var funcSrc = parse(tmplContent, optTmplName, optEtc);
        var func = TrimPath.evalEx(funcSrc, optTmplName, 1);
        if (func != null)
            return new optEtc.Template(optTmplName, tmplContent, funcSrc, func, optEtc);
        return null;
    };
    try {
        String.prototype.process = function(context, optFlags) {
            var template = TrimPath.parseTemplate(this, null);
            if (template != null)
                return template.process(context, optFlags);
            return this;
        }
    } catch (e) {
    };
    TrimPath.parseTemplate_etc = {};
    TrimPath.parseTemplate_etc.statementTag = "forelse|for|if|elseif|else|var|macro";
    TrimPath.parseTemplate_etc.statementDef = {
        "if"     : { delta:  1, prefix: "if (", suffix: ") {", paramMin: 1 },
        "else"   : { delta:  0, prefix: "} else {" },
        "elseif" : { delta:  0, prefix: "} else if (", suffix: ") {", paramDefault: "true" },
        "/if"    : { delta: -1, prefix: "}" },
        "for"    : { delta:  1, paramMin: 3,
                     prefixFunc: function(stmtParts, state, tmplName, etc) {
                        if (stmtParts[2] != "in")
                            throw new etc.ParseError(tmplName, state.line, "bad for loop statement: " + stmtParts.join(' '));
                        var iterVar = stmtParts[1];
                        var listVar = "__LIST__" + iterVar;
                        return [ "var ", listVar, " = ", stmtParts[3], ";",
                             "var __LENGTH_STACK__;",
                             "if (typeof(__LENGTH_STACK__) == 'undefined' || !__LENGTH_STACK__.length) __LENGTH_STACK__ = new Array();",
                             "__LENGTH_STACK__[__LENGTH_STACK__.length] = 0;",
                             "if ((", listVar, ") != null) { ",
                             "var ", iterVar, "_ct = 0;",
                             "for (var ", iterVar, "_index in ", listVar, ") { ",
                             iterVar, "_ct++;",
                             "if (typeof(", listVar, "[", iterVar, "_index]) == 'function') {continue;}",
                             "__LENGTH_STACK__[__LENGTH_STACK__.length - 1]++;",
                             "var ", iterVar, " = ", listVar, "[", iterVar, "_index];" ].join("");
                     } },
        "forelse" : { delta:  0, prefix: "} } if (__LENGTH_STACK__[__LENGTH_STACK__.length - 1] == 0) { if (", suffix: ") {", paramDefault: "true" },
        "/for"    : { delta: -1, prefix: "} }; delete __LENGTH_STACK__[__LENGTH_STACK__.length - 1];" },
        "var"     : { delta:  0, prefix: "var ", suffix: ";" },
        "macro"   : { delta:  1,
                      prefixFunc: function(stmtParts, state, tmplName, etc) {
                          var macroName = stmtParts[1].split('(')[0];
                          return [ "var ", macroName, " = function",
                                   stmtParts.slice(1).join(' ').substring(macroName.length),
                                   "{ var _OUT_arr = []; var _OUT = { write: function(m) { if (m) _OUT_arr.push(m); } }; " ].join('');
                     } },
        "/macro"  : { delta: -1, prefix: " return _OUT_arr.join(''); };" }
    };
    TrimPath.parseTemplate_etc.modifierDef = {
        "eat"       : function(v)    { return ""; },
        "escape"    : function(s)    { return String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;"); },
        "capitalize": function(s)    { return String(s).toUpperCase(); },
        "default"   : function(s, d) { return s != null ? s : d; }
    };
    TrimPath.parseTemplate_etc.modifierDef.h = TrimPath.parseTemplate_etc.modifierDef.escape;
    TrimPath.parseTemplate_etc.Template = function(tmplName, tmplContent, funcSrc, func, etc) {
        this.process = function(context, flags) {
            if (context == null)
                context = {};
            if (context._MODIFIERS == null)
                context._MODIFIERS = {};
            if (context.defined == null)
                context.defined = function(str) { return (context[str] != undefined); };
            for (var k in etc.modifierDef) {
                if (context._MODIFIERS[k] == null)
                    context._MODIFIERS[k] = etc.modifierDef[k];
            };
            if (flags == null)
                flags = {};
            var resultArr = [];
            var resultOut = { write: function(m) { resultArr.push(m); } };
            try {
                func(resultOut, context, flags);
            } catch (e) {
                if (flags.throwExceptions)
                    throw e;
                var result = new String(resultArr.join("") + "[ERROR: " + e.toString() + (e.message ? '; ' + e.message : '') + "]");
                result["exception"] = e;
                return result;
            };
            return resultArr.join("");
        };
        this.name       = tmplName;
        this.source     = tmplContent;
        this.sourceFunc = funcSrc;
        this.toString   = function() { return "TrimPath.Template [" + tmplName + "]"; }
    };
    TrimPath.parseTemplate_etc.ParseError = function(name, line, message) {
        this.name    = name;
        this.line    = line;
        this.message = message;
    };
    TrimPath.parseTemplate_etc.ParseError.prototype.toString = function() {
        return ("TrimPath template ParseError in " + this.name + ": line " + this.line + ", " + this.message);
    };
    var parse = function(body, tmplName, etc) {
        body = cleanWhiteSpace(body);
        var funcText = [ "var TrimPath_Template_TEMP = function(_OUT, _CONTEXT, _FLAGS) { with (_CONTEXT) {" ];
        var state    = { stack: [], line: 1 };
        var endStmtPrev = -1;
        while (endStmtPrev + 1 < body.length) {
            var begStmt = endStmtPrev;
            begStmt = body.indexOf("{", begStmt + 1);
            while (begStmt >= 0) {
                var endStmt = body.indexOf('}', begStmt + 1);
                var stmt = body.substring(begStmt, endStmt);
                var blockrx = stmt.match(/^\{(cdata|minify|eval)/);
                if (blockrx) {
                    var blockType = blockrx[1];
                    var blockMarkerBeg = begStmt + blockType.length + 1;
                    var blockMarkerEnd = body.indexOf('}', blockMarkerBeg);
                    if (blockMarkerEnd >= 0) {
                        var blockMarker;
                        if( blockMarkerEnd - blockMarkerBeg <= 0 ) {
                            blockMarker = "{/" + blockType + "}";
                        } else {
                            blockMarker = body.substring(blockMarkerBeg + 1, blockMarkerEnd);
                        };

                        var blockEnd = body.indexOf(blockMarker, blockMarkerEnd + 1);
                        if (blockEnd >= 0) {
                            emitSectionText(body.substring(endStmtPrev + 1, begStmt), funcText);

                            var blockText = body.substring(blockMarkerEnd + 1, blockEnd);
                            if (blockType == 'cdata') {
                                emitText(blockText, funcText);
                            } else if (blockType == 'minify') {
                                emitText(scrubWhiteSpace(blockText), funcText);
                            } else if (blockType == 'eval') {
                                if (blockText != null && blockText.length > 0)
                                    funcText.push('_OUT.write( (function() { ' + blockText + ' })() );');
                            };
                            begStmt = endStmtPrev = blockEnd + blockMarker.length - 1;
                        }
                    }
                } else if (body.charAt(begStmt - 1) != '$' &&
                           body.charAt(begStmt - 1) != '\\') {
                    var offset = (body.charAt(begStmt + 1) == '/' ? 2 : 1);

                    if (body.substring(begStmt + offset, begStmt + 10 + offset).search(TrimPath.parseTemplate_etc.statementTag) == 0)
                        break;
                };
                begStmt = body.indexOf("{", begStmt + 1);
            };
            if (begStmt < 0)
                break;
            var endStmt = body.indexOf("}", begStmt + 1);
            if (endStmt < 0)
                break;
            emitSectionText(body.substring(endStmtPrev + 1, begStmt), funcText);
            emitStatement(body.substring(begStmt, endStmt + 1), state, funcText, tmplName, etc);
            endStmtPrev = endStmt;
        };
        emitSectionText(body.substring(endStmtPrev + 1), funcText);
        if (state.stack.length != 0)
            throw new etc.ParseError(tmplName, state.line, "unclosed, unmatched statement(s): " + state.stack.join(","));
        funcText.push("}}; TrimPath_Template_TEMP");
        return funcText.join("");
    };
    var emitStatement = function(stmtStr, state, funcText, tmplName, etc) {
        var parts = stmtStr.slice(1, -1).split(' ');
        var stmt = etc.statementDef[parts[0]];
        if (stmt == null) {
            emitSectionText(stmtStr, funcText);
            return;
        };
        if (stmt.delta < 0) {
            if (state.stack.length <= 0)
                throw new etc.ParseError(tmplName, state.line, "close tag does not match any previous statement: " + stmtStr);
            state.stack.pop();
        };
        if (stmt.delta > 0)
            state.stack.push(stmtStr);

        if (stmt.paramMin != null &&
            stmt.paramMin >= parts.length)
            throw new etc.ParseError(tmplName, state.line, "statement needs more parameters: " + stmtStr);
        if (stmt.prefixFunc != null)
            funcText.push(stmt.prefixFunc(parts, state, tmplName, etc));
        else
            funcText.push(stmt.prefix);
        if (stmt.suffix != null) {
            if (parts.length <= 1) {
                if (stmt.paramDefault != null)
                    funcText.push(stmt.paramDefault);
            } else {
                for (var i = 1; i < parts.length; i++) {
                    if (i > 1)
                        funcText.push(' ');
                    funcText.push(parts[i]);
                }
            };
            funcText.push(stmt.suffix);
        }
    };
    var emitSectionText = function(text, funcText) {
        if (text.length <= 0)
            return;
        var nlPrefix = 0;
        var nlSuffix = text.length - 1;
        while (nlPrefix < text.length && (text.charAt(nlPrefix) == '\n'))
            nlPrefix++;
        while (nlSuffix >= 0 && (text.charAt(nlSuffix) == ' ' || text.charAt(nlSuffix) == '\t'))
            nlSuffix--;
        if (nlSuffix < nlPrefix)
            nlSuffix = nlPrefix;
        if (nlPrefix > 0) {
            funcText.push('if (_FLAGS.keepWhitespace == true) _OUT.write("');
            var s = text.substring(0, nlPrefix).replace('\n', '\\n');
            if (s.charAt(s.length - 1) == '\n')
              s = s.substring(0, s.length - 1);
            funcText.push(s);
            funcText.push('");');
        };
        var lines = text.substring(nlPrefix, nlSuffix + 1).split('\n');
        for (var i = 0; i < lines.length; i++) {
            emitSectionTextLine(lines[i], funcText);
            if (i < lines.length - 1)
                funcText.push('_OUT.write("\\n");\n');
        };
        if (nlSuffix + 1 < text.length) {
            funcText.push('if (_FLAGS.keepWhitespace == true) _OUT.write("');
            var s = text.substring(nlSuffix + 1).replace('\n', '\\n');
            if (s.charAt(s.length - 1) == '\n')
              s = s.substring(0, s.length - 1);
            funcText.push(s);
            funcText.push('");');
        };
    };
    var emitSectionTextLine = function(line, funcText) {
        var endMarkPrev = '}';
        var endExprPrev = -1;
        while (endExprPrev + endMarkPrev.length < line.length) {
            var begMark = "${", endMark = "}";
            var endMark;
            var begExpr = line.indexOf(begMark, endExprPrev + endMarkPrev.length);
            if (begExpr < 0)
                break;
            if (line.charAt(begExpr + 2) == '%') {
                begMark = "${%";
                endMark = "%}";
            };
            var endExpr = line.indexOf(endMark, begExpr + begMark.length);
            if (endExpr < 0)
                break;
            emitText(line.substring(endExprPrev + endMarkPrev.length, begExpr), funcText);
            var exprArr = line.substring(begExpr + begMark.length, endExpr).replace(/\|\|/g, "#@@#").split('|');
            for (var k in exprArr) {
                if (exprArr[k].replace)
                    exprArr[k] = exprArr[k].replace(/#@@#/g, '||');
            };
            funcText.push('_OUT.write(');
            emitExpression(exprArr, exprArr.length - 1, funcText);
            funcText.push(');');
            endExprPrev = endExpr;
            endMarkPrev = endMark;
        };
        emitText(line.substring(endExprPrev + endMarkPrev.length), funcText);
    };
    var emitText = function(text, funcText) {
        if (text == null ||
            text.length <= 0)
            return;
        text = text.replace(/\\/g, '\\\\');
        text = text.replace(/\n/g, '\\n');
        text = text.replace(/"/g,  '\\"');
        funcText.push('_OUT.write("');
        funcText.push(text);
        funcText.push('");');
    };
    var emitExpression = function(exprArr, index, funcText) {
        var expr = exprArr[index];
        if (index <= 0) {
            funcText.push(expr);
            return;
        };
        var parts = expr.split(':');
        funcText.push('_MODIFIERS["');
        funcText.push(parts[0]);
        funcText.push('"](');
        emitExpression(exprArr, index - 1, funcText);
        if (parts.length > 1) {
            funcText.push(',');
            funcText.push(parts[1]);
        };
        funcText.push(')');
    };
    var cleanWhiteSpace = function(result) {
        result = result.replace(/\t/g,   "    ");
        result = result.replace(/\r\n/g, "\n");
        result = result.replace(/\r/g,   "\n");
        result = result.replace(/^(\s*\S*(\s+\S+)*)\s*$/, '$1');
        return result;
    };
    var scrubWhiteSpace = function(result) {
        result = result.replace(/^\s+/g,   "");
        result = result.replace(/\s+$/g,   "");
        result = result.replace(/\s+/g,   " ");
        result = result.replace(/^(\s*\S*(\s+\S+)*)\s*$/, '$1');
        return result;
    };
    TrimPath.parseDOMTemplate = function(elementId, optDocument, optEtc) {
        if (optDocument == null)
            optDocument = document;
        var element = optDocument.getElementById(elementId);
        var content = element.value;
        if (content == null)
            content = element.innerHTML;
        content = content.replace(/&lt;/g, "<").replace(/&gt;/g, ">");
        return TrimPath.parseTemplate(content, elementId, optEtc);
    };
    TrimPath.processDOMTemplate = function(elementId, context, optFlags, optDocument, optEtc) {
        return TrimPath.parseDOMTemplate(elementId, optDocument, optEtc).process(context, optFlags);
    }
}) ();

