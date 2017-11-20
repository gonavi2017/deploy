<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ attribute name="formAction" required="true" %>

<bs:modalDialog formId="editCheckoutRulesForm"
                title=""
                action="${formAction}"
                closeCommand="BS.EditCheckoutRulesForm.cancelDialog()"
                saveCommand="BS.EditCheckoutRulesForm.submit()">

  <h2 id="vcsRootName" class="noBorder"></h2>

  <div class="posRel">
    <textarea rows="6" cols="58" name="checkoutRules" id="checkoutRules" class="buildTypeParams" wrap="off"></textarea>
    <span id="checkoutRulesVcsTree"></span>
  </div>

  <span class="error" id="errorCheckoutRules" style="margin-left: 0;"></span>

  <bs:smallNote>
    Newline-delimited set of rules in the form of +|-:VCSPath[=>AgentPath]<bs:help file="VCS+Checkout+Rules"/><br/>
    <!--By default, all is included<br/>-->
    e.g. use <strong>-:.</strong> to exclude all, or <strong>-:repository/path</strong> to exclude only the path from checkout<br/>
    or <strong>+:repository/path => another/path</strong> to map to different path.<br/>
    Note: checkout rules can only be set to directories, files are <strong>not</strong> supported.
  </bs:smallNote>

  <div class="popupSaveButtonsBlock" id="editCheckoutRulesFormSaveBlock">
    <forms:submit name="saveCheckoutRules" label="Save"/>
    <forms:cancel onclick="BS.EditCheckoutRulesForm.cancelDialog()" showdiscardchangesmessage="false"/>
    <forms:saving id="saveRulesProgress"/>
  </div>

  <input type="hidden" name="vcsRootId" value=""/>
</bs:modalDialog>
