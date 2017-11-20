<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@

    attribute name="buildTypes" type="java.util.List" required="true" %><%@
    attribute name="selectedBuildTypeId" type="java.lang.String" required="true" %><%@
    attribute name="url" type="java.lang.String" required="true" %><%@
    attribute name="style" type="java.lang.String" required="false" %><%@
    attribute name="className" type="java.lang.String" required="false"

%><forms:select name="buildType" enableFilter="true" style="${style}" className="${className}"
  ><forms:option value="">&lt;All build configurations&gt;</forms:option
  ><c:forEach items="${buildTypes}" var="bean"
    ><forms:projectOptGroup project="${bean.project}" classes="user-depth-${bean.limitedDepth}"
    ><c:forEach var="buildType" items="${bean.buildTypes}"
      ><forms:option value="${buildType.externalId}"
                     title="${buildType.fullName}"
                     className="user-depth-${bean.limitedDepth + 1}"
                     selected="${buildType.externalId == selectedBuildTypeId}"
        ><c:out value="${buildType.name}"/></forms:option
      ></c:forEach
    ><c:if test="${empty bean.buildTypes}"><forms:option value="" className="user-delete" disabled="true">&nbsp;</forms:option></c:if
    ></forms:projectOptGroup
  ></c:forEach
></forms:select>
<script type="text/javascript">
  $j("#buildType").change(function(e) {
    var selected = $j(this).find("option:selected");
    var url = '${url}' + '&buildTypeId=' + selected.val();
    BS.openUrl(e, url);
    return false;
  });
</script>