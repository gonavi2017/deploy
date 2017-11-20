<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"
    %><%@attribute name="plainText" required="true" type="java.lang.Boolean"
    %><c:choose
    ><c:when test="${plainText}">${buildPromotion.numberOfDependedOnMe} build<bs:s val="${buildPromotion.numberOfDependedOnMe}"/> depend<c:if test="${buildPromotion.numberOfDependedOnMe == 1}">s</c:if> on this build</c:when
    ><c:otherwise><strong>${buildPromotion.numberOfDependedOnMe}</strong> build<bs:s val="${buildPromotion.numberOfDependedOnMe}"/> depend<c:if test="${buildPromotion.numberOfDependedOnMe == 1}">s</c:if> on this build</c:otherwise
    ></c:choose>