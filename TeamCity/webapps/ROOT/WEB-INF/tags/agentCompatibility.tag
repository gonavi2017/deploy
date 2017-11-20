<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ attribute name="compatibility" type="jetbrains.buildServer.serverSide.CompatibilityResult" required="true" %>
<c:choose>
  <c:when test="${compatibility.compatible}">
    <div class="compatible">Compatible</div>
  </c:when>
  <c:otherwise>
    <c:if test="${not compatibility.suitableRunnerExists}">
      <div class="incompatible runner">
        <div class="details name">Incompatible runner:</div>
        <div class="details value"><span class="mono"><strong><c:out value="${compatibility.incompatibleRunner.displayName}"/></strong></span></div>
      </div>
    </c:if>                                                
    <c:if test="${not empty compatibility.nonMatchedRequirements}">
      <div class="incompatible">
        <div class="details name">Unmet requirements:</div>
        <div class="details value">
          <ul>
            <c:forEach items="${compatibility.nonMatchedRequirements}" var="requirement">
              <li><span class="mono"><strong><c:out value="${requirement.propertyName}"/></strong></span>
                <admin:requirementValue requirementType="${requirement.type}" parameterValue="${requirement.propertyValue}"/>
              </li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </c:if>
    <c:if test="${not empty compatibility.missedVcsPluginsOnAgent}">
      <div class="incompatible">
        <div class="details name">Missing VCS plugins on agent:</div>
        <div class="details value">
          <ul>
            <c:forEach items="${compatibility.missedVcsPluginsOnAgent}" var="requirement">
              <li><span class="mono"><strong><c:out value="${requirement.value}"/></strong></span></li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </c:if>
    <c:if test="${not empty compatibility.invalidRunParameters}">
      <div class="incompatible">
        <div class="details name">Missing or invalid build configuration parameters:</div>
        <div class="details value">
          <ul>
            <c:forEach items="${compatibility.invalidRunParameters}" var="invalidParam">
              <li><span class="mono incompatibleValue red-text"><strong><c:out value="${invalidParam.propertyName}"/></strong>: <c:out value="${invalidParam.invalidReason}"/></span></li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </c:if>
    <c:if test="${not empty compatibility.undefinedParameters}">
      <div class="incompatible">
        <div class="details name">Implicit requirements:</div>
        <div class="details value">
          <ul>
            <c:forEach items="${compatibility.undefinedParameters}" var="undefinedParam">
              <li><span class="mono"><strong><c:out value="${undefinedParam.key}"/></strong> defined in <strong><c:out value="${undefinedParam.value}"/></strong></span></li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </c:if>
  </c:otherwise>
</c:choose>
