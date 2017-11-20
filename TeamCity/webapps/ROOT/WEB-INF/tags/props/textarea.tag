<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"%>

<%@ attribute name="name" required="true"
%><%@ attribute name="textAreaName" required="true"
%><%@ attribute name="value" required="true"
%><%@ attribute name="linkTitle" required="true"
%><%@ attribute name="placeholder" required="false"
%><%@ attribute name="cols" required="true" type="java.lang.Integer"
%><%@ attribute name="rows" required="true" type="java.lang.Integer"
%><%@ attribute name="onkeydown" required="false"
%><%@ attribute name="style" required="false"
%><%@ attribute name="expanded" required="false" type="java.lang.Boolean"
%><%@ attribute name="disabled" required="false" type="java.lang.Boolean"
%><%@ attribute name="className" required="false"%>

<c:set var="imageId" value="image_${name}"/>
<c:set var="className" value="multilineProperty ${className}"/>

<div class="textarea" style="${style}">

  <c:if test="${fn:length(linkTitle) > 0 or empty expanded or !expanded}">
  <div>
    <a id="${name}_LinkContainer" href="#" onclick="BS.MultilineProperties.show('${name}', true); return false" showdiscardchangesmessage="false">${linkTitle}</a>
    <span id="${name}_NoteContainer" style="display:none;">${linkTitle}:</span>
  </div>
  </c:if>

  <div id="${name}_Container" style="display: none; position: relative;">
    <textarea id="${name}" ${disabled ? 'disabled="true"' : ""} wrap="off" style="resize: none;" name="${textAreaName}" rows="${rows}" cols="${cols}" <c:if test="${not empty onkeydown}">onkeydown="${onkeydown}"</c:if> <c:if test="${not empty className}">class="${className}"</c:if> <c:if test="${not empty placeholder}">placeholder="${placeholder}"</c:if>><c:out value='${value}'/></textarea>
    <img id="${name}_DragCorner" style="cursor: se-resize; position: absolute; display: none;" width="12" height="12" src="<c:url value='/img/windowResize.gif'/>" title="Drag to resize text area" border="0" data-no-retina/>
  </div>

  <div class="clr"></div>

  <script type="text/javascript">
    BS.MultilineProperties.init('${name}');
    <c:if test="${expanded or (empty expanded and fn:length(value) > 0)}">
    BS.MultilineProperties.setVisible('${name}', true);
    BS.MultilineProperties.updateVisible();
    </c:if>
  </script>
</div>
