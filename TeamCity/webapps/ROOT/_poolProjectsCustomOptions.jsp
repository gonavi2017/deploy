<%@ include file="include-internal.jsp"%>
<jsp:useBean id="dissociateFromOtherPools" scope="request" type="java.lang.Boolean"/>
<forms:checkbox id="dissociateFromOtherPools" name="dissociateFromOtherPools" style="margin-left: 0" checked="${dissociateFromOtherPools}" onclick="${stateChangedJS}"/>
<label for="dissociateFromOtherPools">Dissociate selected projects from other pools</label>
