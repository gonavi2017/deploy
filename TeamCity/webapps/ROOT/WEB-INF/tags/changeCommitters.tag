<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="user" uri="/WEB-INF/functions/user"
  %><%@attribute name="modification" type="jetbrains.buildServer.vcs.SVcsModification" required="true"
  %><%@attribute name="no_tooltip" type="java.lang.Boolean" required="false"
  %><c:set var="users" value="${modification.committers}"
  /><c:set var="tcUsers"><c:forEach var="user" items="${users}" varStatus="pos">${user.descriptiveName}<c:if test="${not pos.last}">, </c:if></c:forEach
  ></c:set><c:set var="tcUsersExtended"><c:forEach var="user" items="${users}" varStatus="pos"><c:out value="${user.extendedName}"/><c:if test="${not pos.last}">, </c:if></c:forEach
  ></c:set
  ><c:choose
  ><c:when test="${no_tooltip}"
  ><c:if test="${not empty users}"><c:out value="${tcUsers}"/></c:if
    ><c:if test="${empty users}"><c:out value="${modification.userName}"/></c:if
  ></c:when
  ><c:otherwise
  ><c:set var="vcsUsername"><c:out value="${modification.userName}"/></c:set
    ><c:if test="${not empty users}"><span <bs:tooltipAttrs text="VCS username: ${vcsUsername}<br/>TeamCity user: ${tcUsersExtended}"/>><c:out value="${tcUsers}"/></span></c:if
    ><c:if test="${empty users}"><bs:trimWhitespace>
      <c:choose>
        <c:when test="${user:isGuestUser(currentUser)}">
          <span <bs:tooltipAttrs text="VCS username: ${vcsUsername}<br/>TeamCity user: unknown"/>><c:out value="${modification.userName}"/></span>
        </c:when>
        <c:otherwise>
          <span <bs:tooltipAttrs text="VCS username: ${vcsUsername}<br/>TeamCity user: unknown <a title='Add this vcs username to my profile' href='javascript:;' onclick='BS.VcsUsername.addVcsNameFromModification(${modification.id});'>it's me!</a>"/>><c:out value="${modification.userName}"/></span>
        </c:otherwise>
      </c:choose>
    </bs:trimWhitespace></c:if
  ></c:otherwise
  ></c:choose>