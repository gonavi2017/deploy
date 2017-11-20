<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="text"
  %><%@ attribute name="style"
  %><c:if test="${not empty text}"
  ><% String id = "commentHover_" + text.hashCode();
  %><div class="icon icon16 commentIcon" <c:if test="${not empty style}">style="${style}" </c:if> <bs:tooltipAttrs containerId="<%=id%>" withOnClick="true"/>></div> <div id="<%=id%>" class="hidden">${text}</div></c:if>