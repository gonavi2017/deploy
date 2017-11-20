<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %> [<c:forEach items="${instances}" var="instance" varStatus="instancesIteration"> [${instance.fileId}, ${instance.startLine}, '${instance.offsetInfo}']<c:if test="${!instancesIteration.last}">,</c:if></c:forEach>]