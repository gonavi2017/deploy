/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:31:54 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class jdkChooser_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(10);
    _jspx_dependants.put("/WEB-INF/tags/forms/textField.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/help.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/tooltipAttrs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/option.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/helpLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/props/textProperty.tag", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/select.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpIcon.tag", Long.valueOf(1504702504000L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_0026_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody;

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
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.release();
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.release();
    _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody.release();
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
      out.write("\r\n");
      jetbrains.buildServer.controllers.admin.AvailableJDKBean availableJdks = null;
      availableJdks = (jetbrains.buildServer.controllers.admin.AvailableJDKBean) _jspx_page_context.getAttribute("availableJdks", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (availableJdks == null){
        throw new java.lang.InstantiationException("bean availableJdks not found within scope");
      }
      out.write("\r\n");
      out.write("<tr class=\"advancedSetting\">\r\n");
      out.write("  <th><label for=\"jdk_home\">JDK:</label></th>\r\n");
      out.write("  <td>\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fselect_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    <span class=\"smallNote\" id=\"default_jdk\">JAVA_HOME environment variable or the agent's own Java.</span>\r\n");
      out.write("  </td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr id=\"custom_jdk_home\" style=\"display: none;\" class=\"advancedSetting\">\r\n");
      out.write("  <th><label for=\"target.jdk.home\">JDK home path: </label>");
      if (_jspx_meth_bs_005fhelp_005f0(_jspx_page_context))
        return;
      out.write("</th>\r\n");
      out.write("  <td>\r\n");
      out.write("    ");
      if (_jspx_meth_props_005ftextProperty_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_c_005fif_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  </td>\r\n");
      out.write("</tr>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("  window.onJdkHomeChange = function() {\r\n");
      out.write("    var selector = $('jdk_home');\r\n");
      out.write("    var selVal = selector.options[selector.selectedIndex].value;\r\n");
      out.write("    if (selVal == 'custom') {\r\n");
      out.write("      $('target.jdk.home').value = '';\r\n");
      out.write("    } else {\r\n");
      out.write("      if (selVal == 'default') {\r\n");
      out.write("        $('target.jdk.home').value = '';\r\n");
      out.write("      } else {\r\n");
      out.write("        $('target.jdk.home').value = selVal;\r\n");
      out.write("      }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    window.updateJdkControlsVisibility();\r\n");
      out.write("  };\r\n");
      out.write("\r\n");
      out.write("  window.updateJdkControlsVisibility = function() {\r\n");
      out.write("    var selector = $('jdk_home');\r\n");
      out.write("    var selVal = selector.options[selector.selectedIndex].value;\r\n");
      out.write("    if (selVal == 'custom') {\r\n");
      out.write("      BS.Util.show('custom_jdk_home');\r\n");
      out.write("      BS.Util.hide('default_jdk');\r\n");
      out.write("    } else {\r\n");
      out.write("      BS.Util.hide('custom_jdk_home');\r\n");
      out.write("      if (selVal == 'default') {\r\n");
      out.write("        BS.Util.show('default_jdk');\r\n");
      out.write("      } else {\r\n");
      out.write("        BS.Util.hide('default_jdk');\r\n");
      out.write("      }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    BS.MultilineProperties.updateVisible();\r\n");
      out.write("  };\r\n");
      out.write("\r\n");
      out.write("  window.populateSelector = function() {\r\n");
      out.write("    var selector = $('jdk_home');\r\n");
      out.write("    var homeField = $('target.jdk.home');\r\n");
      out.write("    var curHome = homeField.value;\r\n");
      out.write("\r\n");
      out.write("    if (homeField.className.indexOf('valueChanged') != -1) {\r\n");
      out.write("      selector.parentNode.className += ' valueChanged';\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    if (curHome == '') {\r\n");
      out.write("      selector.selectedIndex = 0;\r\n");
      out.write("    } else {\r\n");
      out.write("      var found;\r\n");
      out.write("      for (var i = 0; i<selector.options.length; i++) {\r\n");
      out.write("        if (selector.options[i].value == curHome) {\r\n");
      out.write("          selector.selectedIndex = i;\r\n");
      out.write("          found = true;\r\n");
      out.write("        }\r\n");
      out.write("      }\r\n");
      out.write("\r\n");
      out.write("      if (!found) {\r\n");
      out.write("        selector.selectedIndex = 1;\r\n");
      out.write("      }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    BS.jQueryDropdown('#' + selector.id).ufd(\"changeOptions\");\r\n");
      out.write("  };\r\n");
      out.write("\r\n");
      out.write("  window.populateSelector();\r\n");
      out.write("  window.updateJdkControlsVisibility();\r\n");
      out.write("</script>\r\n");
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

  private boolean _jspx_meth_forms_005fselect_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:select
    org.apache.jsp.tag.web.forms.select_tag _jspx_th_forms_005fselect_005f0 = new org.apache.jsp.tag.web.forms.select_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fselect_005f0);
    try {
      _jspx_th_forms_005fselect_005f0.setJspContext(_jspx_page_context);
      // /admin/jdkChooser.jsp(9,4) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fselect_005f0.setName("jdk_home");
      // /admin/jdkChooser.jsp(9,4) name = onchange type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fselect_005f0.setOnchange("onJdkHomeChange()");
      // /admin/jdkChooser.jsp(9,4) name = enableFilter type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fselect_005f0.setEnableFilter(new java.lang.Boolean(true));
      // /admin/jdkChooser.jsp(9,4) name = className type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fselect_005f0.setClassName("mediumField");
      _jspx_th_forms_005fselect_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_forms_005fselect_005f0, null));
      _jspx_th_forms_005fselect_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fselect_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005foption_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:option
    org.apache.jsp.tag.web.forms.option_tag _jspx_th_forms_005foption_005f0 = new org.apache.jsp.tag.web.forms.option_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005foption_005f0);
    try {
      _jspx_th_forms_005foption_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005foption_005f0.setParent(_jspx_parent);
      // /admin/jdkChooser.jsp(10,6) name = value type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f0.setValue("default");
      _jspx_th_forms_005foption_005f0.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_forms_005foption_005f0, null));
      _jspx_th_forms_005foption_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005foption_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005foption_005f1(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:option
    org.apache.jsp.tag.web.forms.option_tag _jspx_th_forms_005foption_005f1 = new org.apache.jsp.tag.web.forms.option_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005foption_005f1);
    try {
      _jspx_th_forms_005foption_005f1.setJspContext(_jspx_page_context);
      _jspx_th_forms_005foption_005f1.setParent(_jspx_parent);
      // /admin/jdkChooser.jsp(11,6) name = value type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f1.setValue("custom");
      _jspx_th_forms_005foption_005f1.setJspBody(new Helper( 2, _jspx_page_context, _jspx_th_forms_005foption_005f1, null));
      _jspx_th_forms_005foption_005f1.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005foption_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fforEach_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    boolean _jspx_th_c_005fforEach_005f0_reused = false;
    try {
      _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /admin/jdkChooser.jsp(12,6) name = items type = java.lang.Object reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f0.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${availableJdks.jdks}", java.lang.Object.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/jdkChooser.jsp(12,6) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f0.setVar("jdk");
      int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
        if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("        ");
            if (_jspx_meth_forms_005foption_005f2(_jspx_th_c_005fforEach_005f0, _jspx_page_context, _jspx_push_body_count_c_005fforEach_005f0))
              return true;
            out.write("\r\n");
            out.write("      ");
            int evalDoAfterBody = _jspx_th_c_005fforEach_005f0.doAfterBody();
            if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
              break;
          } while (true);
        }
        if (_jspx_th_c_005fforEach_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
          throw new javax.servlet.jsp.SkipPageException();
        }
      } catch (java.lang.Throwable _jspx_exception) {
        while (_jspx_push_body_count_c_005fforEach_005f0[0]-- > 0)
          out = _jspx_page_context.popBody();
        _jspx_th_c_005fforEach_005f0.doCatch(_jspx_exception);
      } finally {
        _jspx_th_c_005fforEach_005f0.doFinally();
      }
      _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.reuse(_jspx_th_c_005fforEach_005f0);
      _jspx_th_c_005fforEach_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fforEach_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fforEach_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005foption_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fforEach_005f0, javax.servlet.jsp.PageContext _jspx_page_context, int[] _jspx_push_body_count_c_005fforEach_005f0)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:option
    org.apache.jsp.tag.web.forms.option_tag _jspx_th_forms_005foption_005f2 = new org.apache.jsp.tag.web.forms.option_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005foption_005f2);
    try {
      _jspx_th_forms_005foption_005f2.setJspContext(_jspx_page_context);
      _jspx_th_forms_005foption_005f2.setParent(_jspx_th_c_005fforEach_005f0);
      // /admin/jdkChooser.jsp(13,8) name = value type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f2.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${jdk.value}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_forms_005foption_005f2.setJspBody(new Helper( 3, _jspx_page_context, _jspx_th_forms_005foption_005f2, _jspx_push_body_count_c_005fforEach_005f0));
      _jspx_th_forms_005foption_005f2.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005foption_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fhelp_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:help
    org.apache.jsp.tag.web.help_tag _jspx_th_bs_005fhelp_005f0 = new org.apache.jsp.tag.web.help_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fhelp_005f0);
    try {
      _jspx_th_bs_005fhelp_005f0.setJspContext(_jspx_page_context);
      // /admin/jdkChooser.jsp(20,58) name = file type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelp_005f0.setFile("Ant");
      // /admin/jdkChooser.jsp(20,58) name = anchor type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_bs_005fhelp_005f0.setAnchor("antJdkHomePathOptionDescription");
      _jspx_th_bs_005fhelp_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fhelp_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_props_005ftextProperty_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  props:textProperty
    org.apache.jsp.tag.web.props.textProperty_tag _jspx_th_props_005ftextProperty_005f0 = new org.apache.jsp.tag.web.props.textProperty_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_props_005ftextProperty_005f0);
    try {
      _jspx_th_props_005ftextProperty_005f0.setJspContext(_jspx_page_context);
      // /admin/jdkChooser.jsp(22,4) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_props_005ftextProperty_005f0.setName("target.jdk.home");
      // /admin/jdkChooser.jsp(22,4) name = className type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_props_005ftextProperty_005f0.setClassName("longField");
      _jspx_th_props_005ftextProperty_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_props_005ftextProperty_005f0);
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
      // /admin/jdkChooser.jsp(23,4) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${availableJdks.minJdkInfo != null}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("      <span class=\"smallNote\">");
          if (_jspx_meth_c_005fout_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          out.write(" or higher is required.</span>\r\n");
          out.write("    ");
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

  private boolean _jspx_meth_c_005fout_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:out
    org.apache.taglibs.standard.tag.rt.core.OutTag _jspx_th_c_005fout_005f0 = (org.apache.taglibs.standard.tag.rt.core.OutTag) _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.OutTag.class);
    boolean _jspx_th_c_005fout_005f0_reused = false;
    try {
      _jspx_th_c_005fout_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fout_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
      // /admin/jdkChooser.jsp(24,30) name = value type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fout_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${availableJdks.minJdkInfo.versionText}", java.lang.Object.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      int _jspx_eval_c_005fout_005f0 = _jspx_th_c_005fout_005f0.doStartTag();
      if (_jspx_th_c_005fout_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fout_0026_005fvalue_005fnobody.reuse(_jspx_th_c_005fout_005f0);
      _jspx_th_c_005fout_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fout_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fout_005f0_reused);
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
      out.write("      ");
      if (_jspx_meth_forms_005foption_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("      ");
      if (_jspx_meth_forms_005foption_005f1(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("      ");
      if (_jspx_meth_c_005fforEach_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("    ");
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("&lt;Default&gt;");
      return false;
    }
    public boolean invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("&lt;Custom&gt;");
      return false;
    }
    public boolean invoke3( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${jdk.versionText}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
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