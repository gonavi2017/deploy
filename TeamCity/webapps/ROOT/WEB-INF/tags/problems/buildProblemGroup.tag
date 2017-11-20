<%@ attribute name="header" required="true" fragment="true" %>
<%@ attribute name="problemNumber" required="true" type="java.lang.Integer" %>
<%@ attribute name="body" required="true" fragment="true" %>
<%@ attribute name="classes" required="false"%>
<div>
  <div class="tc-icon_before icon16 groupHeader handle_expanded ${classes}"><jsp:invoke fragment="header"/>&nbsp;<span class="problemCount" title="Number of build problems">(${problemNumber})</span></div>
  <div class="group ${classes}"><jsp:invoke fragment="body"/></div>
</div>
