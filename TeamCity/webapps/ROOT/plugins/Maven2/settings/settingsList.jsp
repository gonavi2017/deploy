<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="../mavenConsts.jsp"%>
<props:option id="${USER_SETTINGS_SELECTION_DEFAULT}" value="${USER_SETTINGS_SELECTION_DEFAULT}"><c:out value="<Default>"/></props:option>
<props:option id="${USER_SETTINGS_SELECTION_BY_PATH}" value="${USER_SETTINGS_SELECTION_BY_PATH}"><c:out value="<Custom>"/></props:option>

<%--@elvariable id="unknownName" type="String"--%>
<c:if test="${not empty unknownName}">
  <props:option value="${unknownName}"><c:out value="Unknown name: ${unknownName}"/></props:option>
</c:if>

<%--@elvariable id="project" type="SProject"--%>
<%--@elvariable id="settings" type="java.util.Map<SProject, List<String>>"--%>
<c:forEach var="projectAndSettings" items="${settings}">
  <c:set var="p" value="${projectAndSettings.key}"/>
  <c:set var="settingsList" value="${projectAndSettings.value}"/>
  <optgroup label="&ndash;&ndash; ${p.name} settings &ndash;&ndash;">
    <c:forEach var="s" items="${settingsList}">
      <props:option value="${s}" className="user-depth-2"><bs:out value="${s}"/></props:option>
    </c:forEach>
  </optgroup>
</c:forEach>
