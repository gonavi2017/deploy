<%@ page import="jetbrains.buildServer.controllers.admin.projects.AdminEditBuildStepsActionExtensionsController" %>
<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>
<c:set var="cameFrom" value='<%=WebUtil.encode(request.getAttribute("pageUrl") + "&init=1")%>'/>
<admin:editBuildTypePage selectedStep="runType">
  <jsp:attribute name="head_include">
    <bs:linkScript>
      /js/bs/queueLikeSorter.js
    </bs:linkScript>
    <bs:linkCSS>
      /css/admin/buildRunners.css
    </bs:linkCSS>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <div class="section noMargin">
      <h2 class="noBorder">Build Steps</h2>
      <bs:smallNote>
        In this section you can configure the sequence of build steps to be executed.
        Each build step is represented by a build runner and provides integration with a specific build or test tool. <bs:help file="Configuring+Build+Steps"/>
      </bs:smallNote>

      <bs:refreshable containerId="buildStepsContainer" pageUrl="${pageUrl}">
        <c:set var="numRunners" value="${fn:length(buildForm.multipleRunnersBean.buildRunners)}"/>
        <c:set var="numInherited" value="0"/>
        <c:forEach items="${buildForm.multipleRunnersBean.buildRunners}" var="runner"
            ><c:if test="${runner.inherited}"><c:set var="numInherited" value="${numInherited+1}"/></c:if
        ></c:forEach>

        <c:url value='/admin/editRunType.html?id=${buildForm.settingsId}&runnerId=__NEW_RUNNER__&cameFromUrl=${cameFrom}' var="addStepUrl"/>
        <c:if test="${not buildForm.readOnly}">
        <div class="configurationSection">
          <forms:addButton href="${addStepUrl}&init=1">Add build step</forms:addButton>

          <c:if test="${numRunners > 1 and numRunners > numInherited}">
            <div class="shift"></div>
            <a class="btn" href="#" onclick="resetBuildRunnersOrder(); BS.BuildStepsOrderDialog.showCentered(); BS.BuildStepsOrderDialog.fixPageScroll(); return false">Reorder build steps</a>
          </c:if>

          <bs:changeRequest key="buildTypeForm" value="${buildForm}">
            <jsp:include page="<%=AdminEditBuildStepsActionExtensionsController.PATH%>"/>
          </bs:changeRequest>

          <c:if test="${buildForm.runnersAutoDiscoveryPossible}">
            <div class="shift"></div>
            <c:url value="/admin/discoverRunners.html?init=1&id=${buildForm.settingsId}" var="autoDetectLink"/>
            <forms:button href="${autoDetectLink}"><span class="icon-magic" style="color: gray"></span> Auto-detect build steps</forms:button>
          </c:if>
        </div>
        </c:if>

        <c:if test="${numRunners > 0}">
          <l:tableWithHighlighting highlightImmediately="true" className="parametersTable">
            <tr>
              <th colspan="2" style="width: 30%;">Build Step</th>
              <th colspan="${buildForm.readOnly ? 2 : 3}">Parameters Description</th>
            </tr>
            <c:set var="stepno" value="0" />
            <c:forEach items="${buildForm.multipleRunnersBean.buildRunners}" var="runner">
              <c:url value='/admin/editRunType.html?init=1&id=${buildForm.settingsId}&runnerId=${runner.id}&cameFromUrl=${cameFrom}' var="onclickUrl"/>
              <c:set var="onclick">onclick="BS.openUrl(event, '${onclickUrl}')"</c:set>
              <c:set var="stepno" value="${stepno + 1}" />
              <c:if test="${runner.inherited}"><c:set var="numInherited" value="${numInherited+1}"/></c:if>
              <tr class="editBuildStepRow">
                <td class="highlight stepNumber" ${onclick} style="vertical-align: top;">
                  <div style="${not runner.enabled ? 'color: #888': ''}"><c:out value="${stepno}" />.</div>
                </td>
                <td class="highlight stepName" ${onclick} style="vertical-align:top; width: 29%;">
                  <admin:runnerInfo runner="${runner}"/>
                </td>
                <td class="highlight stepDescription" ${onclick}>
                  <admin:runnerInfo runner="${runner}"/>
                </td>
                <c:if test="${not runner.inherited and not buildForm.readOnly}">
                  <td class="edit highlight" ${onclick}><a href="${onclickUrl}">Edit</a></td>
                </c:if>
                <c:if test="${runner.inherited or buildForm.readOnly}">
                  <td class="edit highlight" ${onclick}><a href="${onclickUrl}">View</a></td>
                </c:if>
                <c:if test="${not buildForm.readOnly}">
                  <td class="edit">
                    <c:set var="runId" value="${fn:replace(runner.id, '.', '_')}"/>
                    <bs:actionsPopup controlId="runnerActions${runId}"
                                     popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
                  <jsp:attribute name="content">
                    <div>
                      <ul class="menuList">
                        <l:li>
                          <a href="#" onclick="BS.CopyBuildStepForm.showDialog('${buildForm.settingsId}', '${runner.id}'); return false">Copy build step...</a>
                        </l:li>
                        <c:if test="${runner.enabled}">
                          <l:li>
                            <a href="#" onclick="BS.AdminActions.setParametersDescriptorEnabled('${buildForm.settingsId}', '${runner.id}', false, 'Build step'); return false">Disable build
                              step</a>
                          </l:li>
                        </c:if>
                        <c:if test="${not runner.enabled}">
                          <l:li>
                            <a href="#" onclick="BS.AdminActions.setParametersDescriptorEnabled('${buildForm.settingsId}', '${runner.id}', true, 'Build step'); return false">Enable build step</a>
                          </l:li>
                        </c:if>
                        <c:if test="${not runner.inherited}">
                          <l:li>
                            <a href="#" onclick="BS.MultipleRunnersForm.deleteRunner('${buildForm.settingsId}', '${runner.id}'); return false">Delete</a>
                          </l:li>
                        </c:if>
                      </ul>
                    </div>
                  </jsp:attribute>
                      <jsp:body></jsp:body>
                    </bs:actionsPopup>
                  </td>
                </c:if>
              </tr>
            </c:forEach>
          </l:tableWithHighlighting>
        </c:if>

        <c:url var="action" value="/admin/editBuildRunners.html"/>
        <bs:modalDialog formId="buildStepsOrder"
                        title="Reorder Build Steps"
                        action="${action}"
                        closeCommand="BS.BuildStepsOrderDialog.close()"
                        saveCommand="BS.BuildStepsOrderDialog.submitForm('${buildForm.settingsId}')">
          <a class="toggle-build-details clearfix" href="#"><span class="toggle-build-details__toggle-text">Show</span><span class="toggle-build-details__toggle-text hidden">Hide</span> details</a>
          <div>Use drag and drop to change build steps order.</div>

          <div class="messagesHolder">
            <div id="savingData"><i class="icon-refresh icon-spin"></i> Saving...</div>
            <div id="dataSaved">New build steps order applied.</div>
          </div>

          <div id="buildRunners" class="buildRunners_hidden-descr custom-scroll">
             <c:set var="stepno" value="0" />
             <c:forEach items="${buildForm.multipleRunnersBean.buildRunners}" var="runner">
               <c:set var="stepno" value="${stepno + 1}" />
               <div class="buildRunnerRow ${runner.inherited ? 'inherited' : 'draggable tc-icon_before icon16 tc-icon_draggable'}" id="r_${runner.id}">
                  <div class="name">
                    <admin:runnerInfo runner="${runner}" stepno="${stepno}"/>
                  </div>
               </div>
              </c:forEach>
          </div>

          <div class="popupSaveButtonsBlock">
            <forms:submit label="Apply"/>
            <forms:cancel onclick="BS.BuildStepsOrderDialog.close();"/>
            <forms:saving id="saveOrderProgress"/>
          </div>
        </bs:modalDialog>

        <script type="text/javascript">

          setBuildRunnersSortable();

          $j('.toggle-build-details').on('click', function () {
            $j('#buildRunners').toggleClass('buildRunners_hidden-descr');
            $j('.toggle-build-details__toggle-text').toggleClass('hidden');
            BS.BuildStepsOrderDialog.showCentered();
            BS.BuildStepsOrderDialog.fixPageScroll();
            return false;
          });

          function setBuildRunnersSortable() {
            $j('#buildRunners').find('.buildRunnerRow').disableSelection();
            $j('#buildRunners').sortable({
              cancel: '.inherited',
              tolerance: 'pointer',
              scroll: true,
              axis: 'y',
              opacity: 0.7
            });
          }


          var originalBuildRunnersOrder = [];

          function rememberBuildRunnersOrder() {
            $j('.buildRunnerRow').each(function(index, el) {
              originalBuildRunnersOrder.push(el.outerHTML);
            });
          }

          rememberBuildRunnersOrder();

          function resetBuildRunnersOrder() {
            $j('.buildRunnerRow').each(function(index, el) {
              el.outerHTML = originalBuildRunnersOrder[index];
            });
          }

        </script>
      </bs:refreshable>
    </div>
  </jsp:attribute>
</admin:editBuildTypePage>
