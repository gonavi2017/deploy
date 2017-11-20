<%@ tag import="jetbrains.buildServer.serverSide.crypt.RSACipher"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ attribute name="profileForm" rtexprvalue="true" type="jetbrains.buildServer.controllers.profile.ProfileForm" required="true" %>
<%@ attribute name="adminMode" rtexprvalue="true" type="java.lang.Boolean"%>

<script type="text/javascript">
  $j(function ($) {
    if (BS.Util.paramsFromHash('&')['focus'] === 'email' && $("#input_teamcityEmail")) {
      $("#input_teamcityEmail").focus();
    }
    else if ($('#input_teamcityUsername').is(':visible')) {
      $('#input_teamcityUsername').focus();
    }
    else {
      var form = document.forms[0];
      if (form.name && form.name.focus) {
        form.name.focus();
      }
    }
  });
</script>

<div class="settingsBlock">
  <div class="settingsBlockContent">
    <div class="general-property">
      <label class="tableLabel" for="input_teamcityUsername">Username:<c:if test="${profileForm.canChangeUsername}"> <l:star/></c:if></label>
      <span class="input-wrapper input-wrapper_username">
      <c:if test="${profileForm.canSomehowEditUsername}">
        <input class="textField" id="input_teamcityUsername" type="text" name="username1" size="30" maxlength="50"
               value="<c:out value="${profileForm.username1}"/>"
               <c:if test="${!profileForm.canChangeUsername}">style="display: none;"</c:if>
            />
      </c:if>
      <c:if test="${!profileForm.canChangeUsername}">
        <span id="text_teamcityUsername"><span><c:out value="${profileForm.username1}"/></span></span>
      </c:if>
      <c:if test="${profileForm.showEditUsernameLink}">
        <span id="editLink_teamcityUsername">
          <a href="#" onclick="BS.UserProfile.makeEditable('teamcityUsername'); return false"><i class="tc-icon icon16 tc-icon_edit_gray"></i></a>
          <bs:help file="Managing+Users+and+User+Groups" anchor="EditingUserAccount"/>
        </span>
      </c:if>
      </span>
    </div>

    <div class="general-property">
      <label class="tableLabel" for="name">Name:</label>
      <input class="textField" id="name" type="text" name="name" size="30" maxlength="128" value="<c:out value="${profileForm.name}"/>"/>
    </div>

    <div class="general-property">
      <label class="tableLabel" for="input_teamcityEmail">Email address: <c:if test="${profileForm.emailIsMandatory}"><l:star/></c:if></label>
      <span class="input-wrapper input-wrapper_email">
        <input class="textField" id="input_teamcityEmail" type="text" name="email" size="30" maxlength="128" value="<c:out value="${profileForm.email}"/>"/>
        <span id="emailVerificationControls"> <%@ include file="emailVerification/emailVerification.jspf" %> </span>
      </span>
    </div>

    <c:if test="${profileForm.canChangePassword}">
      <c:set var="star"><c:if test="${profileForm.passwordIsMandatory}">&nbsp;<l:star/></c:if></c:set>
      <div style="margin-top: 1em;">&nbsp;</div>

      <c:if test="${not adminMode}">
      <div class="general-property">
        <label class="tableLabel" for="currentPassword">Current password:${star}</label>
        <span class="input-wrapper input-wrapper_currentPassword"><input class="textField" id="currentPassword" type="password" name="currentPassword" size="30" maxlength="80"/></span>
      </div>
      </c:if>

      <div class="general-property">
        <label class="tableLabel" for="password1">New password:${star}</label>
        <span class="input-wrapper input-wrapper_password1"><input class="textField" id="password1" type="password" name="password1" size="30" maxlength="80"/></span>
      </div>

      <div class="general-property">
        <label class="tableLabel" for="retypedPassword">Confirm new password:${star}</label>
        <input class="textField" id="retypedPassword" type="password" name="retypedPassword" size="30" maxlength="80"/>
        <input type="hidden" id="publicKey" name="publicKey" value="<c:out value='<%=RSACipher.getHexEncodedPublicKey()%>'/>"/>
      </div>
    </c:if>
  </div>
</div>
