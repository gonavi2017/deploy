<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="projectBeans" required="true" type="java.util.List" %><%@
    attribute name="id" required="false" type="java.lang.String" %><%@
    attribute name="name" required="false" type="java.lang.String" %><%@
    attribute name="className" required="false" type="java.lang.String" %><%@
    attribute name="onchange" required="false" type="java.lang.String" %><%@
    attribute name="style" required="false" type="java.lang.String" %><%@
    attribute name="defaultOption" required="false" type="java.lang.Boolean" %><%@
    attribute name="additionalOptions" required="false"  fragment="true" %><%@
    attribute name="selectedProjectExternalId" required="false" type="java.lang.String" %><%@
    attribute name="disableRoot" required="false" type="java.lang.Boolean" %><%@
    attribute name="disableProjectExternalId" required="false" type="java.lang.String" %><%@
    attribute name="disabledProjects" required="false" type="java.util.Map"

%><c:choose><c:when test="${defaultOption == null && additionalOptions == null && fn:length(projectBeans) == 1
&& selectedProjectExternalId != null && selectedProjectExternalId == projectBeans[0].project.externalId}"
><c:out value="${projectBeans[0].project.name}"/>${projectBeans[0].project.archived ? ' (archived)' : ''}<input type="hidden" id="${id}" name="${name}" value="${projectBeans[0].project.externalId}"
></c:when><c:otherwise><forms:select id="${id}" name="${name}" onchange="${onchange}" style="${style}" className="${className}" enableFilter="true"
  ><c:if test="${defaultOption}"><forms:option value="">-- Choose a project --</forms:option></c:if
  ><jsp:invoke fragment="additionalOptions"
  /><c:forEach items="${projectBeans}" var="bean"
    ><%--@elvariable id="bean" type="jetbrains.buildServer.web.util.ProjectHierarchyBean"--%><c:set var="externalId" value="${bean.project.externalId}"
    /><forms:option value="${externalId}"
                    selected="${selectedProjectExternalId == externalId}"
                    className="user-depth-${bean.limitedDepth}"
                    disabled="${(disableRoot and bean.project.rootProject) or disableProjectExternalId == externalId or (not empty disabledProjects and disabledProjects[bean.project])}"
                    title="${bean.project.fullName}"
      ><c:out value="${bean.project.name}"/>${bean.project.archived ? ' (archived)' : ''}</forms:option
  ></c:forEach
></forms:select></c:otherwise></c:choose>