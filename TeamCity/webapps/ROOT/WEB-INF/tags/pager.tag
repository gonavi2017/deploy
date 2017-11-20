<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="place" rtexprvalue="true" required="true" %>
<%@ attribute name="urlPattern" rtexprvalue="true" required="true" %>
<%@ attribute name="pager" rtexprvalue="true" required="true" type="jetbrains.buildServer.util.Pager"%>
<%@ attribute name="pagerDesc" required="false" %>

<c:if test='${place eq "title" and (pager.pageCount > 1 or not empty pagerDesc)}'>
  <div class="pager pager-title">
    Page ${pager.currentPage} of ${pager.pageCount}
    <c:if test="${not empty pagerDesc}"> (${pagerDesc})</c:if>
  </div>
</c:if>

<c:choose>
  <c:when test='${place eq "top"}'>
    <div class="pager pager-top">
      <c:choose>
        <c:when test="${pager.previousPageExists}">
          <c:set value='<%=urlPattern.replace("[page]", String.valueOf(pager.getCurrentPage() - 1))%>' var="url"/>
          <span class="back"><a href="${url}" data-page-num="${pager.currentPage - 1}">&larr; previous</a></span>
        </c:when>
        <c:otherwise>
          <span class="back back-disabled">&larr; previous</span>
        </c:otherwise>
      </c:choose>

      <span class="pages">
       Page ${pager.currentPage}/${pager.pageCount}
      </span>

      <c:choose>
        <c:when test="${pager.nextPageExists}">
          <c:set value='<%=urlPattern.replace("[page]", String.valueOf(pager.getCurrentPage() + 1))%>' var="url"/>
          <span class="forward"><a href="${url}" data-page-num="${pager.currentPage + 1}">next &rarr;</a></span>
        </c:when>
        <c:otherwise>
          <span class="forward forward-disabled">next &rarr;</span>
        </c:otherwise>
      </c:choose>
    </div>
  </c:when>

  <c:when test='${place eq "bottom" and fn:length(pager.visiblePages) > 1}'>

    <div class="pager pager-bottom">
      <div class="pages">
        <c:if test="${pager.visiblePages[0]>1}">
          <c:set value='<%=urlPattern.replace("[page]", "1")%>' var="url"/>
          <a class="page" href="${url}" data-page-num="1">1</a>
          ...
        </c:if>
        <c:forEach items="${pager.visiblePages}" var="p">
          <c:if test="${p == pager.currentPage}"><span class="page">${p}</span></c:if>
          <c:if test="${p != pager.currentPage}">
            <c:set value='<%=urlPattern.replace("[page]", String.valueOf(jspContext.getAttribute("p")))%>' var="url"/>
            <a class="page" href="${url}" data-page-num="${p}">${p}</a></c:if>
          <c:set value='${p}' var="lastVisible"/>
        </c:forEach>
        <c:if test="${lastVisible < (pager.pageCount-1)}">
          ...
          <c:set value='<%=urlPattern.replace("[page]", String.valueOf(pager.getPageCount()))%>' var="url"/>
          <a class="page" href="${url}" data-page-num="${pager.pageCount}">${pager.pageCount}</a>
        </c:if>
      </div>

      <c:choose>
        <c:when test="${pager.previousPageExists}">
          <c:set value='<%=urlPattern.replace("[page]", String.valueOf(pager.getCurrentPage() - 1))%>' var="url"/>
          <span class="back"><a href="${url}" data-page-num="${pager.currentPage - 1}">&larr; Prev</a></span>
        </c:when>
        <c:otherwise>
          <span class="back back-disabled">&larr; Prev</span>
        </c:otherwise>
      </c:choose>

      <c:choose>
        <c:when test="${pager.nextPageExists}">
          <c:set value='<%=urlPattern.replace("[page]", String.valueOf(pager.getCurrentPage() + 1))%>' var="url"/>
          <span class="forward"><a href="${url}" data-page-num="${pager.currentPage + 1}">Next &rarr;</a></span>
        </c:when>
        <c:otherwise>
          <span class="forward forward-disabled">Next &rarr;</span>
        </c:otherwise>
      </c:choose>
    </div>
  </c:when>
</c:choose>

