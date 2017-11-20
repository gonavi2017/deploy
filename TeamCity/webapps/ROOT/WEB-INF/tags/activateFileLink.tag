<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"

%><%@ attribute name="fileName" required="true"
%><%@ attribute name="projectName" required="false"

%><a href="#" onclick="BS.Activator.doOpen('file?file=${fn:replace(util:urlEscape(fileName),'\\','/')}&project=${projectName}'); return false"
   title="Click to open in the active IDE" <bs:iconLinkStyle icon="IDE"/>><jsp:doBody/></a>