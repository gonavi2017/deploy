<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="showPopupCommand" required="true"
  %><%@ attribute name="controlId" required="true"
  %><%@ attribute name="style" required="false"
  %><a style="${style}" id="clickPopup${controlId}" href="#"
       onclick="BS.ClickPopupSupport.togglePopup.call(this, '${controlId}', '${showPopupCommand}'); return false"><jsp:doBody/></a>