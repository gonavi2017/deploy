/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:19:31 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jetbrains.buildServer.controllers.admin.users.AdminEditUserController;

public final class userGeneralSettings_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(27);
    _jspx_dependants.put("/include.jsp", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/help.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/saving.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/modified.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/userProfile/emailVerification/viewEmailVerificationStatus.jspf", Long.valueOf(1504702498000L));
    _jspx_dependants.put("/WEB-INF/tags/linkScript.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/settingsBlock.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/_authSettings.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/change-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/user-functions.tld", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/tooltipAttrs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/userProfile/emailVerification/emailVerification.jspf", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/checkbox.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/include-internal.jsp", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/messages.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/authz-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/submit.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/userProfile/userAuthSettings.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpIcon.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/userProfile/emailVerification/verifyEmailControls.jspf", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/progressRing.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/userProfile/general.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/star.tag", Long.valueOf(1504702498000L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody;
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
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.release();
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
      jetbrains.buildServer.users.User currentUser = null;
      currentUser = (jetbrains.buildServer.users.User) _jspx_page_context.getAttribute("currentUser", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (currentUser == null){
        throw new java.lang.InstantiationException("bean currentUser not found within scope");
      }
      out.write('\r');
      out.write('\n');
      jetbrains.buildServer.controllers.profile.EditPersonalProfileForm profileForm = null;
      profileForm = (jetbrains.buildServer.controllers.profile.EditPersonalProfileForm) _jspx_page_context.getAttribute("profileForm", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (profileForm == null){
        throw new java.lang.InstantiationException("bean profileForm not found within scope");
      }
      out.write('\r');
      out.write('\n');
      jetbrains.buildServer.controllers.admin.GroupedExtensionsBean profileBean = null;
      profileBean = (jetbrains.buildServer.controllers.admin.GroupedExtensionsBean) _jspx_page_context.getAttribute("profileBean", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (profileBean == null){
        throw new java.lang.InstantiationException("bean profileBean not found within scope");
      }
      out.write("\r\n");
      out.write("\r\n");
      out.write("<div id=\"profilePage\">\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("$j(document).ready(function() {\r\n");
      out.write("  BS.UpdatePersonalProfileForm.setupEventHandlers();\r\n");
      out.write("\r\n");
      out.write("  BS.UpdatePersonalProfileForm.setModified(");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.stateModified}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write(");\r\n");
      out.write("});\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<form id=\"profileForm\" action=\"profile.html\" onsubmit=\"return BS.UpdatePersonalProfileForm.submitPersonalProfile()\" method=\"post\" autocomplete=\"off\">\r\n");
      out.write("\r\n");
      out.write("<input type=\"hidden\" id=\"submitUpdateUser\" name=\"submitUpdateUser\" value=\"storeInSession\"/>\r\n");
      out.write("<input type=\"hidden\" name=\"item\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileBean.selectedExtension.tabId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\"/>\r\n");
      out.write("\r\n");
      //  bs:messages
      org.apache.jsp.tag.web.messages_tag _jspx_th_bs_005fmessages_005f0 = new org.apache.jsp.tag.web.messages_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fmessages_005f0);
      try {
        _jspx_th_bs_005fmessages_005f0.setJspContext(_jspx_page_context);
        // /profile/userGeneralSettings.jsp(22,0) name = key type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fmessages_005f0.setKey(AdminEditUserController.USER_CHANGED_MESSAGES_KEY);
        _jspx_th_bs_005fmessages_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fmessages_005f0);
      }
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_profile_005fgeneral_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005furl_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_l_005fsettingsBlock_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      if (_jspx_meth_c_005fif_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("  <div class=\"saveButtonsBlock saveButtonsBlock_noborder\">\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fsubmit_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fsaving_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  </div>\r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
      if (_jspx_meth_forms_005fmodified_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("</div>\r\n");
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

  private boolean _jspx_meth_profile_005fgeneral_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  profile:general
    org.apache.jsp.tag.web.userProfile.general_tag _jspx_th_profile_005fgeneral_005f0 = new org.apache.jsp.tag.web.userProfile.general_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_profile_005fgeneral_005f0);
    try {
      _jspx_th_profile_005fgeneral_005f0.setJspContext(_jspx_page_context);
      // /profile/userGeneralSettings.jsp(24,0) name = profileForm type = jetbrains.buildServer.controllers.profile.ProfileForm reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_profile_005fgeneral_005f0.setProfileForm((jetbrains.buildServer.controllers.profile.ProfileForm) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm}", jetbrains.buildServer.controllers.profile.ProfileForm.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /profile/userGeneralSettings.jsp(24,0) name = adminMode type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_profile_005fgeneral_005f0.setAdminMode(new java.lang.Boolean(false));
      _jspx_th_profile_005fgeneral_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_profile_005fgeneral_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005furl_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f0 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f0_reused = false;
    try {
      _jspx_th_c_005furl_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f0.setParent(null);
      // /profile/userGeneralSettings.jsp(26,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f0.setVar("favoritePageLink");
      // /profile/userGeneralSettings.jsp(26,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f0.setValue("/favoriteBuilds.html");
      int _jspx_eval_c_005furl_005f0 = _jspx_th_c_005furl_005f0.doStartTag();
      if (_jspx_th_c_005furl_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005furl_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005furl_005f0);
      _jspx_th_c_005furl_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005furl_005f0, _jsp_getInstanceManager(), _jspx_th_c_005furl_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_l_005fsettingsBlock_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  l:settingsBlock
    org.apache.jsp.tag.web.layout.settingsBlock_tag _jspx_th_l_005fsettingsBlock_005f0 = new org.apache.jsp.tag.web.layout.settingsBlock_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_l_005fsettingsBlock_005f0);
    try {
      _jspx_th_l_005fsettingsBlock_005f0.setJspContext(_jspx_page_context);
      // /profile/userGeneralSettings.jsp(27,0) name = title type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_l_005fsettingsBlock_005f0.setTitle("UI Settings");
      _jspx_th_l_005fsettingsBlock_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_l_005fsettingsBlock_005f0, null));
      _jspx_th_l_005fsettingsBlock_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_l_005fsettingsBlock_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fcheckbox_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:checkbox
    org.apache.jsp.tag.web.forms.checkbox_tag _jspx_th_forms_005fcheckbox_005f0 = new org.apache.jsp.tag.web.forms.checkbox_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fcheckbox_005f0);
    try {
      _jspx_th_forms_005fcheckbox_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fcheckbox_005f0.setParent(_jspx_parent);
      // /profile/userGeneralSettings.jsp(28,61) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setName("highlightMyChanges");
      // /profile/userGeneralSettings.jsp(28,61) name = checked type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setChecked((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.highlightMyChanges}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_forms_005fcheckbox_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fcheckbox_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fcheckbox_005f1(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:checkbox
    org.apache.jsp.tag.web.forms.checkbox_tag _jspx_th_forms_005fcheckbox_005f1 = new org.apache.jsp.tag.web.forms.checkbox_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fcheckbox_005f1);
    try {
      _jspx_th_forms_005fcheckbox_005f1.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fcheckbox_005f1.setParent(_jspx_parent);
      // /profile/userGeneralSettings.jsp(29,61) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f1.setName("autodetectTimeZone");
      // /profile/userGeneralSettings.jsp(29,61) name = checked type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f1.setChecked((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.autodetectTimeZone}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_forms_005fcheckbox_005f1.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fcheckbox_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fcheckbox_005f2(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:checkbox
    org.apache.jsp.tag.web.forms.checkbox_tag _jspx_th_forms_005fcheckbox_005f2 = new org.apache.jsp.tag.web.forms.checkbox_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fcheckbox_005f2);
    try {
      _jspx_th_forms_005fcheckbox_005f2.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fcheckbox_005f2.setParent(_jspx_parent);
      // /profile/userGeneralSettings.jsp(30,64) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f2.setName("showAllPersonalBuilds");
      // /profile/userGeneralSettings.jsp(30,64) name = checked type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f2.setChecked((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.showAllPersonalBuilds}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_forms_005fcheckbox_005f2.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fcheckbox_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fcheckbox_005f3(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:checkbox
    org.apache.jsp.tag.web.forms.checkbox_tag _jspx_th_forms_005fcheckbox_005f3 = new org.apache.jsp.tag.web.forms.checkbox_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fcheckbox_005f3);
    try {
      _jspx_th_forms_005fcheckbox_005f3.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fcheckbox_005f3.setParent(_jspx_parent);
      // /profile/userGeneralSettings.jsp(31,71) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f3.setName("addTriggeredBuildToFavorites");
      // /profile/userGeneralSettings.jsp(31,71) name = checked type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f3.setChecked((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm.addTriggeredBuildToFavorites}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_forms_005fcheckbox_005f3.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fcheckbox_005f3);
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
      // /profile/userGeneralSettings.jsp(34,0) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not isSpecialUser}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("  ");
          if (_jspx_meth_profile_005fuserAuthSettings_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          out.write("\r\n");
          out.write("  ");
          out.write('\r');
          out.write('\n');
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

  private boolean _jspx_meth_profile_005fuserAuthSettings_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  profile:userAuthSettings
    org.apache.jsp.tag.web.userProfile.userAuthSettings_tag _jspx_th_profile_005fuserAuthSettings_005f0 = new org.apache.jsp.tag.web.userProfile.userAuthSettings_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_profile_005fuserAuthSettings_005f0);
    try {
      _jspx_th_profile_005fuserAuthSettings_005f0.setJspContext(_jspx_page_context);
      _jspx_th_profile_005fuserAuthSettings_005f0.setParent(_jspx_th_c_005fif_005f0);
      // /profile/userGeneralSettings.jsp(35,2) name = profileForm type = jetbrains.buildServer.controllers.profile.ProfileForm reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_profile_005fuserAuthSettings_005f0.setProfileForm((jetbrains.buildServer.controllers.profile.ProfileForm) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${profileForm}", jetbrains.buildServer.controllers.profile.ProfileForm.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_profile_005fuserAuthSettings_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_profile_005fuserAuthSettings_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fsubmit_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:submit
    org.apache.jsp.tag.web.forms.submit_tag _jspx_th_forms_005fsubmit_005f0 = new org.apache.jsp.tag.web.forms.submit_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fsubmit_005f0);
    try {
      _jspx_th_forms_005fsubmit_005f0.setJspContext(_jspx_page_context);
      // /profile/userGeneralSettings.jsp(40,4) name = label type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsubmit_005f0.setLabel("Save changes");
      _jspx_th_forms_005fsubmit_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fsubmit_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fsaving_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:saving
    org.apache.jsp.tag.web.forms.saving_tag _jspx_th_forms_005fsaving_005f0 = new org.apache.jsp.tag.web.forms.saving_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fsaving_005f0);
    try {
      _jspx_th_forms_005fsaving_005f0.setJspContext(_jspx_page_context);
      // /profile/userGeneralSettings.jsp(41,4) name = id type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsaving_005f0.setId("saving1");
      _jspx_th_forms_005fsaving_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fsaving_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fmodified_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:modified
    org.apache.jsp.tag.web.forms.modified_tag _jspx_th_forms_005fmodified_005f0 = new org.apache.jsp.tag.web.forms.modified_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fmodified_005f0);
    try {
      _jspx_th_forms_005fmodified_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005fmodified_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fmodified_005f0);
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
      out.write("  <label class=\"ui-settings__label\" for=\"highlightMyChanges\">");
      if (_jspx_meth_forms_005fcheckbox_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write(" Highlight my changes and investigations</label>\r\n");
      out.write("  <label class=\"ui-settings__label\" for=\"autodetectTimeZone\">");
      if (_jspx_meth_forms_005fcheckbox_005f1(_jspx_parent, _jspx_page_context))
        return true;
      out.write(" Show date/time in my timezone</label>\r\n");
      out.write("  <label class=\"ui-settings__label\" for=\"showAllPersonalBuilds\">");
      if (_jspx_meth_forms_005fcheckbox_005f2(_jspx_parent, _jspx_page_context))
        return true;
      out.write(" Show all personal builds</label>\r\n");
      out.write("  <label class=\"ui-settings__label\" for=\"addTriggeredBuildToFavorites\">");
      if (_jspx_meth_forms_005fcheckbox_005f3(_jspx_parent, _jspx_page_context))
        return true;
      out.write(" Add  builds triggered by me to <a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${favoritePageLink}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\">favorites</a></label>\r\n");
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