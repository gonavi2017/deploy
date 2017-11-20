<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%><%@
    attribute name="adminOverviewForm" required="true" type="jetbrains.buildServer.controllers.admin.AdminOverviewBean"

%><form action="<c:url value='/admin/admin.html'/>" method="get">
  <div class="actionBar">
    <span class="nowrap">
      <label class="firstLabel" for="keyword">Filter: </label>
      <forms:textField name="keyword" value="${adminOverviewForm.keyword}" size="20"/>
    </span>
    <forms:filterButton/>
    <c:if test="${not empty adminOverviewForm.keyword}"
        ><c:url value='/admin/admin.html?item=projects&keyword=' var="resetUrl"/><forms:resetFilter resetUrl="${resetUrl}"
    /></c:if>

    <span style="margin-left: 20px;">
      <forms:checkbox name="includeArchived"
                      disabled="${adminOverviewForm.numberOfActiveProjects == 0}"
                      checked="${adminOverviewForm.includeArchived}"
                      onclick="this.form.submit();"/>
      <label for="includeArchived" style="margin: 0;">Show archived</label>
    </span>
    <div class="clearfix"></div>
  </div>
  <input type="hidden" name="item" value="projects">
</form>
