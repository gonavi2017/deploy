<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
    %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
    %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
    %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
    %><%@ attribute name="vcsRootsBean" required="true" type="jetbrains.buildServer.controllers.RevisionsBean"
    %><%@ attribute name="buildId" required="true"
    %>
<c:url value='/ajax.html' var="action"/>

<style type="text/css">
  .mergeSourcesFormDialog {
    width: 50em;
  }
</style>

<bs:modalDialog formId="mergeSourcesForm"
                title="Merge this build sources"
                action="${action}"
                closeCommand="BS.Merge.close()"
                saveCommand="BS.Merge.merge()">

  <div style="margin-bottom: 1em;">
    <label for="dstBranch" style="margin-right: 1em; margin-left: 1em;">Merge into branch:</label>
    <forms:select name="dstBranch">
      <c:forEach var="branch" items="${vcsRootsBean.logicalBranchNames}">
        <forms:option value="${branch}"><c:out value="${util:truncate(branch, 65)}"/></forms:option>
      </c:forEach>
    </forms:select>
    <span class="error" id="error_dstBranch" style="margin-left: 0;"></span>
  </div>

  <div style="margin-bottom: 1em; margin-left: 1em;">
    <div><label for="message">Comment:<l:star/></label></div>
    <forms:textField name="message" expandable="true" minheight="100" style="width: 46em;" className="longField"/>
    <span class="error" id="error_message" style="margin-left: 0;"></span>
  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Merge"/>
    <forms:cancel onclick="BS.Merge.close()"/>
    <input type="hidden" value="${buildId}" name="mergeSourcesForBuild"/>
    <forms:saving id="mergingSources"/>
  </div>

</bs:modalDialog>

