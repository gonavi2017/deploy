<%@ tag import="java.util.Formatter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="value" required="true" rtexprvalue="true" type="java.lang.Integer"
  %><%=new Formatter().format("%h", value)%>