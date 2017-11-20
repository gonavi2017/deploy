<%@include file="/include-internal.jsp"%>
<jsp:useBean id="branches" type="java.util.Collection" scope="request"/>
<jsp:useBean id="targetFieldId" type="java.lang.String" scope="request"/>
<jsp:useBean id="selectMode" type="java.lang.String" scope="request"/>
<style type="text/css">
  .branchesContainer .itemList, .branchesContainer .menuList {
    width: 20em;
  }

  div.popupTitle {
    padding: 4px 0 4px 0;
  }

  ul.menuList {
    padding: 0px 2px 0 2px;
    margin-left: 0;
  }

  ul.menuList li {
    list-style: none;
    padding: 2px;
  }

  ul.menuList li a {
    display: inline;
  }
</style>
<div class="branchesContainer">
  <c:if test="${empty branches}">
    <div>No branches to show</div>
  </c:if>
  <c:set var="containerId"><bs:id/></c:set>
  <form>
  <c:if test="${fn:length(branches) > 10}">
    <bs:inplaceFilter containerId="${containerId}" activate="true" filterText="&lt;filter branches>"/>
  </c:if>
  <c:choose>
    <c:when test="${selectMode eq 'branchFilter'}">
      <ul class="itemsList" id="${containerId}">
        <li class="inplaceFiltered">
          <forms:checkbox id="__all_branches" name="branch__all_branches" value="*"/>
          <label for="__all_branches"><em>&lt;all branches&gt;</em></label>
        </li>
        <c:forEach items="${branches}" var="branch" varStatus="pos">
          <c:set var="branch" value="${fn:escapeXml(branch)}"/>
          <li class="inplaceFiltered">
            <forms:checkbox id="branch_${branch}" name="branch_${branch}" value="${branch}"/>
            <label for="branch_${branch}">${branch}</label>
          </li>
        </c:forEach>
      </ul>
    </c:when>
    <c:otherwise>
      <ul class="menuList" id="${containerId}">
        <c:forEach items="${branches}" var="branch">
          <li class="inplaceFiltered"><c:out value="${branch}"/></li>
        </c:forEach>
      </ul>
      <script type="text/javascript">
        $j('#${containerId}').click(function(event) {
          var fieldId = '${targetFieldId}'.replace(/\./g, '\\.');
          $j('#' + fieldId).val($j(event.target).text());
          BS.BranchesPopup.hidePopup(0);
        });
      </script>
    </c:otherwise>
  </c:choose>

  <c:if test="${selectMode eq 'branchFilter'}">
  <div class="popupSaveButtonsBlock">
      <forms:submit onclick="return BS.BranchesPopup.appendSelected('+:', '${containerId}', '${targetFieldId}')" label="Include selected"/>
      <forms:submit onclick="return BS.BranchesPopup.appendSelected('-:', '${containerId}', '${targetFieldId}')" label="Exclude selected"/>
      <forms:cancel onclick="BS.BranchesPopup.hidePopup(0)"/>
  </div>
  </c:if>
  </form>
</div>
