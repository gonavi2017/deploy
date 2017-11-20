<%@ tag import="java.util.List" %><%@
    tag import="jetbrains.buildServer.UserChanges" %><%@
    tag import="jetbrains.buildServer.controllers.changes.ChangesBean" %><%@
    tag import="jetbrains.buildServer.serverSide.BuildPromotion" %><%@
    tag import="jetbrains.buildServer.users.SUser" %><%@
    tag import="jetbrains.buildServer.web.util.SessionUser" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@

    attribute name="build" fragment="false" required="false" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="queuedBuild" fragment="false" required="false" type="jetbrains.buildServer.serverSide.SQueuedBuild" %><%@
    attribute name="noPopup" type="java.lang.Boolean" required="false" %><%@
    attribute name="noLink" type="java.lang.Boolean" required="false" %><%@
    attribute name="attrs" required="false" %><%@
    attribute name="noUsername" type="java.lang.Boolean" required="false" %><%@
    attribute name="className" type="java.lang.String" required="false" %><%@
    attribute name="highlightIfCommitter" type="java.lang.Boolean" required="false"

%><%
  if (build == null && queuedBuild == null) {
    throw new IllegalStateException("Either build or queuedBuild attributes must be specified");
  }

  BuildPromotion buildPromotion = build != null ? build.getBuildPromotion() : queuedBuild.getBuildPromotion();
  jspContext.setAttribute("buildPromotion", buildPromotion);
  boolean lazy = ChangesBean.lazyChanges(buildPromotion);
  jspContext.setAttribute("lazy", lazy);
  if (!lazy) {
    SUser currentUser = SessionUser.getUser(request);
    ChangesBean changesBean = ChangesBean.createForChangesLink(buildPromotion, currentUser);

    boolean containsUserChanges = false;
    boolean highlight = currentUser.isHighlightRelatedDataInUI();
    if (highlightIfCommitter != null && !highlightIfCommitter) {
      highlight = false;
    } else {
      containsUserChanges = changesBean.containsUserChanges();
    }

    String totalCount = String.valueOf(changesBean.getTotal());
    if (changesBean.isChangesLimitExceeded())
      totalCount += "+";

    List<UserChanges> changes = changesBean.getChanges();
    jspContext.setAttribute("containsUserChanges", containsUserChanges);
    jspContext.setAttribute("changes", changes);
    jspContext.setAttribute("totalNum", changesBean.getTotal());
    jspContext.setAttribute("totalCount", totalCount);
    jspContext.setAttribute("highlight", highlight);
  }
%><%--@elvariable id="buildPromotion" type="jetbrains.buildServer.serverSide.BuildPromotionEx"--%>
<c:choose>
  <c:when test="${lazy}">
    <c:set var="id" value="lazy_changes_${buildPromotion.id}_${util:uniqueId()}"/>
    <span id="${id}" class="${className}">
      <bs:changesLink queuedBuild="${queuedBuild}" build="${build}" showPopup="${not noPopup}" highlightIfCommitter="${false}" containsUserChanges="${false}">Changes</bs:changesLink>
    </span>
    <script type="text/javascript">
      BS.BackgroundLoader.load($j('#${id}'),
                               'changesLink.html',
                               {promotionId: ${buildPromotion.id},
                                noPopup: ${noPopup ? 'true' : 'false'},
                                noUsername: ${noUsername ? 'true' : 'false'},
                                noLink: ${noLink ? 'true' : 'false'},
                                highlightIfCommitter: ${empty highlightIfCommitter ? 'true' : (highlightIfCommitter ? 'true' : 'false')}});
    </script>
  </c:when>
  <c:otherwise>
    <span class="${className} ${totalNum eq 0 ? 'noChanges' : ''}">
    <bs:changesLinkFullInner build="${build}"
                             queuedBuild="${queuedBuild}"
                             buildPromotion="${buildPromotion}"
                             noPopup="${noPopup}"
                             noUsername="${noUsername}"
                             noLink="${noLink}"
                             highlight="${highlight}"
                             containsUserChanges="${containsUserChanges}"
                             totalNum="${totalNum}"
                             totalCount="${totalCount}"
                             changes="${changes}"/>
    </span>
  </c:otherwise>
</c:choose>
