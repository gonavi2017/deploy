<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext" %><%@
    taglib prefix="changefn" uri="/WEB-INF/functions/change" %><%@
    tag import="java.util.List" %><%@
    tag import="jetbrains.buildServer.controllers.changes.VcsWebUtil" %><%@
    tag import="jetbrains.buildServer.vcs.FilteredVcsChange" %><%@
    attribute name="modification" required="true" type="jetbrains.buildServer.vcs.SVcsModification" %><%@
    attribute name="build" required="false" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="buildType" required="false" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="disableFileFiltering" required="false" type="java.lang.Boolean" %>
<%
  final List<FilteredVcsChange> filteredChanges;
  if (disableFileFiltering) {
    filteredChanges = VcsWebUtil.convertAllChangesToFiltered(modification);
  } else if (build != null) {
    filteredChanges = modification.getFilteredChanges(build);
  } else if (buildType != null) {
    filteredChanges = modification.getFilteredChanges(buildType);
  } else {
    filteredChanges = VcsWebUtil.convertAllChangesToFiltered(modification);
  }
  jspContext.setAttribute("filteredChanges", filteredChanges);

%>
<tr class="files-row" id="tr-files-${modification.id}">
  <td colspan="7" class="files-row-inner">
    <bs:changedFiles changes="${filteredChanges}" modification="${modification}"/>
  </td>
</tr>