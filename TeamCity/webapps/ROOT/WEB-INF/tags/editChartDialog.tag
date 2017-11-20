<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="keysDescriptions" required="false" type="java.util.List"%>
<%@ attribute name="additionalContent" fragment="true" required="false" %>
<%@ attribute name="currentProjectId" required="false" type="java.lang.String" %>
<%@taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<bs:linkScript>
  /js/bs/chart.js
</bs:linkScript>
<bs:dialog dialogId="editChartDialog" title="Edit custom chart" closeCommand="" dialogClass="editChartDialog" titleId="editChartDialogTitle">
  <div class="editPane">
    <span style="display: none"><bs:helpLink file="Custom+Chart" anchor="AddingCustomCharts"><bs:helpIcon/></bs:helpLink></span>

    <div class="simpleTabs clearfix" style="margin-bottom: 0.5em; display: none;">
      <ul class="tabs"  style="display: none">
        <li class="first selected" id="generalTab" onclick=""><p><a href="#" onclick="return false;">General</a></p></li>
        <li class="last" id="xmlTab" onclick="" style="display: none"><p><a href="#" onclick="return false;">XML</a></p></li>
      </ul>
    </div>

    <div class="tabContent" id="generalTab-content">
      <div class="group">
        <span class="title first" for="chartTitle">Chart title:</span>
        <span><forms:textField className="chartTitle fullSize" name="chartTitle" expandable="false" noAutoComplete="true" value=""/></span>
        <div class="sourceProject smallNote" style="display: none">The chart is defined in the <span class="projectExtId"></span> Project</div>
      </div>
      <c:if test="${not empty additionalContent}">
        <jsp:invoke fragment="additionalContent"/>
      </c:if>
      <div class="group editValueTypes">
        <div class="header valueTypeHeader" style="display: none">
          Added Statistic Values
          <div class="tableHeader">
            <span class="key greyNote">Statistic Value</span><span class="description greyNote">Display Name</span>
          </div>
        </div>
        <div>
          <div class="sortableValueTypes">
            <div class="valueType smallSortable proto" style="display: none">
              <span id="key" class="key"></span>
              <forms:textField name="title" className="title fullSize" expandable="false" value=""/>
              <a class="removeValueType noUnderline" href="#" onclick="return false;">&#xd7;</a>
              <input type="hidden" id="sourceBuildTypeId"/>
              <input type="hidden" id="currentProjectId" value="${currentProjectId}"/>
              <div style="display: none" class="smallNote sourceBuildTypeNote" id="sourceBuildTypeNote"></div>
            </div>
          </div>
          <div class="vtChooser">
            <span class="key"></span>
            <forms:select name="valueTypeChooser" className="valueTypeChooser fullSize" enableFilter="true">
              <forms:option disabled="true" selected="true" value="__none__">-- Add a statistic value --</forms:option>
              <c:forEach var="vt" items="${keysDescriptions}">
                <forms:option>
                  <jsp:attribute name="title"><c:out value="${vt.first} ${vt.second}"/></jsp:attribute>
                  <jsp:attribute name="data"><c:out value="${vt.second}"/></jsp:attribute>
                  <jsp:attribute name="value">${vt.first}</jsp:attribute>
                  <jsp:body><c:out value="${vt.second}"/><c:if test="${vt.second != vt.first}"> (<c:out value="${vt.first}"/>)</c:if></jsp:body>
                </forms:option>
              </c:forEach>
            </forms:select>
          </div>
        </div>
      </div>
      <div class="group">
        <span class="title" for="seriesTitle">Series title:</span>
        <span><forms:textField className="seriesTitle fullSize" name="seriesTitle" expandable="false" noAutoComplete="true" value=""/></span>
      </div>
      <div class="group">
        <span class="title" for="dataFormat">Data format:</span>
        <span>
          <forms:select name="dataFormat" className="dataFormat fullSize" enableFilter="true">
          </forms:select>
        </span>
      </div>
    </div>
    <div class="tabContent" id="xmlTab-content" style="display: none">
      <textarea class="editChart data"></textarea>
    </div>

    <div class="status">
      <div class="successMessage" style="display: none;"></div>
      <div class="error" style="display: none;"></div>
    </div>

    <div class="buttons">
      <button class="btn btn_primary submitButton submitChartXml" data-chart-id="${chart.key}" data-buildtype-id="${buildType.externalId}" data-project-id="${chart.owner}" data-chart-group="${chartGroup}">Save</button>
      <button class="btn cancel cancelEditChart">Cancel</button>
      <button class="btn cancel deleteChartXml">Delete Chart</button>
    </div>
  </div>
</bs:dialog>
<script type="text/javascript">
  $j(function() {
    var $p = $j(".editChartDialog .helpIcon");
    $p.appendTo($j("#editChartDialogTitle"));

    var $formatSelect = $j("#dataFormat");
    for (var property in BS.Chart.Formats) {
      if (BS.Chart.Formats.hasOwnProperty(property)) {
        $formatSelect.append("<option value=\"" + property + "\">" + BS.Chart.Formats[property].BSChart.description + "</option>");
      }
    }
  });
</script>