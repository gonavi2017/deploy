<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %><%@
    attribute name="extensions" type="java.util.Map"%><%@
    attribute name="selectedExtension" type="jetbrains.buildServer.web.openapi.PageExtension"%><%@
    attribute name="urlPrefix" type="java.lang.String"

%><c:forEach items="${extensions}" var="entry">
  <div class="category">${entry.key}</div>
  <c:forEach items="${entry.value}" var="ext">
    <div class="item${ext == selectedExtension ? ' active' : ''}">
      <c:url var="url" value="${urlPrefix}?item=${ext.tabId}&init=1"/>
      <a href="${url}">${ext.tabTitle}</a>
    </div>
  </c:forEach>
</c:forEach>
