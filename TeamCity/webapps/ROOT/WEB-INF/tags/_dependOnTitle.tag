<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"
    %><%@attribute name="plainText" required="true" type="java.lang.Boolean"
    %><c:choose
    ><c:when test="${plainText}"
    >This build depends on ${buildPromotion.numberOfDependencies} build<bs:s val="${buildPromotion.numberOfDependencies}"/></c:when
    ><c:otherwise
    >This build depends on <strong>${buildPromotion.numberOfDependencies}</strong> build<bs:s val="${buildPromotion.numberOfDependencies}"/></c:otherwise
    ></c:choose>