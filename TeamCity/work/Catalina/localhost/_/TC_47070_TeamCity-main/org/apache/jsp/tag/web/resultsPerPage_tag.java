/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.79
 * Generated at: 2017-09-23 02:17:32 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.tag.web;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class resultsPerPage_tag
    extends javax.servlet.jsp.tagext.SimpleTagSupport
    implements org.apache.jasper.runtime.JspSourceDependent {


  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/tags/forms/option.tag", Long.valueOf(1504702502000L));
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
  private jetbrains.buildServer.util.Pager pager;
  private java.lang.String onchange;
  private java.lang.Integer minItemsNumber;

  public jetbrains.buildServer.util.Pager getPager() {
    return this.pager;
  }

  public void setPager(jetbrains.buildServer.util.Pager pager) {
    this.pager = pager;
    jspContext.setAttribute("pager", pager);
  }

  public java.lang.String getOnchange() {
    return this.onchange;
  }

  public void setOnchange(java.lang.String onchange) {
    this.onchange = onchange;
    jspContext.setAttribute("onchange", onchange);
  }

  public java.lang.Integer getMinItemsNumber() {
    return this.minItemsNumber;
  }

  public void setMinItemsNumber(java.lang.Integer minItemsNumber) {
    this.minItemsNumber = minItemsNumber;
    jspContext.setAttribute("minItemsNumber", minItemsNumber);
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
    if( getPager() != null ) 
      _jspx_page_context.setAttribute("pager", getPager());
    if( getOnchange() != null ) 
      _jspx_page_context.setAttribute("onchange", getOnchange());
    if( getMinItemsNumber() != null ) 
      _jspx_page_context.setAttribute("minItemsNumber", getMinItemsNumber());

    try {
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<label for=\"recordsPerPage\">Results per page:</label>&nbsp;\r\n");
      out.write("<select name=\"recordsPerPage\" id=\"recordsPerPage\" style=\"width: 5em;\" onchange=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${onchange}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      out.write("\">\r\n");
      out.write("  ");
      if (_jspx_meth_c_005fif_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_forms_005foption_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_forms_005foption_005f2(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_forms_005foption_005f3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("  ");
      if (_jspx_meth_forms_005foption_005f4(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("</select>");
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
      _jspx_th_c_005fif_005f0.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/resultsPerPage.tag(10,2) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${minItemsNumber != null and minItemsNumber != 20}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false)).booleanValue());
      int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
      if (_jspx_eval_c_005fif_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("    ");
          if (_jspx_meth_forms_005foption_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
            return true;
          out.write("\r\n");
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

  private boolean _jspx_meth_forms_005foption_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:option
    org.apache.jsp.tag.web.forms.option_tag _jspx_th_forms_005foption_005f0 = new org.apache.jsp.tag.web.forms.option_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005foption_005f0);
    try {
      _jspx_th_forms_005foption_005f0.setJspContext(_jspx_page_context);
      _jspx_th_forms_005foption_005f0.setParent(_jspx_th_c_005fif_005f0);
      // /WEB-INF/tags/resultsPerPage.tag(11,4) name = value type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f0.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${minItemsNumber}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      // /WEB-INF/tags/resultsPerPage.tag(11,4) name = selected type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f0.setSelected((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pager.recordsPerPage == minItemsNumber}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_forms_005foption_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_forms_005foption_005f0, null));
      _jspx_th_forms_005foption_005f0.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005foption_005f0);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005foption_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:option
    org.apache.jsp.tag.web.forms.option_tag _jspx_th_forms_005foption_005f1 = new org.apache.jsp.tag.web.forms.option_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005foption_005f1);
    try {
      _jspx_th_forms_005foption_005f1.setJspContext(_jspx_page_context);
      _jspx_th_forms_005foption_005f1.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/resultsPerPage.tag(13,2) name = value type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f1.setValue("20");
      // /WEB-INF/tags/resultsPerPage.tag(13,2) name = selected type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f1.setSelected((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pager.recordsPerPage == 20}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_forms_005foption_005f1.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_forms_005foption_005f1, null));
      _jspx_th_forms_005foption_005f1.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005foption_005f1);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005foption_005f2(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:option
    org.apache.jsp.tag.web.forms.option_tag _jspx_th_forms_005foption_005f2 = new org.apache.jsp.tag.web.forms.option_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005foption_005f2);
    try {
      _jspx_th_forms_005foption_005f2.setJspContext(_jspx_page_context);
      _jspx_th_forms_005foption_005f2.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/resultsPerPage.tag(14,2) name = value type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f2.setValue("50");
      // /WEB-INF/tags/resultsPerPage.tag(14,2) name = selected type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f2.setSelected((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pager.recordsPerPage == 50}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_forms_005foption_005f2.setJspBody(new Helper( 2, _jspx_page_context, _jspx_th_forms_005foption_005f2, null));
      _jspx_th_forms_005foption_005f2.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005foption_005f2);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005foption_005f3(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:option
    org.apache.jsp.tag.web.forms.option_tag _jspx_th_forms_005foption_005f3 = new org.apache.jsp.tag.web.forms.option_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005foption_005f3);
    try {
      _jspx_th_forms_005foption_005f3.setJspContext(_jspx_page_context);
      _jspx_th_forms_005foption_005f3.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/resultsPerPage.tag(15,2) name = value type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f3.setValue("100");
      // /WEB-INF/tags/resultsPerPage.tag(15,2) name = selected type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f3.setSelected((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pager.recordsPerPage == 100}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_forms_005foption_005f3.setJspBody(new Helper( 3, _jspx_page_context, _jspx_th_forms_005foption_005f3, null));
      _jspx_th_forms_005foption_005f3.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005foption_005f3);
    }
    return false;
  }

  private boolean _jspx_meth_forms_005foption_005f4(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  forms:option
    org.apache.jsp.tag.web.forms.option_tag _jspx_th_forms_005foption_005f4 = new org.apache.jsp.tag.web.forms.option_tag();
    _jsp_getInstanceManager().newInstance(_jspx_th_forms_005foption_005f4);
    try {
      _jspx_th_forms_005foption_005f4.setJspContext(_jspx_page_context);
      _jspx_th_forms_005foption_005f4.setParent(new javax.servlet.jsp.tagext.TagAdapter((javax.servlet.jsp.tagext.SimpleTag) this ));      // /WEB-INF/tags/resultsPerPage.tag(16,2) name = value type = java.lang.String reqTime = true required = true fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f4.setValue("500");
      // /WEB-INF/tags/resultsPerPage.tag(16,2) name = selected type = java.lang.Boolean reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
      _jspx_th_forms_005foption_005f4.setSelected((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pager.recordsPerPage == 500}", java.lang.Boolean.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      _jspx_th_forms_005foption_005f4.setJspBody(new Helper( 4, _jspx_page_context, _jspx_th_forms_005foption_005f4, null));
      _jspx_th_forms_005foption_005f4.doTag();
    } finally {
      _jsp_getInstanceManager().destroyInstance(_jspx_th_forms_005foption_005f4);
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
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${minItemsNumber}", java.lang.String.class, (javax.servlet.jsp.PageContext)this.getJspContext(), null, false));
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write('2');
      out.write('0');
      return false;
    }
    public boolean invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write('5');
      out.write('0');
      return false;
    }
    public boolean invoke3( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write('1');
      out.write('0');
      out.write('0');
      return false;
    }
    public boolean invoke4( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write('5');
      out.write('0');
      out.write('0');
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
