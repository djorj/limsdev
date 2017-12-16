/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.mysoft;

import java.util.*;
/**
 *
 * @author djorj
 */
public class pbar {
    private String script = "";
    private String pbarcounter = "";

    public pbar(String hdr,String url,boolean tp)
    {
        pbarcounter = String.valueOf(new Date().getTime());
        script = getInitPbar(hdr,url,tp);
    }

    public String getInitPbar(String hdr,String url,boolean tp)
    {
        String s = "<script type=\"text/javascript\">";
        s += "var progresshandler;";
        s += "var handlername=\""+pbarcounter+"\";";
        s += "jQuery(document).ready(function() {";
        s += "jQuery(\"#dialog\").dialog({";
        s += "bgiframe: true, autoOpen: false, height: 140, width: 400, modal: true, draggable: false, resizable: false,";
    //    s += "buttons: { \"შეწყვეტა\": function() { $(this).dialog(\"close\"); } },";
        s += "open: function(event, ui) {";
        if(tp)
            s += "document.location.href='"+url+"&pbarcounter="+pbarcounter+"';";
        else
            s += "$.get(\""+url+"&pbarcounter="+pbarcounter+"\",function(data){});";
        s += "cn=0;progresshandler = setInterval('doProgress1()',300);},";
        s += "close: function(event, ui) {$.get(\"pbar/sessionvaluehandler.jsp?stop=1&sessionvarname=\"+handlername,function(data){});cn=0;$(\"#progressbar\").progressbar({ value: cn });clearInterval(progresshandler);}";
        s += "});";
        s += "});";
        s += "function doProgress1()";
        s += "{";
        s += "$.get(\"pbar/sessionvaluehandler.jsp?sessionvarname=\"+handlername,";
        s += "function(data){";
        s += "var cn = parseFloat(data);";
        s += "$(\"#progressbar\").progressbar({ value: cn });";
        s += "$(\"#progressval\").html(cn.toFixed(2)+\"%\");";
        s += "if(cn >= 100)";
        s += "{";
        s += "jQuery('#dialog').dialog('close');";
        s += "}";
        s += "});";
        s += "}";
        s += "</script>\n";
        s += "<div id=\"dialog\" title=\""+hdr+"\">\n";
        s += "<div align=\"center\" id=\"progressbar\"></div>\n";
        s += "<div align=\"center\" id=\"progressval\"></div>\n";
        s += "</div>\n";
        return s;
    }

    public String getPbarcounter(){return pbarcounter;}
    public String getScript(){return script;}

}
