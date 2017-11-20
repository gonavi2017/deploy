<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="layers" type="java.util.List" required="true" %>
<%@attribute name="id" type="java.lang.String" required="false" %>
<%@attribute name="nodeContent" fragment="true" required="true" %>
<c:set var="nodesByLayer" value="${layers}"/>
<c:if test="${not empty id}"><c:set var="graphId" value="${id}"/></c:if>
<c:if test="${empty id}"><c:set var="graphId"><bs:id/></c:set></c:if>
<div style="position: relative;" id="${graphId}">
  <div id="canvas${graphId}"></div>
  <div class="layeredGraph invisible" id="${graphId}_nodes">
    <c:forEach items="${nodesByLayer}" var="layer" varStatus="pos">
      <c:forEach items="${layer}" var="node" varStatus="nodePos">
        <c:choose>
          <c:when test="${empty node.userData}">
            <div class="fakeNode" id="${graphId}_${node.id}"></div>
          </c:when>
          <c:when test="${not empty node.userData}">
            <div class="depNode" id="${graphId}_${node.id}">
              <c:set var="node" value="${node}" scope="request"/>
              <jsp:invoke fragment="nodeContent"/>
            </div>
          </c:when>
        </c:choose>
      </c:forEach>
    </c:forEach>
  </div>
</div>
<script type="text/javascript">
  var GraphObject = function(graphContainerId) {
    this._id = graphContainerId;
    this._shown = false;
    this._graph = new BS.LayeredGraph();
    this._graphDrawer = new BS.LayeredGraphDrawer(this._graph);

  <c:forEach items="${nodesByLayer}" var="layer" varStatus="pos">
    <c:forEach items="${layer}" var="node">
    this._graph.addNode('${graphId}_${node.id}', ${pos.index}, ${node.fakeNode});
    </c:forEach>
  </c:forEach>

<c:forEach items="${nodesByLayer}" var="layer" varStatus="pos">
  <c:forEach items="${layer}" var="node">
    <c:forEach items="${node.parents}" var="dep">
    this._graph.nodes['${graphId}_${node.id}'].addDependency('${graphId}_${dep.id}');
    </c:forEach>
  </c:forEach>
</c:forEach>

    this.drawGraph = function(callback) {
      if (this._shown) return true;

      // check visibility, if parent has display: none, we can't draw graph correctly
      if (!BS.Util.visible($(this._id))) return false;

      $('${graphId}_nodes').style.visibility = "hidden";

      var drawCallback = function() {
        $('${graphId}_nodes').style.visibility = "visible";
        if (callback) {
          callback();
        }
      };

      this._graphDrawer.drawGraph($("canvas${graphId}"), drawCallback);
      this._shown = true;
      return true;
    }.bind(this);

    this.hasSelectedNodes = function() {
      return this._graphDrawer.hasSelectedNodes();
    }.bind(this);
  };

  if ($('${graphId}')) {
    $('${graphId}').graphObject = new GraphObject('${graphId}');
  }
</script>
