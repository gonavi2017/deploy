/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:34 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.buildLog;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class buildLogTail_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(3);
    _jspx_dependants.put("/WEB-INF/tags/changeRequest.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/buildLog.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/user-functions.tld", Long.valueOf(1504702502000L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_0026_005ftest;

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
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.release();
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      jetbrains.buildServer.serverSide.BuildPromotion buildPromotion = null;
      buildPromotion = (jetbrains.buildServer.serverSide.BuildPromotion) _jspx_page_context.getAttribute("buildPromotion", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (buildPromotion == null){
        throw new java.lang.InstantiationException("bean buildPromotion not found within scope");
      }
      out.write("\r\n");
      out.write("\r\n");
      java.util.Iterator tailIterator = null;
      tailIterator = (java.util.Iterator) _jspx_page_context.getAttribute("tailIterator", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (tailIterator == null){
        throw new java.lang.InstantiationException("bean tailIterator not found within scope");
      }
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_bs_005fbuildLog_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005fif_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
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

  private boolean _jspx_meth_bs_005fbuildLog_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:buildLog
    org.apache.jsp.tag.web.buildLog_tag _jspx_th_bs_005fbuildLog_005f0 = new org.apache.jsp.tag.web.buildLog_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fbuildLog_005f0);
    try {
      _jspx_th_bs_005fbuildLog_005f0.setJspContext(_jspx_page_context);
      // /buildLog/buildLogTail.jsp(7,0) name = buildPromotion type = jetbrains.buildServer.serverSide.BuildPromotion reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fbuildLog_005f0.setBuildPromotion((jetbrains.buildServer.serverSide.BuildPromotion) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildPromotion}", jetbrains.buildServer.serverSide.BuildPromotion.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildLog/buildLogTail.jsp(7,0) name = messagesIterator type = java.util.Iterator reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fbuildLog_005f0.setMessagesIterator((java.util.Iterator) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${tailIterator}", java.util.Iterator.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /buildLog/buildLogTail.jsp(7,0) name = renderRunningTime type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fbuildLog_005f0.setRenderRunningTime(new java.lang.Boolean(true));
      // /buildLog/buildLogTail.jsp(7,0) name = mergeTestOutput type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fbuildLog_005f0.setMergeTestOutput(new java.lang.Boolean(false));
      _jspx_th_bs_005fbuildLog_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fbuildLog_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fif_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    boolean _jspx_th_c_005fif_005f0_reused = false;
    try {
      _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f0.setParent(null);
      // /buildLog/buildLogTail.jsp(9,0) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${(not empty buildPromotion.associatedBuild) and (not buildPromotion.associatedBuild.finished)}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("  <script type=\"text/javascript\">\r\n");
          out.write("    $j(document).ready(function () {\r\n");
          out.write("      BS.BuildLog.enableRefresh();\r\n");
          out.write("    });\r\n");
          out.write("  </script>\r\n");
          int evalDoAfterBody = _jspx_th_c_005fif_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f0);
      _jspx_th_c_005fif_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fif_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fif_005f0_reused);
    }
    return false;
  }
}
