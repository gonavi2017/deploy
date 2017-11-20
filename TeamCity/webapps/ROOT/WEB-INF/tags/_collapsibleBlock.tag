<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@

    attribute name="collapsedByDefault" type="java.lang.Boolean" %><%@
    attribute name="saveState" type="java.lang.Boolean" %><%@
    attribute name="title" type="java.lang.String" required="true" %><%@
    attribute name="id" type="java.lang.String" required="true" %><%@
    attribute name="handleClass" type="java.lang.String" required="false"
              description="The extra CSS class applied to the header element,
              intended to affect the header handle. For instance, setting this
              to &quot;light&quot; will produce &quot;expanded_light&quot; or
              &quot;collapsed_light&quot;, depending on the block state." %><%@
    attribute name="headerStyle" type="java.lang.String" required="false" %><%@
    attribute name="headerClass" type="java.lang.String" required="false" %><%@
    attribute name="contentClass" type="java.lang.String" required="false" %><%@
    attribute name="tag" type="java.lang.String" required="false"


%><c:set var="collapsedByDefault" value="${collapsedByDefault != null ? collapsedByDefault : false}"
/><c:set var="saveState" value="${saveState != null ? saveState : true}"
/><c:set var="blocksType" value="Block_${id}"
/><c:set var="tag" value="${not empty tag ? tag : 'p'}"
/><c:set var="completeHandleClass" value="${collapsedByDefault ? 'collapsed' : 'expanded'}"
/><c:if test="${fn:length(handleClass) > 0}"
  ><c:set var="completeHandleClass" value="${completeHandleClass} ${completeHandleClass}_${handleClass}"
/></c:if>
<${tag} class="icon_before icon16 blockHeader ${completeHandleClass} ${headerClass}" style="${headerStyle}" id="${id}">${title}</${tag}>
<div id="${id}Dl"
     class="collapsibleBlock ${contentClass}"
     style="${util:blockHiddenCss(pageContext.request, blocksType, collapsedByDefault)}">
  <jsp:doBody/>
</div>
<script type="text/javascript">
  <c:if test="${saveState}"><l:blockState blocksType="${blocksType}"/></c:if>
  (function() {
    var el = $('${id}');
    if (!el._block) {
      el._block = new BS.BlocksWithHeader('${id}');
    } else {
      <c:if test="${saveState}">el._block.restoreSavedBlocks();</c:if>
    }
  })();
</script>