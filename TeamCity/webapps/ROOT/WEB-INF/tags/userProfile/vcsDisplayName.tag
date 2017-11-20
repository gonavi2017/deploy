<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="vcsUsername" required="true" rtexprvalue="true" type="jetbrains.buildServer.controllers.profile.VcsUsername"
  %><c:choose
  ><c:when test="${vcsUsername.anyVcsUsername}">&lt;Default for all of the VCS roots&gt;</c:when
  ><c:when test="${vcsUsername.anyVcsRootUsername}">&lt;Default for all of the <strong><c:out value="${vcsUsername.vcsSupport.displayName}"/></strong> roots&gt;</c:when
  ><c:otherwise><c:out value="${vcsUsername.vcsRoot.name}"/></c:otherwise
  ></c:choose>