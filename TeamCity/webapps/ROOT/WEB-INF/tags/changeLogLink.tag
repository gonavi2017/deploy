<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="baseUrl" required="true" %><%@
    attribute name="from" required="false" %><%@
    attribute name="to" required="false" %><%@
    attribute name="userId" required="false" %><%@
    attribute name="path" required="false" %><%@
    attribute name="comment" required="false" %><%@
    attribute name="revision" required="false" %><%@
    attribute name="showBuilds" required="false" type="java.lang.Boolean" %><%@
    attribute name="changesLimit" required="false" %><%@
    attribute name="style" required="false"

%><a href="${baseUrl}${fn:contains(baseUrl,"?") ? "&" : "?" }from=${util:urlEscape(from)}&to=${util:urlEscape(to)}&userId=${util:urlEscape(userId)}&path=${util:urlEscape(path)}&comment=${util:urlEscape(comment)}&revision=${util:urlEscape(revision)}&showBuilds=${showBuilds}&changesLimit=${util:urlEscape(changesLimit)}" style="${style}"><jsp:doBody/></a>
