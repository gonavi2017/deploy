<%@ include file="/include-internal.jsp"%>
<jsp:useBean id="auditLogData" scope="request" type="jetbrains.buildServer.controllers.audit.AuditLogData"/>
<bs:webComponentsSettings/>

<style>
  .comboBox {
    display: inline-block;
    max-width: 330px;
    margin-right: 10px;
  }
</style>
<form action="<c:url value="/admin/audit.html"/>" method="post" id="auditLogFilterForm" onsubmit="BS.AuditLogFilterForm.submit(); return false;">
  <div class="actionBar">
    <span class="actionBarRight">
      <label for="actionsPerPage">Results per page:</label>&nbsp;
      <select id="actionsPerPage" name="actionsPerPage" onchange="BS.AuditLogFilterForm.submit();">
        <admin:_actionsPerPageOption value="10" auditLogData="${auditLogData}"/>
        <admin:_actionsPerPageOption value="20" auditLogData="${auditLogData}"/>
        <admin:_actionsPerPageOption value="50" auditLogData="${auditLogData}"/>
        <admin:_actionsPerPageOption value="100" auditLogData="${auditLogData}"/>
        <admin:_actionsPerPageOption value="200" auditLogData="${auditLogData}"/>
        <admin:_actionsPerPageOption value="500" auditLogData="${auditLogData}"/>
      </select>
      <input type="hidden" name="reset" id="reset"/>
    </span>

    <span class="nowrap">
      <label class="firstLabel" for="actionTypeSet">Show:</label>
      <forms:select id="actionTypeSet" name="actionTypeSet" className="comboBox" enableFilter="true" filterOptions="{maxWidth: 175}">
        <c:forEach items="${auditLogData.actionTypeSets}" var="actionTypeSet">
          <c:set var="optionFullName"><c:out value="${actionTypeSet.fullName}"/></c:set>
          <option data-title="${optionFullName}"
                  <c:if test="${auditLogData.selectedActionTypeSetIdAsString == actionTypeSet.id}">selected="true"</c:if>
                  value="${actionTypeSet.id}"
                  class="<c:if test='${actionTypeSet.group}'>optgroup </c:if>user-depth-${actionTypeSet.limitedDepth}"
              >
            <c:out value="${actionTypeSet.name}"/>
          </option>
        </c:forEach>
      </forms:select>
    </span>

    <span class="nowrap">
      <label for="filterScopeId">in:</label>
      <c:choose>
        <c:when test="${restSelectorsDisabled}">
          <forms:select id="filterScopeId" name="filterScopeId" className="comboBox" enableFilter="true" filterOptions="{maxWidth: 175}">
            <option <c:if test="${!auditLogData.filterScopeIdFilterApplied}">selected="true"</c:if> value="-1">Everywhere</option>
            <c:forEach items="${auditLogData.filterScopes}" var="filterScope">
              <c:set var="optionTitle"><c:out value="${filterScope.description}"/></c:set>
              <c:set var="optionFullName"><c:out value="${filterScope.fullName}"/></c:set>
              <option title="${optionTitle}"
                      data-title="${optionFullName}"
                      <c:if test="${auditLogData.filterScopeId == filterScope.id}">selected="true"</c:if>
                      value="${filterScope.id}"
                      class="<c:if test='${filterScope.group}'>optgroup </c:if>user-depth-${filterScope.limitedDepth}"
                  >
                <c:out value="${filterScope.name}"/>
              </option>
            </c:forEach>
          </forms:select>
        </c:when>
        <c:otherwise>
          <input name="filterScopeId" id="filterScopeId" value="${auditLogData.filterScopeId}" type="hidden"/>
          <div id="buildTypeSelector" class="comboBox" style="width: 330px;"></div>
          <script>
            BS.RestProjectsPopup.componentPlaceholder('#buildTypeSelector', 'buildtype-dropdown', function(){
              var dropdown = document.createElement('buildtype-dropdown');
              dropdown.allItemName = 'Everywhere';
              dropdown.server = base_uri;
              dropdown.selectableNodeTypes = ['bt', 'project', 'all'];
              dropdown.expandAll = true;
              dropdown.settings = {
                quickNavigation: false,
                editMode: false,
                source: 'global',
                baseUri: base_uri,
                currentServer: base_uri,
                hideFirstServerHeader: true
              };
              var selected = null;
              <c:if test="${auditLogData.filterScopeIdFilterApplied}">
                <c:forEach items="${auditLogData.filterScopes}" var="filterScope">
                  <c:if test="${auditLogData.filterScopeId == filterScope.id}">
                    var idRE = /^(buildType|project)_(.*)$/;
                    var parsedId = '${filterScope.id}'.match(idRE);
                    if (parsedId !== null) {
                      var type = parsedId[1];
                      if (type === 'buildType') {
                        type = 'bt';
                      }
                      var id = parsedId[2];

                      selected = {
                        nodeType: type,
                        id: id,
                        fullPath: '<bs:escapeForJs text="${filterScope.fullName}"/>',
                        name: '<bs:escapeForJs text="${filterScope.name}"/>'
                      };
                    }
                  </c:if>
                </c:forEach>
              </c:if>
              dropdown.selected = selected;

              $j('#buildTypeSelector').append(dropdown);
              $j('#buildTypeSelector').on('buildtype-changed', function(e){
                var item = e.detail;
                var filterScopeId;
                switch (item.nodeType) {
                  case 'project':
                    filterScopeId = 'project_' + item.id;
                    break;
                  case 'bt':
                    filterScopeId = 'buildType_' + item.id;
                    break;
                  default:
                    filterScopeId = -1;
                }
                $j('#filterScopeId').val(filterScopeId);
                dropdown.ensureClose();
              });
              dropdown.loadData();
            });
          </script>
        </c:otherwise>
      </c:choose>
    </span>

    <span class="nowrap">
      <label for="userId">by:</label>
      <forms:select id="userId" name="userId" className="comboBox" enableFilter="true" filterOptions="{maxWidth: 175}">
        <option <c:if test="${!auditLogData.userIdFilterApplied}">selected="true"</c:if> value="-1"><c:out value="All users"/></option>
        <c:forEach items="${auditLogData.users}" var="user">
          <option <c:if test="${auditLogData.selectedUserId == user.id}">selected="true"</c:if> value="${user.id}"><c:out value="${user.descriptiveName}"/></option>
        </c:forEach>
      </forms:select>
    </span>

    <div style="display: inline-block; min-width: 76px;">
      <forms:filterButton/>
      <c:if test="${auditLogData.filterApplied}"><forms:resetFilter resetHandler="BS.AuditLogFilterForm.clearFilter();"/></c:if>
      <forms:saving id="auditLogFilterApplyingProgressIcon" className="progressRingInline"/>
    </div>
  </div>

  <div id="auditPermalink">
    <admin:_auditLogPermalink data="${auditLogData}"/>
  </div>
</form>
