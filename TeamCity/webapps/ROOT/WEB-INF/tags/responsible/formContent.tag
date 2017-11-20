<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="user" uri="/WEB-INF/functions/user" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp" %><%@
    attribute name="buildType" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="currentUser" required="true" type="jetbrains.buildServer.users.User"
%><c:set var="responsibility" value="${buildType.responsibilityInfo}"/>
<div class="investigation-dialog">
  <div class="clearfix">
    <div class="list">
      <a class="right" id="moreBuildTypes" href="#" onclick="return BS.ResponsibilityDialog.moreConfigurations();">more</a>
      <span id="currentBuildType"><bs:buildTypeIcon buildType="${buildType}"/> <c:out value="${buildType.name}"/></span>
      <table style="display:none;" id="allBuildTypes" class="configurations"><jsp:doBody/></table>
    </div>
  </div>

  <h3 class="blockHeader">
    <a href="#" id="bt-reset-investigate" class="reset">reset</a>
    <forms:checkbox name="do-investigate" id="do-bt-investigate" checked="${true}"/>
    <label>Investigation options</label>
  </h3>

  <table class="investigate-params collapsible-section" id="bt-investigate-section">
    <tr>
      <th>
        <forms:radioButton name="investigate" value="ASSIGN" id="bt-assign-investigate" checked="${responsibility.state.active}"/>
        <label for="bt-assign-investigate">Investigated by:</label>
      </th>
      <td>
        <forms:select tabindex="2" name="investigator" id="bt-responsible" className="wholeWidth" enableFilter="true">
          <c:set var="selectedUser" value="${currentUser}"/>
          <c:if test="${responsible:hasResponsible(responsibility)}">
            <c:set var="selectedUser" value="${responsibility.responsibleUser}"/>
          </c:if>
          <resp:userOptions currentUser="${currentUser}" selectedUser="${selectedUser}" potentialResponsibles="${buildType.project.potentiallyResponsibleUsers}"/>
        </forms:select>
        <div id="bt-investigation-warning"></div>
        <table class="inner">
          <tr>
            <th>
              <label for="bt-remove-investigation">Resolve:</label>
            </th>
            <td>
              <forms:select name="remove-investigation" id="bt-remove-investigation">
                <forms:option value="0" selected="${responsibility.removeMethod.whenFixed}">When build configuration is successful</forms:option>
                <forms:option value="1" selected="${responsibility.removeMethod.manually}">Manually</forms:option>
              </forms:select>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <th>
        <forms:radioButton name="investigate" value="MARK_FIXED" id="bt-fix-investigate"
                           checked="${responsibility.state.fixed}"/>
        <label for="bt-fix-investigate">Mark as fixed</label>
      </th>
      <td></td>
    </tr>
    <tr>
      <th>
        <forms:radioButton name="investigate" value="GIVE_UP" id="bt-giveup-investigate"
                           checked="${not responsibility.state.active and not responsibility.state.fixed}"/>
        <label for="bt-giveup-investigate">No investigation</label>
      </th>
      <td></td>
    </tr>
  </table>

  <h3 class="blockHeader">Comment</h3>
  <table class="collapsible-section">
    <tr>
      <td colspan="2">
        <textarea name="comment" id="bt-comment" rows="3" cols="46" class="commentTextArea"><c:out value="${responsibility.comment}"/></textarea>
        <div class="error-msg" id="comment-error"></div>
      </td>
    </tr>
  </table>

  <div class="popupSaveButtonsBlock">
    <forms:submit onclick="return BS.ResponsibilityDialog.submit();" id="bt-submit" label="Save"/>
    <forms:cancel onclick="BS.ResponsibilityDialog.close()"/>
    <forms:saving id="responsibilityProgressIcon"/>
    <input type="hidden" name="buildTypeId" value="${buildType.buildTypeId}"/>
  </div>

  <script type="text/javascript">
    BS.ResponsibilityDialog.checkUserPermissionsOnChange("${buildType.projectExternalId}");
  </script>
</div>
