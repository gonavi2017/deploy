<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="intprop" uri="/WEB-INF/functions/intprop"%><%@
    attribute name="testBean" type="jetbrains.buildServer.serverSide.STest" required="true" %><%@
    attribute name="testRun" type="jetbrains.buildServer.serverSide.TestRunEx" %><%@
    attribute name="showPackage" type="java.lang.Boolean" required="false" %><%@
    attribute name="trimTestName" type="java.lang.Boolean" required="false" %><%@
    attribute name="maxTestNameLength" type="java.lang.Integer" required="false" %><%@
    attribute name="noClass" type="java.lang.Boolean" required="false"

%><c:choose
  ><c:when test="${trimTestName}"
    ><c:if test="${noClass}"
      ><c:set var="testName" value='<%=testBean.getName().getTestNameWithParameters()%>'
   /></c:if
    ><c:if test="${not noClass}"
      ><c:set var="testName" value='<%=testBean.getName().getShortName()%>'
   /></c:if
  ><c:set var="testName"><bs:trimWithTooltip maxlength="${maxTestNameLength > 0 ? maxTestNameLength : intprop:getInteger('teamcity.ui.test.max.length', 80)}"
                                             trimCenter="true">${testName}</bs:trimWithTooltip></c:set
  ></c:when
  ><c:otherwise
    ><c:if test="${noClass}"
      ><c:set var="testName" value='<%=WebUtil.makeBreakable(testBean.getName().getTestNameWithParameters(), "[\\\\.\\\\/\\\\\\\\_]+", true)%>'
   /></c:if
    ><c:if test="${not noClass}"
      ><c:set var="testName" value='<%=WebUtil.makeBreakable(testBean.getName().getShortName(), "[\\\\.\\\\/\\\\\\\\_]+", true)%>'
   /></c:if
  ></c:otherwise
></c:choose

><span class="hoverable">${testName}</span><jsp:doBody
  /><c:if test="${showPackage and not empty testBean.name.prefix}"
  > <span class="package">(<bs:trimWithTooltip maxlength="40" trimCenter="true">${testBean.name.prefix}</bs:trimWithTooltip>)</span></c:if>