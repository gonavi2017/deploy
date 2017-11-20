<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>

<div id="inspectionBrowser">
  <div class="actionBar" style="margin-bottom: 1em">
    <%--@elvariable id="stats" type="int[]"--%>
    <span class="inspectionToolbar" title="Total inspection results count, number of new and obsolete results since the previous build.">
      <input type="radio" name="filter" id="showAll" checked onclick="IB.filter=false;IB.selectPath(0);IB.listModules();">
      <label class="rightLabel" for="showAll">Total: ${stats[0]} (+${stats[1]} -${stats[2]})</label>
      <input type="radio" name="filter" id="filterSev" onclick="IB.filter=true;IB.selectPath('0');IB.listModules();">
      <label class="rightLabel" for="filterSev">Errors: ${stats[3]} (+${stats[4]} -${stats[5]})</label>
    </span>
    <forms:checkbox title="" name="" id="filterChanges" checked="true" onclick="IB.diff=this.checked; IB.path_index = 0; IB.listModules();"/>
    <label class="rightLabel" for="filterChanges" title="If checked, shows all inspections where new problems were detected">inspections with new problems only</label>
  </div>
  <div id="details"><forms:progressRing className="progressRingInline"/>&nbsp;Loading...</div>
  <div id="ibControls" style="display:none;">
  <div class="dtitle">Scope</div>
  <div id="modules"></div>
  <div id="inspections"></div>
  <div id="popupDescription"></div>
</div>

<textarea id="modulesT" style="display:none;">
  <div id="moduleList">
    {for path in modules}
    {if (!IB.diff || path[1])}
        <div class="module"><a class="moduleLink" href="#" id="path_\${path_index}" onclick="IB.selectPath('\${path_index}'); return false">\${path[0]}</a></div>
    {/if}
    {/for}
  </div>
</textarea>

<textarea id="inspectionsT" style="display:none">
<div id="inspectionsList">
\${g=null|eat}
  <div class="inspection">
{for i in inspections}
{if (!IB.filter || i.s==0) && (!IB.diff || i.w>0)}
{if 0>IB.inspectionId}\${IB.inspectionId=i_index|eat}{/if}
{if g!=i.g}
  </div>
  <div onclick="IB.doToggle(this);" class="group"><span class="openGroup">&nbsp;</span>\${(i.g=="")?"General":i.g}</div><div class="inspection">
  \${g=i.g|eat}
{/if}
<a href="#" id="inspection_\${i_index}" onclick="IB.listFiles('\${i_index}'); return false">\${i.n} \${(!IB.filter && i.s==0)?"(Errors)":""} (\${IB.diff?i.w:i.c})</a>
{/if}
{/for}
  </div>
</div>
</textarea>

<textarea id="filesT" style="display:none">
<div>
  <div class="dtitle">
    <div id="help" class="tc-icon icon16 tc-icon_comment">&nbsp;</div>
    Selected: \${IB.inspections[IB.inspectionId].n} (\${IB.inspections[IB.inspectionId][IB.diff?"w":"c"]})
  </div>
</div>
<div id="files">
  \${ppath=''|eat}
  <div>
  {for file in files}
  {if (!IB.diff || file[2]>0) && (IB.inspections[IB.inspectionId].s == file[3])}
    \${path=file[0]|eat}
    \${name=path.substr(path.lastIndexOf("/")+1)|eat}
    \${path=path.substr(0,path.lastIndexOf("/"))|eat}
    {if ppath!=path}
      </div>
      <div onclick="IB.doToggle(this);" class="group"><span class="openGroup">&nbsp;</span>\${path}</div><div>
      \${ppath=path|eat}
    {/if}
    <div class="file" onclick="IB.listDetails(this,'\${file[0]}');"><span class="closedGroup">&nbsp;</span><span class="filename">\${name} (\${file[IB.diff?2:1]})</span></div>
  {/if}
  {/for}
     </div>
</div>
</textarea>
<!--
-->
<c:set var="inspections" value="${inspectionInfo.inspections}"/>
<!-- DO NOT REFORMAT -->
<!-- inspections_DESC-${inspectionInfo.buildId} -->
<div style="display:none;"><c:forEach items="${inspections}" var="inspection"><div id="DESC_${inspection[2]}">${fn:escapeXml(inspection[5])}</div></c:forEach></div>

<script type="text/javascript">
var IB = {}; //inspection browser

IB.IS_URL_PATTERN = /(\w+):\/\/([\w.]+)\/(\S*)/;

<c:set var="modules" value="${inspectionInfo.paths}"/>
IB.modules = [
  <%--@elvariable id="modules" type="java.util.Map<String, Boolean>"--%>
  <c:forEach items="${modules}" var="path" varStatus="pathIteration"> ['${util:forJS(path.key, true, true)}', ${path.value.first}]<c:if test="${!pathIteration.last}">,</c:if></c:forEach>
];

IB.errorModules = [
  <%--@elvariable id="modules" type="java.util.Map<String, Boolean>"--%>
  <c:forEach items="${modules}" var="path" varStatus="pathIteration"><c:if test="${path.value.second == 0 || pathIteration.first}"> ['${util:forJS(path.key, true, true)}', ${path.value.first}]<c:if test="${!pathIteration.last}">,</c:if></c:if></c:forEach>
];

IB.inspections = [
  <c:forEach items="${inspections}" var="inspection" varStatus="inspectionIteration">
{s:${inspection[0]},g:"${util:forJS(inspection[1], true, true)}",i:"${inspection[2]}",n:"${util:forJS(inspection[3], true, true)}",c:${inspection[4]},w:${inspection[6]}}<c:if test="${!inspectionIteration.last}">,</c:if></c:forEach>
  ];
IB.allInspections = IB.inspections; 

IB.diff=IB.inspections.detect(function(value,index) { return value.w>0 })!=null;
$("filterChanges").checked=IB.diff;
$("filterChanges").disabled=!IB.diff;
IB.filter = false;
IB.inspectionId = -1;
IB.filesCache={};
IB.pathsCache={};

IB.listModules = function() {
  var modules = $("modules");
  modules.innerHTML = TrimPath.processDOMTemplate("modulesT", {modules: IB.getModules()});
  modules.scrollTop = 0;
  IB.selectPath(0);
};

IB.currentPath = "";
IB.path_index = 0;

IB.getModules = function(){
  return !IB.filter ? IB.modules : IB.errorModules;
};

IB.selectPath = function (path_index) {
  $("path_" + IB.path_index).removeClassName("active");
  IB.path_index = path_index;
  $("path_" + IB.path_index).addClassName("active");
  if(path_index==0) {
    IB.inspections = IB.allInspections;
    IB.currentPath = "";
    IB.listInspections();
    return;
  }
  var path = IB.getModules()[IB.path_index][0];
  var key = "_" + path;
  IB.currentPath = path;
  if(!IB.pathsCache[key]) {
    BS.ajaxRequest("inspectionFiles.html?mode=data&buildId=${inspectionInfo.build.buildId}&path=" + IB.currentPath, {
        onSuccess: function(t) {
          IB.inspections = eval(t.responseText);
          IB.pathsCache[key] = IB.inspections; 
          IB.listInspections();
        }
      }
    );
  } else {
    IB.inspections = IB.pathsCache[key];
    IB.listInspections();
  }
};

IB.listFiles = function(i) {
  $("details").innerHTML='<i class="icon-refresh icon-spin"></i>&nbsp;Loading...';
  var activeInspection = $("inspection_" + IB.inspectionId);
  if (activeInspection) {
    activeInspection.removeClassName("active");
    IB.inspectionId = i;
    var key = "_" + IB.inspections[i].i + "_" + IB.currentPath;
    if(!IB.filesCache[key]) {
      BS.ajaxRequest("inspectionFiles.html?buildId=${inspectionInfo.build.buildId}&inspectionId=" + IB.inspections[i].i + "&path=" + IB.currentPath, {
          onSuccess: function(t) {
            var filesT = t.responseText;
            IB.files = eval(filesT);
            IB.filesCache[key] = IB.files;
            IB.renderFiles();
          }
        }
      );
    } else {
      IB.files = IB.filesCache[key];
      IB.renderFiles();
    }
  } else {
    $("details").innerHTML = ""
  }
};

IB.renderFiles = function () {
  $("details").innerHTML = TrimPath.processDOMTemplate("filesT", {files:IB.files});
  $("inspection_" + IB.inspectionId).addClassName("active");
  IB.updateDescription();
  IB.doResize(true);
};

  IB.updateDescription = function() {
  var currentDescription = $("DESC_"+IB.inspections[IB.inspectionId].i).innerHTML.unescapeHTML();
  var helpDiv = $("help");

  if (currentDescription.length == 0) {
    helpDiv.className = "help_none";
    helpDiv.title = "";

    helpDiv.onmouseover = null;
    helpDiv.onmouseout = null;
    helpDiv.onclick = null;
  } else if (currentDescription.match(IB.IS_URL_PATTERN)) {
    helpDiv.className = "help_url tc-icon icon16 tc-icon_help";
    helpDiv.title = "Why we suggest this?";

    helpDiv.onmouseover = null;
    helpDiv.onmouseout = null;
    helpDiv.onclick = function(event){ window.open(currentDescription, helpDiv.title, "height=500, width=900, resizable, scrollbars"); };
  } else {
    helpDiv.className = "help_text tc-icon icon16 tc-icon_comment";
    helpDiv.title = "";

    var descriptionTooltip = $("popupDescription");
    try {
      descriptionTooltip.innerHTML = $("DESC_"+IB.inspections[IB.inspectionId].i).innerHTML.unescapeHTML().replace(/height=/g,"_height=");
    } catch (x) {};

    helpDiv.onmouseover = function(event) { BS.Util.show(descriptionTooltip); };
    helpDiv.onmouseout = function(event) { BS.Util.hide(descriptionTooltip); };
    helpDiv.onclick = null;
  }
};

IB.doToggle = function (src) {
  if ($(src.nextSibling).visible()) {
    $(src.firstChild).removeClassName("openGroup");
    $(src.firstChild).addClassName("closedGroup");
    new Effect.BlindUp(src.nextSibling, {queue: 'end', duration: 0.2});
  } else {
    $(src.firstChild).removeClassName("closedGroup");
    $(src.firstChild).addClassName("openGroup");
    new Effect.BlindDown(src.nextSibling, {queue: 'end', duration: 0.2});
  }
};

IB.listDetails = function(src, f) {
  if (src.nextSibling && src.nextSibling.className == "insertedDetails") {
    IB.doToggle(src);
  }
  else {
    var target = document.createElement('div');
    target.className = "insertedDetails";
    target.style.display = "none";
    src.parentNode.insertBefore(target, src.nextSibling);
    target.innerHTML = '<div class="details"><i class="icon-refresh icon-spin"></i>&nbsp;Loading...</div>';
    IB.doToggle(src);
    BS.ajaxRequest(
        "inspectionDetails.html?buildId=${inspectionInfo.build.buildId}&inspectionId=" + IB.inspections[IB.inspectionId].i
            + "&file=" + encodeURIComponent(f) + "&filterNew=" + IB.diff,
        {
          onSuccess:function (t) {
            target.innerHTML = t.responseText;
          }
        }
    );
  }
};

IB.listInspections = function() {
  IB.errors=IB.inspections.detect(function(value,index) { return value.s==0 })!=null;
  if(!IB.errors) { $("filterSev").checked=false; $("showAll").checked=true; }
  $("filterSev").disabled=!IB.errors;
  if (IB.inspections.length > 0) {
    IB.inspectionId = -1;
    $("inspections").innerHTML = TrimPath.processDOMTemplate("inspectionsT", {inspections: IB.inspections});
    IB.listFiles(IB.inspectionId);
  } else {
    $("details").innerHTML="";
  }
};

IB.doActivate = function (file, line) {
  BS.Activator.doOpen('file?buildId=${buildId}&file='+file+'&line='+line);
};

IB.doResize = function() {
  var height = $j(window).height();
  var offset = $j("#inspectionBrowser").offset().top + 130;

  height = height - offset;
  if (height < 100) height = 100;

  var container = $j("#container"),
      files = $j("#files"),
      details = $j("#details"),
      inspectionsList = $j("#inspectionsList"),
      popupDescription = $j("#popupDescription");

  inspectionsList.height(height - 200);
  files.height(height - 10);
  popupDescription.width(files.width() - 22); // minus paddings and border
  details.width(container.width() - 420);

  popupDescription.css({top: files.offset().top, left: files.offset().left});
};

$j(document).ready(function() {
  $("ibControls").toggle();
  IB.listModules();
});

$j(window).resize(_.throttle(IB.doResize, 50));

</script>
</div>
