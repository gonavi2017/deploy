<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="project" scope="request" type="jetbrains.buildServer.serverSide.SProject"/>
<jsp:useBean id="generateTokenMode" scope="request" type="java.lang.Boolean"/>
<c:choose>
  <c:when test="${generateTokenMode}">
    <c:set var="dialogTitle" value="Generate Token"/>
    <c:set var="actionTitle" value="Generate token for a secure value..."/>
    <c:set var="buttonTitle" value="Generate Token"/>
    <c:set var="generatedTokenNote" value="Generated token can be used in project configuration files instead of secure value."/>
  </c:when>
  <c:otherwise>
    <c:set var="dialogTitle" value="Scramble Secure Value"/>
    <c:set var="actionTitle" value="Scramble secure value..."/>
    <c:set var="buttonTitle" value="Scramble"/>
    <c:set var="generatedTokenNote" value="Scrambled value can be used in project configuration files instead of secure value."/>
  </c:otherwise>
</c:choose>
<c:url var="generateAction" value="/admin/action.html"/>
<l:li>
  <a href="#" onclick="return BS.GenerateTokenForm.showDialog('${project.externalId}')">${actionTitle}</a>
  <bs:executeOnce id="generateTokenDialog">
    <bs:modalDialog formId="generateTokenForm"
                    title="${dialogTitle}"
                    action=""
                    closeCommand="BS.GenerateTokenForm.close()"
                    saveCommand="false">
      <label for="secureValue" class="tableLabel">Secure value:</label>
      <forms:passwordField name="secureValue" className="longField"/>
      <input type="hidden" name="projectId" value=""/>

      <div>
        <span class="clipboard-btn tc-icon icon16 tc-icon_copy" style="float: left" data-clipboard-action="copy" data-clipboard-target="#generatedToken"></span>
        <div id="generatedToken" class="mono"></div>
        <div id="generatedTokenNode" class="smallNote" style="margin-left: 0; margin-top: 0.5em; display: none;"><c:out value="${generatedTokenNote}"/></div>
      </div>

      <div class="popupSaveButtonsBlock">
        <forms:button onclick="BS.GenerateTokenForm.generateToken()" className="btn_primary">${buttonTitle}</forms:button>
        <forms:saving id="generateTokenProgress"/>
      </div>
      <script type="text/javascript">
        BS.GenerateTokenForm = OO.extend(BS.AbstractModalDialog, {
          getContainer: function() {
            return $j('#generateTokenFormDialog')[0];
          },

          showDialog: function(projectId) {
            this.showCentered();
            $j('#generateTokenForm input[name="projectId"]').attr('value', projectId);
            $j('#generateTokenForm .clipboard-btn').hide();
            BS.Clipboard('#generateTokenFormDialog span.clipboard-btn');
            return false;
          },

          generateToken: function() {
            $j('#generatedToken').text('');
            $j('#generateTokenProgress').show();

            var projectId = $j('#generateTokenForm input[name="projectId"]').val();
            var secureVal = $j('#generateTokenForm input[name="secureValue"]').val();

            BS.ajaxRequest('${generateAction}', {
              parameters: "generateToken=true&projectId=" + projectId + "&secureValue=" + secureVal,
              onComplete: function(transport) {
                $j('#generateTokenProgress').hide();
                var root = transport.responseXML;
                if (root) {
                  var elems = root.getElementsByTagName('token');
                  var tokenEl = elems[0];
                  $j('#generatedToken').text(tokenEl.firstChild.nodeValue);
                  $j('#generatedTokenNode').show();
                  $j('#generateTokenForm .clipboard-btn').show();
                }
              }
            });
            return false;
          }
        });
      </script>
    </bs:modalDialog>
  </bs:executeOnce>
</l:li>
