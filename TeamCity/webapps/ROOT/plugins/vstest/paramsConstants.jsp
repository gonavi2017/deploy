<%@ page import="jetbrains.buildServer.runner.mstest.MSTestConstants" %>
<%@ page import="jetbrains.buildServer.runner.vstest.VSTestConstants" %>
<%@ page import="jetbrains.buildServer.runner.vstest.VisualStudioTestConstants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Runner parameters--%>
<c:set var="dotTestEngine" value="<%=VisualStudioTestConstants.ENGINE%>"/>
<c:set var="dotTestRunnerPath" value="<%=VisualStudioTestConstants.RUNNER_PATH%>"/>
<c:set var="dotTestInclude" value="<%=VisualStudioTestConstants.INCLUDE%>"/>
<c:set var="dotTestExclude" value="<%=VisualStudioTestConstants.EXCLUDE%>"/>
<c:set var="dotTestExtraCmd" value="<%=VisualStudioTestConstants.EXTRA_CMD%>"/>
<c:set var="dotTestRunSettings" value="<%=VisualStudioTestConstants.RUN_SETTINGS%>"/>

<c:set var="engine_vstest" value="<%=VisualStudioTestConstants.ENGINE_VSTEST%>"/>
<c:set var="engine_mstest" value="<%=VisualStudioTestConstants.ENGINE_MSTEST%>"/>

<c:set var="msTestPath" value="<%=MSTestConstants.PATH%>"/>
<c:set var="msTestMetadata" value="<%=MSTestConstants.METADATA%>"/>
<c:set var="msTestTestlist" value="<%=MSTestConstants.TESTLIST%>"/>
<c:set var="msTestTest" value="<%=MSTestConstants.TEST%>"/>
<c:set var="msTestUnique" value="<%=MSTestConstants.UNIQUE%>"/>
<c:set var="msTestResult" value="<%=MSTestConstants.RESULT%>"/>

<c:set var="vsTestVersion" value="<%=VSTestConstants.VERSION%>"/>
<c:set var="platform" value="<%=VSTestConstants.PLATFORM%>"/>
<c:set var="framework" value="<%=VSTestConstants.FRAMEWORK%>"/>
<c:set var="testNames" value="<%=VSTestConstants.TEST_NAMES%>"/>
<c:set var="testCaseFilter" value="<%=VSTestConstants.TEST_CASE_FILTER%>"/>
<c:set var="default" value="<%=VSTestConstants.DEFAULT_VALUE%>"/>
<c:set var="inIsolation" value="<%=VSTestConstants.RUN_IN_ISOLATION%>"/>
<c:set var="detectTeamCityLogger" value="<%=VSTestConstants.DETECT_TEAM_CITY_LOGGER%>"/>

