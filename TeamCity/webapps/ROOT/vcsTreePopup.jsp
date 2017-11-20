<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><c:if test="${showVcsTreeIcon}"
><script type="text/javascript">
  BS.VCS.registerTreePopup('${vcsTreeId}', '${buildFormId}', '${callback}', '${fieldId}', 'vcsTreeControl_${vcsTreeId}', { dirsOnly: '${dirsOnly}', vcsRootId: '${vcsRootId}', rootDirName: '${rootDirName}' } );
</script>
<i id="vcsTreeControl_${vcsTreeId}" class="tc-icon icon16 tc-icon_folders handle vcsTreeHandle" onclick="BS.VCS.showTree('${vcsTreeId}')" title="Choose file or directory in VCS"></i>
</c:if>
