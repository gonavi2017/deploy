/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:35 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.buildLog;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jetbrains.buildServer.util.StringUtil;

public final class buildParametersChart_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(22);
    _jspx_dependants.put("/include.jsp", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/refreshable.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/linkScript.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/agentsFilter.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/chartSettings.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/rangeFilter.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/popupWithTitle.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/change-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/buildGraph.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/buildLog/../include-internal.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/user-functions.tld", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWithTooltip.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/linkCSS.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/checkbox.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/dialog.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/graph/averageFilter.tag", Long.valueOf(1504702498000L));
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

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");

  final String valueType = request.getParameter("valueType");
  request.setAttribute("valueType", valueType);
  request.setAttribute("title", StringUtil.escapeHTML(valueType, true));

      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_bs_005fdialog_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("  new Draggable('chartDialogPopup', {\r\n");
      out.write("    starteffect: function () {},\r\n");
      out.write("    endeffect: function () {},\r\n");
      out.write("    handle: 'chartDialogTitle'\r\n");
      out.write("  });\r\n");
      out.write("</script>");
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

  private boolean _jspx_meth_bs_005fdialog_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:dialog
    org.apache.jsp.tag.web.dialog_tag _jspx_th_bs_005fdialog_005f0 = new org.apache.jsp.tag.web.dialog_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fdialog_005f0);
    try {
      _jspx_th_bs_005fdialog_005f0.setJspContext(_jspx_page_context);
      // /buildLog/buildParametersChart.jsp(10,0) name = dialogId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setDialogId("chartDialog");
      // /buildLog/buildParametersChart.jsp(10,0) name = title type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setTitle((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${title}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildLog/buildParametersChart.jsp(10,0) name = closeCommand type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setCloseCommand("BS.Hider.hideDiv('chartDialogPopup');");
      // /buildLog/buildParametersChart.jsp(10,0) name = titleId type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setTitleId("chartDialogTitle");
      // /buildLog/buildParametersChart.jsp(10,0) name = dialogClass type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fdialog_005f0.setDialogClass("buildParameters_chartPopup");
      _jspx_th_bs_005fdialog_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_bs_005fdialog_005f0, null));
      _jspx_th_bs_005fdialog_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fdialog_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_stats_005fbuildGraph_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  stats:buildGraph
    org.apache.jsp.tag.web.graph.buildGraph_tag _jspx_th_stats_005fbuildGraph_005f0 = new org.apache.jsp.tag.web.graph.buildGraph_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_stats_005fbuildGraph_005f0);
    try {
      _jspx_th_stats_005fbuildGraph_005f0.setJspContext(_jspx_page_context);
      _jspx_th_stats_005fbuildGraph_005f0.setParent(_jspx_parent);
      // /buildLog/buildParametersChart.jsp(12,2) name = id type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setId("temp");
      // /buildLog/buildParametersChart.jsp(12,2) name = valueType type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setValueType((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${valueType}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildLog/buildParametersChart.jsp(12,2) name = valueTypeBean type = jetbrains.buildServer.serverSide.statistics.ValueType reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setValueTypeBean((jetbrains.buildServer.serverSide.statistics.ValueType) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${valueTypeBean}", jetbrains.buildServer.serverSide.statistics.ValueType.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildLog/buildParametersChart.jsp(12,2) name = height type = java.lang.Integer reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setHeight(new java.lang.Integer(150));
      // /buildLog/buildParametersChart.jsp(12,2) name = width type = java.lang.Integer reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setWidth(new java.lang.Integer(500));
      // /buildLog/buildParametersChart.jsp(12,2) name = additionalProperties type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setAdditionalProperties("buildId");
      // /buildLog/buildParametersChart.jsp(12,2) name = defaultFilter type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setDefaultFilter("showFailed");
      // /buildLog/buildParametersChart.jsp(12,2) name = controllerUrl type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setControllerUrl("buildGraph.html");
      // /buildLog/buildParametersChart.jsp(12,2) name = filtersHiddable type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setFiltersHiddable(new java.lang.Boolean(false));
      // /buildLog/buildParametersChart.jsp(12,2) name = filtersHidden type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_stats_005fbuildGraph_005f0.setFiltersHidden(new java.lang.Boolean(true));
      _jspx_th_stats_005fbuildGraph_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_stats_005fbuildGraph_005f0);
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
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_stats_005fbuildGraph_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write('\r');
      out.write('\n');
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