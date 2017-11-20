<%--@elvariable id="serverLicenseBean" type="jetbrains.buildServer.controllers.license.ServerLicenseBean"--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<h3 class="title_underlined">Active license keys</h3>

<form action="#" id="editActiveLicenses">
  <table class="settings licensesTable">
    <tr>
      <th class="name licenseKey">License key</th>
      <th class="name">Type</th>
      <th class="name numAgents" ># of agents</th>
      <th class="name numConfs" ># of build configurations</th>
      <th class="name generationDate">Generation date</th>
      <th class="name subscriptionDate">End of maintenance</th>
      <th class="name expirationDate">Expiration date</th>
      <th class="name edit"><forms:checkbox name="selectAllActiveCB" onclick="if (this.checked) BS.Util.selectAll($('editActiveLicenses'), 'removeKeyCB'); else BS.Util.unselectAll($('editActiveLicenses'), 'removeKeyCB');"/></th>
    </tr>
    <c:forEach items="${serverLicenseBean.licenses}" var="lic">
      <tr>
        <td class="licenseKey">
          ${lic.key}
        </td>
        <td class="licenseType">
          <strong><c:out value="${lic.licenseName}"/></strong>
        </td>
        <td class="numAgents"><c:out value='${lic.numberOfAgents}'/></td>
        <td class="numConfs"><c:out value='${lic.numberOfConfigurations}'/></td>
        <td class="generationDate"><bs:formatDate value="${lic.generationDate}" pattern="yyyy-MMM-dd"/></td>
        <td class="subscriptionDate">
          <c:if test="${lic.maintenanceExpired || lic.maintenanceExpiringSoon || lic.requiresRenewalBeforeUpgrade}">
            <c:set var="warningContent">
              <c:choose>
                <c:when test="${lic.maintenanceExpired}">
                  <div>Maintenance is expired</div>
                </c:when>
                <c:when test="${not lic.maintenanceExpired and lic.maintenanceExpiringSoon}">
                  <div>Maintenance is expiring soon</div>
                </c:when>
                <c:when test="${lic.requiresRenewalBeforeUpgrade}">
                  <div>The license needs renewing before upgrade to <c:out value="${serverLicenseBean.newAvailableVersion.displayName}"/></div>
                </c:when>
              </c:choose>
            </c:set>
            <span class="icon icon16 yellowTriangle" <bs:tooltipAttrs text="${warningContent}"></bs:tooltipAttrs>></span>
          </c:if>
          <bs:formatDate value="${lic.maintenanceDueDate}" pattern="yyyy-MMM-dd"/>
        </td>
        <td class="expirationDate">
          <c:choose>
            <c:when test="${not empty lic.expirationDate}">
              <c:if test="${lic.expiringSoon}"><span class="icon icon16 yellowTriangle" title="License is expiring soon"></span></c:if>
              <bs:formatDate value="${lic.expirationDate}" pattern="yyyy-MMM-dd"/>
            </c:when>
            <c:otherwise>N/A</c:otherwise>
          </c:choose>
          <c:if test="${lic.licenseExpired}"> (<span class="expired">expired</span>)</c:if>
        </td>
        <td class="edit">
          <c:set var="keyEscaped"><bs:escapeForJs text='${lic.key}' forHTMLAttribute='true'/></c:set>
          <forms:checkbox name="removeKeyCB" value="${keyEscaped}"/>
        </td>
      </tr>
    </c:forEach>
  </table>
  <div class="licensesActions">
    <a href="#" class="remove btn" onclick="BS.LicensesForm.removeLicenseKeys(BS.Util.getSelectedValues($('editActiveLicenses'), 'removeKeyCB'));return false">Remove selected</a>
  </div>
</form>