<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="projectId" rtexprvalue="true" description="project external id"
  %><%@ attribute name="tab" required="false" %><c:url value="/project.html?projectId=${projectId}&tab=${empty tab ? 'projectOverview' : tab}"/>