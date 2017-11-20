<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SBuild"
  %><bs:promotionCommentIcon promotion="${build.buildPromotion}"/>