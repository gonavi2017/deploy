/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:38 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class buildTypeChangeLog_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(124);
    _jspx_dependants.put("/WEB-INF/tags/forms/saving.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/canStopBuild.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/buildRowArtifactsLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/tagsInfoInner.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/blockState.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/snapDepChangeIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/user-functions.tld", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/showBuildPromotionTags.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/includeJsp.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeType.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/filterButton.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/are_is.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/commentIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popup.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildTypeLinkFull.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeLogShowBuildsCheckBox.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/changeLogTable.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/buildDataIcon.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWithTooltip.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeLogFilesRow.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/option.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/shortRevision.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/agentDetailsFullLink.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/s.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/eventTracker/subscribeOnBuildTypeEvents.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popupControl.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/_viewLog.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/personalBuildComment.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/showPublicAndPrivateTags.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_commentText.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeLogLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_viewQueued.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/favoriteBuildInner.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changedFiles.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/refreshable.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/osIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_artifactsLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeLogUserFilter.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/textField.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/tagsLinkPopup.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/editTagsLink.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/changedFilesLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectUrl.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/personalBuildPrefix.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/eventTracker/subscribeOnProjectEvents.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/changesLinkFullInner.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/trim.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/changesList.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/pinImg.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/showTags.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/linkCSS.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/editBuildTypeGranted.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildTypeLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/makeBreakable.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/agentOutdated.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/include.jsp", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/modificationLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/userName.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/favoriteBuildAuth.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/change-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_commentInfo.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/promotionCommentIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popup_static.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tooltipAttrs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/artifactsLink.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/helpLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/simpleDate.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/checkbox.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/trimBranch.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/changeLogBuildRow.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildCommentIcon.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/include-internal.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildProgress.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/duration.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/agentDetailsLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeLogCaptionRow.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/progress.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/agentComment.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/buildRow.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/select.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeCommitters.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/resultsPerPage.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/resetFilter.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/progressRing.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/changesLinkFull.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/agentPoolLink.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/pinCommentToolTipText.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/printTag.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/authorize.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/help.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/pager.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/linkScript.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/date.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/_subscribeToCommonBuildTypeEvents.jspf", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeRequest.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changesTable.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/favoriteBuild.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/subrepoIcon.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/agentShortStatus.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/resultsLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_commentUserInfo.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWhitespace.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/pinLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/printTime.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changesLink.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/changesPopup.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/tagsInfo.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/tagLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/formatDate.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/branchLink.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/out.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/stopBuild.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/snapDepChangeLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/helpIcon.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLinkFull.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildNumber.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/changeLogChangeRow.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/projectLinkFullAbstract.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/_pinInfo.tag", Long.valueOf(1504702500000L));
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			"/runtimeError.html", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');
      jetbrains.buildServer.serverSide.SBuildType buildType = null;
      buildType = (jetbrains.buildServer.serverSide.SBuildType) _jspx_page_context.getAttribute("buildType", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (buildType == null){
        throw new java.lang.InstantiationException("bean buildType not found within scope");
      }
      out.write('\r');
      out.write('\n');
      jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean changeLogBean = null;
      changeLogBean = (jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean) _jspx_page_context.getAttribute("changeLogBean", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (changeLogBean == null){
        throw new java.lang.InstantiationException("bean changeLogBean not found within scope");
      }
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_et_005fsubscribeOnProjectEvents_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_et_005fsubscribeOnBuildTypeEvents_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_et_005fsubscribeOnBuildTypeEvents_005f1(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_bs_005fchangesList_005f0(_jspx_page_context))
        return;
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_et_005fsubscribeOnProjectEvents_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  et:subscribeOnProjectEvents
    org.apache.jsp.tag.web.eventTracker.subscribeOnProjectEvents_tag _jspx_th_et_005fsubscribeOnProjectEvents_005f0 = new org.apache.jsp.tag.web.eventTracker.subscribeOnProjectEvents_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_et_005fsubscribeOnProjectEvents_005f0);
    try {
      _jspx_th_et_005fsubscribeOnProjectEvents_005f0.setJspContext(_jspx_page_context);
      // /_subscribeToCommonBuildTypeEvents.jspf(1,1) name = projectId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_et_005fsubscribeOnProjectEvents_005f0.setProjectId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildType.projectId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      javax.servlet.jsp.tagext.JspFragment _jspx_temp0 = new Helper( 0, _jspx_page_context, _jspx_th_et_005fsubscribeOnProjectEvents_005f0, null);
      // /_subscribeToCommonBuildTypeEvents.jspf(1,1) null
      _jspx_th_et_005fsubscribeOnProjectEvents_005f0.setEventNames(_jspx_temp0);
      javax.servlet.jsp.tagext.JspFragment _jspx_temp1 = new Helper( 1, _jspx_page_context, _jspx_th_et_005fsubscribeOnProjectEvents_005f0, null);
      // /_subscribeToCommonBuildTypeEvents.jspf(1,1) null
      _jspx_th_et_005fsubscribeOnProjectEvents_005f0.setEventHandler(_jspx_temp1);
      _jspx_th_et_005fsubscribeOnProjectEvents_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_et_005fsubscribeOnProjectEvents_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_et_005fsubscribeOnBuildTypeEvents_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  et:subscribeOnBuildTypeEvents
    org.apache.jsp.tag.web.eventTracker.subscribeOnBuildTypeEvents_tag _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0 = new org.apache.jsp.tag.web.eventTracker.subscribeOnBuildTypeEvents_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0);
    try {
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0.setJspContext(_jspx_page_context);
      // /_subscribeToCommonBuildTypeEvents.jspf(13,0) name = buildTypeId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0.setBuildTypeId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildType.buildTypeId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      javax.servlet.jsp.tagext.JspFragment _jspx_temp2 = new Helper( 2, _jspx_page_context, _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0, null);
      // /_subscribeToCommonBuildTypeEvents.jspf(13,0) null
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0.setEventNames(_jspx_temp2);
      javax.servlet.jsp.tagext.JspFragment _jspx_temp3 = new Helper( 3, _jspx_page_context, _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0, null);
      // /_subscribeToCommonBuildTypeEvents.jspf(13,0) null
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0.setEventHandler(_jspx_temp3);
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_et_005fsubscribeOnBuildTypeEvents_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_et_005fsubscribeOnBuildTypeEvents_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  et:subscribeOnBuildTypeEvents
    org.apache.jsp.tag.web.eventTracker.subscribeOnBuildTypeEvents_tag _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1 = new org.apache.jsp.tag.web.eventTracker.subscribeOnBuildTypeEvents_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1);
    try {
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1.setJspContext(_jspx_page_context);
      // /buildTypeChangeLog.jsp(5,2) name = buildTypeId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1.setBuildTypeId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildType.buildTypeId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      javax.servlet.jsp.tagext.JspFragment _jspx_temp4 = new Helper( 4, _jspx_page_context, _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1, null);
      // /buildTypeChangeLog.jsp(5,2) null
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1.setEventNames(_jspx_temp4);
      javax.servlet.jsp.tagext.JspFragment _jspx_temp5 = new Helper( 5, _jspx_page_context, _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1, null);
      // /buildTypeChangeLog.jsp(5,2) null
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1.setEventHandler(_jspx_temp5);
      _jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_et_005fsubscribeOnBuildTypeEvents_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fchangesList_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:changesList
    org.apache.jsp.tag.web.changesList_tag _jspx_th_bs_005fchangesList_005f0 = new org.apache.jsp.tag.web.changesList_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fchangesList_005f0);
    try {
      _jspx_th_bs_005fchangesList_005f0.setJspContext(_jspx_page_context);
      // /buildTypeChangeLog.jsp(19,0) name = changeLog type = jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fchangesList_005f0.setChangeLog((jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${changeLogBean}", jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildTypeChangeLog.jsp(19,0) name = url type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fchangesList_005f0.setUrl((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("viewType.html?buildTypeId=${buildType.externalId}&tab=buildTypeChangeLog", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildTypeChangeLog.jsp(19,0) name = filterUpdateUrl type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fchangesList_005f0.setFilterUpdateUrl((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("buildTypeChangeLogTab.html?buildTypeId=${buildType.externalId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildTypeChangeLog.jsp(19,0) name = projectId type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fchangesList_005f0.setProjectId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildType.projectExternalId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_bs_005fchangesList_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fchangesList_005f0);
    }
    return false;
  }

  private class Helper
      extends org.apache.jasper.runtime.JspFragmentHelper
  {
    private javax.servlet.jsp.tagext.JspTag _jspx_parent;
    private int[] _jspx_push_body_count;

    public Helper( int discriminator, javax.servlet.jsp.JspContext jspContext, javax.servlet.jsp.tagext.JspTag _jspx_parent, int[] _jspx_push_body_count ) {
      super( discriminator, jspContext, _jspx_parent );
      this._jspx_parent = _jspx_parent;
      this._jspx_push_body_count = _jspx_push_body_count;
    }
    public boolean invoke0( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("PROJECT_REMOVED\r\n");
      out.write("    PROJECT_RESTORED\r\n");
      out.write("    PROJECT_PERSISTED\r\n");
      out.write("    PROJECT_ARCHIVED\r\n");
      out.write("    PROJECT_DEARCHIVED");
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("BS.reload();");
      return false;
    }
    public boolean invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("BUILD_TYPE_UNREGISTERED");
      return false;
    }
    public boolean invoke3( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("BS.reload();");
      return false;
    }
    public boolean invoke4( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("BUILD_STARTED\r\n");
      out.write("      BUILD_CHANGES_LOADED\r\n");
      out.write("      BUILD_FINISHED\r\n");
      out.write("      BUILD_INTERRUPTED\r\n");
      out.write("      BUILD_TYPE_ADDED_TO_QUEUE\r\n");
      out.write("      BUILD_TYPE_REMOVED_FROM_QUEUE\r\n");
      out.write("      CHANGE_ADDED");
      return false;
    }
    public boolean invoke5( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("BS.BuildType.updateView();");
      return false;
    }
    public void invoke( java.io.Writer writer )
      throws javax.servlet.jsp.JspException
    {
      javax.servlet.jsp.JspWriter out = null;
      if( writer != null ) {
        out = this.jspContext.pushBody(writer);
      } else {
        out = this.jspContext.getOut();
      }
      try {
        Object _jspx_saved_JspContext = this.jspContext.getELContext().getContext(javax.servlet.jsp.JspContext.class);
        this.jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,this.jspContext);
        switch( this.discriminator ) {
          case 0:
            invoke0( out );
            break;
          case 1:
            invoke1( out );
            break;
          case 2:
            invoke2( out );
            break;
          case 3:
            invoke3( out );
            break;
          case 4:
            invoke4( out );
            break;
          case 5:
            invoke5( out );
            break;
        }
        jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,_jspx_saved_JspContext);
      }
      catch( java.lang.Throwable e ) {
        if (e instanceof javax.servlet.jsp.SkipPageException)
            throw (javax.servlet.jsp.SkipPageException) e;
        throw new javax.servlet.jsp.JspException( e );
      }
      finally {
        if( writer != null ) {
          this.jspContext.popBody();
        }
      }
    }
  }
}
