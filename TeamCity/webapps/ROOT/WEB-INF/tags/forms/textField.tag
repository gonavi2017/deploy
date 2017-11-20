<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="name" required="true" %><%@
    attribute name="id" required="false" %><%@
    attribute name="value" required="false" %><%--
    use 'disableBuildTypeParams' class to avoid parameter autocompletion popup attachment --%><%@
    attribute name="className" required="false" %><%@
    attribute name="style" required="false" %><%@
    attribute name="size" required="false" type="java.lang.Integer"%><%@
    attribute name="maxlength" required="false" type="java.lang.Integer"%><%@
    attribute name="disabled" required="false" type="java.lang.Boolean"%><%@
    attribute name="onclick" required="false"%><%@
    attribute name="onkeyup" required="false"%><%@
    attribute name="onchange" required="false"%><%@
    attribute name="onfocus" required="false"%><%@
    attribute name="minheight" type="java.lang.Integer" required="false"%><%@
    attribute name="maxheight" type="java.lang.Integer" required="false"%><%@
    attribute name="expandable" required="false" type="java.lang.Boolean" %><%@
    attribute name="readonly" required="false" type="java.lang.Boolean" %><%@
    attribute name="noAutoComplete" required="false" type="java.lang.Boolean"%><%@
    attribute name="defaultText" required="false"

%><c:set var="className" value="${fn:length(className) == 0 ? 'textField' : className}"
/><c:set var="showDefault" value="${fn:length(value) == 0 and fn:length(defaultText) > 0}"
/><c:set var="valueToSet" value="${showDefault ? defaultText : value}"
/><c:set var="onclickAttr"><c:if test="${showDefault or fn:length(onclick) > 0}">onclick="<c:if test="${showDefault}">if (this.value == '${defaultText}') this.value = '';</c:if> ${onclick}"</c:if></c:set
 ><c:set var="onchangeAttr"><c:if test="${not empty onchange}">onchange="${onchange}"</c:if></c:set
 ><c:set var="onfocusAttr"><c:if test="${not empty onfocus}">onfocus="${onfocus}"</c:if></c:set
 ><c:set var="onkeyupAttr"><c:if test="${not empty onkeyup}">onkeyup="${onkeyup}"</c:if></c:set
 ><c:set var="autocomplete"><c:if test="${not empty noAutoComplete}">autocomplete="off"</c:if></c:set
 ><c:set var="readonlyAttr"><c:if test="${not empty readonly}">readonly="readonly"</c:if></c:set
 ><c:set var="id" value="${empty id ? name : id}"

/><c:choose
><c:when test="${not expandable}"><input type="text" name="${name}" id="${id}" <c:if test="${size > 0}">size="${size}"</c:if> <c:if test="${maxlength > 0}">maxlength="${maxlength}"</c:if> value="<c:out value="${valueToSet}"/>" class="${className}" <c:if test="${not empty style}"> style="${style}"</c:if> <c:if test="${disabled}">disabled</c:if> ${onclickAttr} ${onchangeAttr} ${onfocusAttr} ${autocomplete} ${onkeyupAttr} ${readonlyAttr}></c:when
><c:otherwise><textarea style="resize: both; ${style}" class="expandable ${className}" name="${name}" id="${id}" <c:if test="${disabled}">disabled</c:if> ${onclickAttr} ${onchangeAttr} ${onfocusAttr} ${onkeyupAttr} ${autocomplete}><c:out value="${valueToSet}"/></textarea>
<script type="text/javascript">
  (function() {
    var id = '${id}';
    BS.VisibilityHandlers.detachFrom(id);
    BS.VisibilityHandlers.attachTo(id, {
      updateVisibility: function() {
        var element = $j(BS.Util.escapeId(id));
        if (element.length) {
          element.textAreaExpander(${minheight == null ? '0' : minheight}, ${maxheight == null ? '200' : maxheight}, 'updateVisibility');
        } else {
          BS.VisibilityHandlers.detachFrom(id);
        }
      }
    });
  })();
</script></c:otherwise></c:choose>
