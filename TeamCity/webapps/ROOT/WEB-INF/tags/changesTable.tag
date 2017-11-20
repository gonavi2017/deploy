<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<bs:linkCSS dynamic="${true}">/css/overviewTable.css</bs:linkCSS>
<bs:linkScript>/js/bs/changeLog.js</bs:linkScript>
<bs:linkScript>/js/bs/changeLogGraph.js</bs:linkScript>
<table id="changesTable" class="overviewTypeTable separatedWithLine">
  <thead>
  <tr>
    <td class="changeDescription"></td>
    <td class="userName"></td>
    <td class="chainChangesIcon"></td>
    <td class="changedFiles"></td>
    <td class="vcsChange"></td>
    <td class="date"></td>
    <td class="vcsChangeDetails"></td>
  </tr>
  </thead>
  <tbody>
    <jsp:doBody/>
  </tbody>
</table>
