<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"
  %><%@ taglib prefix="changefn" uri="/WEB-INF/functions/change"
  %><%@attribute name="changes" required="true" type="java.util.List"
  %><%@attribute name="modification" required="true" type="jetbrains.buildServer.vcs.SVcsModification"
  %><%@attribute name="maxFilePathLen" required="false" type="java.lang.Integer"
  %><%@attribute name="openLinkInSameTab" required="false" type="java.lang.Boolean"
  %><%@attribute name="highlightChange" required="false" type="java.lang.String"
  %><c:set var="numIncludedFiles" value="${changefn:getNumberOfIncludedFiles(changes)}"
/><table class="changedFiles">
  <c:choose
    ><c:when test="${numIncludedFiles > 0}"
      ><c:forEach items="${changes}" var="change" varStatus="changeIndex"
        ><c:if test="${not change.excludedByCheckoutRules}"
            ><c:set var="modification" value="${modification}" scope="request"
           /><c:set var="maxFilePathLen" value="${maxFilePathLen}" scope="request"
           /><c:set var="openLinkInSameTab" value="${openLinkInSameTab}" scope="request"
           /><c:set var="highlight" value="${change.fileName == highlightChange}" scope="request"
           /><bs:changeRequest key="changedFile" value="${change}"
              ><ext:includeJsp jspPath="/changedFile.jsp"
           /></bs:changeRequest
      ></c:if
      ></c:forEach
    ></c:when
    ><c:otherwise
      ><tr><td class="typeTD none">No files found</td></tr>
    </c:otherwise
  ></c:choose>
</table>