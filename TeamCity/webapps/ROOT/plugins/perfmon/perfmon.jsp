<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="teamcityPluginResourcesPath" type="java.lang.String" scope="request"/>
<jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
<jsp:useBean id="perfmonData" type="org.jetbrains.teamcity.perfmon.PerfMonData" scope="request"/>

<script src="<c:url value='${teamcityPluginResourcesPath}flot/excanvas.js'/>" type="text/javascript"></script>
<script src="<c:url value='${teamcityPluginResourcesPath}flot/jquery.flot.js'/>" type="text/javascript"></script>
<script src="<c:url value='${teamcityPluginResourcesPath}flot/jquery.flot.crosshair.js'/>" type="text/javascript"></script>
<script src="<c:url value='${teamcityPluginResourcesPath}flot/jquery.flot.selection.js'/>" type="text/javascript"></script>
<script src="<c:url value='${teamcityPluginResourcesPath}js/perfmon.js'/>" type="text/javascript"></script>

<table id="perfmon">
    <tr>
        <td>
            <div id="chart"></div>
        </td>
        <td class="rightBar">
            <div id="legend">
                <div class="cpu">
                    <label for="show-cpu" class="legend-item__label"><forms:checkbox name="show-cpu" checked="true" className="legend-item__checkbox"
                    /><div class='color-bullet'></div>CPU</label> = <span title="Average value"><fmt:formatNumber maxFractionDigits="2" value="${perfmonData.averageUsage['cpu']}"/>%</span>
                </div>
                <div class="disk">
                    <label for="show-disk" class="legend-item__label"><forms:checkbox name="show-disk" checked="true" className="legend-item__checkbox"
                    /><div class='color-bullet'></div>Disk</label> = <span title="Average value"><fmt:formatNumber maxFractionDigits="2" value="${perfmonData.averageUsage['disk']}"/>%</span>
                </div>
                <div class="memory">
                    <label for="show-memory" class="legend-item__label"><forms:checkbox name="show-memory" checked="true" className="legend-item__checkbox"
                    /><div class='color-bullet'></div>Memory</label> = <span title="Average value"><fmt:formatNumber maxFractionDigits="2" value="${perfmonData.averageUsage['memory']}"/>%</span>
                </div>
            </div>
            <div id="legendHint">
                Disk and Memory usage values are in % of available on agent
            </div>
            <div id="buildStages">
                Build stages:
                <ul>
                    <c:forEach items="${perfmonData.regions}" var="r">
                        <li>
                            <c:out value="${r.name}"/>:
                            <a href="#" onclick="return BS.Perfmon.select(${r.from}, ${r.to})">
                                <bs:printTime time="${r.duration/1000}"/>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </td>
    </tr>
</table>

<div style="height: 1em;">
    <span id="loadingLog" style="display: none;"><forms:progressRing/> Please wait...</span>
</div>
<div id="buildLogDiv" style="display: none;">
    <a id="buildLogAnchor"></a>
    <div><span id="buildLogMarker">Build log:</span></div>
    <div id="buildLogContainer"></div>
</div>

<script type="text/javascript">
    (function() {
        var data = {
            cpu: [<c:forEach items="${perfmonData.series['cpu']}" var="d" varStatus="pos">${d},</c:forEach>],
            disk: [<c:forEach items="${perfmonData.series['disk']}" var="d" varStatus="pos">${d},</c:forEach>],
            memory: [<c:forEach items="${perfmonData.series['memory']}" var="d" varStatus="pos">${d},</c:forEach>],
            labels: [<c:forEach items="${perfmonData.timestamps}" var="d" varStatus="pos">${d},</c:forEach>]
        };

        BS.Perfmon.setBuildId(${build.buildId});
        BS.Perfmon.init("#chart", "#legend", data);
        BS.Perfmon.restoreFromUrl();
    })();
</script>
