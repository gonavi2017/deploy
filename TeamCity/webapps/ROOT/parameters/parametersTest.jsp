<%@include file="/include-internal.jsp"%>
<%@ taglib prefix="p" tagdir="/WEB-INF/tags/p" %>
<jsp:useBean id="pps" scope="request" type="java.util.Collection< jetbrains.buildServer.serverSide.Parameter >"/>

<bs:page>
  <jsp:attribute name="body_include">

    <h2>Here goes typed controls test</h2>

    <div style="width: 45em">

      <table class="runnerFormTable">
        <tbody>
        <!-- here goes the rest of big generic parameters form -->
        <p:container JSObject="BS.Moo" contextId="123">
          <jsp:attribute name="context">
            <!-- this adds extra key-value to additional parameters of control
            <p:context key="aaa" value="bbb"/>
          </jsp:attribute>

          <jsp:attribute name="content">
            <!-- here goes parameters -->
            <c:forEach var="p" items="${pps}">
              <p:parameter parameter="${p}"/>
            </c:forEach>
          </jsp:attribute>
        </p:container>
        <!-- here goes submit buttons and all other stuff -->

        </tbody>
      </table>


    </div>



    <a id="testValues" href="#">TestValues</a>
    |
    <a id="testSubmit" href="#">TestSubmit</a>
    |
    <a id="testErrors" href="#">TestErrors</a>
    |
    <a id="hideErrors" href="#">HideErrors</a>

    <div id="testValuesDump"></div>

    <script type="text/javascript">
      $j("#testValues").click(function() {
        var s = "";
        var data = BS.Moo.getInternalValues();

        $j("#testValuesDump").html(JSON.stringify(data));
      });

      $j("#testSubmit").click(function() {
        BS.Moo.getSubmitValues(
            {
              onComplete: function (json) {
                $j("#testValuesDump").html(JSON.stringify(json));
              }
            });
      });

      $j("#testErrors").click(function() {
        BS.Moo.getSubmitValues(
            {
              onComplete: function (json) {
                $j("#testValuesDump").html(JSON.stringify(json));
                BS.Moo.updateErrors(json.errors);
              }
            });
      });

      $j("#hideErrors").click(function() {
        BS.Moo.hideErrors();
      });
    </script>

  </jsp:attribute>

</bs:page>