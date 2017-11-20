<%@ include file="/include-internal.jsp" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<script type="text/javascript">
  BS.DataDir = OO.extend(BS.AbstractWebForm, OO.extend(BS.AbstractModalDialog, OO.extend(BS.FileBrowse, {
    getContainer: function() {
      return $('uploadFile');
    },

    formElement: function() {
      return $('uploadFileForm');
    },

    refresh: function() {
      $("dataDir").refresh();
    }
  })));
  if (BS.internalProperty('teamcity.ui.codeMirrorEditor.enabled', true)) {
    BS.DataDir = OO.extend(BS.DataDir, {
      startEdit: function(filename) {
        BS.FileBrowse.startEdit.call(this);

        this.editor = BS.CodeMirror.fromTextArea(document.getElementById('edit-area'), {
          mode: CodeMirror.TeamCity.getFileExtension(filename)
        });
        this.editor.setSize($('edit-area').getWidth(), '100%');
      },
      save: function() {
        this.editor.save();
        BS.FileBrowse.save.apply(this, arguments);
      },
      cancelEdit: function() {
        this.editor.toTextArea();
        BS.FileBrowse.cancelEdit.call(this);
      }
    });
  }
</script>

<jsp:useBean id="bean" type="jetbrains.buildServer.controllers.admin.TeamCityDataDirectoryBrowseController.DataDirectoryBean" scope="request"/>
<bs:fileBrowsePage id="dataDir"
                   dialogId="uploadFile"
                   dialogTitle="Upload File"
                   bean="${bean}"
                   actionPath="/admin/dataDir.html"
                   homePath="/admin/admin.html?item=diagnostics&tab=dataDir"
                   pageUrl="${pageUrl}"
                   jsBase="BS.DataDir">
  <jsp:attribute name="headMessage">
    Browse TeamCity data directory ${bean.dataDir}:
  </jsp:attribute>
</bs:fileBrowsePage>

<script type="text/javascript">
  $j("#tree").add(".fileOperations").on("click", "a", function() {
    if (this.href != "#") {
      this.href += window.location.hash;
    }
  });
</script>
