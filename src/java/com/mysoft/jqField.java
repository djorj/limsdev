/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft;

/**
 *
 * @author djorj
 */
public class jqField {
    private String[] types = {"INTEGER","DOUBLE","DATE","TIME","DATETIME","BOOLEAN","LIST","TEXT","TEXTAREA","ID"};
    private boolean editable, hidden, sortable, search, title, viewable, required;
    private String name, index, sname, label, align, classes, defval, editoptions, editrules, edittype, searchoptions, stype, surl;
    private double width;
    private int type;
    private String script;
    private String[] selectNames, selectIds;
    
    public void setType(String stype,boolean required){
        this.required = required;
        for(int i=0;i<types.length;i++){
            if(stype.equals(types[i])){
                type = i;
                break;
            }
        }
    }
    
    public void jqField(String stype,boolean required)
    {
        setType(stype,required);
        editable = true;
        hidden = true;
        sortable = true;
        search = true;
        title = true;
        viewable = true;
        if(types[type].equals("INTEGER")){
            align = "right";
            edittype = "text";
            editoptions = "{size: 10, maxlength: 10}";
            editrules = "{integer: true,";
            if(this.required)   editrules += "required:true";
            editrules += "}";
            searchoptions = "{attr: { size: 10, maxlengh: 10 }, sopt:['eq','ne','lt','le','gt','ge']}";
            stype = "text";
        } else if(types[type].equals("DOUBLE")){
            align = "right";
            edittype = "text";
            editoptions = "{size: 15, maxlength: 15}";
            editrules = "{number: true,";
            if(this.required)   editrules += "required:true";
            editrules += "}";
            searchoptions = "{attr: { size: 15, maxlengh: 15 }, sopt:['eq','ne','lt','le','gt','ge']}";
            stype = "text";
        } else if(types[type].equals("DATE")){
            align = "center";
            edittype = "text";
            editoptions = "{size: 10, maxlength: 10, dataInit: function(element) {$(element).datepicker({dateFormat: 'dd/mm/yy'})}}";
            editrules = "{date: true,";
            if(this.required)   editrules += "required:true";
            editrules += "}";
            searchoptions = "{attr: { size: 10, maxlengh: 10 }, dataInit: function(element) {$(element).datepicker({dateFormat: 'dd/mm/yy'})}, sopt:['eq','ne','lt','le','gt','ge']}";
            stype = "text";
        } else if(types[type].equals("TIME")){
            align = "center";
            edittype = "text";
            editoptions = "{size: 5, maxlength: 5}";
            editrules = "{time: true,";
            if(this.required)   editrules += "required:true";
            editrules += "}";
            searchoptions = "{attr: { size: 5, maxlengh: 5 } sopt:['eq','ne','lt','le','gt','ge']}";
            stype = "text";
        } else if(types[type].equals("DATETIME")){
            
        } else if(types[type].equals("BOOLEAN")){
            align = "center";
            edittype = "checkbox";
            editoptions = "{value:\"Yes:No\"}";
            searchoptions = "{sopt:['eq','ne'], value: \"1:Yes;0:No\" }";
            stype = "select";
        } else if(types[type].equals("LIST")){
            String editselect = "";
            String editsearch = "<select>";
            for(int i=0;i<selectNames.length;i++){
                if(i>0) editselect  += ";";
                editselect += selectIds[i]+":"+selectNames[i].replaceAll("\\\"", "\\\\\"").replaceAll("\\\"", "\\\\\"");
                editsearch += "<option value=\""+selectIds[i]+"\">"+selectNames[i].replaceAll("\\\"", "\\\\\"")+"</option>";
            }
            editsearch += "</select>";
            align = "left";
            edittype = "select";
            editoptions = "{value:\""+editselect+"\"},";
            searchoptions = "{dataUrl:'content/getsels.jsp',buildSelect: getSearch"+name+", sopt:['eq','ne'] }";
            stype = "select";
            if(script == null)  script = "";
            script += "\ngetSearch"+name+" = function(){return '"+editsearch+"';}\n";
        } else if(types[type].equals("TEXT")){
            align = "left";
            edittype = "text";
            editoptions = "{size: 30}";
            editrules = "{";
            if(this.required)   editrules += "required:true";
            editrules += "}";
            searchoptions = "{attr: { size: 30 }, sopt:['eq','ne','lt','le','gt','ge','bw','bn','in','ni','ew','en','cn','nc'] }";
            stype = "text";
        } else if(types[type].equals("TEXTAREA")){
            align = "left";
            edittype = "textarea";
            editoptions = "{cols: 30, rows: 3}";
            editrules = "{";
            if(this.required)   editrules += "required:true";
            editrules += "}";
            searchoptions = "{attr: { size: 30 }, sopt:['eq','ne','lt','le','gt','ge','bw','bn','in','ni','ew','en','cn','nc'] }";
            stype = "text";
        } else if(types[type].equals("ID")){
            align = "right";
            editable = false;
            hidden = false;
            sortable = false;
            search = false;
            title = false;
            viewable = false;
        }
    }

    public String getAlign() {
        return align;
    }

    public void setAlign(String align) {
        this.align = align;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public String getDefval() {
        return defval;
    }

    public void setDefval(String defval) {
        this.defval = defval;
    }

    public boolean isEditable() {
        return editable;
    }

    public void setEditable(boolean editable) {
        this.editable = editable;
    }

    public String getEditoptions() {
        return editoptions;
    }

    public void setEditoptions(String editoptions) {
        this.editoptions = editoptions;
    }

    public String getEditrules() {
        return editrules;
    }

    public void setEditrules(String editrules) {
        this.editrules = editrules;
    }

    public String getEdittype() {
        return edittype;
    }

    public void setEdittype(String edittype) {
        this.edittype = edittype;
    }

    public boolean isHidden() {
        return hidden;
    }

    public void setHidden(boolean hidden) {
        this.hidden = hidden;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isSearch() {
        return search;
    }

    public void setSearch(boolean search) {
        this.search = search;
    }

    public String getSearchoptions() {
        return searchoptions;
    }

    public void setSearchoptions(String searchoptions) {
        this.searchoptions = searchoptions;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public boolean isSortable() {
        return sortable;
    }

    public void setSortable(boolean sortable) {
        this.sortable = sortable;
    }

    public String getStype() {
        return stype;
    }

    public void setStype(String stype) {
        this.stype = stype;
    }

    public String getSurl() {
        return surl;
    }

    public void setSurl(String surl) {
        this.surl = surl;
    }

    public boolean isTitle() {
        return title;
    }

    public void setTitle(boolean title) {
        this.title = title;
    }

    public boolean isViewable() {
        return viewable;
    }

    public void setViewable(boolean viewable) {
        this.viewable = viewable;
    }

    public double getWidth() {
        return width;
    }

    public void setWidth(double width) {
        this.width = width;
    }

    public boolean isRequired() {
        return required;
    }

    public void setRequired(boolean required) {
        this.required = required;
    }

    public String getScript() {
        return script;
    }

    public void setScript(String script) {
        this.script = script;
    }

    public String[] getSelectIds() {
        return selectIds;
    }

    public void setSelectIds(String[] selectIds) {
        this.selectIds = selectIds;
    }

    public String[] getSelectNames() {
        return selectNames;
    }

    public void setSelectNames(String[] selectNames) {
        this.selectNames = selectNames;
    }
    
    
    
    public String getColModel(){
        String model = "";
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += " name: '"+name.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "index: '"+index.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "label: '"+label.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "editable: "+editable;
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "align: '"+name.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "classes: '"+classes.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "defval: '"+defval.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "editoptions: '"+editoptions.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "hidden: "+hidden;
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "sortable: "+hidden;
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "search: "+search;
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "searchoptions: '"+searchoptions.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "stype: '"+stype.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "surl: '"+surl.replaceAll("'", "\\'").replaceAll("\n", "\\n")+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "title: "+title;
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "width: '"+width+"'";
        }
        if(name != null && name.trim().length() > 0){
            if(model.length() > 0)  model += ", ";
            model += "viewable: "+viewable;
        }

        model = "{"+model+"}";
        return model;
    }
}
