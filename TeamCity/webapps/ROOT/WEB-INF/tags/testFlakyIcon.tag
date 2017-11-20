<%@ tag display-name="testFlakyIcon"
        trimDirectiveWhitespaces="true"
        example="<tt:testFlakyIcon test='${sTest}'/>"
        description="<p>Displays the corresponding icon if the test is flaky.</p>"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="ftd" uri="/WEB-INF/functions/flaky-test-detector"
%><%@ attribute name="test" type="jetbrains.buildServer.serverSide.STest" required="true"
%><%@ attribute name="showNew" type="java.lang.Boolean"
%><%@ attribute name="noActions" type="java.lang.Boolean"
%><%@ variable name-given="shownNewFlacky" variable-class="java.lang.Boolean" scope="AT_END"
%><c:if test="${not empty test}">
  <c:set var="testNameId" value="${test.testNameId}"/>
  <c:if test="${ftd:isFlaky(testNameId)}">
    <c:set var="flakyReasonsTooltip">
      <div class="name-value">
        <div><strong>This test looks flaky:</strong><bs:help file="Viewing+Tests+and+Configuration+Problems" anchor="FlakyTests"/></div>
        <c:set var="flakyReasons" value="${ftd:getFlakyReasons(testNameId)}"/>
        <c:forEach var="flakyReason" items="${flakyReasons}">
          <div>${flakyReason}</div>
        </c:forEach>

          <%-- See jetbrains.buildServer.util.ContextProjectInfo --%>
          <%--@elvariable id="contextProject" type="jetbrains.buildServer.serverSide.SProject"--%>
        <c:if test="${not empty contextProject and not noActions}">
          <div>
            <c:url var="url" value="/project.html?projectId=${contextProject.externalId}&tab=testDetails&testNameId=${test.testNameId}#analysis"/>
            <a href="${url}">View test history &raquo;</a>
          </div>
        </c:if>
      </div>
    </c:set>
    <c:if test="${showNew}"><c:set var="newIconClass" value="new"/><c:set var="shownNewFlacky" value="${true}"/></c:if>
    <span class="icon icon16 bp flaky ${newIconClass}" <bs:tooltipAttrs text="${flakyReasonsTooltip}" className="name-value-popup"/>></span>
  </c:if>
</c:if>
