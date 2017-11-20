<%@ taglib prefix="util" uri="/WEB-INF/functions/util"
    %><%@ attribute name="blocksType"
    %><%@ attribute name="wrapInScript"
    %>${util:blockHiddenJs(pageContext.request, blocksType, wrapInScript)}