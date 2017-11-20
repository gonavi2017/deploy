<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>

<%@attribute name="showExpandCollapseActions" type="java.lang.Boolean" required="true" %>
<div class="bpl">
<c:if test="${showExpandCollapseActions}">
  <div class="expandCollapseActions action-bar expand_collapse">
    <bs:collapseExpand collapseAction="BS.BuildProblems.collapseGroups(this); return false" expandAction="BS.BuildProblems.expandGroups(this); return false"/>
  </div>
  <div class="expandCollapseContainer">
    <jsp:doBody/>
  </div>
</c:if>
<c:if test="${not showExpandCollapseActions}">
  <jsp:doBody/>
</c:if>
</div>

