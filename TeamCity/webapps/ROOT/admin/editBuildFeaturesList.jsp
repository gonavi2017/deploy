<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>

<c:set var="featurePlace" value="${param['featurePlace']}"/>
<c:choose>
  <c:when test="${featurePlace == 'GENERAL'}">
    <c:set var="noFeaturesMessage">There are no build features configured.</c:set>
    <c:set var="settingName">build feature</c:set>
  </c:when>
  <c:otherwise>
    <c:set var="settingName">failure condition</c:set>
  </c:otherwise>
</c:choose>

<c:set var="addButtonTitle">Add ${settingName}</c:set>
<c:if test="${fn:length(buildForm.buildFeaturesBean.availableBuildFeatures) > 0 and not buildForm.readOnly}">
  <div>
    <forms:addButton onclick="BS.BuildFeatureDialog.showAddDialog('${featurePlace}', '${addButtonTitle}'); return false">${addButtonTitle}</forms:addButton>
  </div>
</c:if>

<c:set var="tableRows">
  <c:forEach items="${buildForm.buildFeaturesBean.buildFeatureDescriptors}" var="featureInfo">
    <c:if test="${featureInfo.descriptor.buildFeature.placeToShow == featurePlace}">
      <c:set var="onclick" value=""/>
      <c:if test="${featureInfo.inherited}">
        <c:set var="onclick">onclick="BS.BuildFeatureDialog.showEditDialog('${featurePlace}', '${featureInfo.descriptor.id}', '${featureInfo.descriptor.type}', '${featureInfo.descriptor.buildFeature.displayName} (inherited from <c:out value="${fn:escapeXml(featureInfo.inheritanceDescription)}"/>)', true, ${featureInfo.inherited}, ${!featureInfo.canEdit}, ${featureInfo.overridden}); Event.stop(event)"</c:set>
      </c:if>
      <c:if test="${not featureInfo.inherited}">
        <c:set var="onclick">onclick="BS.BuildFeatureDialog.showEditDialog('${featurePlace}', '${featureInfo.descriptor.id}', '${featureInfo.descriptor.type}', '${featureInfo.descriptor.buildFeature.displayName}'); Event.stop(event)"</c:set>
      </c:if>
      <tr>
        <td class="highlight" ${onclick} style="vertical-align:top;">
          <admin:featureInfo feature="${featureInfo}" showDescription="false"/>
        </td>
        <td class="highlight" ${onclick}>
          <admin:featureInfo feature="${featureInfo}" showName="false"/>
        </td>
        <c:choose>
          <c:when test="${buildForm.readOnly or not featureInfo.canEdit}">
            <td class="highlight edit" ${onclick}><a href="#" ${onclick}>View</a></td>
          </c:when>
          <c:otherwise>
            <td class="highlight edit" ${onclick}><a href="#" ${onclick}>Edit</a></td>
          </c:otherwise>
        </c:choose>
        <c:if test="${not buildForm.readOnly}">
        <td class="edit">
          <c:set var="featureId" value="${fn:replace(featureInfo.descriptor.id, '.', '_')}"/>
          <c:choose>
            <c:when test="${featureInfo.canEdit}">

          <bs:actionsPopup controlId="featureActions${featureId}" popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
            <jsp:attribute name="content">
              <div>
                <ul class="menuList">
                  <c:if test="${featureInfo.enabled}">
                    <l:li>
                      <a href="#" onclick="BS.AdminActions.setParametersDescriptorEnabled('${buildForm.settingsId}', '${featureInfo.descriptor.id}', false, '${settingName}'); return false">Disable ${settingName}</a>
                    </l:li>
                  </c:if>
                  <c:if test="${not featureInfo.enabled}">
                    <l:li>
                      <a href="#" onclick="BS.AdminActions.setParametersDescriptorEnabled('${buildForm.settingsId}', '${featureInfo.descriptor.id}', true, '${settingName}'); return false">Enable ${settingName}</a>
                    </l:li>
                  </c:if>
                  <c:if test="${featureInfo.inherited and featureInfo.overridden}">
                  <l:li>
                    <a href="#" onclick="BS.BuildFeatureDialog.resetFeature('${featurePlace}', '${featureInfo.descriptor.id}', '${param['messagePrefix']}', false); return false">Reset</a>
                  </l:li>
                  </c:if>
                  <c:if test="${not featureInfo.inherited}">
                  <l:li>
                    <a href="#" onclick="BS.BuildFeatureDialog.deleteFeature('${featurePlace}', '${featureInfo.descriptor.id}', '${param['messagePrefix']}'); return false">Delete</a>
                  </l:li>
                  </c:if>
                </ul>
              </div>
            </jsp:attribute>
            <jsp:body></jsp:body>
          </bs:actionsPopup>

            </c:when>
            <c:otherwise>

              <c:choose>
              <c:when test="${featureInfo.own != null}">
              <bs:actionsPopup controlId="featureActions${featureId}"
                               popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
                <jsp:attribute name="content">
                  <div>
                    <ul class="menuList">
                      <l:li>
                        <a href="#" ${onclick}>View defined in enforced settings</a>
                      </l:li>
                      <l:li>
                        <a href="#" onclick="BS.BuildFeatureDialog.showEditDialog('${featurePlace}', '${featureInfo.descriptor.id}', '${featureInfo.descriptor.type}', '${featureInfo.descriptor.buildFeature.displayName}', true, ${featureInfo.inherited}, ${!featureInfo.canEdit}, ${featureInfo.overridden}); Event.stop(event)">View defined in ${buildForm.template ? 'template' : 'build configuration'}</a>
                      </l:li>
                      <l:li>
                        <a href="#" onclick="BS.BuildFeatureDialog.resetFeature('${featurePlace}', '${featureInfo.descriptor.id}', '${param['messagePrefix']}', true, '${buildForm.template ? 'template' : 'build configuration'}'); return false">Reset defined in ${buildForm.template ? 'template' : 'build configuration'}...</a>
                      </l:li>
                    </ul>
                  </div>
                </jsp:attribute>
                <jsp:body></jsp:body>
              </bs:actionsPopup>
              </c:when>
                <c:otherwise>
                  <span class="btn-group"><button disabled class="btn btn_mini popupLink" type="button"><i class="icon-list-ul"></i> <i class="icon-lock protectedSetting" title="${featureInfo.inheritanceDescription}"></i></button></span>
                </c:otherwise>
              </c:choose>

            </c:otherwise>
          </c:choose>
        </td>
        </c:if>
      </tr>
    </c:if>
  </c:forEach>
</c:set>
<%--<c:if test="${empty tableRows and not empty noFeaturesMessage}"><p>${noFeaturesMessage}</p></c:if>--%>

<c:set var="tableRows" value="${fn:trim(tableRows)}"/>
<c:if test="${not empty tableRows}">
  <l:tableWithHighlighting highlightImmediately="true" className="parametersTable">
    <tr>
      <th style="width: 30%;">Type</th>
      <th colspan="${buildForm.readOnly ? 2 : 3}">Parameters Description</th>
    </tr>
    ${tableRows}
  </l:tableWithHighlighting>
</c:if>

<%@ include file="editBuildFeaturesDialog.jspf" %>

<script type="text/javascript">
  (function() {
    var allFeatureTypes = {};
    var allFeatureDisplayNames = {};

    <c:forEach items="${buildForm.buildFeaturesBean.buildFeatureDescriptors}" var="featureInfo">
    allFeatureTypes['${featureInfo.descriptor.id}'] = '<bs:escapeForJs text="${featureInfo.descriptor.type}"/>';
    allFeatureDisplayNames['${featureInfo.descriptor.id}'] = '<bs:escapeForJs text="${featureInfo.descriptor.buildFeature.displayName}"/>';
    </c:forEach>

    var parsedHash = BS.Util.paramsFromHash('&');
    var type = parsedHash['addFeature'];
    if (type) {
      BS.Util.setParamsInHash({}, '&', true);
      BS.BuildFeatureDialog.showAddDialog('${featurePlace}', '${addButtonTitle}', type);
    } else {
      var featureId = parsedHash['editFeature'];
      if (featureId) {
        BS.Util.setParamsInHash({}, '&', true);
        BS.BuildFeatureDialog.showEditDialog('${featurePlace}', featureId,
                                             allFeatureTypes[featureId],
                                             allFeatureDisplayNames[featureId]);
      }
    }
  })();
</script>
