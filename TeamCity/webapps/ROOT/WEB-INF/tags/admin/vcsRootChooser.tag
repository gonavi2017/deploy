<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><%@ attribute name="chooserName" required="true" type="java.lang.String" description="A name for select"
%><%@ attribute name="headerOption" required="false" type="java.lang.String" description="Header option phrase, by default it is '-- Choose VCS root --' "
%><%@ attribute name="topOptions" required="false" type="java.util.Map" description="Additional options shown in the top"
%><%@ attribute name="popularRoots" required="false" type="java.util.Collection"
%><%@ attribute name="attachableRoots" required="true" type="java.util.Collection"
%>
<c:if test="${empty headerOption}">
  <c:set var="headerOption" value="-- Choose VCS root --"/>
</c:if>
<forms:select name="${chooserName}" enableFilter="true" className="longField">
  <forms:option value="">${headerOption}</forms:option>
  <c:forEach items="${topOptions}" var="entry">
    <forms:option value="${entry.value}"><c:out value="${entry.key}"/></forms:option>
  </c:forEach>
  <c:if test="${not empty popularRoots}">
    <optgroup value="" label="-- Popular VCS roots --">
      <c:forEach items="${popularRoots}" var="vcsRoot">
        <forms:option value="${vcsRoot.externalId}"><c:out value="${vcsRoot.name}"/></forms:option>
      </c:forEach>
    </optgroup>
  </c:if>
  <c:set var="prevProjId" value=""/>
  <c:forEach items="${attachableRoots}" var="vcsRoot">
    <c:set var="createGroup">
      ${vcsRoot.scope.ownerProjectId != prevProjId}
    </c:set>
    <c:if test="${createGroup}">
      <optgroup value="" label="-- ${vcsRoot.project.fullName} project VCS roots --">
      <c:set var="prevProjId" value="${vcsRoot.scope.ownerProjectId}"/>

    </c:if>
    <forms:option value="${vcsRoot.externalId}" className="user-depth-2"><c:out value="${vcsRoot.name}"/></forms:option>
    <c:if test="${createGroup}">
      </optgroup>
    </c:if>
  </c:forEach>
</forms:select>
