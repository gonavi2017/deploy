<%@include file="/include-internal.jsp"%>
<jsp:useBean id="template" scope="request" type="jetbrains.buildServer.serverSide.BuildTypeTemplate"/>
<jsp:useBean id="paramNames" scope="request" type="java.util.Collection"/>
<jsp:useBean id="templateParameters" scope="request" type="java.util.Map"/>
<c:if test="${not empty paramNames}">
  <table class="runnerFormTable">
    <tr>
      <td colspan="2" class="name noBorder">Please review the parameters:</td>
    </tr>
  <c:forEach items="${paramNames}" var="paramName" varStatus="pos">
    <c:set var="escapedParamName"><c:out value="${paramName}"/></c:set>
    <c:set var="paramId">${template.id}_param_${pos.index}</c:set>
    <tr>
      <td class="name"><label for="${paramId}"><bs:makeBreakable text="${paramName}" regex="[._:-]+"/>:</label></td>
      <td class="value">
        <div class="completionIconWrapper">
          <forms:textField name="param:${escapedParamName}" id="${paramId}" value="${templateParameters[paramName]}" style="width: 100%;" className="buildTypeParams" expandable="true"/>
        </div>
      </td>
    </tr>
  </c:forEach>
  </table>
  <script type="text/javascript">
    BS.AvailableParams.attachPopups("settingsId=template:${template.id}");
  </script>
</c:if>
