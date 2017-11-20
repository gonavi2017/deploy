<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="branch" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.Branch" %><%@
    attribute name="build" required="false" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="buildPromotion" required="false" type="jetbrains.buildServer.serverSide.BuildPromotion" %><%@
    attribute name="buildType" required="false" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="vcsChangeBranchTag" required="false" type="jetbrains.buildServer.controllers.buildType.tabs.VcsChangeBranchTag" %><%@
    attribute name="noLink" required="false" type="java.lang.Boolean" %><%@
    attribute name="classes" required="false" type="java.lang.String"
%><c:set var="text"><jsp:doBody/></c:set><c:if test="${empty text}"><c:set var="text"><c:out value="${branch.displayName}"/></c:set></c:if
><c:choose
  ><c:when test="${noLink}"><span class="branchName">${text}</span></c:when
  ><c:otherwise
    ><c:set var="btId"
      ><c:choose
        ><c:when test="${not empty build}">${not empty build.buildType ? build.buildType.externalId : ''}</c:when
        ><c:when test="${not empty buildPromotion}">${not empty buildPromotion.buildType ? buildPromotion.buildType.externalId : ''}</c:when
        ><c:when test="${not empty buildType}">${buildType.externalId}</c:when
        ><c:when test="${not empty vcsChangeBranchTag}">${vcsChangeBranchTag.buildTypeExternalId}</c:when
      ></c:choose
    ></c:set
    ><c:set var="projectId"
      ><c:choose
        ><c:when test="${not empty build}">${not empty build.buildType ? build.buildType.project.externalId : ''}</c:when
        ><c:when test="${not empty buildPromotion}">${not empty buildPromotion.buildType ? buildPromotion.buildType.project.externalId : ''}</c:when
        ><c:when test="${not empty buildType}">${buildType.projectExternalId}</c:when
        ><c:when test="${not empty vcsChangeBranchTag}">${vcsChangeBranchTag.projectExternalId}</c:when
      ></c:choose
    ></c:set
    ><c:set var="name"><bs:escapeForJs forHTMLAttribute="true" text="${branch.name}"/></c:set
    ><a href="#" onmouseover="BS.Branch.setLink(this, '${btId}', '${projectId}', '${name}');" class="branchName ${not empty classes ? classes : ''}">${text}</a
  ></c:otherwise
></c:choose>