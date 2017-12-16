/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.mysoft;

/**
 *
 * @author djorj
 */
public class jqexport {

    private String clickcode = "";
    private String formname = "progressform";
    private String formname1 = "dpma";
    private String ses = "";
    private String title = "დაელოდეთ, მიმდინარეობს მონაცემთა ექსპორტირება...";

    public jqexport(){}
    
    public jqexport(String ses, String gp1, String gp2, String stopses, String exportfile, String title)
    {

        this.ses = ses;
        if(title != null && title.length() > 0) this.title = title;
        clickcode = "BootstrapDialog.show(\n"
	+"    {\n"
        +"        title: '"+this.title+"',\n"
	+"        size: BootstrapDialog.SIZE_NORMAL,\n"
	+"        resizable: false,\n"
	+"        modal: true,\n"
	+"        draggable: false,\n"
	+"        closeOnEscape: false,\n"
        +"        message: function(dialog){\n"
        +"        var $message = $('<div></div>');\n"
        +"        var pageToLoad = dialog.getData('pageToLoad');\n"
        +"        $message.load(pageToLoad);\n"
        +"        wt = setTimeout(\"progBar()\", 1000);\n"
	+"        $.post(\""+exportfile+"\",\n"
	+"           { ses: '"+ses+"', gp1: '"+gp1+"', gp2: '"+gp2+"' },\n"
	+"           function(data){\n"
	+"               clearTimeout(wt);\n"
        +"               if(data.result == 0){ alert(data.error); dialog.close();}\n"
        +"               else {var fname = data.filename; window.open(\"readfile?name=\"+fname); dialog.close();}\n"
	//+"               var fname = data.filename;\n"  //.replace(/\\n/g,\"\");\n"
	//+"               window.open(\"readfile?name=\"+fname);\n"
	//+"               dialog.close();\n"
	+"            },\"json\");\n"
        +"        return $message;\n"
        +"        },\n"
        +"        data: {\n"
        +"           'pageToLoad': \"includes/wait0.jsp\"\n"
        +"        },"
	+"        buttons: [{"
        +"        id: 'btn-cancel',\n"
        +"        icon: 'fa fa-times',\n"
        +"        label: ' შეწყვეტა',\n"
        +"        cssClass: 'btn-danger', \n"
        +"        autospin: false,\n"
        +"        action: function(dialogRef){\n"
        +"          $.post(\"content/setsessionpar.jsp\", { ses: \""+stopses+"\", val: \"YES\"},function(data){ dialogRef.close(); clearTimeout(wt); });"
        +"                \n"
        +"          }"
        +"        }]\n"
	+"    });\n";

    }

    public String getClickCode()
    {
        return clickcode;
    }

    public String getExportAttr()
    {
        String s = "<script type=\"text/javascript\">\n"
                + "var wt;\n"
                + "function progBar()\n"
                + "{\n"
                + "$.post(\"includes/wt.jsp\", { ses: '"+ses+"'},function(data){ $(\"#progressbar01\").css(\"width\", data.val+'%').attr(\"aria-valuenow\", data.val).text(data.val+' %'); },'json');\n"
                + "wt = setTimeout(\"progBar()\", 1000);\n"
                + "}\n"
                + "</script>\n";
        return s;
    }

}



