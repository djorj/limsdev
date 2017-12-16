/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft.bootstrap;

import com.mysoft.lims.Manager;
import com.mysoft.lims.translation;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import static javax.servlet.jsp.tagext.Tag.SKIP_BODY;
import javax.servlet.jsp.tagext.TagSupport;

/**
 *
 * @author djorj
 */
public class textInput  extends TagSupport{ 
    
    private String icon;
    private String name;
    private String id;
    private String style;
    private String classes;
    private String placeholder;
    private String value;

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public void setPlaceholder(String placeholder) {
        this.placeholder = placeholder;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    
    public void release(){
        icon = null;
        name = null;
        id = null;
        style = null;
        classes = null;
        placeholder = null;
        value = null;
    }
    
    
    public int doStartTag() throws JspException {  
        JspWriter out=pageContext.getOut();
        try{
            HttpSession session = pageContext.getSession();
            translation trs = (translation)session.getAttribute("trs");
            if(style == null)    style = "";
            else                style = " style=\""+style.replaceAll("\"", "&quot;")+"\"";
            if(name == null)    name = "";
            else                name = " name=\""+name.replaceAll("\"", "&quot;")+"\"";
            if(placeholder == null)    placeholder = "";
            else                placeholder = " placeholder=\""+trs.t(placeholder).replaceAll("\"", "&quot;")+"\"";
            if(value == null)    value = "";
            else                value = " value=\""+value.replaceAll("\"", "&quot;")+"\"";
            if(classes == null)    classes = "";
            else                classes = " class=\""+classes+"\"";
            String res ="<label class=\"input\"> <i class=\"icon-append fa fa-"+icon+"\"></i><input id=\""+id+"\" type=\"text\""+name+style+placeholder+value+classes+"></label>";
            out.print(res);
            release();
        }catch(Exception e){System.out.println(e);}  
        return SKIP_BODY;//will not evaluate the body content of the tag  
    }
    
}
