<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    attribute name="testBean" type="jetbrains.buildServer.serverSide.STest" required="true" %><%@
    attribute name="showPackage" type="java.lang.Boolean" required="false" %><%@
    attribute name="noClass" type="java.lang.Boolean" required="false"
%><tt:testName testBean="${testBean}" showPackage="${showPackage}" noClass="${noClass}">
  <tt:testDetailsLink testBean="${testBean}" />
  <bs:currentMuteIcon test="${testBean}"/>
  <jsp:doBody/>
</tt:testName>