/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:25 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class tagsLink_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(22);
    _jspx_dependants.put("/include.jsp", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/tagsInfoInner.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/change-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/user-functions.tld", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/showBuildPromotionTags.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/resetFilter.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popup_static.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/tagsLinkPopup.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/showTags.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/../include-internal.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWhitespace.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/editTagsLink.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/printTag.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/s.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/authorize.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popup.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/showPublicAndPrivateTags.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/tagLink.tag", Long.valueOf(1504702500000L));
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

      jetbrains.buildServer.serverSide.BuildPromotion buildPromotion = null;
      buildPromotion = (jetbrains.buildServer.serverSide.BuildPromotion) _jspx_page_context.getAttribute("buildPromotion", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (buildPromotion == null){
        throw new java.lang.InstantiationException("bean buildPromotion not found within scope");
      }
      if (_jspx_meth_t_005ftagsInfoInner_005f0(_jspx_page_context))
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

  private boolean _jspx_meth_t_005ftagsInfoInner_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  t:tagsInfoInner
    org.apache.jsp.tag.web.tags.tagsInfoInner_tag _jspx_th_t_005ftagsInfoInner_005f0 = new org.apache.jsp.tag.web.tags.tagsInfoInner_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_t_005ftagsInfoInner_005f0);
    try {
      _jspx_th_t_005ftagsInfoInner_005f0.setJspContext(_jspx_page_context);
      // /tagsLink.jsp(5,2) name = buildPromotion type = jetbrains.buildServer.serverSide.BuildPromotion reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_t_005ftagsInfoInner_005f0.setBuildPromotion((jetbrains.buildServer.serverSide.BuildPromotion) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildPromotion}", jetbrains.buildServer.serverSide.BuildPromotion.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /tagsLink.jsp(5,2) name = tags type = java.util.List<java.lang.String> reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_t_005ftagsInfoInner_005f0.setTags((java.util.List) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${buildPromotion.tags}", java.util.List.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /tagsLink.jsp(5,2) name = compactView type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_t_005ftagsInfoInner_005f0.setCompactView((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${compactView}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_t_005ftagsInfoInner_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_t_005ftagsInfoInner_005f0);
    }
    return false;
  }
}