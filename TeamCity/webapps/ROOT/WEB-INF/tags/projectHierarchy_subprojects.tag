<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="id"                   required="true"  type="java.lang.String"
%><%@ attribute name="tableSubProjectClass" required="true"  type="java.lang.String"
%><%@ attribute name="projectBean"          required="true"  type="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean"
%>
<tr>
  <td id="${id}_subproj_holder" colspan="10" class="sub_project_table ${tableSubProjectClass}">
    <c:if test="${not empty projectBean.subProjects}">
      <jsp:doBody/>
    </c:if>
  </td>
</tr>