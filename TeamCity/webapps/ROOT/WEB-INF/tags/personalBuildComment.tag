<%@ tag import="java.util.List"
  %><%@ tag import="jetbrains.buildServer.util.StringUtil"
  %><%@ tag import="jetbrains.buildServer.vcs.SVcsModification"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="buildPromotion" type="jetbrains.buildServer.serverSide.BuildPromotion" required="true"
  %><% List<SVcsModification> personalChanges = buildPromotion.getPersonalChanges(); SVcsModification lastChange = personalChanges.isEmpty() ? null : personalChanges.get(0);
if (lastChange != null && StringUtil.isEmptyOrSpaces(lastChange.getDescription())) { out.write("No comment"); }
else if (lastChange != null) { out.write(lastChange.getDescription()); }
else { out.write("<no personal changes found>"); } %>