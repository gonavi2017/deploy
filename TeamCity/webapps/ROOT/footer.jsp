<%--@elvariable id="serverTC" type="jetbrains.buildServer.serverSide.impl.BuildServerImpl"--%>
<%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<%--@elvariable id="newVersionBean" type="jetbrains.buildServer.controllers.updates.NewVersionBean"--%>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="include-internal.jsp"
  %><c:set var="mode" value="${serverSummary.enterpriseMode ? 'ent' : 'prof'}"
  /><c:url value="https://www.jetbrains.com/teamcity/feedback?source=footer&version=${serverTC.fullServerVersion}&build=${serverTC.buildNumber}&mode=${mode}" var="feedbackUrl"/>

<div id="footer">
  <div class="footerExtensions fixedWidth"><ext:includeExtensions placeId="<%=PlaceId.ALL_PAGES_FOOTER%>"/></div>

  <div class="footerMainContainer">
    <div class="footerMain fixedWidth clearfix">
      <div class="column1">
        <div class="columnContent">
          <a class="icon_before icon16 helpLink" target="_blank" href="<bs:helpUrlPrefix/>"> Help</a>
          <a class="icon_before icon16 feedbackLink" target="_blank" href="${feedbackUrl}"> Feedback</a>
        </div>
      </div>

      <div class="column2">
        <div class="columnContent">
          <bs:licenseAndVersion licensingPolicy="${serverSummary.licensingPolicy}"
          /><c:if test="${serverSummary.enterpriseMode && serverTC.licenseExpiringSoon}"
          ><span class="expirationWarning">
          <authz:authorize allPermissions="MANAGE_SERVER_LICENSES">
            <jsp:attribute name="ifAccessDenied">
              will expire in ${serverTC.daysToLicenseExpiration} day<bs:s val="${serverTC.daysToLicenseExpiration}"/>
            </jsp:attribute>
            <jsp:attribute name="ifAccessGranted">
              <a href="<c:url value='/admin/admin.html?item=license'/>" class="expirationWarning">will expire in ${serverTC.daysToLicenseExpiration} day<bs:s val="${serverTC.daysToLicenseExpiration}"/></a>
            </jsp:attribute>
          </authz:authorize></span
          ></c:if>

          <c:if test="${newVersionBean != null}">
            <div>
              <span class="icon_before icon16 newVersionLink"><bs:downloadNewVersionLink newVersionBean="${newVersionBean}" linkText="Get new version!"/></span>
            </div>
          </c:if>

        </div>
      </div>

      <div class="column3">
        <div class="columnContent">
          <a onclick="BS.Util.popupWindow('<c:url value='/showAgreement.html'/>', 'agreement'); return false" href="#">License agreement</a>
        </div>
      </div>

    </div>
  </div>
</div>

<script type="text/javascript">
  (function($) {
    var mainContent = $('#mainContent'),
        footer = $('#footer');

    mainContent.css('padding-bottom', footer.height() + 'px');
    footer.css('height', footer.height() + 'px');
    footer.css('visibility', 'visible');
  })(jQuery);
</script>
