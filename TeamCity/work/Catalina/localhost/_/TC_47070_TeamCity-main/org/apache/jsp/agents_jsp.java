/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:26 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jetbrains.buildServer.web.openapi.PlaceId;
import jetbrains.buildServer.web.openapi.PlaceId;

public final class agents_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(55);
    _jspx_dependants.put("/include.jsp", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/saving.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/stopBuildDialog.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/ua.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_tagsEditingControl.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/change-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/includeExtension.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/user-functions.tld", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/popup_static.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/checkbox.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/dialog.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/include-internal.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/popup.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/importWebComponents.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/includeExtensions.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/smallNote.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/commonDialogs.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/submit.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/popupWithTitle.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/eventTracker/subscribeOnEvents.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/executeOnce.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/progressRing.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/forJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/authorize.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/forEachTab.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/pageMeta.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/baseUri.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/refreshable.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/linkScript.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/page.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/responsible/form.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/_applyToAllBuildsCheckbox.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/prototype.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/textField.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/installLinks.jspf", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/trimWhitespace.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/commonFrameworks.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/messages.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpUrlPrefix.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/webComponentsSettings.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/ext/forEachExtension.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/XUACompatible.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/predefinedIntProps.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/cancel.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/agentsList.jsp", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/problems/buildProblemStylesAndScripts.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/linkCSS.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/encrypt.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/modalDialog.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/jquery.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tags/editTagsForm.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/commonTemplates.tag", Long.valueOf(1504702504000L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody;

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
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.release();
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.release();
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
      out.write('\r');
      out.write('\n');
      jetbrains.buildServer.users.User currentUser = null;
      currentUser = (jetbrains.buildServer.users.User) _jspx_page_context.getAttribute("currentUser", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (currentUser == null){
        throw new java.lang.InstantiationException("bean currentUser not found within scope");
      }
      out.write('\r');
      out.write('\n');
      java.lang.String currentTab = null;
      currentTab = (java.lang.String) _jspx_page_context.getAttribute("currentTab", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (currentTab == null){
        throw new java.lang.InstantiationException("bean currentTab not found within scope");
      }
      out.write('\r');
      out.write('\n');
      jetbrains.buildServer.web.openapi.CustomTab myCustomTab = null;
      myCustomTab = (jetbrains.buildServer.web.openapi.CustomTab) _jspx_page_context.getAttribute("myCustomTab", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (myCustomTab == null){
        throw new java.lang.InstantiationException("bean myCustomTab not found within scope");
      }
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005fset_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      //  bs:page
      org.apache.jsp.tag.web.page_tag _jspx_th_bs_005fpage_005f0 = new org.apache.jsp.tag.web.page_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fpage_005f0);
      try {
        _jspx_th_bs_005fpage_005f0.setJspContext(_jspx_page_context);
        javax.servlet.jsp.tagext.JspFragment _jspx_temp0 = new Helper( 0, _jspx_page_context, _jspx_th_bs_005fpage_005f0, null);
        // /agents.jsp(9,0) null
        _jspx_th_bs_005fpage_005f0.setPage_title(_jspx_temp0);
        javax.servlet.jsp.tagext.JspFragment _jspx_temp1 = new Helper( 1, _jspx_page_context, _jspx_th_bs_005fpage_005f0, null);
        // /agents.jsp(9,0) null
        _jspx_th_bs_005fpage_005f0.setQuickLinks_include(_jspx_temp1);
        javax.servlet.jsp.tagext.JspFragment _jspx_temp2 = new Helper( 2, _jspx_page_context, _jspx_th_bs_005fpage_005f0, null);
        // /agents.jsp(9,0) null
        _jspx_th_bs_005fpage_005f0.setHead_include(_jspx_temp2);
        javax.servlet.jsp.tagext.JspFragment _jspx_temp3 = new Helper( 5, _jspx_page_context, _jspx_th_bs_005fpage_005f0, null);
        // /agents.jsp(9,0) null
        _jspx_th_bs_005fpage_005f0.setBody_include(_jspx_temp3);
        _jspx_th_bs_005fpage_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fpage_005f0);
      }
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

  private boolean _jspx_meth_c_005fset_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f0_reused = false;
    try {
      _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f0.setParent(null);
      // /agents.jsp(7,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setVar("currentTabCaption");
      // /agents.jsp(7,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate(" > ${myCustomTab.tabTitle}", java.lang.Object.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      int _jspx_eval_c_005fset_005f0 = _jspx_th_c_005fset_005f0.doStartTag();
      if (_jspx_th_c_005fset_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
      _jspx_th_c_005fset_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005flinkCSS_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:linkCSS
    org.apache.jsp.tag.web.linkCSS_tag _jspx_th_bs_005flinkCSS_005f0 = new org.apache.jsp.tag.web.linkCSS_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005flinkCSS_005f0);
    try {
      _jspx_th_bs_005flinkCSS_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005flinkCSS_005f0.setParent(_jspx_parent);
      _jspx_th_bs_005flinkCSS_005f0.setJspBody(new Helper( 3, _jspx_page_context, _jspx_th_bs_005flinkCSS_005f0, null));
      _jspx_th_bs_005flinkCSS_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005flinkCSS_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005flinkScript_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:linkScript
    org.apache.jsp.tag.web.linkScript_tag _jspx_th_bs_005flinkScript_005f0 = new org.apache.jsp.tag.web.linkScript_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005flinkScript_005f0);
    try {
      _jspx_th_bs_005flinkScript_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005flinkScript_005f0.setParent(_jspx_parent);
      _jspx_th_bs_005flinkScript_005f0.setJspBody(new Helper( 4, _jspx_page_context, _jspx_th_bs_005flinkScript_005f0, null));
      _jspx_th_bs_005flinkScript_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005flinkScript_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fforJs_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:forJs
    org.apache.jsp.tag.web.forJs_tag _jspx_th_bs_005fforJs_005f0 = new org.apache.jsp.tag.web.forJs_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fforJs_005f0);
    try {
      _jspx_th_bs_005fforJs_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fforJs_005f0.setParent(_jspx_parent);
      _jspx_th_bs_005fforJs_005f0.setJspBody(new Helper( 8, _jspx_page_context, _jspx_th_bs_005fforJs_005f0, null));
      _jspx_th_bs_005fforJs_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fforJs_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005furl_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f0 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f0_reused = false;
    try {
      _jspx_th_c_005furl_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /agentsList.jsp(16,13) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f0.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("/agents.html?tab=${extension.tabId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      int _jspx_eval_c_005furl_005f0 = _jspx_th_c_005furl_005f0.doStartTag();
      if (_jspx_th_c_005furl_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.reuse(_jspx_th_c_005furl_005f0);
      _jspx_th_c_005furl_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005furl_005f0, _jsp_getInstanceManager(), _jspx_th_c_005furl_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_ext_005fincludeExtension_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  ext:includeExtension
    org.apache.jsp.tag.web.ext.includeExtension_tag _jspx_th_ext_005fincludeExtension_005f0 = new org.apache.jsp.tag.web.ext.includeExtension_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_ext_005fincludeExtension_005f0);
    try {
      _jspx_th_ext_005fincludeExtension_005f0.setJspContext(_jspx_page_context);
      _jspx_th_ext_005fincludeExtension_005f0.setParent(_jspx_parent);
      // /agentsList.jsp(24,0) name = extension type = jetbrains.buildServer.web.openapi.PageExtension reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_ext_005fincludeExtension_005f0.setExtension((jetbrains.buildServer.web.openapi.PageExtension) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${myCustomTab}", jetbrains.buildServer.web.openapi.PageExtension.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_ext_005fincludeExtension_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_ext_005fincludeExtension_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_l_005fpopupWithTitle_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  l:popupWithTitle
    org.apache.jsp.tag.web.layout.popupWithTitle_tag _jspx_th_l_005fpopupWithTitle_005f0 = new org.apache.jsp.tag.web.layout.popupWithTitle_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_l_005fpopupWithTitle_005f0);
    try {
      _jspx_th_l_005fpopupWithTitle_005f0.setJspContext(_jspx_page_context);
      _jspx_th_l_005fpopupWithTitle_005f0.setParent(_jspx_parent);
      // /agentsList.jsp(28,0) name = id type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_l_005fpopupWithTitle_005f0.setId("installAgents");
      // /agentsList.jsp(28,0) name = title type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_l_005fpopupWithTitle_005f0.setTitle("Install Build Agents");
      _jspx_th_l_005fpopupWithTitle_005f0.setJspBody(new Helper( 9, _jspx_page_context, _jspx_th_l_005fpopupWithTitle_005f0, null));
      _jspx_th_l_005fpopupWithTitle_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_l_005fpopupWithTitle_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005furl_005f1(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f1 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f1_reused = false;
    try {
      _jspx_th_c_005furl_005f1.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f1.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /installLinks.jspf(2,15) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f1.setValue("/update/agentInstaller.exe");
      int _jspx_eval_c_005furl_005f1 = _jspx_th_c_005furl_005f1.doStartTag();
      if (_jspx_th_c_005furl_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.reuse(_jspx_th_c_005furl_005f1);
      _jspx_th_c_005furl_005f1_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005furl_005f1, _jsp_getInstanceManager(), _jspx_th_c_005furl_005f1_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005furl_005f2(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f2 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f2_reused = false;
    try {
      _jspx_th_c_005furl_005f2.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f2.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /installLinks.jspf(3,15) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f2.setValue("/update/buildAgent.zip");
      int _jspx_eval_c_005furl_005f2 = _jspx_th_c_005furl_005f2.doStartTag();
      if (_jspx_th_c_005furl_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.reuse(_jspx_th_c_005furl_005f2);
      _jspx_th_c_005furl_005f2_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005furl_005f2, _jsp_getInstanceManager(), _jspx_th_c_005furl_005f2_reused);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fhelpUrlPrefix_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:helpUrlPrefix
    org.apache.jsp.tag.web.helpUrlPrefix_tag _jspx_th_bs_005fhelpUrlPrefix_005f0 = new org.apache.jsp.tag.web.helpUrlPrefix_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fhelpUrlPrefix_005f0);
    try {
      _jspx_th_bs_005fhelpUrlPrefix_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fhelpUrlPrefix_005f0.setParent(_jspx_parent);
      _jspx_th_bs_005fhelpUrlPrefix_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fhelpUrlPrefix_005f0);
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
    public void invoke0( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("Agents");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${currentTabCaption}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      return;
    }
    public void invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("<a class=\"quickLinksControlLink\" href='#' onclick='BS.InstallAgentsPopup.showNearElement(this); return false'>Install Build Agents</a>");
      return;
    }
    public void invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      if (_jspx_meth_bs_005flinkCSS_005f0(_jspx_parent, _jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_bs_005flinkScript_005f0(_jspx_parent, _jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("    BS.Navigation.items = [\r\n");
      out.write("      {title: \"Agents\", selected:true}\r\n");
      out.write("    ];\r\n");
      out.write("\r\n");
      out.write("    BS.topNavPane.setActiveCaption('agents');\r\n");
      out.write("  </script>");
      return;
    }
    public boolean invoke3( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("    /css/progress.css\r\n");
      out.write("    /css/agents.css\r\n");
      out.write("    /css/installAgent.css\r\n");
      out.write("    /css/filePopup.css\r\n");
      out.write("  ");
      return false;
    }
    public boolean invoke4( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("    /js/bs/runningBuilds.js\r\n");
      out.write("    /js/bs/testGroup.js\r\n");
      out.write("\r\n");
      out.write("    /js/bs/blocks.js\r\n");
      out.write("    /js/bs/blockWithHandle.js\r\n");
      out.write("\r\n");
      out.write("    /js/bs/agents.js\r\n");
      out.write("  ");
      return false;
    }
    public void invoke5( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("\r\n");
      //  bs:refreshable
      org.apache.jsp.tag.web.refreshable_tag _jspx_th_bs_005frefreshable_005f0 = new org.apache.jsp.tag.web.refreshable_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_bs_005frefreshable_005f0);
      try {
        _jspx_th_bs_005frefreshable_005f0.setJspContext(_jspx_page_context);
        _jspx_th_bs_005frefreshable_005f0.setParent(_jspx_parent);
        // /agentsList.jsp(3,0) name = containerId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005frefreshable_005f0.setContainerId("agentsList");
        // /agentsList.jsp(3,0) name = pageUrl type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005frefreshable_005f0.setPageUrl((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageUrl}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
        _jspx_th_bs_005frefreshable_005f0.setJspBody(new Helper( 6, _jspx_page_context, _jspx_th_bs_005frefreshable_005f0, null));
        _jspx_th_bs_005frefreshable_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005frefreshable_005f0);
      }
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_l_005fpopupWithTitle_005f0(_jspx_parent, _jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      return;
    }
    public void invoke6( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("  (function() {\r\n");
      out.write("    if (BS.agentsTabPane instanceof TabbedPane) {\r\n");
      out.write("      BS.agentsTabPane.clearTabs();\r\n");
      out.write("    } else {\r\n");
      out.write("      BS.agentsTabPane = new TabbedPane();\r\n");
      out.write("    }\r\n");
      out.write("    ");
      //  ext:forEachTab
      org.apache.jsp.tag.web.ext.forEachTab_tag _jspx_th_ext_005fforEachTab_005f0 = new org.apache.jsp.tag.web.ext.forEachTab_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_ext_005fforEachTab_005f0);
      try {
        _jspx_th_ext_005fforEachTab_005f0.setJspContext(_jspx_page_context);
        _jspx_th_ext_005fforEachTab_005f0.setParent(_jspx_parent);
        // /agentsList.jsp(12,4) name = placeId type = jetbrains.buildServer.web.openapi.PlaceId reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_ext_005fforEachTab_005f0.setPlaceId(PlaceId.AGENTS_TAB);
        _jspx_th_ext_005fforEachTab_005f0.setJspBody(new Helper( 7, _jspx_page_context, _jspx_th_ext_005fforEachTab_005f0, null));
        _jspx_th_ext_005fforEachTab_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_ext_005fforEachTab_005f0);
      }
      out.write("\r\n");
      out.write("    BS.agentsTabPane.showIn('tabsContainer3');\r\n");
      out.write("    BS.agentsTabPane.setActiveCaption('");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${myCustomTab.tabId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("');\r\n");
      out.write("  })();\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      if (_jspx_meth_ext_005fincludeExtension_005f0(_jspx_parent, _jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      return;
    }
    public void invoke7( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("    // plugin ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${extension.tabId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write(":\r\n");
      out.write("    BS.agentsTabPane.addTab('");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${extension.tabId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("', {\r\n");
      out.write("      caption: '");
      if (_jspx_meth_bs_005fforJs_005f0(_jspx_parent, _jspx_page_context))
        return;
      out.write("',\r\n");
      out.write("      url : '");
      if (_jspx_meth_c_005furl_005f0(_jspx_parent, _jspx_page_context))
        return;
      out.write("'\r\n");
      out.write("    });\r\n");
      out.write("    ");
      return;
    }
    public boolean invoke8( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${extension.tabTitle}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      return false;
    }
    public boolean invoke9( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("  ");
      out.write("<ul>\r\n");
      out.write("  <li><a href=\"");
      if (_jspx_meth_c_005furl_005f1(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\">MS Windows Installer</a></li>\r\n");
      out.write("  <li><a href=\"");
      if (_jspx_meth_c_005furl_005f2(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\">Zip file distribution</a> for manual installation\r\n");
      out.write("    (unzip the file, specify the build agent's properties and run the executable file).\r\n");
      out.write("  </li>\r\n");
      out.write("</ul>\r\n");
      out.write("<p>See our <a target=\"_blank\" href=\"");
      if (_jspx_meth_bs_005fhelpUrlPrefix_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("/Setting+up+and+Running+Additional+Build+Agents\">documentation</a> for details.</p>");
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
          case 6:
            invoke6( out );
            break;
          case 7:
            invoke7( out );
            break;
          case 8:
            invoke8( out );
            break;
          case 9:
            invoke9( out );
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