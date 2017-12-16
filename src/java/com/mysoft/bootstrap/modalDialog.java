/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft.bootstrap;

import java.util.Calendar;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import com.mysoft.lims.*;

/**
 *
 * @author djorj
 */
public class modalDialog extends TagSupport{ 
    
    private String savename;
    private String closename;
    private String saveaction;
    private String contentfile;
    private String openaction;
    private String title;
    private int width = 800;
    
    public void release(){
        savename = null;
        closename = null;
        id = null;
        saveaction = null;
        contentfile = null;
        openaction = null;
        title = null;
        width = 800;
    }

    public void setSavename(String savename) {
        this.savename = savename;
    }

    public void setClosename(String closename) {
        this.closename = closename;
    }

    public void setSaveaction(String saveaction) {
        this.saveaction = saveaction;
    }

    public void setContentfile(String contentfile) {
        this.contentfile = contentfile;
    }

    public void setOpenaction(String openaction) {
        this.openaction = openaction;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setWidth(int width) {
        this.width = width;
    }
    
    
    
    public int doStartTag() throws JspException {  
        JspWriter out=pageContext.getOut();
        try{  
            Calendar cal = Calendar.getInstance();
            
            HttpSession session = pageContext.getSession();
            translation trs = (translation)session.getAttribute("trs");
            if(savename == null)    savename = trs.t("შენახვა");
            if(closename == null)    closename = trs.t("დახურვა");
            title = trs.t(title);
            
            String modalid = "modal_"+cal.getTimeInMillis();
            String headid = "modalHead_"+cal.getTimeInMillis();
            String bodyid = "modalBody_"+cal.getTimeInMillis();
            String s = "<div class=\"modal fade\" id=\""+modalid+"\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"iconsModalLabel\" aria-hidden=\"true\">";
            s += "<div class=\"modal-dialog\" style=\"width: "+width+"px !important;\">";
            s += "<div class=\"modal-content\">";
            s += "<div class=\"modal-header modal-header-primary\">";
            s += "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>";
            s += "<h4 class=\"modal-title\" id=\""+headid+"\">"+title.replaceAll("\"", "&quot;")+"</h4>";
            s += "</div>";
            s += "<div class=\"modal-body\">";
            s += "<div class=\"table-sizeModal\" id=\""+bodyid+"\">";

            s += "</div>";
            s += "</div>";
            s += "<footer class=\"modal-footer\">";
            s += "<button type=\"button\" class=\"btn btn-success\" onclick=\""+saveaction.replaceAll("\"", "&quot;")+"\">";
            s += savename+" <span class=\"fa fa-save\"></span>";
            s += "</button>";
            s += "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">";
            s += closename+" <span class=\"fa fa-close\"></span>";
            s += "</button>";
            s += "</footer>";
            s += "</div>";
            s += "</div>";
            s += "</div>\n";
            s += "<script>\n"
                    + "function "+openaction+"(id){"
                    + "$.post(\""+contentfile+"\",{ id: id },function(data){"
                    //+ "$(\"#"+headid+"\").html(\""+title+"\");"
                    + "$(\"#"+modalid+"\").modal(\"show\");"
                    + "$(\"#"+bodyid+"\").html(data);"
                    + "});"
                    + "}\n"
                    + "</script>";
            
            
            out.print(s);
            release();
        }catch(Exception e){System.out.println(e);}  
        return SKIP_BODY;//will not evaluate the body content of the tag  
    }  
    
}
