<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%--
  treeId - id of vcs tree, specify it if you have several trees on the page.
           When not specified - fieldId is used, if fieldId is not specified -
           constant 'vcsTree' is used
  callback - name of javascript function to call when some item in the tree
           is selected. Callback gets 2 parameters: chosen file and selected
           tree element, the 2nd parameter maybe removed in the future, so use
           callbacks with single parameter. When callback is not set - default
           callback is used - it does $j(fieldId).val(chosenFile)
  fieldId - text field id. Default callback sets value of this element when
           some file is chosen in the tree
--%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="treeId" type="java.lang.String" required="false"
%><%@ attribute name="callback" type="java.lang.String" required="false"
%><%@ attribute name="fieldId" type="java.lang.String" required="false"
%><%@ attribute name="dirsOnly" type="java.lang.Boolean" required="false"
%><%@ attribute name="vcsRootId" type="java.lang.String" required="false"
%><%@ attribute name="rootDirName" type="java.lang.String" required="false"

%><jsp:include page="/vcsTreePopup.html?treeId=${not empty treeId ? treeId : fieldId}&callback=${callback}&fieldId=${fieldId}&dirsOnly=${dirsOnly}&vcsRootId=${not empty vcsRootId ? vcsRootId : ''}&rootDirName=${not empty rootDirName ? fn:escapeXml(rootDirName) : ''}"/>
