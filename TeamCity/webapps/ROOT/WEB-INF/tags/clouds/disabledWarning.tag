<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@taglib prefix="forms" tagdir="/WEB-INF/tags/forms"

%><%@ attribute name="disabled" type="java.lang.Boolean"

%><c:if test="${disabled}">
  <forms:attentionComment>Cloud integration is disabled.</forms:attentionComment>
</c:if>
