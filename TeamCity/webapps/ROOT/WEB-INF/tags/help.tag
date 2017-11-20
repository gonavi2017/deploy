<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="urlPrefix" required="false"
  %><%@ attribute name="file" required="true"
  %><%@ attribute name="anchor" required="false"
  %><%@ attribute name="shortHelp" required="false"
  %><%@ attribute name="style" required="false"
  %><%@ attribute name="id" required="false"
  %><%@ attribute name="width" required="false"
  %><%@ attribute name="height" required="false"
  %><bs:helpLink urlPrefix="${urlPrefix}" file="${file}" anchor="${anchor}" id="${id}" style="${style}" width="${width}" height="${height}"><bs:helpIcon iconTitle="${shortHelp}"/></bs:helpLink>