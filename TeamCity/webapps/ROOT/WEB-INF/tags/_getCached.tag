<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ tag import="java.util.HashMap"
    %><%@ tag import="java.util.Map"
    %><%@attribute name="id" required="true"
    %><%
  Map<String, String> myCache = (Map<String, String>)request.getAttribute("__contentCache");
  if (myCache == null) {
    myCache = new HashMap<String, String>();
  }
  request.setAttribute("__contentCache", myCache);
  String cached = myCache.get(id);
  if (cached != null) {
    out.print(cached);
  } else {
    %><jsp:doBody var="_res"/>${_res}<%
    cached = (String)jspContext.getAttribute("_res");
    if (cached != null) {
      myCache.put(id, cached);
    }
  }
%>