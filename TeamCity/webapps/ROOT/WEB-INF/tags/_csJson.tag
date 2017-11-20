<%@ attribute name="changeStatus" type="jetbrains.buildServer.vcs.ChangeStatus" required="true" 
    %>{'modId': ${changeStatus.change.id}, 'personal': ${changeStatus.change.personal}}