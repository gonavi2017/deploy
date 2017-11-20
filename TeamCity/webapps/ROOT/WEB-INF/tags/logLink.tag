<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="build" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuild"
  %><%@ attribute name="attrs" fragment="false" required="false"
  %><bs:_viewLog build="${build}" title="View build log" attrs="${attrs}">Build Log</bs:_viewLog>