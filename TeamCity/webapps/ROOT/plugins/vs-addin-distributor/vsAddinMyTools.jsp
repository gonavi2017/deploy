<%--
  Created by IntelliJ IDEA.
  User: Evgeniy.Koshkin
  Date: 22.06.12
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="vsAddinDownloadUrl" type="java.lang.String"  scope="request"/>
<jsp:useBean id="vsImageUrl" type="java.lang.String"  scope="request"/>

<c:set var="vsAddinDownloadPath"><c:url value="${vsAddinDownloadUrl}"/></c:set>

<style type="text/css">
    p.toolTitle.vs-addin {
        background-image: url("<c:url value="${vsImageUrl}"/>");
        background-repeat: no-repeat;
        background-size: 16px 16px;
    }
</style>
<p class="toolTitle vs-addin">Visual Studio Addin<bs:help style="display:inline;" file="Visual+Studio+Addin"/></p>

<a showdiscardchangesmessage="false" title="Visual Studio Addin" href="${vsAddinDownloadPath}">download</a>
