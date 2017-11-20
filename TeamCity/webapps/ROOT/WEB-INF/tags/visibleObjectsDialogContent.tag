<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@

    attribute name="showReorderButtons" type="java.lang.Boolean" required="true"  %><%@
    attribute name="object" type="java.lang.String" required="true"  %><%@
    attribute name="jsDialog" type="java.lang.String" required="true"  %><%@
    attribute name="visibleTitle" type="java.lang.String" required="true"  %><%@
    attribute name="hiddenTitle" type="java.lang.String" required="true"  %><%@
    attribute name="filterText" type="java.lang.String" required="true"  %><%@
    attribute name="visibleOptions" fragment="true" required="true"  %><%@
    attribute name="hiddenOptions" fragment="true" required="true"

%><table class="visible-objects-table">
  <tr>
    <c:if test="${showReorderButtons}">
      <td class="arrowButtons"><button type="button" class="btn btn_mini" id="${object}_moveVisibleUp" onclick="${jsDialog}.moveUp();">
          &#8593;
        </button><br/><button type="button" class="btn btn_mini" id="${object}_moveVisibleDown" onclick="${jsDialog}.moveDown();">
          &#8595;
        </button>
      </td>
    </c:if>
    <td class="visibleProjects">
      ${visibleTitle}:
      <br>
      <forms:selectMultipleHScroll name="${object}_visible" id="${object}_visible" wrapperClassName="visible-objects__visible-wrapper">
        <jsp:invoke fragment="visibleOptions"/>
      </forms:selectMultipleHScroll>
      <script>
        $j(BS.Util.escapeId('${object}_visible'))
            .on('change', function() { ${jsDialog}.updateButtons(); })
            .on('dblclick', function () { ${jsDialog}.moveToHidden(); });
      </script>
    </td>
    <td class="arrowButtons">
      <button type="button" class="btn btn_mini" id="${object}_moveToHidden" onclick="${jsDialog}.moveToHidden();">
        &#8594;
      </button><br/><button type="button" class="btn btn_mini" id="${object}_moveToVisible" onclick="${jsDialog}.moveToVisible();">
        &#8592;
      </button>
    </td>
    <td class="hiddenProjects">
      ${hiddenTitle}:
      <br>
      <bs:inplaceFilter containerId="${object}_hidden" activate="true" filterText="&lt;${filterText}&gt;" style="width:100%;" afterApplyFunc="function() {BS.VisibleProjectsDialog.expandMultiSelects()}"/>
      <forms:selectMultipleHScroll name="${object}_hidden" id="${object}_hidden" wrapperClassName="visible-objects__hidden-wrapper">
        <jsp:invoke fragment="hiddenOptions"/>
      </forms:selectMultipleHScroll>
      <script>
        $j(BS.Util.escapeId('${object}_hidden'))
          .on('change', function() { ${jsDialog}.updateButtons(); })
          .on('dblclick', function () { ${jsDialog}.moveToVisible(); });
      </script>
    </td>
  </tr>
</table>