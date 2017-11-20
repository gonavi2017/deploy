<%@include file="/include-internal.jsp" %>
<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request" />

<h2 class="noBorder">Versioned Settings</h2>

<bs:linkCSS>
  /css/pager.css
  /css/filePopup.css
</bs:linkCSS>

<bs:refreshable containerId="versionedSettingsTabs" pageUrl="${pageUrl}">
  <div id="tabsContainer4" class="simpleTabs clearfix">
    <ul class="tabs">
      <c:forEach var="tab" items="${tabs}">
        <li class="${tab.selected ? 'selected' : ''}">
          <p>
            <a class="tabs" href="<c:url value="${basePageUrl}&subTab=${tab.id}"/>">${tab.title}</a>
          </p>
        </li>
      </c:forEach>
    </ul>
  </div>

  <jsp:include page="${selectedTab.contentUrl}"/>

</bs:refreshable>
