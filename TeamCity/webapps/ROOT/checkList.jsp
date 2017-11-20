<%@ include file="include-internal.jsp"%>
<jsp:useBean id="form" scope="request" type="jetbrains.buildServer.controllers.popupDialogs.checkLists.CheckListForm"/>

<bs:linkCSS dynamic="${true}">
  /css/checkList.css
</bs:linkCSS>
<bs:linkScript>
  /js/bs/checkList.js
</bs:linkScript>

<c:set var="typeId" value="${form.type.typeId}"/>
<c:set var="contextId" value="${form.contextId}"/>
<c:set var="contextParam"><c:if test="${not empty contextId}">&contextId=<bs:forUrl val="${contextId}"/></c:if></c:set>
<c:url var="refreshUrl" value="/popupDialog.html?typeId=${typeId}${contextParam}"/>

<div class="checkList">

  <c:set var="note" value="${form.topHtmlNote}"/>
  <c:if test="${not empty note}">
    <div>${note}</div> <%-- do not escape this note, it can contain HTML code--%>
    <div class="verticalStrut"></div>
  </c:if>

  <script type="text/javascript">
    <c:forEach items="${form.items}" var="item">
      if (!BS.CheckList._childItemIds['${item.info.parentId}']) {
        BS.CheckList._childItemIds['${item.info.parentId}'] = [];
      }
      BS.CheckList._childItemIds['${item.info.parentId}'].push('${item.info.id}');
    </c:forEach>
  </script>

  <bs:refreshable containerId="checkListContent_${typeId}" pageUrl="${refreshUrl}">

    <form id="checkListFirstForm_${typeId}">

      <c:if test="${form.hasFilteringSupport}">
        <table class="filterTable">
          <tr>
            <td class="filterInputTd">
              <input type="text" id="checkListFilter_${typeId}" value="${form.keyPhrase}"/>
              <span id="checkListFilterProgressIcon_${typeId}" class="iconPlace iconProgressRing" style="display: none">
                <forms:progressRing progressTitle="Filtering..."/>
              </span>
              <span id="checkListFilterEmptyIcon_${typeId}" class="iconPlace" style="display: none"></span>
              <span id="checkListFilterErrorIcon_${typeId}" class="iconPlace " style="display: none">
                <span class="icon icon16 build-status-icon build-status-icon_error"></span>
              </span>
            </td>
          </tr>
        </table>
        <div class="verticalStrut"></div>
      </c:if>

      <c:set var="hasValidationSupport" value="${form.hasValidationSupport}"/>
      <c:set var="hasCustomOptionsSupport" value="${form.hasCustomOptionsSupport}"/>
      <c:set var="stateChangedJS" value="BS.CheckList.stateChanged(this, '${typeId}', ${hasValidationSupport}, ${hasCustomOptionsSupport});" scope="request"/>

      <c:set var="hasVisibleItem" value="${false}"/>
      <bs:refreshable containerId="checkListItems_${typeId}" pageUrl="${refreshUrl}">
        <div class="checkListItems">
          <table>
            <c:forEach items="${form.items}" var="item">
              <c:if test="${item.visible}">
                <c:set var="hasVisibleItem" value="${true}"/>
              </c:if>
              <c:set var="checkBoxId" value="checkListItem-${typeId}-${item.info.id}" scope="request"/>
              <tr style="<c:if test="${not item.visible}">display: none;</c:if>">
                <td>
                  <forms:checkbox
                      id="${checkBoxId}"
                      name=""
                      value="${item.info.id}"
                      checked="${item.checked}"
                      disabled="${!item.info.editable}"
                      onclick="${stateChangedJS}"
                      className="check-list-item-${typeId}"
                      style="margin-left: 0"/>
                </td>
                <td style="padding-left: ${15 * item.depth}px">
                  <c:set var="checkListItem" value="${item}" scope="request"/>
                  <jsp:include page="${form.itemRendererJspPage}"/>
                </td>
              </tr>
            </c:forEach>
          </table>
        </div>
        <c:if test="${hasVisibleItem}">
          <div class="verticalStrut"></div>
        </c:if>

        <c:if test="${form.hasCurrentStateInfoSupport}">
          <bs:refreshable containerId="checkListStateInfo_${typeId}" pageUrl="${refreshUrl}">
            <div><c:out value="${form.currentStateInfoText}"/></div>
            <div class="verticalStrut"></div>
          </bs:refreshable>
        </c:if>

      </bs:refreshable>

    </form>

    <c:if test="${form.hasCustomOptionsSupport}">
      <form id="checkListCustomOptionsForm_${typeId}">
        <jsp:include page="${form.customOptionsJspPagePath}"/>
      </form>
      <div class="verticalStrut"></div>
    </c:if>

    <c:if test="${hasValidationSupport}">
      <bs:refreshable containerId="checkListWarnings_${typeId}" pageUrl="${refreshUrl}">
        <div id="checkListValidationEmpty_${typeId}" class="validationStatus">
          &nbsp;
        </div>
        <div id="checkListValidationProgress_${typeId}" class="validationStatus" style="display: none;">
          <forms:progressRing/>
          <c:out value="${form.validationProgressText}"/>
        </div>
        <div id="checkListValidationError_${typeId}" class="validationStatus" style="display: none;">
          <span class="icon icon16 build-status-icon build-status-icon_error"></span>
          <span id="checkListValidationErrorText_${typeId}">&nbsp;</span>
        </div>
        <div id="checkListValidationResult_${typeId}">
          <c:set var="warnings" value="${form.warnings}"/>
          <c:choose>
            <c:when test="${empty warnings}">
              <c:set var="noWarningsText" value="${form.noWarningsText}"/>
              <c:if test="${noWarningsText != null}">
                <div class="verticalStrut"></div>
                <img src="<c:url value='/img/buildStates/success.png'/>" width="16" height="16" style="vertical-align: text-bottom;"/>
                <c:out value="${noWarningsText}"/>
              </c:if>
            </c:when>
            <c:otherwise>
              <div class="verticalStrut"></div>
              <c:forEach items="${warnings}" var="warning">
                <c:set var="_warning" value="${warning}" scope="request"/>
                <div class="icon_before icon16 attentionComment"><jsp:include page="${warning.rendererPage}"/></div>
                <div class="verticalStrut"></div>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </div>
      </bs:refreshable>
    </c:if>

  </bs:refreshable>

  <c:if test="${form.hasFilteringSupport}">
    <script type="text/javascript">
      (function($) {
        var input = $("#checkListFilter_${typeId}");

        input.focus();
        input.select();

        input.on('keyup', _.throttle(function() {
          BS.CheckList.filterChanged('${typeId}');
        }, 100));
      })(jQuery);
    </script>
  </c:if>

  <form id="checkListSecondForm_${typeId}">
    <div class="popupSaveButtonsBlock">
      <forms:submit type="button" label="Save" onclick="BS.CheckList.submitForm('${typeId}', ${hasCustomOptionsSupport});"/>
      <forms:cancel onclick="BS.CheckList.cancel('${typeId}')"/>
      <forms:saving id="checkListMainProgressIcon_${typeId}"/>
    </div>
  </form>
</div>