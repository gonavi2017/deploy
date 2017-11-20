<%@ attribute name="projectId" required="true" type="java.lang.String" description="External id of the project whose ssh keys is to be shown" %>
<%@ attribute name="keySelectionCallback" required="false" type="java.lang.String"%>

<jsp:include page="/admin/sskKeyChooser.html?projectId=${projectId}&keySelectionCallback=${keySelectionCallback}"/>
