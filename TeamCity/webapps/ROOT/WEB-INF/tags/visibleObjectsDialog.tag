<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@

    attribute name="actionUrl" type="java.lang.String" required="true"  %><%@
    attribute name="object" type="java.lang.String" required="true"  %><%@
    attribute name="objectHumanReadable" type="java.lang.String" required="true"  %><%@
    attribute name="jsDialog" type="java.lang.String" required="true"  %><%@
    attribute name="resetButtonLabel" type="java.lang.String" required="false"  %><%@
    attribute name="visibleObjectBean" type="jetbrains.buildServer.controllers.profile.VisibleObjectBean" required="true" %><%@
    attribute name="resetAction" type="java.lang.Boolean" required="false" %><%@
    attribute name="rootProject" type="jetbrains.buildServer.serverSide.SProject" required="false"

%><bs:modalDialog formId="${object}_visibleForm"
                  title="Configure visible ${objectHumanReadable}"
                  action="${actionUrl}"
                  closeCommand="${jsDialog}.close();"
                  saveCommand="${jsDialog}.save();">
  <c:set value="${visibleObjectBean.objectsOrderParsed}" var="order"/>
  <bs:visibleObjectsDialogContent showReorderButtons="${true}"
                                  object="${object}"
                                  jsDialog="${jsDialog}"
                                  visibleTitle="Visible ${objectHumanReadable}"
                                  hiddenTitle="Hidden ${objectHumanReadable}"
                                  filterText="filter ${objectHumanReadable}">
    <jsp:attribute name="visibleOptions">
      <c:if test="${not empty rootProject}"><option value="" data-filter-data="0"><c:out value="${rootProject.name}"/></option><c:set var="addLevel" value="1"/></c:if>
      <c:forEach items="${visibleObjectBean.orderedVisible}" var="objectBean">
        <c:set var="objectName"><c:out value="${objectBean.name}"/></c:set>
        <option value="${objectBean.id}" data-filter-data="${objectBean.depth + addLevel}" class="projectName depth-${objectBean.depth + addLevel} <c:if test="${util:contains(order, objectBean.id)}">moved</c:if>" title="${objectName}">
          ${objectName}
        </option>
      </c:forEach>
    </jsp:attribute>
    <jsp:attribute name="hiddenOptions">
      <c:forEach items="${visibleObjectBean.sortedHidden}" var="objectBean">
        <option class="inplaceFiltered" value="${objectBean.id}"
                data-filter-data="${objectBean.depth}" data-title="<c:out value='${objectBean.fullName}'/>"
                <c:if test="${objectBean.disabled}">disabled="disabled"</c:if>>
          <c:out value="${objectBean.name}"/>
        </option>
      </c:forEach>
    </jsp:attribute>
  </bs:visibleObjectsDialogContent>
  <div <c:if test="${fn:length(visibleObjectBean.objectsOrder) == 0}">style="display: none"</c:if> class="reorderedMessage">Some ${objectHumanReadable} are reordered (underlined)</div>
  <div <c:if test="${fn:length(visibleObjectBean.objectsOrder) != 0}">style="display: none"</c:if> class="reorder">You can change ${objectHumanReadable} order. This order will be applied to your personal Overview page. </div>
  <input type="hidden" id="${object}_order" name="${object}_order" value="<c:out value="${visibleObjectBean.objectsOrder}"/>"/>

  <div class="popupSaveButtonsBlock">
    <c:if test="${resetAction}"><c:if test="${empty resetButtonLabel}"><c:set var="resetButtonLabel" value="Reset to defaults"/></c:if>
      <forms:submit type="button" label="${resetButtonLabel}" onclick="${jsDialog}.resetAction();"/>
    </c:if>
    <forms:submit label="Save"/>
    <forms:cancel onclick="${jsDialog}.close()"/>
    <forms:saving id="${object}_savingVisible"/>
  </div>
</bs:modalDialog>
