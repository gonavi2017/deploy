<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ attribute name="promotionId" required="true" type="java.lang.Long"
  %><%@ attribute name="oldComment" required="false" type="java.lang.String"
  %><%@ attribute name="className" required="false" type="java.lang.String"
  %><a href="#" class="${className}" onclick="BS.BuildCommentDialog.showBuildCommentDialog(${promotionId}, '<bs:escapeForJs forHTMLAttribute="true" text="${oldComment}"/>'); return false"><jsp:doBody/></a
    ><forms:saving id="buildCommentProgressIcon" className="progressRingInline"/>
