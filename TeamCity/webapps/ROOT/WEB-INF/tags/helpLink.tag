<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
  %><%@ attribute name="urlPrefix" required="false"
  %><%@ attribute name="file" required="true" description="Encoded page name"
  %><%@ attribute name="anchor" required="false"
  %><%@ attribute name="style" required="false"
  %><%@ attribute name="id" required="false"
  %><%@ attribute name="width" required="false"
  %><%@ attribute name="height" required="false"
  %><c:set var="url">${util:helpUrl(urlPrefix, file, anchor, false)}</c:set
  ><a id="${id}" class="helpIcon" onclick="BS.Util.showHelp(event, '${url}', {width: ${empty width ? 0 : width}, height: ${empty height ? 0 : height}}); return false" style="${style}" href="${url}" title="View help" showdiscardchangesmessage="false"><jsp:doBody/></a>