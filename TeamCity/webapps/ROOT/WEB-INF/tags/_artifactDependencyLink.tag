<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="dependency" type="java.lang.Object" required="true"
%><c:set var="showLink" value="${dependency.sourceBuildTypeAccessible}"
/><c:choose
  ><c:when test="${dependency.revisionRuleIsBuildNumberRule}"
    ><c:choose
      ><c:when test="${showLink}"
        ><bs:buildLink buildNumber="${dependency.revisionRuleValue}"
                       buildTypeId="${dependency.sourceBuildType.externalId}"><c:out value="${dependency.revisionRuleDescription}"/></bs:buildLink
      ></c:when
      ><c:otherwise><c:out value="${dependency.revisionRuleDescription}"/></c:otherwise
    ></c:choose
  ></c:when
  ><c:when test="${dependency.revisionRuleIsBuildTagRule}"
    ><c:choose
      ><c:when test="${showLink}"
        ><bs:buildLink buildTag="${dependency.revisionRuleValue}" buildBranch="${dependency.buildBranch}"
                       buildTypeId="${dependency.sourceBuildType.externalId}"><c:out value="${dependency.revisionRuleDescription}"/></bs:buildLink
      ></c:when
      ><c:otherwise><c:out value="${dependency.revisionRuleDescription}"/></c:otherwise
    ></c:choose
  ></c:when
  ><c:otherwise
    ><c:choose
      ><c:when test="${showLink}"
        ><bs:buildLink buildId="${dependency.revisionRuleName}" buildBranch="${dependency.buildBranch}"
                       buildTypeId="${dependency.sourceBuildType.externalId}"><c:out value="${dependency.revisionRuleDescription}"/></bs:buildLink
      ></c:when
      ><c:otherwise><c:out value="${dependency.revisionRuleDescription}"/></c:otherwise
    ></c:choose
  ></c:otherwise
></c:choose>