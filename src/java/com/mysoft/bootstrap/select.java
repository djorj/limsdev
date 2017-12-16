/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft.bootstrap;

import com.mysoft.lims.*;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.Hashtable;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

/**
 *
 * @author djorj
 */
public class select  extends TagSupport{ 
    
    private String where;
    private String objname;
    private String[] cols;
    private boolean edit;
    private String nmand;
    private String id;
    private String style;
    private String classes;
    
    public void release(){
        where = null;
        objname = null;
        id = null;
        style = null;
        classes = null;
        cols = null;
        edit = false;
        nmand = null;
    }

    public void setWhere(String where) {
        this.where = where;
    }

    public void setObjname(String objname) {
        this.objname = objname;
    }

    public void setCols(String cols) {
        this.cols = cols.split(",");
    }

    public void setEdit(boolean edit) {
        this.edit = edit;
    }

    public void setNmand(String nmand) {
        this.nmand = nmand;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }
    
    
    
    public int doStartTag() throws JspException {  
        JspWriter out=pageContext.getOut();
        try{
            HttpSession session = pageContext.getSession();
            translation trs = (translation)session.getAttribute("trs");
            if(where == null)   where = "";
            Class cl = Class.forName("com.mysoft.lims."+objname+"Manager");
            Object obj = cl.newInstance();
            Method mt = cl.getMethod("loadByWhere",new Class[] {String.class});
            Object[] records = (Object[])mt.invoke(obj,new Object[] {where});

            //Hashtable h = new Hashtable();
            Connection con = Manager.getInstance().getConnection();
            DatabaseMetaData meta = con.getMetaData();
            ResultSet rs = meta.getImportedKeys(null, null, objname.toLowerCase());
            while(rs.next()){
                String tablename = rs.getString("PKTABLE_NAME");
                String pkeyname = rs.getString("PKCOLUMN_NAME");
                String colname = rs.getString("FKCOLUMN_NAME");
                String sql = "select * from "+tablename+" where "+pkeyname+" = ";
                //h.put((String)colname, (String)sql);
            }
            rs.close();
            if(style == null)   style = "";
            else                style = " style=\""+style+"\"";
            if(classes == null)   classes = "";
            else                classes = " class=\""+classes+"\"";
            String res = "<select id=\""+id+"\""+style+classes+">\n<option value=\"0\">"+trs.t("-- ყველა --")+"</option>\n";
            if(edit){
                res = "<select id=\""+id+"\""+style+classes+">\n";
            } else if(nmand != null){
                res = "<select id=\""+id+"\""+style+classes+">\n<option value=\"0\">"+trs.t(nmand).replaceAll("\"", "&quot;")+"</option>\n";
            }

            for(int i=0;i<records.length;i++)
                {
                String id = "";
                String value = "";
                for(int j=0;j<cols.length;j++){
                    Class cl0 = records[i].getClass();
                    mt = cl0.getMethod("get"+cols[j],new Class[] {});
                    Object ob = mt.invoke(records[i]);
                    String val = "";
                    if(ob != null){
                        val = ob.toString();

                    }
                    if(j==0) id = val;
                    else{
                        if(value.length() > 0)  value += " ";
                        value += val;
                    }
                }
                res += "<option value=\""+id+"\">"+trs.t(value).replaceAll("\"", "&quot;")+"</option>\n";
            }
            res += "</select><i></i>\n";
            res = "<label class=\"select\">\n"+res+"</label>\n";
            out.print(res);
            release();
        }catch(Exception e){System.out.println(e);}  
        return SKIP_BODY;//will not evaluate the body content of the tag  
    }
}
