<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<div class="inactiveLicensesContainer">
  <l:blockStateCss blocksType="Block_inactiveLicenses" collapsedByDefault="false" id="editInactiveLicenses"/>
  <p class="icon_before icon16 blockHeader expanded" id="inactiveLicenses">Inactive license keys: ${fn:length(serverLicenseBean.inactiveLicenses)}</p>
  <form action="#" id="editInactiveLicenses">
    <table class="settings licensesTable inactiveLicensesTable" id="inactiveLicensesTable">
      <tr>
        <th class="name licenseKey">License key</th>
        <th class="name description">Description</th>
        <th class="name edit"><forms:checkbox name="selectAllInaciveCB" onclick="if (this.checked) BS.Util.selectAll($('editInactiveLicenses'), 'removeKeyCB'); else BS.Util.unselectAll($('editInactiveLicenses'), 'removeKeyCB');"/></th>
      </tr>
      <c:forEach items="${serverLicenseBean.inactiveLicenses}" var="lic">
        <tr>
          <td><c:out value="${lic.key}"/></td>
          <td>
            <c:if test="${lic.requiresRenewalBeforeUpgrade}">
              <span class="icon icon16 yellowTriangle" title="The license will become obsolete after upgrade to ${serverLicenseBean.newAvailableVersion.displayName}"></span>
            </c:if>
            <c:choose>
              <c:when test="${not lic.recognized}">Invalid key</c:when>
              <c:when test="${lic.recognized}">
                <strong><c:out value="${lic.licenseName}"/></strong>,
                <c:choose>
                  <c:when test="${not empty lic.expirationDate}">expires: <bs:formatDate value="${lic.expirationDate}" pattern="yyyy-MMM-dd"/></c:when>
                  <c:otherwise>end of maintenance: <bs:formatDate value="${lic.maintenanceDueDate}" pattern="yyyy-MMM-dd"/></c:otherwise>
                </c:choose>

                <c:if test="${lic.licenseExpired}"> (<span class="expired">expired</span>)</c:if>
                <c:if test="${lic.licenseObsolete}"> (<span class="expired">obsolete</span>)</c:if>
              </c:when>
            </c:choose>
          </td>
          <td class="edit">
            <c:set var="keyEscaped"><bs:escapeForJs text='${lic.key}' forHTMLAttribute='true'/></c:set>
            <forms:checkbox name="removeKeyCB" value="${keyEscaped}"/>
          </td>
        </tr>
      </c:forEach>
    </table>
    <div class="licensesActions">
      <a href="#" class="remove btn" onclick="BS.LicensesForm.removeLicenseKeys(BS.Util.getSelectedValues($('editInactiveLicenses'), 'removeKeyCB'));return false">Remove selected</a>
    </div>
  </form>

  <script type="text/javascript">
    <l:blockState blocksType="Block_inactiveLicenses"/>
    new BS.BlocksWithHeader('inactiveLicenses');
  </script>

  <br/>
</div>