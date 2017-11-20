<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="collapseAction" required="true" %>
<%@ attribute name="expandAction" required="true" %>
<%@ attribute name="type" required="false" %>
<c:choose>
  <c:when test="${type eq 'text'}">
    <a href="#" title="Collapse All" onclick="${collapseAction}">Collapse All</a>
    <span class="separator">|</span>
    <a href="#" title="Expand All" onclick="${expandAction}">Expand All</a>
  </c:when>
  <c:otherwise>
    <a class="btn btn_mini btn_icon" href="#" title="Collapse All" onclick="${collapseAction}" style="margin-right: 4px;"><span class="icon icon16 icon_collapse-all"></span></a>
    <a class="btn btn_mini btn_icon" href="#" title="Expand All" onclick="${expandAction}"><span class="icon icon16 icon_expand-all"></span></a>
  </c:otherwise>
</c:choose>
