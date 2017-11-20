<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"
  %><%@attribute name="cameFromUrl" required="false"
  %>

<bs:popup type="buildTypeMenuPopup" id="editControl${buildType.buildTypeId}" showOptions="'${buildType.externalId}', '${cameFromUrl}'">
  <admin:editBuildTypeLink buildTypeId="${buildType.externalId}" cameFromUrl="${cameFromUrl}" classes="nonInitializedBuildTypeMenu"
                           title="Edit build configuration settings"><jsp:doBody/></admin:editBuildTypeLink>
</bs:popup>
