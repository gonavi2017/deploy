<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<%@ taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests"%>

<%@ attribute name="investigateBean" required="true" type="jetbrains.buildServer.controllers.tests.BulkInvestigateBean"%>
<%@ attribute name="muteBean" required="true" type="jetbrains.buildServer.controllers.investigate.BulkMuteBean"%>
<%@ attribute name="hideMuteSettings" required="false" type="java.lang.Boolean"%>

<authz:authorize projectId="${investigateBean.projectId}" allPermissions="ASSIGN_INVESTIGATION">
  <jsp:attribute name="ifAccessGranted">
    <h3 class="blockHeader">
      <a href="#" id="reset-investigate" class="reset">reset</a>
      <%--used to determine if there were any changes in investigation settings--%>
      <forms:checkbox name="do-investigate"/>
      <label>Investigation options</label>
    </h3>
    <table class="investigate-params collapsible-section" id="investigate-section">
      <tr>
        <th>
          <forms:radioButton name="investigate" value="ASSIGN" id="assign-investigate"
                             checked="${investigateBean.known and investigateBean.assigned}"/>
          <label for="assign-investigate">Investigated by:</label>
        </th>
        <td>
          <forms:select name="investigator" className="wholeWidth" id="investigator" enableFilter="true">
            <resp:userOptions currentUser="${currentUser}" selectedUser="${investigateBean.investigator}"
                              potentialResponsibles="${investigateBean.users}" allowNoResponsible="false"/>
          </forms:select>
          <div id="test-investigation-warning"></div>
          <table class="inner">
            <tr>
              <th>
                <label for="remove-investigation">Resolve:</label>
              </th>
              <td>
                <forms:select name="remove-investigation">
                  <forms:option value="0" selected="${investigateBean.removeMethod.whenFixed}">Automatically when fixed</forms:option>
                  <forms:option value="1" selected="${investigateBean.removeMethod.manually}">Manually</forms:option>
                </forms:select>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <th>
          <forms:radioButton name="investigate" value="MARK_FIXED" id="fix-investigate"
                             checked="${investigateBean.known and investigateBean.fixed}"/>
          <label for="fix-investigate">Mark as fixed</label>
        </th>
        <td></td>
      </tr>
      <tr>
        <th>
          <forms:radioButton name="investigate" value="GIVE_UP" id="giveup-investigate"
                             checked="${investigateBean.known and investigateBean.givenUp}"/>
          <label for="giveup-investigate">No investigation</label>
        </th>
        <td></td>
      </tr>
    </table>
  </jsp:attribute>
</authz:authorize>

<c:if test="${empty hideMuteSettings or hideMuteSettings eq false}">
  <authz:authorize projectId="${investigateBean.projectId}" allPermissions="MANAGE_BUILD_PROBLEMS">
    <jsp:attribute name="ifAccessGranted">
      <h3 class="blockHeader">
        <a href="#" id="reset-mute" class="reset">reset</a>
        <%--used to determine if there were any changes in mute settings--%>
        <forms:checkbox name="do-mute"/>
        <label>Mute options</label>
      </h3>
      <div class="collapsible-section"  id="mute-section">
        <div>
          <table class="mute-params">
            <tr>
              <th>
                <forms:radioButton name="mute" value="MUTE" id="mute-mute" checked="${muteBean.known and muteBean.muted}"/>
                <label for="mute-mute">Mute in:</label>
              </th>
              <td>
                <forms:select name="scope" id="mute-scope">
                  <forms:option value="P">Project-wide</forms:option>
                  <forms:option value="C" selected="${muteBean.buildTypeScopeSelected}">Selected build configuration</forms:option>
                </forms:select>
                <div class="custom-scroll" id="mute-in-bt-list" <c:if test="${not muteBean.buildTypeScopeSelected}">style="display: none"</c:if>>
                  <div class="error-msg" id="bt-list-error"></div>
                  <tt:_checkedBuildTypes muteBean="${muteBean}"/>
                </div>

                <table class="inner">
                  <tr>
                    <th>
                      <label for="unmute">Unmute:</label>
                    </th>
                    <td>
                      <c:set var="unmuteOption" value="${muteBean.selectedUnmuteOption}"/>
                      <forms:select name="unmute">
                        <forms:option value="F" selected="${unmuteOption == 'F'}">Automatically when fixed</forms:option>
                        <forms:option value="M" selected="${unmuteOption == 'M'}">Manually</forms:option>
                        <forms:option value="T" selected="${unmuteOption == 'T'}">On a specific date</forms:option>
                      </forms:select>
                    </td>
                  </tr>
                  <c:set var="style" value="${unmuteOption == 'T' ? '' : 'display: none'}"/>
                  <tr id="unmute-row" style="${style}">
                    <th>
                      <label for="unmute-time">Unmute on:</label>
                    </th>
                    <td>
                      <forms:textField name="unmute-time" value="${muteBean.selectedUnmuteTimeOption}"/>
                    </td>
                  </tr>
                  <tr><td colspan="2"><div class="error-msg" id="unmute-time-error"></div></td></tr>
                </table>
              </td>
            </tr>
            <tr>
              <th>
                <forms:radioButton name="mute" value="UNMUTE" id="unmute-mute" checked="${muteBean.known and not muteBean.muted}"/>
                <label for="unmute-mute">Not muted</label>
              </th>
              <td></td>
            </tr>
          </table>
        </div>
      </div>
    </jsp:attribute>
  </authz:authorize>
</c:if>

<authz:authorize projectId="${investigateBean.projectId}" anyPermission="ASSIGN_INVESTIGATION, MANAGE_BUILD_PROBLEMS">
  <jsp:attribute name="ifAccessDenied">
    <span class="icon_before icon16 attentionRed investigate-no-permission">
    You don't have permissions to investigate or mute problems in this project (<c:out value="${investigateBean.project.fullName}"/>)
    </span>
  </jsp:attribute>
  <jsp:attribute name="ifAccessGranted">

      <h3 class="blockHeader">Comment</h3>
      <table class="mute-params collapsible-section">
        <tr>
          <td colspan="2">
            <textarea name="comment" id="investigate-comment" rows="3" cols="46" class="commentTextArea"><c:out value="${investigateBean.comment}"/></textarea>
            <div class="error-msg" id="comment-error"></div>
          </td>
        </tr>
      </table>

  </jsp:attribute>
</authz:authorize>

