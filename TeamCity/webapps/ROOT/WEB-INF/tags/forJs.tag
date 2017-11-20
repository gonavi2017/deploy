<%@ tag import="java.util.List"
  %><%@ tag import="jetbrains.buildServer.web.util.SessionUser"
  %><%@ tag import="jetbrains.buildServer.web.util.WebUtil"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
  %><c:set var="js_output"><jsp:doBody/></c:set><jsp:useBean id="js_output" type="java.lang.String"/>${util:forJS(js_output, true , false )}