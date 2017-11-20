<%@ include file="/include.jsp" %>
<jsp:useBean id="deploymentPath" type="java.lang.String" scope="request" />
<jsp:useBean id="modification" type="jetbrains.buildServer.vcs.VcsModification" scope="request" />
<jsp:useBean id="fileModification" type="jetbrains.buildServer.vcs.VcsFileModification" scope="request" />
<jsp:useBean id="isGraphics" type="java.lang.Boolean" scope="request" />

<c:set var="title" value="${fn:split(fileModification.relativeFileName,'\\\/')}"/>
<c:set var="title" value="${title[fn:length(title)-1]} diff"/>

<bs:externalPage>
  <jsp:attribute name="page_title">${title}</jsp:attribute>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/filePopup.css
      /css/forms.css
      /css/issues.css

      ${deploymentPath}ring-diff.min.css
      ${deploymentPath}diff.css
    </bs:linkCSS>

    <bs:linkScript>
      /js/swfobject.js
      /js/jquery/jquery.zclip.min.js

      /js/bs/forms.js
      /js/bs/modalDialog.js
      /js/bs/activation.js
      /js/bs/issues.js
      /js/bs/vcsSettings.js

      ${deploymentPath}ring-diff.min.js
      ${deploymentPath}diff.js
      /js/codemirror/lib/codemirror-teamcity.js
      /js/codemirror/addon/mode/loadmode.js
    </bs:linkScript>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <jsp:include page="diffHeader.jsp"/>

    <div class="diff-layout">
      <div class="diff-spinner">
        <forms:progressRing className="progressRingInline"/> Loading...
      </div>
    </div>

    <c:url var="rawUrl" value="/diffRaw.html?id=${modification.id}&vcsFileName=${fileModification.fileName}&personal=${modification.personal}"/>
    <c:url var="jsonUrl" value="/diffJson.html?id=${modification.id}&vcsFileName=${fileModification.fileName}&personal=${modification.personal}"/>

    <c:choose>
      <c:when test="${isGraphics}">
        <script type="text/javascript">
          // Temporary, until ring-diff supports images
          jQuery(function($) {
            function td(table) {
              return $("<td/>").appendTo(table.find("tr"));
            }

            var diffImages = $('<table class="diff-images"/>');
            diffImages.append("<tr/>");

            var originalImage = td(diffImages),
                modifiedImage = td(diffImages);

            $(".diff-layout").empty().append(diffImages);

            <c:if test="${not fileModification.type.added}">
            originalImage.html("<iframe src='${rawUrl}&before=true'/>");
            </c:if>
            <c:if test="${not fileModification.type.removed}">
            modifiedImage.html("<iframe src='${rawUrl}&before=false'/>");
            </c:if>
          });
        </script>
      </c:when>
      <c:otherwise>
        <script type="text/javascript">
          jQuery(function($) {
            var requiredFiles = [
              '${jsonUrl}',
              '${rawUrl}&before=true',
              '${rawUrl}&before=false'
            ];

            var deferredObjects = [];
            requiredFiles.forEach(function(filename) {
              deferredObjects.push($.ajax(filename));
            });

            function setEditorOptions(editor, mode, mimeType) {
              CodeMirror.modeURL = window["base_uri"] + "/js/codemirror/mode/%N/%N.js";
              CodeMirror.requireMode(mode, function() {
                for (var m in CodeMirror.mimeModes) {
                  if (CodeMirror.mimeModes.hasOwnProperty(m)) {
                    if (m == mimeType) {
                      editor.setOption("mode", CodeMirror.mimeModes[m]);
                    }
                  }
                }
              });
            }

            $.when.apply($, deferredObjects).then(function(diff, original, modified) {
              var diffLayout = $('.diff-layout');

              diffLayout.empty();

              var diffTool = ring('diff').invoke('doublePaneDiff',
                                                 diffLayout.get(0),
                                                 original[0],
                                                 modified[0],
                                                 $.parseJSON(diff[0]));

              var cmMode = CodeMirror.TeamCity.getModeByFileName("${fileModification.relativeFileName}");
              var cmMimeType = CodeMirror.TeamCity.getMimeTypeByFileName("${fileModification.relativeFileName}");

              if (cmMode) {
                if (diffTool.getMode() == 2) {
                  setEditorOptions(diffTool.getController().getOriginalEditor(), cmMode, cmMimeType);
                  setEditorOptions(diffTool.getController().getModifiedEditor(), cmMode, cmMimeType);
                } else if (diffTool.getMode() == 8) {
                  setEditorOptions(diffTool.getController().getEditor(), cmMode, cmMimeType);
                }
              }

              BS.DiffView.init(diffTool);
            });
          });
        </script>
      </c:otherwise>
    </c:choose>

    <bs:modalDialog formId="errorForm"
                    title=""
                    action="#"
                    saveCommand="BS.ErrorDialog.close();"
                    closeCommand="BS.ErrorDialog.close();">
    </bs:modalDialog>

    <div id="issueDetailsTemplate" style="display:none">
      <div id="detailedSummary:##ISSUE_ID##">
        <forms:progressRing className="progressRingInline"/>
      </div>
    </div>
  </jsp:attribute>
</bs:externalPage>
