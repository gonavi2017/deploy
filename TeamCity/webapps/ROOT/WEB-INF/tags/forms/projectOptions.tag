<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ attribute name="selected" required="true"
    %><%@ attribute name="projects" required="true" type="java.lang.Iterable" %>
<c:forEach items="${projects}" var="project">
 <forms:option value="${project.projectId}" selected="${project.projectId == selected}">
   <c:out value="${project.name}"/>
 </forms:option>
</c:forEach>
