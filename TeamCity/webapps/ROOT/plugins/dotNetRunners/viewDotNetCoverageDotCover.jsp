<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="pns" scope="request" class="jetbrains.buildServer.dotNetCoverage.dotCover.DotCoverConstants"/>

<div class="parameter">
  Path to dotCover home: <props:displayValue name="${pns.dotCoverHome}" emptyValue="use bundled"/>
</div>

<div class="parameter">
  Filters: <props:displayValue name="${pns.dotCoverFilters}" emptyValue="<empty>" showInPopup="${true}" popupTitle="Coverage Filters"/>
</div>

<div class="parameter">
  Attribute filters: <props:displayValue name="${pns.dotCoverAttributeFilters}" emptyValue="<empty>" showInPopup="${true}" popupTitle="Attribute Filters"/>
</div>

<div class="parameter">
  Additional dotCover.exe arguments: <strong><props:displayValue name="${pns.customCommandline}" showInPopup="${true}"/></strong>
</div>