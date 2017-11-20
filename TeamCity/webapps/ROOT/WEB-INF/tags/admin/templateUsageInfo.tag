<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@attribute name="template" required="true" type="jetbrains.buildServer.serverSide.BuildTypeTemplate" %>
<c:set var="numUsages" value="${template.numberOfUsages}"/>
<c:if test="${numUsages == 0}"><span class="templateUsage">Unused template</span></c:if>
<c:if test="${numUsages > 0}"><span class="templateUsage">Used in <strong>${numUsages}</strong> <admin:templateUsagesPopup templateId="${template.id}" selectedStep="general">configuration<bs:s val="${numUsages}"/></admin:templateUsagesPopup></span></c:if>
