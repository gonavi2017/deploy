<%@include file="/include.jsp"%>

<jsp:useBean id="data" class="jetbrains.buildServer.controllers.agent.AgentTypesToMove" scope="request"/>

<div style="max-height: 10cm; overflow-y: auto;">

  <table id="agents-to-move">

    <c:forEach items="${data.agentTypes}" var="agt">
      <tr>
        <td>
          <forms:checkbox id="select-agt-${agt.agentTypeId}"
                          name="select-agt-${agt.agentTypeId}"
                          className="select-item"/>
          <label for="select-agt-${agt.agentTypeId}"><c:out value="${agt.agentTypeName}"/></label>
        </td>
        <td>
          <c:if test="${agt.OSKind ne null}">
            <span class="osIcon osIconMedium"
                  style="background-image: url(<c:url value='/img/os/${agt.OSKind.code}-bw.png'/>)"
                  title="<c:out value='${agt.OSName}'/>"></span>
          </c:if>
        </td>
        <td>
          <span class="gray"><c:out value="${agt.agentPoolName}"/></span>
        </td>
      </tr>
    </c:forEach>

  </table>

</div>
