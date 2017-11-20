<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<div id="buildResultsSummaryTemplate" style="display:none">
  <div class="summaryContainer">
    <div id="detailedSummary:##BUILD_ID##">
      <table>
      <tr>
        <td>
          <div class="header">Build shortcuts</div>
          <ul class="bsLinks">
            <li>
              <a href="<c:url value='/viewLog.html?tab=buildLog&buildTypeId=##BUILD_TYPE_ID##&buildId=##BUILD_ID##'/>"
                     title="View log messages">Build log</a>
              <span class="separator">|</span>
              <a href="<c:url value='downloadBuildLog.html?buildId=##BUILD_ID##&archived=true'/>" target="_blank"
                      title="Download archived build log">.zip</a>
            </li>
            <li><span id="summaryProgress:##BUILD_ID##" style="font-weight: normal; color:#888;"></span></li>
          </ul>
        </td>
      </tr>
      </table>
    </div>
  </div>
</div>
<div id="issueDetailsTemplate" style="display:none">
  <div id="detailedSummary:##ISSUE_ID##_##PROJECT_ID##">
    <forms:progressRing className="progressRingInline"/>
  </div>
</div>
