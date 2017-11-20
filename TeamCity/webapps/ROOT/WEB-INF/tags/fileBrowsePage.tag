<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="string" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="id" required="true" type="java.lang.String" %><%@
    attribute name="dialogId" required="true" type="java.lang.String" %><%@
    attribute name="dialogTitle" required="true" type="java.lang.String" %><%@
    attribute name="pageUrl" required="true" type="java.lang.String" %><%@
    attribute name="bean" required="true" type="java.lang.Object" %><%@
    attribute name="actionPath" required="true" type="java.lang.String" %><%@
    attribute name="homePath" required="true" type="java.lang.String" %><%@
    attribute name="jsBase" required="true" type="java.lang.String" %><%@
    attribute name="belowFileName" fragment="true" required="false" %><%@
    attribute name="headMessage" fragment="true" required="false" %><%@
    attribute name="headMessageNoFiles" fragment="true" required="false" %>

<c:url var="actionUrl" value="${actionPath}"/>
<c:if test="${empty jsBase}">
  <c:set var="jsBase" value="BS.FileBrowse"/>
</c:if>

<bs:refreshable containerId="${id}" pageUrl="${pageUrl}">
<div class="fileBrowse">
  <c:choose>
    <c:when test="${bean.showFile}">
      <c:url var="homeUrl" value="${homePath}"/>
      <c:set var="fileName" value="${bean.fileName}"/>
      <c:set var="fileContent" value="${bean.fileContent}"/>
      <c:set var="clazz" value="${bean.clazz}"/>
      <div class="headMessage">
        <span class="fileName">
          <c:out value="${fileName}"/> <span class="fileSize">(${bean.fileSize})</span>
        </span>
        <span class="fileOperations">
          <a href="${homeUrl}">&laquo; All files</a>
          <span class="separator">|</span>

          <c:if test="${bean.editSupported and clazz == 'ok'}">
            <i class="icon-pencil"></i>
            <a href="#" onclick="return ${jsBase}.startEdit('${fileName}');" class="edit" title='Edit this file'>Edit</a>
            <span class="separator">|</span>
          </c:if>

          <c:if test="${bean.deleteSupported}">
            <i class="icon-trash"></i>
            <a href="#" onclick="return ${jsBase}.deleteFile('${actionUrl}','${homeUrl}','${bean.messageOnDelete}','<c:out value="${fileName}"/>');"
               title='Remove this file'> Delete</a>
            <span class="separator">|</span>
          </c:if>

          <c:url var="linkForFile" value="${bean.linkForFile}"/>
          <c:set var="ch" value="${string:contains(linkForFile, '?') ? '&' : '?'}"/>
          <i class="icon-share"></i>
          <a href="${linkForFile}${ch}forceInline=true">View in browser</a>
          <span class="separator">|</span>

          <a class="downloadLink tc-icon_before icon16 tc-icon_download" href="${linkForFile}${ch}forceAttachment=true">Download file</a>
        </span>
        <div><jsp:invoke fragment="belowFileName"/></div>
      </div>
      <div>
        <pre class="fileContent ${clazz}"><c:out value="${fileContent}"/></pre>
      </div>
      <script type="text/javascript">
        ${jsBase}.autoRunOperation('${fileName}');
      </script>
    </c:when>
    <c:when test="${bean.hasFiles}">
      <div class="headMessage">
        <jsp:invoke fragment="headMessage"/>
        <forms:saving id="refreshing"/>
        <c:if test="${bean.downloadZip}">
          <div class="downloadLink">
            <a class="downloadLink tc-icon_before icon16 tc-icon_download" href="<c:url value="${bean.linkForZip}" />">Download all</a>
            <c:if test="${not empty bean.additionalDownloadLinks}">
              <c:forEach items="${bean.additionalDownloadLinks}" var="entry">
                <span class="separator">|</span>
                <a class="downloadLink" href="<c:url value="${entry.value}" />">${entry.key}</a>
              </c:forEach>
            </c:if>
          </div>
        </c:if>
      </div>
      <div id="tree"></div>
      <c:if test="${bean.showTotalSize}">
        <div class="filesize" style="margin-top: 1em;">
          Total size: ${bean.totalSize}
          <c:if test="${not bean.showEmptyFiles}">
            &nbsp;&nbsp;
            <em style="color: #888;">(zero-length files aren't shown)</em>
          </c:if>
        </div>
      </c:if>
      <script type="text/javascript">
        ${jsBase}.autoRunOperation();
        BS.LazyTree.treeUrl = "${actionUrl}";
        BS.LazyTree.loadTree("tree");
      </script>
    </c:when>
    <c:otherwise>
      <div class="headMessage">
        <jsp:invoke fragment="headMessageNoFiles"/>
        <forms:saving id="refreshing"/>
      </div>
    </c:otherwise>
  </c:choose>

  <c:if test="${not bean.showFile and bean.uploadSupported}">
    <div class="upload">
      <forms:addButton onclick="return ${jsBase}.show();">Upload new file</forms:addButton>
    </div>

    <bs:dialog dialogId="${dialogId}"
               dialogClass="uploadDialog"
               title="${dialogTitle}"
               titleId="${dialogId}Title"
               closeCommand="${jsBase}.close();">
      <forms:multipartForm id="${dialogId}Form" action="${actionUrl}"
                           onsubmit="return ${jsBase}.validate();"
                           targetIframe="hidden-iframe">
        <div>
          <table class="runnerFormTable">
            <c:if test="${bean.uploadToAnySubdirectory}">
              <tr>
                <th><label for="destination">Path: <l:star/></label></th>
                <td><input type="text" id="destination" name="destination" value="${bean.pathToRoot}" default="${bean.pathToRoot}"/></td>
              </tr>
            </c:if>
            <tr>
              <th><label for="fileName">Name: <l:star/></label></th>
              <td><input type="text" id="fileName" name="fileName" value="${bean.initUploadFileName}"/></td>
            </tr>
            <tr>
              <th><label for="fileToUpload">File: <l:star/></label></th>
              <td>
                <forms:file name="fileToUpload" size="28"/>
                <span id="uploadError" class="error hidden"></span>
              </td>
            </tr>
          </table>
        </div>
        <div class="popupSaveButtonsBlock">
          <forms:submit label="Save"/>
          <forms:cancel onclick="${jsBase}.close()" showdiscardchangesmessage="false"/>
          <forms:saving id="saving"/>
        </div>
      </forms:multipartForm>
    </bs:dialog>

    <script type="text/javascript">
      ${jsBase}.setFiles([<c:forEach var="file" items="${bean.files}">'${file}',</c:forEach>]);
      ${jsBase}.prepareFileUpload();
    </script>
  </c:if>

  <c:if test="${bean.editSupported}">
    <script type="text/javascript">
      (function() {
        var fileContent = $j(".fileContent");
        if (!fileContent.length) return;

        var parent = fileContent.parent();
        var width = $j("#content").width() - ($j(".admin-sidebar").outerWidth() || 0);
        var height = Math.min($j(window).height() - fileContent.position().top, $j("#content").height());
        $j("<textarea id='edit-area'/>").attr({wrap:"off"}).html(fileContent.html()).hide().css({width: width, height: height}).appendTo(parent);
      })();
    </script>

    <forms:modified>
      <jsp:body>
        <div class="fixedWidth">
          <input class="btn btn_primary submitButton" type="button" value="Save" name="save" onclick="${jsBase}.save('${actionUrl}','<c:out value="${fileName}"/>');"/>
          <input class="btn" type="button" value="Cancel" name="cancel" onclick="${jsBase}.cancelEdit();"/>
        </div>
      </jsp:body>
    </forms:modified>
  </c:if>

  <c:if test="${bean.highlightContent}">
    <script type="text/javascript">
      (function() {
        var msie = false, msie9 = false;
        /*@cc_on
          msie = true;
          @if (@_jscript_version >= 9)
            msie9 = true;
          @end
        @*/

        if (!msie || msie && msie9) {
          var fileContent = $j(".fileContent.ok");
          if (fileContent.length > 0) {
            hljs.highlightBlock(fileContent.get(0));
          }
        }
      })();
    </script>
  </c:if>
</div>
</bs:refreshable>
