<%--
Branch spec should be placed closer to the branch field.
Branch field location is vcs-plugin specific. This tag
is needed to not edit markup in each plugin.
--%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="note">Branches to monitor besides the default one as a newline-delimited set of rules in the form of <b>+|-:branch name</b> (with the optional <b>*</b> placeholder)<bs:help file="Working+with+Feature+Branches#WorkingwithFeatureBranches-branchSpec"/><br/></c:set>
<props:multilineProperty name="teamcity:branchSpec" value="${vcsPropertiesBean.branchSpec}" rows="3" cols="60"
                         linkTitle="Edit branch specification" expanded="${true}" className="longField" note="${note}"/>
