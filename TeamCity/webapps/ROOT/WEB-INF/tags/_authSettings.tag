<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="pluginSections" rtexprvalue="true" type="java.util.List" required="true"
%><%@ attribute name="title" type="java.lang.String" required="true"
%><%@ attribute name="propertyFieldNamePrefix" type="java.lang.String" required="true"
%><%@ attribute name="showEditUsernameLink" type="java.lang.Boolean" required="true"
%><%@ attribute name="canSomehowEditUsername" type="java.lang.Boolean" required="true"
%><%@ attribute name="canChangeUsername" type="java.lang.Boolean" required="true"
%><c:if test="${not empty pluginSections}"
><l:settingsBlock title="${title}">
  <c:forEach items="${pluginSections}" var="pluginSection">
    <div class="notifierSection">
      <div class="notifierSection__title">
        <h3 class="notifierSection__title-text"><c:out value="${pluginSection.displayName}"/></h3>
      </div>
      <c:forEach items="${pluginSection.propertyList}" var="property">
        <c:set var="propertyFieldId" value="${pluginSection.pluginType}_${pluginSection.pluginName}_${property.propertyName}"/>
        <c:set var="propertyFieldName" value="${propertyFieldNamePrefix}[${pluginSection.pluginName}].properties[${property.propertyName}].value"/>
        <c:set var="propertyValue" value="${property.value}"/>
        <c:if test="${(empty propertyValue) && (not empty property.placeHolder)}">
          <c:set var="propertyValue" value="${property.placeHolder}"/>
        </c:if>
        <div class="notifier-property">
          <label class="notifier-property__label" for="input_${propertyFieldId}"><c:out value="${property.displayName}"/>:</label>
          <c:if test="${canSomehowEditUsername}">
            <input class="textField" id="input_${propertyFieldId}" type="text" name="${propertyFieldName}" size="30" maxlength="256"
                   value="<c:out value="${propertyValue}"/>"
                   <c:if test="${!canChangeUsername}">style="display: none;"</c:if>
                />
            <c:if test="${not empty property.placeHolder}">
              <script type="text/javascript">
                BS.Util.installPlaceHolder("input_${propertyFieldId}", '<bs:escapeForJs text="${property.placeHolder}"/>', false);
              </script>
            </c:if>
          </c:if>
          <c:if test="${!canChangeUsername}">
            <c:set var="propertyLink" value="${property.link}"/>
            <c:set var="propertyText"><c:out value="${empty propertyValue ? '<empty>' : propertyValue}"/></c:set>
            <span id="text_${propertyFieldId}"><c:choose
                ><c:when test="${empty propertyLink}">${propertyText}</c:when
                ><c:otherwise><a href="<c:url value='${propertyLink}'/>">${propertyText}</a></c:otherwise
              ></c:choose
            ></span>
          </c:if>
          <c:if test="${showEditUsernameLink}">
            <span id="editLink_${propertyFieldId}">
              <a href="#" onclick="BS.UserProfile.makeEditable('${propertyFieldId}'); return false"><i class="tc-icon icon16 tc-icon_edit_gray"></i></a>
            </span>
          </c:if>
          <span class="error" id="error_${propertyFieldId}" style="margin-left: 14.3em"></span>
        </div>
      </c:forEach>
    </div>
  </c:forEach>
</l:settingsBlock
></c:if>