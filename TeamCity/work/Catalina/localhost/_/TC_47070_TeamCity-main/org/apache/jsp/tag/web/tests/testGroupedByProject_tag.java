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

public final class testGroupedByProject_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/WEB-INF/util-functions.tld", Long.valueOf(1504702500000L));
    _jspx_dependants.put("/WEB-INF/tags/tests/projectTestGroups.tag", Long.valueOf(1504702504000L));
  }

  private javax.servlet.jsp.JspContext jspContext;
  private java.io.Writer _jspx_sout;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems;

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
  private java.util.List projectGroups;
  private java.lang.String withoutActions;
  private java.lang.Integer maxTests;
  private java.lang.Integer maxTestsPerGroup;
  private java.lang.Boolean ignoreMuteScope;
  private java.lang.Boolean showMuteFromTestRun;
  private javax.servlet.jsp.tagext.JspFragment viewAllUrl;
  private javax.servlet.jsp.tagext.JspFragment testMoreData;
  private javax.servlet.jsp.tagext.JspFragment testAfterName;
  private javax.servlet.jsp.tagext.JspFragment testLinkAttrs;
  private java.lang.Integer maxTestNameLength;

  public java.lang.String getGroupId() {
    return this.groupId;
  }

  public void setGroupId(java.lang.String groupId) {
    this.groupId = groupId;
    jspContext.setAttribute("groupId", groupId);
  }

  public java.util.List getProjectGroups() {
    return this.projectGroups;
  }

  public void setProjectGroups(java.util.List projectGroups) {
    this.projectGroups = projectGroups;
    jspContext.setAttribute("projectGroups", projectGroups);
  }

  public java.lang.String getWithoutActions() {
    return this.withoutActions;
  }

  public void setWithoutActions(java.lang.String withoutActions) {
    this.withoutActions = withoutActions;
    jspContext.setAttribute("withoutActions", withoutActions);
  }

  public java.lang.Integer getMaxTests() {
    return this.maxTests;
  }

  public void setMaxTests(java.lang.Integer maxTests) {
    this.maxTests = maxTests;
    jspContext.setAttribute("maxTests", maxTests);
  }

  public java.lang.Integer getMaxTestsPerGroup() {
    return this.maxTestsPerGroup;
  }

  public void setMaxTestsPerGroup(java.lang.Integer maxTestsPerGroup) {
    this.maxTestsPerGroup = maxTestsPerGroup;
    jspContext.setAttribute("maxTestsPerGroup", maxTestsPerGroup);
  }

  public java.lang.Boolean getIgnoreMuteScope() {
    return this.ignoreMuteScope;
  }

  public void setIgnoreMuteScope(java.lang.Boolean ignoreMuteScope) {
    this.ignoreMuteScope = ignoreMuteScope;
    jspContext.setAttribute("ignoreMuteScope", ignoreMuteScope);
  }

  public java.lang.Boolean getShowMuteFromTestRun() {
    return this.showMuteFromTestRun;
  }

  public void setShowMuteFromTestRun(java.lang.Boolean showMuteFromTestRun) {
    this.showMuteFromTestRun = showMuteFromTestRun;
    jspContext.setAttribute("showMuteFromTestRun", showMuteFromTestRun);
  }

  public javax.servlet.jsp.tagext.JspFragment getViewAllUrl() {
    return this.viewAllUrl;
  }

  public void setViewAllUrl(javax.servlet.jsp.tagext.JspFragment viewAllUrl) {
    this.viewAllUrl = viewAllUrl;
    jspContext.setAttribute("viewAllUrl", viewAllUrl);
  }

  public javax.servlet.jsp.tagext.JspFragment getTestMoreData() {
    return this.testMoreData;
  }

  public void setTestMoreData(javax.servlet.jsp.tagext.JspFragment testMoreData) {
    this.testMoreData = testMoreData;
    jspContext.setAttribute("testMoreData", testMoreData);
  }

  public javax.servlet.jsp.tagext.JspFragment getTestAfterName() {
    return this.testAfterName;
  }

  public void setTestAfterName(javax.servlet.jsp.tagext.JspFragment testAfterName) {
    this.testAfterName = testAfterName;
    jspContext.setAttribute("testAfterName", testAfterName);
  }

  public javax.servlet.jsp.tagext.JspFragment getTestLinkAttrs() {
    return this.testLinkAttrs;
  }

  public void setTestLinkAttrs(javax.servlet.jsp.tagext.JspFragment testLinkAttrs) {
    this.testLinkAttrs = testLinkAttrs;
    jspContext.setAttribute("testLinkAttrs", testLinkAttrs);
  }

  public java.lang.Integer getMaxTestNameLength() {
    return this.maxTestNameLength;
  }

  public void setMaxTestNameLength(java.lang.Integer maxTestNameLength) {
    this.maxTestNameLength = maxTestNameLength;
    jspContext.setAttribute("maxTestNameLength", maxTestNameLength);
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
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(config);
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(config.getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(config);
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.release();
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
    if( getProjectGroups() != null ) 
      _jspx_page_context.setAttribute("projectGroups", getProjectGroups());
    if( getWithoutActions() != null ) 
      _jspx_page_context.setAttribute("withoutActions", getWithoutActions());
    if( getMaxTests() != null ) 
      _jspx_page_context.setAttribute("maxTests", getMaxTests());
    if( getMaxTestsPerGroup() != null ) 
      _jspx_page_context.setAttribute("maxTestsPerGroup", getMaxTestsPerGroup());
    if( getIgnoreMuteScope() != null ) 
      _jspx_page_context.setAttribute("ignoreMuteScope", getIgnoreMuteScope());
    if( getShowMuteFromTestRun() != null ) 
      _jspx_page_context.setAttribute("showMuteFromTestRun", getShowMuteFromTestRun());
    if( getViewAllUrl() != null ) 
      _jspx_page_context.setAttribute("viewAllUrl", getViewAllUrl());
    if( getTestMoreData() != null ) 
      _jspx_page_context.setAttribute("testMoreData", getTestMoreData());
    if( getTestAfterName() != null ) 
      _jspx_page_context.setAttribute("testAfterName", getTestAfterName());
    if( getTestLinkAttrs() != null ) 
      _jspx_page_context.setAttribute("testLinkAttrs", getTestLinkAttrs());
    if( getMaxTestNameLength() != null ) 
      _jspx_page_context.setAttribute("maxTestNameLength", getMaxTestNameLength());

    try {
      if (_jspx_meth_c_005fforEach_005f0(_jspx_page_context))
        return;
      out.write('\r');
      out.write('\n');
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

  private boolean _jspx_meth_c_005fforEach_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    boolean _jspx_th_c_005fforEach_005f0_reused = false;
    try {
      _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fforEach_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/tests/testGroupedByProject.tag(24,2) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f0.setVar("projectGroup");
      // /WEB-INF/tags/tests/testGroupedByProject.tag(24,2) name = items type = java.lang.Object reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fforEach_005f0.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectGroups}", java.lang.Object.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
      try {
        int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
        if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
          do {
            out.write("\r\n");
            out.write("  ");
            if (_jspx_meth_tt_005fprojectTestGroups_005f0(_jspx_th_c_005fforEach_005f0, _jspx_page_context, _jspx_push_body_count_c_005fforEach_005f0))
              return true;
            out.write('\r');
            out.write('\n');
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

  private boolean _jspx_meth_tt_005fprojectTestGroups_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fforEach_005f0, javax.servlet.jsp.PageContext _jspx_page_context, int[] _jspx_push_body_count_c_005fforEach_005f0)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  tt:projectTestGroups
    org.apache.jsp.tag.web.tests.projectTestGroups_tag _jspx_th_tt_005fprojectTestGroups_005f0 = new org.apache.jsp.tag.web.tests.projectTestGroups_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_tt_005fprojectTestGroups_005f0);
    try {
      _jspx_th_tt_005fprojectTestGroups_005f0.setJspContext(_jspx_page_context);
      _jspx_th_tt_005fprojectTestGroups_005f0.setParent(_jspx_th_c_005fforEach_005f0);
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) name = projectGroup type = jetbrains.buildServer.web.problems.ProjectTestsBean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005fprojectTestGroups_005f0.setProjectGroup((jetbrains.buildServer.web.problems.ProjectTestsBean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectGroup}", jetbrains.buildServer.web.problems.ProjectTestsBean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) name = withoutActions type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005fprojectTestGroups_005f0.setWithoutActions((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${withoutActions}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) name = maxTests type = java.lang.Integer reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005fprojectTestGroups_005f0.setMaxTests((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${maxTests}", java.lang.Integer.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) name = maxTestsPerGroup type = java.lang.Integer reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005fprojectTestGroups_005f0.setMaxTestsPerGroup((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${maxTestsPerGroup}", java.lang.Integer.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) name = ignoreMuteScope type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005fprojectTestGroups_005f0.setIgnoreMuteScope((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ignoreMuteScope}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) name = showMuteFromTestRun type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005fprojectTestGroups_005f0.setShowMuteFromTestRun((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${showMuteFromTestRun}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) name = maxTestNameLength type = java.lang.Integer reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_tt_005fprojectTestGroups_005f0.setMaxTestNameLength((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${maxTestNameLength}", java.lang.Integer.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      javax.servlet.jsp.tagext.JspFragment _jspx_temp0 = new Helper( 0, _jspx_page_context, _jspx_th_tt_005fprojectTestGroups_005f0, _jspx_push_body_count_c_005fforEach_005f0);
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) null
      _jspx_th_tt_005fprojectTestGroups_005f0.setViewAllUrl(_jspx_temp0);
      javax.servlet.jsp.tagext.JspFragment _jspx_temp1 = new Helper( 1, _jspx_page_context, _jspx_th_tt_005fprojectTestGroups_005f0, _jspx_push_body_count_c_005fforEach_005f0);
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) null
      _jspx_th_tt_005fprojectTestGroups_005f0.setTestMoreData(_jspx_temp1);
      javax.servlet.jsp.tagext.JspFragment _jspx_temp2 = new Helper( 2, _jspx_page_context, _jspx_th_tt_005fprojectTestGroups_005f0, _jspx_push_body_count_c_005fforEach_005f0);
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) null
      _jspx_th_tt_005fprojectTestGroups_005f0.setTestAfterName(_jspx_temp2);
      javax.servlet.jsp.tagext.JspFragment _jspx_temp3 = new Helper( 3, _jspx_page_context, _jspx_th_tt_005fprojectTestGroups_005f0, _jspx_push_body_count_c_005fforEach_005f0);
      // /WEB-INF/tags/tests/testGroupedByProject.tag(25,2) null
      _jspx_th_tt_005fprojectTestGroups_005f0.setTestLinkAttrs(_jspx_temp3);
      _jspx_th_tt_005fprojectTestGroups_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_tt_005fprojectTestGroups_005f0);
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
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getViewAllUrl() != null) {
        getViewAllUrl().invoke(_jspx_sout);
      }
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getTestMoreData() != null) {
        getTestMoreData().invoke(_jspx_sout);
      }
      return false;
    }
    public boolean invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getTestAfterName() != null) {
        getTestAfterName().invoke(_jspx_sout);
      }
      return false;
    }
    public boolean invoke3( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      ((org.apache.jasper.runtime.JspContextWrapper) this.jspContext).syncBeforeInvoke();
      _jspx_sout = null;
      if (getTestLinkAttrs() != null) {
        getTestLinkAttrs().invoke(_jspx_sout);
      }
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