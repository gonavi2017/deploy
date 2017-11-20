<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ attribute name="showImmideatelly" type="java.lang.Boolean"
%><%@ attribute name="autoSetupHandlers" type="java.lang.Boolean"
%><%@ attribute name="depth" type="java.lang.Integer"
%><%@ attribute name="ajaxControllerUrl" type="java.lang.String"
%><%@ attribute name="ajaxParameters" type="java.lang.String"
%><%@ attribute name="handleId" type="java.lang.String"
%><%@ attribute name="contentContainerId" type="java.lang.String" %>
<c:if test="${showImmideatelly}">
  <jsp:doBody/>
</c:if>
<c:if test="${not showImmideatelly}">
  <c:set var="parameters">
    {${ajaxParameters}}
  </c:set>
  <tr><td class="depth-${depth} <c:if test="${not autoSetupHandlers}">nonInitializedAjaxHandler</c:if>" <c:if test="${not autoSetupHandlers}">data-id="${handleId}" data-collapsible-ajax-parameters="<c:out value="${parameters}"/>"</c:if>><forms:progressRing className="progressRingInline"/> Loading data...</td></tr>
  <c:if test="${autoSetupHandlers}">
  <script type="text/javascript">
    BS.ProjectHierarchyTree.patchHandle(BS.ProjectHierarchyTree.findCollapsibleBlock("${handleId}"),
                                        "${ajaxControllerUrl}", "${contentContainerId}", {${ajaxParameters}});
  </script>
  </c:if>
</c:if>
