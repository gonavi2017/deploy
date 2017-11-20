<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
 %><%@ attribute name="build" type="jetbrains.buildServer.serverSide.SBuild" 
 %><c:forEach var="tag" items="${build.tags}" >${tag} </c:forEach>