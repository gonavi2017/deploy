/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:39 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jetbrains.buildServer.web.openapi.PlaceId;

public final class buildTypeStatistics_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(26);
    _jspx_dependants.put("/include.jsp", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/refreshable.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/linkScript.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/agentsFilter.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/_subscribeToCommonBuildTypeEvents.jspf", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/change-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/buildGraph.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/includeExtension.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/user-functions.tld", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/helpLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/checkbox.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/include-internal.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/averageFilter.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/includeExtensions.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/eventTracker/subscribeOnProjectEvents.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/chartSettings.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/rangeFilter.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/popupWithTitle.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWithTooltip.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/linkCSS.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/eventTracker/subscribeOnBuildTypeEvents.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/statusFilter.tag", Long.valueOf(1504702504000L));
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

      if (_jspx_meth_et_005fsubscribeOnProjectEvents_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_et_005fsubscribeOnBuildTypeEvents_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      out.write("<style type=\"text/css\">\r\n");
      out.write("  #agentsFilterTimeToFixStatistics {\r\n");
      out.write("    display: none;\r\n");
      out.write("  }\r\n");
      out.write("  #showFailedTimeToFixStatistics {\r\n");
      out.write("    display: none;\r\n");
      out.write("  }\r\n");
      out.write("</style>\r\n");
      out.write("<br />\r\n");
      if (_jspx_meth_stats_005fbuildGraph_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_stats_005fbuildGraph_005f1(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_stats_005fbuildGraph_005f2(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_stats_005fbuildGraph_005f3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_stats_005fbuildGraph_005f4(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      //  ext:includeExtensions
      org.apache.jsp.tag.web.ext.includeExtensions_tag _jspx_th_ext_005fincludeExtensions_005f0 = new org.apache.jsp.tag.web.ext.includeExtensions_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_ext_005fincludeExtensions_005f0);
      try {
        _jspx_th_ext_005fincludeExtensions_005f0.setJspContext(_jspx_page_context);
        // /buildTypeStatistics.jsp(25,0) name = placeId type = jetbrains.buildServer.web.openapi.PlaceId reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_ext_005fincludeExtensions_005f0.setPlaceId(PlaceId.BUILD_CONF_STATISTICS_FRAGMENT);
        _jspx_th_ext_005fincludeExtensions_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_ext_005fincludeExtensions_005f0);
      }
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

  private boolean _jspx_meth_stats_005fbuildGraph_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  stats:buildGraph
    org.apache.jsp.tag.web.graph.buildGraph_tag _jspx_th_stats_005fbuildGraph_005f0 = new org.apache.jsp.tag.web.graph.buildGraph_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_stats_005fbuildGraph_005f0);
    try {
      _jspx_th_stats_005fbuildGraph_005f0.setJspContext(_jspx_page_context);
      // /buildTypeStatistics.jsp(14,0) name = id type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setId("SuccessRate");
      // /buildTypeStatistics.jsp(14,0) name = isPredefined type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setIsPredefined((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${true}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildTypeStatistics.jsp(14,0) name = valueType type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setValueType("SuccessRate");
      // /buildTypeStatistics.jsp(14,0) name = defaultFilter type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setDefaultFilter("showFailed,averaged");
      // /buildTypeStatistics.jsp(14,0) name = hideFilters type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setHideFilters("showFailed,averaged,forceZero,yAxisType");
      // /buildTypeStatistics.jsp(14,0) name = hints type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setHints("rendererB,itemLabels");
      _jspx_th_stats_005fbuildGraph_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_stats_005fbuildGraph_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_stats_005fbuildGraph_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  stats:buildGraph
    org.apache.jsp.tag.web.graph.buildGraph_tag _jspx_th_stats_005fbuildGraph_005f1 = new org.apache.jsp.tag.web.graph.buildGraph_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_stats_005fbuildGraph_005f1);
    try {
      _jspx_th_stats_005fbuildGraph_005f1.setJspContext(_jspx_page_context);
      // /buildTypeStatistics.jsp(16,0) name = id type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f1.setId("BuildDurationNetTimeStatistics");
      // /buildTypeStatistics.jsp(16,0) name = isPredefined type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f1.setIsPredefined((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${true}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildTypeStatistics.jsp(16,0) name = valueType type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f1.setValueType("BuildDurationNetTime");
      // /buildTypeStatistics.jsp(16,0) name = hideFilters type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f1.setHideFilters("");
      _jspx_th_stats_005fbuildGraph_005f1.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_stats_005fbuildGraph_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_stats_005fbuildGraph_005f2(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  stats:buildGraph
    org.apache.jsp.tag.web.graph.buildGraph_tag _jspx_th_stats_005fbuildGraph_005f2 = new org.apache.jsp.tag.web.graph.buildGraph_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_stats_005fbuildGraph_005f2);
    try {
      _jspx_th_stats_005fbuildGraph_005f2.setJspContext(_jspx_page_context);
      // /buildTypeStatistics.jsp(17,0) name = id type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f2.setId("TimeInQueueStatistics");
      // /buildTypeStatistics.jsp(17,0) name = isPredefined type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f2.setIsPredefined((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${true}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildTypeStatistics.jsp(17,0) name = valueType type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f2.setValueType("TimeSpentInQueue");
      // /buildTypeStatistics.jsp(17,0) name = defaultFilter type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f2.setDefaultFilter("showFailed");
      // /buildTypeStatistics.jsp(17,0) name = hideFilters type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f2.setHideFilters("series,markers,showFailed");
      _jspx_th_stats_005fbuildGraph_005f2.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_stats_005fbuildGraph_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_stats_005fbuildGraph_005f3(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  stats:buildGraph
    org.apache.jsp.tag.web.graph.buildGraph_tag _jspx_th_stats_005fbuildGraph_005f3 = new org.apache.jsp.tag.web.graph.buildGraph_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_stats_005fbuildGraph_005f3);
    try {
      _jspx_th_stats_005fbuildGraph_005f3.setJspContext(_jspx_page_context);
      // /buildTypeStatistics.jsp(19,0) name = id type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f3.setId("TestCount");
      // /buildTypeStatistics.jsp(19,0) name = isPredefined type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f3.setIsPredefined((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${true}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildTypeStatistics.jsp(19,0) name = valueType type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f3.setValueType("TestCount");
      // /buildTypeStatistics.jsp(19,0) name = defaultFilter type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f3.setDefaultFilter("showFailed");
      // /buildTypeStatistics.jsp(19,0) name = hideFilters type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f3.setHideFilters("averaged");
      _jspx_th_stats_005fbuildGraph_005f3.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_stats_005fbuildGraph_005f3);
    }
    return false;
  }

  private boolean _jspx_meth_stats_005fbuildGraph_005f4(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  stats:buildGraph
    org.apache.jsp.tag.web.graph.buildGraph_tag _jspx_th_stats_005fbuildGraph_005f4 = new org.apache.jsp.tag.web.graph.buildGraph_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_stats_005fbuildGraph_005f4);
    try {
      _jspx_th_stats_005fbuildGraph_005f4.setJspContext(_jspx_page_context);
      // /buildTypeStatistics.jsp(23,0) name = id type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f4.setId("TimeToFixStatistics");
      // /buildTypeStatistics.jsp(23,0) name = isPredefined type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f4.setIsPredefined((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${true}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildTypeStatistics.jsp(23,0) name = valueType type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f4.setValueType("MaxTimeToFixTestGraph");
      // /buildTypeStatistics.jsp(23,0) name = defaultFilter type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f4.setDefaultFilter("showFailed");
      // /buildTypeStatistics.jsp(23,0) name = hideFilters type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f4.setHideFilters("");
      _jspx_th_stats_005fbuildGraph_005f4.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_stats_005fbuildGraph_005f4);
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
