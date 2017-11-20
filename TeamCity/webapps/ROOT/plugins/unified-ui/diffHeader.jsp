<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="/include.jsp" %>
<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%>

<%--@elvariable id="modification" type="jetbrains.buildServer.vcs.VcsModification"--%>
<%--@elvariable id="fileModification" type="jetbrains.buildServer.vcs.VcsFileModification"--%>
<%--@elvariable id="prevChange" type="String"--%>
<%--@elvariable id="nextChange" type="String"--%>

<c:set var="ignoreSpaces" value="false"/>
<c:choose>
  <c:when test="${fileModification.type == 'CHANGED'}"><c:set var="chg" value="edited"/></c:when>
  <c:when test="${fileModification.type == 'ADDED'}"><c:set var="chg" value="added"/></c:when>
  <c:when test="${fileModification.type == 'REMOVED'}"><c:set var="chg" value="deleted"/></c:when>
  <c:when test="${fileModification.type == 'NOT_CHANGED'}"><c:set var="chg" value="unchanged"/></c:when>
</c:choose>

<c:set var="isActualModification" value="${modification.id >= 0}"/>
<c:if test="${isActualModification}">
  <c:set var="queryParams" value="modId=${modification.id}&personal=${modification.personal}"/>
  <c:set var="queryParams" value="${queryParams}&openFileLinksInSameTab=true&highlightChange=${fileModification.fileName}"/>
</c:if>

<c:if test="${!isActualModification}">
  <c:set var="chg" value="${fileModification.changeTypeName}"/>
</c:if>

<div class="diff-header">
  <div class="diff-header__filename">
    <a class="diff-header__close" href="#" onclick="window.close(); return false" title="Close window">&#xd7;</a>
    <c:if test="${isActualModification}">
      <span class="diff-header__prevnext">
        <c:choose>
          <c:when test="${empty prevChange}">
            <a class="diff-header__prevnext__link diff-header__prevnext__link_disabled" href="#">&larr;</a>
          </c:when>
          <c:otherwise>
            <c:url value='/diff.html?id=${modification.id}&personal=${modification.personal}' var="prevDiffUrl">
              <c:param name="vcsFileName" value="${prevChange}"/>
            </c:url>
            <a class="diff-header__prevnext__link" href="${prevDiffUrl}" title="Show previous file diff">&larr;</a>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${empty nextChange}">
            <a class="diff-header__prevnext__link diff-header__prevnext__link_disabled" href="#">&rarr;</a>
          </c:when>
          <c:otherwise>
            <c:url value='/diff.html?id=${modification.id}&personal=${modification.personal}' var="nextDiffUrl">
              <c:param name="vcsFileName" value="${nextChange}"/>
            </c:url>
            <a class="diff-header__prevnext__link" href="${nextDiffUrl}" title="Show next file diff">&rarr;</a>
          </c:otherwise>
        </c:choose>
      </span>
    </c:if>

    <c:set var="chgAndFileName">
      ${chg} <bs:trimWithTooltip trimCenter="true" maxlength="120">${fileModification.relativeFileName}</bs:trimWithTooltip>
    </c:set>
    <c:choose>
      <c:when test="${isActualModification}">
        <bs:popupControl showPopupCommand="BS.FilesPopup.showPopup(event, {parameters: '${queryParams}'});"
                         hidePopupCommand="BS.FilesPopup.hidePopup();"
                         stopHidingPopupCommand="BS.FilesPopup.stopHidingPopup();"
                         controlId="modfiles:${modification.id}"
                         clazz="fileNamePopup">${chgAndFileName}</bs:popupControl>
        <ext:includeExtensions placeId="<%=PlaceId.CHANGED_FILE_LINK%>"/>
      </c:when>
      <c:otherwise>
        <span style="color: white;">${chgAndFileName}</span>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="diff-header__desc">
    <div class="diff-header__buttonbar">
      <c:if test="${isActualModification}">
        <span class="diff-header__buttonbar__ide">
          <a href="#" onclick="BS.Activator.doOpen('file?file=${fileModification.relativeFileName}'); return false"
             title="Open file in IDE" <bs:iconLinkStyle icon="IDE"/>>Open in IDE</a>
        </span>
      </c:if>
    </div>

    <div class="diff-header__desc__text" title="<c:out value="${modification.description}"/>">
      <c:choose>
        <c:when test="${isActualModification}">
          <strong><bs:changeCommitters modification="${modification}"/></strong>: <bs:out value="${modification.description}" resolverContext="${modification}"/>
        </c:when>
        <c:otherwise>
          <c:set var="userName" value="${modification.userName}"/>
          <c:if test="${not empty userName}"><strong><c:out value="${userName}"/></strong>: </c:if><bs:out value="${modification.description}" resolverContext="${modification}"/>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<div class="diff-header__toolbar">
  <c:set var="personal" value="${param['personal']=='true'}"/>
  <span class="column-before invisible">
    <!-- Show legend in case of comparison failure diff -->
    <c:if test="${fileModification.beforeChangeRevisionNumber eq 'Expected'}"><span class="legend"><c:out value="${fileModification.beforeChangeRevisionNumber}"/></span></c:if>
    <a href="#" class="clipboard tc-icon_before icon16 tc-icon_copy" data-for="original">Copy</a>
    <c:if test="${personal}"><span class="personal-build">Displaying LATEST repository revision</span></c:if>
  </span>
  <span class="column-after invisible">
    <!-- Show legend in case of comparison failure diff -->
    <c:if test="${fileModification.afterChangeRevisionNumber eq 'Actual'}"><span class="legend"><c:out value="${fileModification.afterChangeRevisionNumber}"/></span></c:if>
    <a href="#" class="clipboard tc-icon_before icon16 tc-icon_copy" data-for="modified">Copy</a>
  </span>
</div>
