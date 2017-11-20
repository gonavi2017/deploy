<%@ tag import="jetbrains.buildServer.web.openapi.CustomTab" %>
<%@ tag import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="placeId" required="true" type="jetbrains.buildServer.web.openapi.PlaceId" %><%@
    attribute name="urlPrefix" required="true"  %><%@
    attribute name="tabContainerId" required="false"  %><%@
    attribute name="showActiveTabContent" required="false" type="java.lang.Boolean"

%><c:if test="${empty showActiveTabContent}"><c:set var="showActiveTabContent" value="${true}"/></c:if
><c:if test="${fn:contains(urlPrefix, '?')}"><c:set var="urlPrefix" value="${urlPrefix}&"/></c:if
><c:if test="${not fn:contains(urlPrefix, '?')}"><c:set var="urlPrefix" value="${urlPrefix}?"/></c:if
><c:set var="containerId" value="${empty tabContainerId ? 'tabsContainer3' : tabContainerId}"
/><c:set var="tabParamName"><%=placeId.equals(PlaceId.EDIT_PROJECT_PAGE_TAB) ? "item" : "tab"%></c:set
><ext:defineExtensionTab placeId="${placeId}"

/><c:if test="${not empty extensionTab}"
  ><bs:trimWhitespace>
    <script type="text/javascript">
      (function() {
        var tabs = new TabbedPane("${placeId.anchor}");
        <ext:forEachTab placeId="${placeId}">
          <c:if test="${extension.visible or extensionTab == extension}">
          <c:set var="tabCaption" value="<%=((CustomTab)jspContext.getAttribute(\"extension\")).getTabTitle((HttpServletRequest)((PageContext)jspContext).getRequest())%>"/>
          <c:set var="tabCaption"><bs:forJs>${tabCaption}</bs:forJs></c:set>

            // plugin ${extension.tabId}:
            tabs.addTab('${extension.tabId}', {
              caption: '${tabCaption}',
              <c:choose>
                <c:when test="${extension.visible}">
                  url: '<c:url value="${urlPrefix}tab=${extension.tabId}"/>'
                </c:when>
                <c:otherwise>
                  url: '#'
                </c:otherwise>
              </c:choose>
            });
          </c:if>
        </ext:forEachTab>

        tabs.showIn('${containerId}');
        tabs.setActiveCaption('${extensionTab.tabId}');

        // Example: "Users and Groups \u2014 TeamCity" -> "Users and Groups > Users \u2014 TeamCity"
        var tabTitle = '> <c:out value="${extensionTab.tabTitle}"/> \u2014 TeamCity';

        if (document.title.indexOf(tabTitle) == -1) {
          document.title = document.title.replace(/\u2014 TeamCity$/, tabTitle);
        }
      })();
    </script>
  </bs:trimWhitespace>
  <jsp:doBody/>
  <c:if test="${showActiveTabContent}"><ext:includeExtension extension="${extensionTab}"/></c:if>
</c:if>