<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@attribute name="dataId" type="java.lang.String" required="true" %>

<a href="javascript://" <bs:iconLinkStyle icon="copy copy2Clipboard"/> data-clipboard-id="${dataId}"><jsp:doBody/></a>