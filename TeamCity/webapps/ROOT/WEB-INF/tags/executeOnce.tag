<%@ tag import="jetbrains.buildServer.controllers.interceptors.ExecuteOnceSupport"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="id" required="true" type="java.lang.String"
  %><% if (ExecuteOnceSupport.execute(id)) { %><jsp:doBody/><%  } %>