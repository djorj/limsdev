/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft;

/**
 *
 * @author djorj
 */
public class jqTable {
    
    private int rowNum, height;
    private boolean autowidth, viewrecords;
    private String rowList, sortname, sortorder, editurl, caption, url;
    private String listname, pagername;
    private jqField[] fields;

    public jqTable(String caption, String url, String listname, String pagername) {
        this.caption = caption;
        this.url = url;
        this.listname = listname;
        this.pagername = pagername;
    }

    public boolean isAutowidth() {
        return autowidth;
    }

    public void setAutowidth(boolean autowidth) {
        this.autowidth = autowidth;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public String getEditurl() {
        return editurl;
    }

    public void setEditurl(String editurl) {
        this.editurl = editurl;
    }

    public jqField[] getFields() {
        return fields;
    }

    public void setFields(jqField[] fields) {
        this.fields = fields;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public String getListname() {
        return listname;
    }

    public void setListname(String listname) {
        this.listname = listname;
    }

    public String getPagername() {
        return pagername;
    }

    public void setPagername(String pagername) {
        this.pagername = pagername;
    }

    public String getRowList() {
        return rowList;
    }

    public void setRowList(String rowList) {
        this.rowList = rowList;
    }

    public int getRowNum() {
        return rowNum;
    }

    public void setRowNum(int rowNum) {
        this.rowNum = rowNum;
    }

    public String getSortname() {
        return sortname;
    }

    public void setSortname(String sortname) {
        this.sortname = sortname;
    }

    public String getSortorder() {
        return sortorder;
    }

    public void setSortorder(String sortorder) {
        this.sortorder = sortorder;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isViewrecords() {
        return viewrecords;
    }

    public void setViewrecords(boolean viewrecords) {
        this.viewrecords = viewrecords;
    }
    
    private String getTable(){
        String script = "";
        String s = "<script type=\"text/javascript\">\njQuery().ready(function ()\n{\njQuery(\"#"+listname+"\").jqGrid(\n{\n";
        s += "url:'"+url+"',\ndatatype: \"xml\",\n";
        String snames = "colNames:[";
        String smodel = "colModel:[";
        for(int i=0;i<fields.length;i++){
            if(i>0){
                snames += ",";
                smodel += "\n,";
            }
            snames += "'"+fields[i].getSname().replaceAll("'", "\\'")+"'";
            smodel += fields[i].getColModel();
            script += fields[i].getScript();
        }
        snames += "],\n";
        smodel += "],\n";
        s += snames + smodel;
        s += "rowNum: "+rowNum+","
                + "\nheight: "+height+","
                + "\nautowidth: "+autowidth+","
                + "\nrowList: "+rowList+","
                + "\npager: jQuery('#"+pagername+"'),"
                + "\nsortname: '"+sortname+"',"
                + "\nviewrecords: "+viewrecords+","
                + "\nsortorder: \""+sortorder+"\","
                + "\nediturl:\""+editurl+"\","
                + "\ncaption:\""+caption.replaceAll("'", "\\'")+"\"\n})\n";
        s += ".navGrid('#"+pagername+"',{edit:true,add:true,del:true,view:true},\n{height:250,width:450,reloadAfterSubmit:false,afterSubmit:checkStatus},\n{height:250,width:450,reloadAfterSubmit:false,clearAfterAdd : true,afterSubmit:checkStatus},\n{},\n{multipleSearch:true},\n{}\n);;});";
        s += script+"\n</script>";
        return s;
    }
}
