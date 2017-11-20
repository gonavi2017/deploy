<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@

    attribute name="blocksType" required="true" %><%@
    attribute name="collapsedByDefault" required="true" type="java.lang.Boolean" %><%@
    attribute name="id" required="true" %><%@
    attribute name="content" fragment="true" required="true" %><%@
    attribute name="alwaysShowBlock" required="false" type="java.lang.Boolean"

%><c:if test="${alwaysShowBlock or not util:isBlockHidden(pageContext.request, blocksType, collapsedByDefault)}"
  ><jsp:invoke fragment="content"/></c:if>