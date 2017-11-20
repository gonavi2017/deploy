<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="containerId" required="true" %><%@
    attribute name="pageUrl" required="true" %><%@
    attribute name="useJsp" required="false" %><%@
    attribute name="deferred" required="false" type="java.lang.Boolean"

%><div id="${containerId}" class="refreshable" data-pageurl="${util:escapeUrlForQuotes(pageUrl)}" data-passjsp="${useJsp}">
  <!--##BEGIN:${containerId}Inner##--><div id="${containerId}Inner" class="refreshableInner"><jsp:doBody/></div><!--##END:${containerId}Inner##-->
</div>
