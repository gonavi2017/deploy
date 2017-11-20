<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ attribute name="vcsRootsBean" required="true" type="jetbrains.buildServer.controllers.RevisionsBean"
  %><%@ attribute name="buildId" required="true"
  %>
<c:url value='/ajax.html' var="action"/>
<bs:modalDialog formId="setLabelForm" 
                title="Label this build in VCS"
                action="${action}" 
                closeCommand="BS.Label.close()" 
                saveCommand="BS.Label.setLabel()">
  
  <label for="labelName" class="labelName">Label:</label>
  <forms:textField name="labelName" value="${vcsRootsBean.defaultLabel}" maxlength="256" style="width: 25em;"/>

  <div class="labelVcsRootsTitle">VCS roots:</div>

  <ul class="vcsRootsToLabel">
    <c:forEach items="${vcsRootsBean.availableRootsToLabel}" var="root">
      <c:set var="propName" value="labelingRootsManual[${root.id}]"/>
      <li>
        <forms:checkbox checked="${vcsRootsBean.labelingRoots[root.id]}" name="${propName}" id="${propName}"/>
        <label for="${propName}"><c:out value="${root.name}"/></label>
      </li>
    </c:forEach>
  </ul>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Set label"/>
    <forms:cancel onclick="BS.Label.close()"/>
    <input type="hidden" value="${buildId}" name="setLabelForBuild"/>
    <forms:saving id="setLabel"/>
  </div>

</bs:modalDialog>
