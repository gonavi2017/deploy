/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:30 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web.tests;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class _005fbulkOperationsLinks_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/WEB-INF/tags/tests/testInvestigationLink.tag", Long.valueOf(1504702502000L));
    _jspx_dependants.put("/WEB-INF/tags/authz/authorize.tag", Long.valueOf(1504702500000L));
  }

  private javax.servlet.jsp.JspContext jspContext;
  private java.io.Writer _jspx_sout;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_0026_005ftest;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public void setJspContext(javax.servlet.jsp.JspContext ctx) {
    super.setJspContext(ctx);
    java.util.ArrayList _jspx_nested = null;
    java.util.ArrayList _jspx_at_begin = null;
    java.util.ArrayList _jspx_at_end = null;
    this.jspContext = new org.apache.jasper.runtime.JspContextWrapper(ctx, _jspx_nested, _jspx_at_begin, _jspx_at_end, null);
  }

  public javax.servlet.jsp.JspContext getJspContext() {
    return this.jspContext;
  }
  private java.lang.String groupId;
  private java.lang.Boolean noFix;
  private java.lang.String projectId;

  public java.lang.String getGroupId() {
    return this.groupId;
  }

  public void setGroupId(java.lang.String groupId) {
    this.groupId = groupId;
    jspContext.setAttribute("groupId", groupId);
  }

  public java.lang.Boolean getNoFix() {
    return this.noFix;
  }

  public void setNoFix(java.lang.Boolean noFix) {
    this.noFix = noFix;
    jspContext.setAttribute("noFix", noFix);
  }

  public java.lang.String getProjectId() {
    return this.projectId;
  }

  public void setProjectId(java.lang.String projectId) {
    this.projectId = projectId;
    jspContext.setAttribute("projectId", projectId);
  }

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    return _jsp_instancemanager;
  }

  private void _jspInit(javax.servlet.ServletConfig config) {
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(config.getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(config);
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.release();
  }

  public void doTag() throws javax.servlet.jsp.JspException, java.io.IOException {
    javax.servlet.jsp.PageContext _jspx_page_context = (javax.servlet.jsp.PageContext)jspContext;
    javax.servlet.http.HttpServletRequest request = (javax.servlet.http.HttpServletRequest) _jspx_page_context.getRequest();
    javax.servlet.http.HttpServletResponse response = (javax.servlet.http.HttpServletResponse) _jspx_page_context.getResponse();
    javax.servlet.http.HttpSession session = _jspx_page_context.getSession();
    javax.servlet.ServletContext application = _jspx_page_context.getServletContext();
    javax.servlet.ServletConfig config = _jspx_page_context.getServletConfig();
    javax.servlet.jsp.JspWriter out = jspContext.getOut();
    _jspInit(config);
    jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,jspContext);
    if( getGroupId() != null ) 
      _jspx_page_context.setAttribute("groupId", getGroupId());
    if( getNoFix() != null ) 
      _jspx_page_context.setAttribute("noFix", getNoFix());
    if( getProjectId() != null ) 
      _jspx_page_context.setAttribute("projectId", getProjectId());

    try {
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_c_005fif_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
      if (_jspx_meth_tt_005ftestInvestigationLink_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("<a class=\"bulk-operation-link bulk-operation-cancel\" href=\"#\" onclick=\"jQuery('#");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${groupId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write("-actions-docked').hide(); return false;\">Cancel</a>");
    } catch( java.lang.Throwable t ) {
      if( t instanceof javax.servlet.jsp.SkipPageException )
          throw (javax.servlet.jsp.SkipPageException) t;
      if( t instanceof java.io.IOException )
          throw (java.io.IOException) t;
      if( t instanceof java.lang.IllegalStateException )
          throw (java.lang.IllegalStateException) t;
      if( t instanceof javax.servlet.jsp.JspException )
          throw (javax.servlet.jsp.JspException) t;
      throw new javax.servlet.jsp.JspException(t);
    } finally {
      jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,super.getJspContext());
      ((org.apache.jasper.runtime.JspContextWrapper) jspContext).syncEndTagFile();
      _jspDestroy();
    }
  }

  private boolean _jspx_meth_c_005fif_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    boolean _jspx_th_c_005fif_005f0_reused = false;
    try {
      _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fif_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/tests/_bulkOperationsLinks.tag(9,0) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not noFix}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("  ");
          if (_jspx_meth_authz_005fauthorize_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          out.write('\r');
          out.write('\n');
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

  private boolean _jspx_meth_authz_005fauthorize_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  authz:authorize
    org.apache.jsp.tag.web.authz.authorize_tag _jspx_th_authz_005fauthorize_005f0 = new org.apache.jsp.tag.web.authz.authorize_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_authz_005fauthorize_005f0);
    try {
      _jspx_th_authz_005fauthorize_005f0.setJspContext(_jspx_page_context);
      _jspx_th_authz_005fauthorize_005f0.setParent(_jspx_th_c_005fif_005f0);
      // /WEB-INF/tags/tests/_bulkOperationsLinks.tag(10,2) name = projectId type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_authz_005fauthorize_005f0.setProjectId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/tests/_bulkOperationsLinks.tag(10,2) name = anyPermission type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_authz_005fauthorize_005f0.setAnyPermission("ASSIGN_INVESTIGATION");
      javax.servlet.jsp.tagext.JspFragment _jspx_temp0 = new Helper( 0, _jspx_page_context, _jspx_th_authz_005fauthorize_005f0, null);
      // /WEB-INF/tags/tests/_bulkOperationsLinks.tag(10,2) null
      _jspx_th_authz_005fauthorize_005f0.setIfAccessGranted(_jspx_temp0);
      _jspx_th_authz_005fauthorize_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_authz_005fauthorize_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_tt_005ftestInvestigationLink_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  tt:testInvestigationLink
    org.apache.jsp.tag.web.tests.testInvestigationLink_tag _jspx_th_tt_005ftestInvestigationLink_005f0 = new org.apache.jsp.tag.web.tests.testInvestigationLink_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_tt_005ftestInvestigationLink_005f0);
    try {
      _jspx_th_tt_005ftestInvestigationLink_005f0.setJspContext(_jspx_page_context);
      _jspx_th_tt_005ftestInvestigationLink_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/tests/_bulkOperationsLinks.tag(17,0) name = onclick type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005ftestInvestigationLink_005f0.setOnclick((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("return BS.TestGroup.investigateSelected('#${groupId}');", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/tests/_bulkOperationsLinks.tag(17,0) name = projectId type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005ftestInvestigationLink_005f0.setProjectId((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_tt_005ftestInvestigationLink_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_tt_005ftestInvestigationLink_005f0);
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
      out.write("<a class=\"bulk-operation-link\" href=\"#\" title=\"Fix and unmute selected tests\"\r\n");
      out.write("         onclick=\"return BS.TestGroup.investigateSelected('#");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${groupId}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write("', true);\">Fix...</a>");
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
