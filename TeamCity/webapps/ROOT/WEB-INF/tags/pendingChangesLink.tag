<%@ tag import="java.util.Collection" %><%@
    tag import="jetbrains.buildServer.serverSide.ChangeDescriptor" %><%@
    tag import="jetbrains.buildServer.users.SUser" %><%@
    tag import="jetbrains.buildServer.vcs.SVcsModification" %><%@
    tag import="jetbrains.buildServer.web.util.SessionUser" %>
<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="ufn" uri="/WEB-INF/functions/user" %><%@

    attribute name="buildType" fragment="false" required="true" type="jetbrains.buildServer.serverSide.BuildTypeEx" %><%@
    attribute name="pendingChanges" fragment="false" required="true" type="java.util.Collection" %><%@
    attribute name="noLink" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="showForAllBranches" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="branch" fragment="false" required="false" type="jetbrains.buildServer.serverSide.BranchEx"

%><c:set var="text"><jsp:doBody/></c:set
 ><c:set var="textToShow"
   ><c:choose
      ><c:when test="${empty text}">Pending (${fn:length(pendingChanges)})</c:when
      ><c:otherwise>${text}</c:otherwise
    ></c:choose
   ></c:set
 ><c:set var="href"><bs:pendingChangesTabUrl buildType="${buildType}" branch="${branch}"/></c:set
><%
  SUser currentUser = SessionUser.getUser(request);
  Collection<ChangeDescriptor> pending = (Collection<ChangeDescriptor>)pendingChanges;
  boolean highlight = false;
  if (currentUser.isHighlightRelatedDataInUI()) {
    for (ChangeDescriptor change: pending) {
      SVcsModification mod = change.getRelatedVcsChange();
      if (mod == null) continue;
      if (mod.isCommitter(currentUser)) {
        highlight = true;
        break;
      }
    }
  }

  jspContext.setAttribute("highlightChanges", highlight);
%><c:set var="branchName"
    ><c:if test="${not empty branch}">'<bs:escapeForJs text="${branch.name}" forHTMLAttribute="true"/>'</c:if
    ><c:if test="${empty branch}">null</c:if></c:set
><bs:popupControl clazz="${highlightChanges ? 'highlightChanges': ''}"
    showPopupCommand="BS.ChangesPopup.showPendingChangesPopup(this, '${buildType.buildTypeId}', ${showForAllBranches ? 1 : 0}, ${branchName});"
    hidePopupCommand="BS.ChangesPopup.hidePopup()"
    stopHidingPopupCommand="BS.ChangesPopup.stopHidingPopup()"
    controlId="pending:${buildType.buildTypeId}"
    ><c:choose><c:when test="${noLink}"><c:out value="${textToShow}"/></c:when><c:otherwise><a href="${href}" title="View pending changes"><c:out value="${textToShow}"/></a></c:otherwise></c:choose
></bs:popupControl>