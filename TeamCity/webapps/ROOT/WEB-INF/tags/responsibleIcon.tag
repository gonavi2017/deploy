<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="responsibility" type="jetbrains.buildServer.responsibility.ResponsibilityEntry" required="false" %><%@
    attribute name="responsibilities" type="java.util.List" required="false" %><%@
    attribute name="title" type="java.lang.String" required="false" %><%@
    attribute name="style" type="java.lang.String" required="false" %><%@
    attribute name="test" type="jetbrains.buildServer.serverSide.STest" required="false" %><%@
    attribute name="buildTypeRef" type="jetbrains.buildServer.serverSide.SBuildType" required="false" %><%@
    attribute name="showNew" type="java.lang.Boolean" required="false" %><%@
    attribute name="noActions" type="java.lang.Boolean" required="false" %><%@
    variable name-given="shownNewReponsibility" variable-class="java.lang.Boolean" scope="AT_END"
%><c:set var="shownNewReponsibility" value="${false}"/><c:if test="${empty responsibility and not empty responsibilities}"
  ><c:set var="responsibility" value="${responsibilities[0]}"/></c:if
><c:choose
  ><c:when test="${not empty responsibility and responsibility.state.fixed}"
    ><c:set var="iconClassName" value="fixed"/></c:when><c:when test="${not empty responsibility and responsibility.state.active}"
    ><c:set var="iconClassName" value="taken"/></c:when
></c:choose
    
><c:if test="${not empty responsibility}"
    ><c:set var="title"
      ><bs:responsibleTooltip responsibility="${responsibility}"
                              responsibilities="${responsibilities}"
                              test="${test}"
                              buildTypeRef="${buildTypeRef}"
                              noActions="${noActions}"
    /></c:set
></c:if

 ><c:if test="${not empty style}"
    ><c:set var="style_attr">style="${style}"</c:set
 ></c:if
><c:if test="${not empty iconClassName}">
<c:if test="${showNew}"><c:set var="newIconClass" value="new"/><c:set var="shownNewReponsibility" value="${true}"/></c:if>
<span class="icon icon16 bp test ${iconClassName} ${newIconClass}" <bs:tooltipAttrs text="${title}" className="name-value-popup"/>></span></c:if>