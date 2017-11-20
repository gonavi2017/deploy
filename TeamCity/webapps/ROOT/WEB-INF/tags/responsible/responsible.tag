<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp" %><%@
    attribute name="buildData" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="server" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.BuildServerEx" %><%@
    attribute name="currentUser" required="true" rtexprvalue="true" type="jetbrains.buildServer.users.SUser"
%>
<c:if test="${not empty buildData && not empty buildData.buildType}">
<c:set var="buildType" value="${buildData.buildType}"
/><c:set var="responsibility" value="${buildType.responsibilityInfo}"
/><c:if test="${(not buildType.status.successful && not buildData.personal) or not empty responsibility}">
  <div class="responsible">
    <c:choose>
      <c:when test="${responsible:isActive(responsibility)}">
        <!-- Has active responsible -->
        <bs:responsibleIcon responsibility="${responsibility}"/>
        <c:if test="${responsibility.responsibleUser == currentUser}">
          <span class="responsibleHighlight ${currentUser.highlightRelatedDataInUI ? 'highlightChanges' : ''}">You are assigned to investigate the build configuration<bs:_whoSetResponsibility respInfo="${responsibility}" doNotUseAssigned="true"/></span>
          <%@ include file="comment.jsp" %>

          <authz:authorize projectId="${buildType.projectId}" allPermissions="ASSIGN_INVESTIGATION">
            <span class="responsibleActions">
              <c:set var="name"><bs:escapeForJs text="${buildType.name}" forHTMLAttribute="true"/></c:set>
              <span class="statusChangeLink-normal" onclick="BS.ResponsibilityDialog.showDialog('${buildType.externalId}', '${name}', true)">Fix</span>
              <span class="separator">|</span>
              <span class="statusChangeLink-normal" onclick="BS.ResponsibilityDialog.showDialog('${buildType.externalId}', '${name}')">Investigate</span>
            </span>

          <resp:form buildType="${buildType}" currentUser="${currentUser}"/>
          </authz:authorize>
        </c:if>
        <c:if test="${responsibility.responsibleUser != currentUser}">
          <span class="responsibleHighlight"><c:out value="${responsibility.responsibleUser.descriptiveName}"/></span>
          since <bs:date value="${responsibility.timestamp}"/><bs:_whoSetResponsibility respInfo="${responsibility}"/>
          <%@ include file="comment.jsp" %>
          <authz:authorize projectId="${buildType.projectId}" allPermissions="ASSIGN_INVESTIGATION">
          <div class="takeResponsibility"><resp:takeResponsibility buildType="${buildType}" currentUser="${currentUser}"/></div>
          </authz:authorize>
        </c:if>
        <%--<%@ include file="comment.jsp" %>--%>
      </c:when>

      <c:when test="${responsible:isFixed(responsibility)}">
        <!-- Build Configuration is fixed by someone -->
        <bs:responsibleIcon responsibility="${responsibility}"/>
        <c:if test="${responsibility.responsibleUser == currentUser}">
          <span class="responsibleHighlight">Fixed by you at</span> &nbsp;<bs:date value="${responsibility.timestamp}"/><bs:_whoSetResponsibility respInfo="${responsibility}"/>
        </c:if>
        <c:if test="${responsibility.responsibleUser != currentUser}">
          fixed by <span class="responsibleHighlight"><c:out value="${responsibility.responsibleUser.descriptiveName}"/></span>
          at <bs:date value="${responsibility.timestamp}"/><bs:_whoSetResponsibility respInfo="${responsibility}"/>
        </c:if>
        <%@ include file="comment.jsp" %>
        <authz:authorize projectId="${buildType.projectId}" allPermissions="ASSIGN_INVESTIGATION">
        <div class="takeResponsibility"><resp:takeResponsibility buildType="${buildType}" currentUser="${currentUser}"/></div>
        </authz:authorize>
      </c:when>

      <c:when test="${not responsible:isFixed(responsibility) and responsible:hasResponsible(responsibility)}">
        <!-- Given up by some user -->
        Was <span class="responsibleHighlight"><c:out value="${responsibility.responsibleUser.descriptiveName}"/></span><bs:_whoSetResponsibility respInfo="${responsibility}"/>
        <%@ include file="comment.jsp" %>
        <authz:authorize projectId="${buildType.projectId}" allPermissions="ASSIGN_INVESTIGATION">
        <div class="takeResponsibility"><resp:takeResponsibility buildType="${buildType}" currentUser="${currentUser}"/></div>
        </authz:authorize>
      </c:when>

      <c:otherwise>
        <!-- No responsibility information at all -->
        <c:if test="${not empty failMyCommit}">
          <div>
            <span class="responsibilityMessage">
              Your
              <bs:changesLink build="${buildData}">changes</bs:changesLink>
              might have led to the failure in <c:out value="${buildType.name}"/>.
            </span>
          </div>
        </c:if>

        <authz:authorize projectId="${buildType.projectId}" allPermissions="ASSIGN_INVESTIGATION">
          <jsp:attribute name="ifAccessGranted">
            <div class="takeResponsibility"><resp:takeResponsibility buildType="${buildType}" currentUser="${currentUser}"/></div>
          </jsp:attribute>
          <jsp:attribute name="ifAccessDenied">
            <span id="responsibleHighlight">No one is investigating the build configuration</span>
          </jsp:attribute>
        </authz:authorize>
      </c:otherwise>
    </c:choose>
  </div>
</c:if>
</c:if>