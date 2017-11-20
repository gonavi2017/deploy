<%@ attribute name="title"
  %><%@ attribute name="style" %>
<div class="settingsBlock" style="${style}">
  <div class="settingsBlockTitle">${title}</div>
  <div class="settingsBlockContent"><jsp:doBody/></div>
</div>
