<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@

    attribute name="formId" type="java.lang.String" required="true" %><%@
    attribute name="title" type="java.lang.String" required="true" %><%@
    attribute name="action" type="java.lang.String" required="true" rtexprvalue="true" %><%@
    attribute name="closeCommand" type="java.lang.String" required="true" %><%@
    attribute name="saveCommand" type="java.lang.String" required="true" %><%@
    attribute name="dialogClass" type="java.lang.String" required="false"

%><form id="${formId}" action="${action}" method="post" onsubmit="return ${saveCommand};" autocomplete="off">
  <bs:dialog dialogId="${formId}Dialog" title="${title}" closeCommand="${closeCommand}"
             dialogClass="${formId}Dialog ${dialogClass}" titleId="${formId}Title"
  ><jsp:doBody/></bs:dialog></form>