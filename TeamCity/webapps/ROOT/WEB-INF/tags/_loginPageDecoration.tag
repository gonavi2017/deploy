<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop" %>
<%@ attribute name="id" required="true" type="java.lang.String" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<div id="${id}" class="initialPage">
  <div class="page-content-wrapper">
    <div id="pageContent">
      <span class="logo" title="TeamCity"></span>
      <h1 id="header">${title}</h1>

      <jsp:doBody/>

      <div class="version"><bs:version/></div>
    </div>
  </div>
</div>
