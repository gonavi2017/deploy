<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>

<%@ attribute name="params" required="true" type="java.util.Collection<jetbrains.buildServer.controllers.buildType.ParameterInfo>"%>
<%@ attribute name="paramType" required="true" type="java.lang.String"%>
<%@ attribute name="readOnly" required="false" type="java.lang.Boolean"%>
<%@ attribute name="externalId" required="true" type="java.lang.String"%>
<c:choose>
  <c:when test="${empty params}">
    <p>None defined</p>
  </c:when>
  <c:otherwise>
    <l:tableWithHighlighting id="${paramType}Table" className="parametersTable" highlightImmediately="true">
      <tr style="background-color: #f5f5f5;">
        <th>Name</th>
        <th colspan="${readOnly ? 2 : 3}">Value</th>
      </tr>
      <c:forEach var="parameter" items="${params}">
      <jsp:useBean id="parameter" type="jetbrains.buildServer.controllers.buildType.ParameterInfo"/>
      <c:set var="paramValue" value="${parameter.value}"/>
      <c:set var="paramSpec" value="${empty parameter.parameterSpec ? '' : parameter.parameterSpec}"/>
      <c:set var="escapedParamValue" value='<%=WebUtil.escapeXml((String)jspContext.getAttribute("paramValue")).replace("\n", "##10##").replace("\r", "##13##")%>'/>
      <c:set var="escapedParamSpec" value='<%=WebUtil.escapeXml((String)jspContext.getAttribute("paramSpec")).replace("\n", "##10##").replace("\r", "##13##")%>'/>
      <c:set var="inheritedParam" value="${not parameter.redefined and parameter.inherited}"/>
      <c:set var="canEditParam" value="${not readOnly and (parameter.editableOrigin or not parameter.readOnly)}"/>
      <c:set var="onclick">BS.EditParameterDialog.showDialog($('name_${parameter.id}'), $('value_${parameter.id}'), '${paramType}', ${parameter.inherited}, ${not canEditParam}, ${parameter.undefined}, $('spec_${parameter.id}'), ${parameter.redefined}, ${parameter.readOnly && parameter.inherited});</c:set>
      <tr class="${inheritedParam ? 'inheritedParam' : 'ownParam'}">
        <td class="name highlight" onclick="${onclick}" id="edit_${parameter.id}">
          <a name="<c:out value="${parameter.nameWithPrefix}"/>"></a>
          <bs:makeBreakable text="${parameter.nameWithPrefix}" regex="[._/]"/>
          <c:if test="${parameter.inherited}"><span class="inheritedParam">(inherited from <c:out value="${parameter.inheritanceOrigin}"/>)</span></c:if>
        </td>
        <td class="value highlight" onclick="${onclick}">
          <c:if test="${parameter.readOnly}">
            <c:set var="inheritanceMessage">The parameter is defined as read-only<c:if test="${not empty parameter.inheritanceOrigin}"> in <c:out value="${parameter.inheritanceOrigin}"/></c:if></c:set>
            <c:if test="${parameter.ownValue != null}">
              <i class="icon-lock undefinedParam" title='${inheritanceMessage}. The value "<bs:out value="${parameter.ownValue}" multilineOnly="true"/>" defined here is ignored.'></i>
            </c:if>
            <c:if test="${parameter.ownValue == null && not empty parameter.inheritanceOrigin}">
              <i class="icon-lock" title='${inheritanceMessage} and can&apos;t be changed.'></i>
            </c:if>
            <c:if test="${parameter.ownValue == null && empty parameter.inheritanceOrigin}">
              <i class="icon-lock" title='${inheritanceMessage} and can&apos;t be changed before or during the build.'></i>
            </c:if>
          </c:if>
          <c:choose>
            <c:when test="${parameter.undefined}"><span class="undefinedParam" title="A reference to this parameter exists but parameter value is not specified yet.">&lt;value is required&gt;</span></c:when>
            <c:otherwise>
              <c:choose>
                <c:when test="${empty parameter.value}">
                  <span class="emptyValue">&lt;empty&gt;</span>
                </c:when>
                <c:otherwise>
                  <c:choose>
                    <c:when test="${fn:length(parameter.value) > 100}">
                      <span class="longValue">
                        <bs:out value="${parameter.value}" multilineOnly="true"/>
                      </span>
                    </c:when>
                    <c:otherwise>
                      <bs:out value="${parameter.value}" multilineOnly="true"/>
                    </c:otherwise>
                  </c:choose>
                </c:otherwise>
              </c:choose>
            </c:otherwise>
          </c:choose>
        </td>
        <td class="edit highlight" onclick="${onclick}"><a href="#" showdiscardchangesmessage="false" onclick="${onclick}; Event.stop(event)">${canEditParam ? 'Edit' : 'View'}</a>
          <span style="display: none;" id="name_${parameter.id}"><c:out value='${parameter.nameWithPrefix}'/></span>
          <span style="display: none;" id="value_${parameter.id}">${escapedParamValue}</span>
          <span style="display: none;" id="spec_${parameter.id}">${escapedParamSpec}</span>
        </td>
        <c:if test="${not readOnly}">
        <td class="edit">
          <c:choose>
            <c:when test="${parameter.redefined}">
              <a href="#" showdiscardchangesmessage="false" onclick="BS.EditParameterForm.resetParameter(${parameter.id}, '${paramType}'); return false">Reset</a>
            </c:when>
            <c:when test="${parameter.inherited}">
              <span title="Inherited parameters cannot be deleted.">undeletable</span>
            </c:when>
            <c:when test="${parameter.undefined}">
              <span title="To delete this parameter you need to remove reference to it from the settings.">undeletable</span>
            </c:when>
            <c:otherwise>
              <a href="#" showdiscardchangesmessage="false" onclick="BS.EditParameterForm.removeParameter(${parameter.id}, '${paramType}'); return false">Delete</a>
            </c:otherwise>
          </c:choose>
        </td>
        </c:if>
      </tr>
      </c:forEach>
    </l:tableWithHighlighting>
  </c:otherwise>
</c:choose>
