<%@ tag import="jetbrains.buildServer.serverSide.BuildPromotionEx" %>
<%@ tag import="jetbrains.buildServer.serverSide.TeamCityProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags"
  %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
  %><%@ attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"
  %><%@ attribute name="compactView" required="false" type="java.lang.Boolean"
  %><%
  final boolean tagsLoaded = ((BuildPromotionEx)buildPromotion).hasLoadedTags();
  boolean lazy = !tagsLoaded && TeamCityProperties.getBooleanOrTrue("teamcity.buildTagsLink.lazyLoading");
  jspContext.setAttribute("lazy", lazy);
%><c:choose
><c:when test="${lazy}"><c:set var="id" value="lazy_tags_${buildPromotion.id}_${util:uniqueId()}"/>
  <span id="${id}" class="commentText">None</span>
  <script type="text/javascript">
    BS.BackgroundLoader.load($j('#${id}'),
                             'tagsLink.html',
                             {promotionId: ${buildPromotion.id},
                              compactView: ${compactView ? 'true' : 'false'}});
  </script>
</c:when
><c:otherwise><t:tagsInfoInner buildPromotion="${buildPromotion}" tags="${buildPromotion.tags}" compactView="${compactView}"/></c:otherwise
></c:choose>
