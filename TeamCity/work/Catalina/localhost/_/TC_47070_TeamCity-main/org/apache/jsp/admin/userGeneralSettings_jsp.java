/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-24 23:30:02 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jetbrains.buildServer.controllers.admin.users.AdminEditUserController;
import jetbrains.buildServer.controllers.emailVerification.EmailVerificationController;

public final class userGeneralSettings_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(31);
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
    _jspx_dependants.put("/WEB-INF/tags/smallNote.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/escapeForJs.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/submit.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/userProfile/userAuthSettings.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/internal-props-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/helpIcon.tag", Long.valueOf(1504702504000L));
    _jspx_dependants.put("/WEB-INF/tags/userProfile/emailVerification/verifyEmailControls.jspf", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/progressRing.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/forms/cancel.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/userProfile/general.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/admin/perProjectRolesNote.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/authorize.tag", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/layout/star.tag", Long.valueOf(1504702498000L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody;
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
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.release();
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      jetbrains.buildServer.controllers.admin.users.AdminEditUserForm adminEditUserForm = null;
      adminEditUserForm = (jetbrains.buildServer.controllers.admin.users.AdminEditUserForm) _jspx_page_context.getAttribute("adminEditUserForm", javax.servlet.jsp.PageContext.REQUEST_SCOPE);
      if (adminEditUserForm == null){
        throw new java.lang.InstantiationException("bean adminEditUserForm not found within scope");
      }
      out.write("\r\n");
      out.write("<div id=\"profilePage\">\r\n");
      out.write("<form action=\"");
      if (_jspx_meth_c_005furl_005f0(_jspx_page_context))
        return;
      out.write("\" onsubmit=\"return BS.AdminUpdateUserForm.submitUserProfile()\" method=\"post\" autocomplete=\"off\">\r\n");
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_authz_005fauthorize_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("  ");
      //  bs:messages
      org.apache.jsp.tag.web.messages_tag _jspx_th_bs_005fmessages_005f0 = new org.apache.jsp.tag.web.messages_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fmessages_005f0);
      try {
        _jspx_th_bs_005fmessages_005f0.setJspContext(_jspx_page_context);
        // /admin/userGeneralSettings.jsp(17,2) name = key type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fmessages_005f0.setKey(AdminEditUserController.USER_CHANGED_MESSAGES_KEY);
        _jspx_th_bs_005fmessages_005f0.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fmessages_005f0);
      }
      out.write("\r\n");
      out.write("  ");
      //  bs:messages
      org.apache.jsp.tag.web.messages_tag _jspx_th_bs_005fmessages_005f1 = new org.apache.jsp.tag.web.messages_tag();
      _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fmessages_005f1);
      try {
        _jspx_th_bs_005fmessages_005f1.setJspContext(_jspx_page_context);
        // /admin/userGeneralSettings.jsp(18,2) name = key type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fmessages_005f1.setKey(EmailVerificationController.MESSAGE_KEY);
        // /admin/userGeneralSettings.jsp(18,2) name = permanent type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
        _jspx_th_bs_005fmessages_005f1.setPermanent((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${true}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
        _jspx_th_bs_005fmessages_005f1.doTag();
      } finally {
        _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fmessages_005f1);
      }
      out.write("\r\n");
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_profile_005fgeneral_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_c_005fif_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_profile_005fuserAuthSettings_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("  <div class=\"saveButtonsBlock saveButtonsBlock_noborder\">\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fsubmit_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fcancel_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    ");
      if (_jspx_meth_forms_005fsaving_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  </div>\r\n");
      out.write("\r\n");
      out.write("  <input type=\"hidden\" id=\"submitUpdateUser\" name=\"submitUpdateUser\" value=\"storeInSession\"/>\r\n");
      out.write("  <input type=\"hidden\" name=\"userId\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminEditUserForm.userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\"/>\r\n");
      out.write("  <input type=\"hidden\" name=\"tab\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${currentTab}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\"/>\r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
      if (_jspx_meth_forms_005fmodified_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("  BS.AdminUpdateUserForm.setupEventHandlers();\r\n");
      out.write("  BS.AdminUpdateUserForm.setModified(");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminEditUserForm.stateModified}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write(");\r\n");
      out.write("</script>\r\n");
      out.write("</div>");
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

  private boolean _jspx_meth_c_005furl_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:url
    org.apache.taglibs.standard.tag.rt.core.UrlTag _jspx_th_c_005furl_005f0 = (org.apache.taglibs.standard.tag.rt.core.UrlTag) _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.UrlTag.class);
    boolean _jspx_th_c_005furl_005f0_reused = false;
    try {
      _jspx_th_c_005furl_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005furl_005f0.setParent(null);
      // /admin/userGeneralSettings.jsp(7,14) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005furl_005f0.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("/admin/editUser.html?userId=${adminEditUserForm.userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      int _jspx_eval_c_005furl_005f0 = _jspx_th_c_005furl_005f0.doStartTag();
      if (_jspx_th_c_005furl_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005furl_0026_005fvalue_005fnobody.reuse(_jspx_th_c_005furl_005f0);
      _jspx_th_c_005furl_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005furl_005f0, _jsp_getInstanceManager(), _jspx_th_c_005furl_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_authz_005fauthorize_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  authz:authorize
    org.apache.jsp.tag.web.authz.authorize_tag _jspx_th_authz_005fauthorize_005f0 = new org.apache.jsp.tag.web.authz.authorize_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_authz_005fauthorize_005f0);
    try {
      _jspx_th_authz_005fauthorize_005f0.setJspContext(_jspx_page_context);
      // /admin/userGeneralSettings.jsp(9,2) name = allPermissions type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_authz_005fauthorize_005f0.setAllPermissions("DELETE_USER");
      _jspx_th_authz_005fauthorize_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_authz_005fauthorize_005f0, null));
      _jspx_th_authz_005fauthorize_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_authz_005fauthorize_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fif_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    boolean _jspx_th_c_005fif_005f0_reused = false;
    try {
      _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /admin/userGeneralSettings.jsp(10,2) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminEditUserForm.canRemoveUserAccount}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    <input class=\"btn btn_mini submitButton\" type=\"button\" value=\"Delete User Account\" onclick=\"BS.AdminUpdateUserForm.deleteUserAccount()\" style=\"margin-right: 10px\"/>\r\n");
          out.write("    <div class=\"clr\"></div>\r\n");
          out.write("    <br/>\r\n");
          out.write("  ");
          int evalDoAfterBody = _jspx_th_c_005fif_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f0);
      _jspx_th_c_005fif_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fif_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fif_005f0_reused);
    }
    return false;
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
      // /admin/userGeneralSettings.jsp(20,2) name = profileForm type = jetbrains.buildServer.controllers.profile.ProfileForm reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_profile_005fgeneral_005f0.setProfileForm((jetbrains.buildServer.controllers.profile.ProfileForm) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminEditUserForm}", jetbrains.buildServer.controllers.profile.ProfileForm.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/userGeneralSettings.jsp(20,2) name = adminMode type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_profile_005fgeneral_005f0.setAdminMode(new java.lang.Boolean(true));
      _jspx_th_profile_005fgeneral_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_profile_005fgeneral_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fif_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    boolean _jspx_th_c_005fif_005f1_reused = false;
    try {
      _jspx_th_c_005fif_005f1.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f1.setParent(null);
      // /admin/userGeneralSettings.jsp(21,2) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f1.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not adminEditUserForm.perProjectPermissionsEnabled}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f1 = _jspx_th_c_005fif_005f1.doStartTag();
      if (_jspx_eval_c_005fif_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    ");
          if (_jspx_meth_l_005fsettingsBlock_005f0(_jspx_th_c_005fif_005f1, _jspx_page_context))
            return true;
          out.write("\r\n");
          out.write("  ");
          int evalDoAfterBody = _jspx_th_c_005fif_005f1.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f1);
      _jspx_th_c_005fif_005f1_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fif_005f1, _jsp_getInstanceManager(), _jspx_th_c_005fif_005f1_reused);
    }
    return false;
  }

  private boolean _jspx_meth_l_005fsettingsBlock_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f1, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  l:settingsBlock
    org.apache.jsp.tag.web.layout.settingsBlock_tag _jspx_th_l_005fsettingsBlock_005f0 = new org.apache.jsp.tag.web.layout.settingsBlock_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_l_005fsettingsBlock_005f0);
    try {
      _jspx_th_l_005fsettingsBlock_005f0.setJspContext(_jspx_page_context);
      _jspx_th_l_005fsettingsBlock_005f0.setParent(_jspx_th_c_005fif_005f1);
      // /admin/userGeneralSettings.jsp(22,4) name = title type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_l_005fsettingsBlock_005f0.setTitle("Administrator status");
      _jspx_th_l_005fsettingsBlock_005f0.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_l_005fsettingsBlock_005f0, null));
      _jspx_th_l_005fsettingsBlock_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_l_005fsettingsBlock_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_admin_005fperProjectRolesNote_005f0(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  admin:perProjectRolesNote
    org.apache.jsp.tag.web.admin.perProjectRolesNote_tag _jspx_th_admin_005fperProjectRolesNote_005f0 = new org.apache.jsp.tag.web.admin.perProjectRolesNote_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_admin_005fperProjectRolesNote_005f0);
    try {
      _jspx_th_admin_005fperProjectRolesNote_005f0.setJspContext(_jspx_page_context);
      _jspx_th_admin_005fperProjectRolesNote_005f0.setParent(_jspx_parent);
      _jspx_th_admin_005fperProjectRolesNote_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_admin_005fperProjectRolesNote_005f0);
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
      // /admin/userGeneralSettings.jsp(24,6) name = name type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setName("administrator");
      // /admin/userGeneralSettings.jsp(24,6) name = checked type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setChecked((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminEditUserForm.administrator}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      // /admin/userGeneralSettings.jsp(24,6) name = disabled type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcheckbox_005f0.setDisabled((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not adminEditUserForm.canEditPermissions or adminEditUserForm.administratorStatusInherited}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_forms_005fcheckbox_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fcheckbox_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fif_005f2(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f2 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    boolean _jspx_th_c_005fif_005f2_reused = false;
    try {
      _jspx_th_c_005fif_005f2.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f2.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) _jspx_parent));
      // /admin/userGeneralSettings.jsp(26,6) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f2.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminEditUserForm.administratorStatusInherited}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f2 = _jspx_th_c_005fif_005f2.doStartTag();
      if (_jspx_eval_c_005fif_005f2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("        ");
          if (_jspx_meth_bs_005fsmallNote_005f0(_jspx_th_c_005fif_005f2, _jspx_page_context))
            return true;
          out.write("\r\n");
          out.write("      ");
          int evalDoAfterBody = _jspx_th_c_005fif_005f2.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fif_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        throw new javax.servlet.jsp.SkipPageException();
      }
      _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f2);
      _jspx_th_c_005fif_005f2_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fif_005f2, _jsp_getInstanceManager(), _jspx_th_c_005fif_005f2_reused);
    }
    return false;
  }

  private boolean _jspx_meth_bs_005fsmallNote_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f2, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  bs:smallNote
    org.apache.jsp.tag.web.smallNote_tag _jspx_th_bs_005fsmallNote_005f0 = new org.apache.jsp.tag.web.smallNote_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_bs_005fsmallNote_005f0);
    try {
      _jspx_th_bs_005fsmallNote_005f0.setJspContext(_jspx_page_context);
      _jspx_th_bs_005fsmallNote_005f0.setParent(_jspx_th_c_005fif_005f2);
      _jspx_th_bs_005fsmallNote_005f0.setJspBody(new Helper( 2, _jspx_page_context, _jspx_th_bs_005fsmallNote_005f0, null));
      _jspx_th_bs_005fsmallNote_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_bs_005fsmallNote_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_profile_005fuserAuthSettings_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  profile:userAuthSettings
    org.apache.jsp.tag.web.userProfile.userAuthSettings_tag _jspx_th_profile_005fuserAuthSettings_005f0 = new org.apache.jsp.tag.web.userProfile.userAuthSettings_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_profile_005fuserAuthSettings_005f0);
    try {
      _jspx_th_profile_005fuserAuthSettings_005f0.setJspContext(_jspx_page_context);
      // /admin/userGeneralSettings.jsp(31,2) name = profileForm type = jetbrains.buildServer.controllers.profile.ProfileForm reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_profile_005fuserAuthSettings_005f0.setProfileForm((jetbrains.buildServer.controllers.profile.ProfileForm) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminEditUserForm}", jetbrains.buildServer.controllers.profile.ProfileForm.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
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
      // /admin/userGeneralSettings.jsp(34,4) name = label type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fsubmit_005f0.setLabel("Save changes");
      _jspx_th_forms_005fsubmit_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fsubmit_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005fcancel_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:cancel
    org.apache.jsp.tag.web.forms.cancel_tag _jspx_th_forms_005fcancel_005f0 = new org.apache.jsp.tag.web.forms.cancel_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005fcancel_005f0);
    try {
      _jspx_th_forms_005fcancel_005f0.setJspContext(_jspx_page_context);
      // /admin/userGeneralSettings.jsp(35,4) name = cameFromSupport type = jetbrains.buildServer.web.util.CameFromSupport reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005fcancel_005f0.setCameFromSupport((jetbrains.buildServer.web.util.CameFromSupport) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${adminEditUserForm.cameFromSupport}", jetbrains.buildServer.web.util.CameFromSupport.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      _jspx_th_forms_005fcancel_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005fcancel_005f0);
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
      // /admin/userGeneralSettings.jsp(36,4) name = id type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
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
      out.write("  ");
      if (_jspx_meth_c_005fif_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("  ");
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("      ");
      if (_jspx_meth_admin_005fperProjectRolesNote_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("      ");
      if (_jspx_meth_forms_005fcheckbox_005f0(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("      <label for=\"administrator\">Give this user administrative privileges</label>\r\n");
      out.write("      ");
      if (_jspx_meth_c_005fif_005f2(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("    ");
      return false;
    }
    public boolean invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("Administrative privileges are inherited from one or more parent groups");
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
