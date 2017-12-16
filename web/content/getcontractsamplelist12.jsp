<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
JSONArray rows = new JSONArray();
SpeciesBean[] sps = SpeciesManager.getInstance().loadByWhere("order by name");
if (request.getParameter("loadfull")==null)
{
// BOX parent
    
    
    
    ContractsampletypeBean[] list = ContractsampletypeManager.getInstance().loadByWhere("WHERE deleted=false AND isbox=true AND parentid is null AND contractid="+request.getParameter("contractid")+" ORDER BY contractsampletypeid");
    for(int i=0; i<list.length;i++)
    { 
        String spc = "<label class=\"select\"><select class=\"selspicies\" id=\"spc_"+list[i].getContractsampletypeid()+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\">";
        spc += "<option value=''></option>";
        for(int j=0;j<sps.length;j++){
            String sel = "";
            if(list[i].getSpeciesid() != null && sps[j].getSpeciesid().intValue() == list[i].getSpeciesid().intValue())
                sel = "selected";
            spc += "<option value='"+sps[j].getSpeciesid()+"' "+sel+">"+sps[j].getName()+"</option>";
        }
        spc += "</select></label>";
        
        ContractsampleitemBean[] item = ContractsampleitemManager.getInstance().loadByWhere("WHERE deleted=false AND contractsampletypeid="+list[i].getContractsampletypeid()+" ORDER BY contractsampleitemid");
        int count1 = SampleboxreseachManager.getInstance().countWhere(""
                + "WHERE deleted=false "
                + "AND contractsampletypeid IN ("
                +   "SELECT contractsampletypeid "
                +   "FROM contractsampletype "
                +   "WHERE parentid="+list[i].getContractsampletypeid()
                +   ")"
                );
        String parent = ""+list[i].getContractsampletypeid();
        JSONObject ob = new JSONObject();
        ob.put("id",     parent);
        ob.put("sample", trs.t("ყუთი"));
        ob.put("code",   item[0].getContractsampleitemid());
        ob.put("number", "<div class=\"input-group\"><label class=\"input\"><input id=\"boxnum_"+list[i].getContractsampletypeid()+"\" value=\""+list[i].getBoxnum()+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success sampleboxnum\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\" ><i class=\"fa fa-check\"></i></button></div></div>");
        ob.put("speciesid", spc);
        ob.put("animal", "");
        ob.put("count",  "");
        ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+list[i].getContractsampletypeid()+"\">"+count1+"</a>");
        ob.put("act",    ""
                //"<div class=\"btn-group\">"

                //+ "<button class=\"btn btn-primary btn-xs dropdown-toggle\" data-toggle=\"dropdown\" aria-expanded=\"false\">"+trs.t("მოქმედება")+" <span class=\"caret\"></span></button>"
		//+ "<ul class=\"dropdown-menu\" style=\"z-index: 99999\">"
		//+ "<li><a href=\"javascript:void(0);\" class=\"delsample\" data-itemid=\""+list[i].getContractsampletypeid()+"\">"+trs.t("წაშლა")+"</a></li>"
                //+ "<li><a href=\"javascript:void(0);\" class=\"showcode\" data-itemid=\""+item[0].getContractsampleitemid()+"\">"+trs.t("ბეჭდვა")+"</a></li>"
                //+ "<li><a href=\"javascript:void(0);\" class=\"sampletypeinfo\" data-itemid=\""+list[i].getContractsampletypeid()+"\">"+trs.t("შენიშვნა")+"</a></li>"
                //+ "</ul></div>"
                
                + "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button> "
                + "<button class=\"btn btn-sm btn-primary showcode\" type=\"button\" data-original-title=\""+trs.t("ბეჭდვა")+"\" data-itemid=\""+item[0].getContractsampleitemid()+"\"><i class=\"fa fa-print\"></i></button> "
                + "<button class=\"btn btn-sm btn-default sampletypeinfo\" type=\"button\" data-original-title=\""+trs.t("შენიშვნა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-commenting-o\"></i></button>"
                + "");
        ob.put("cbb", "<input type=checkbox class=contactsamplebox data-itemid="+list[i].getContractsampletypeid()+" >");
        ob.put("level", 0);
        ob.put("parent","NULL");
        ob.put("isLeaf", false);
        ob.put("loaded", true);
        ob.put("expanded", true);
        rows.add(ob);
        
//BOX child
        ContractsampletypeBean[] chld = ContractsampletypeManager.getInstance().loadByWhere("WHERE deleted=false AND parentid="+list[i].getContractsampletypeid()+" ORDER BY contractsampletypeid");
        for(int i2=0; i2<chld.length;i2++)
        {
            SampletypeBean smp = SampletypeManager.getInstance().loadByPrimaryKey(chld[i2].getSampletypeid());
            item = ContractsampleitemManager.getInstance().loadByContractsampletypeid(chld[i2].getContractsampletypeid());
            count1 = SampleboxreseachManager.getInstance().countWhere("WHERE deleted=false  AND contractsampletypeid="+chld[i2].getContractsampletypeid());
            String parent1 = ""+chld[i2].getContractsampletypeid();
            
            ob = new JSONObject();
            ob.put("id",    parent1);
            ob.put("sample",trs.t(smp.getName()));
            ob.put("code",  "");
            ob.put("number","");
            ob.put("speciesid", "");
            ob.put("animal","");
            ob.put("count", "<div class=\"input-group\"><label class=\"input\"><input id=\"quantity_"+chld[i2].getContractsampletypeid()+"\" value=\""+(chld[i2].getQuantity()>0 ? chld[i2].getQuantity() : "")+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success samplequantity\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" data-itemid=\""+chld[i2].getContractsampletypeid()+"\"><i class=\"fa fa-check\"></i></button></div></div>");
            ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+list[i].getContractsampletypeid()+"\">"+count1+"</a>");
            ob.put("act",   ""
                + "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+chld[i2].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button> "
                + "<button class=\"btn btn-sm btn-default sampletypeinfo\" type=\"button\" data-original-title=\""+trs.t("შენიშვნა")+"\" data-itemid=\""+chld[i2].getContractsampletypeid()+"\"><i class=\"fa fa-commenting-o\"></i></button>"
                );
            ob.put("cbb", "<input type=checkbox data-itemid=\""+list[i].getContractsampletypeid()+"\" class=contactsampleboxitem value="+chld[i2].getContractsampletypeid()+" >");
            ob.put("level",  1);
            ob.put("parent", parent);
            ob.put("isLeaf", true);
            ob.put("loaded", true);
            ob.put("expanded", true);
            rows.add(ob);
        }
    }


// Normal parent
    list = ContractsampletypeManager.getInstance().loadByWhere("WHERE deleted=false AND isbox=false AND parentid is null AND contractid="+request.getParameter("contractid")+" ORDER BY contractsampletypeid");
    for(int i=0; i<list.length;i++)
    {
        String spc = "<label class=\"select\"><select class=\"selspicies\" id=\"spc_"+list[i].getContractsampletypeid()+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\">";
        spc += "<option value=''></option>";
        for(int j=0;j<sps.length;j++){
            String sel = "";
            if(list[i].getSpeciesid() != null && sps[j].getSpeciesid().intValue() == list[i].getSpeciesid().intValue())
                sel = "selected";
            spc += "<option value='"+sps[j].getSpeciesid()+"' "+sel+">"+sps[j].getName()+"</option>";
        }
        spc += "</select></label>";
        
        SampletypeBean smp = SampletypeManager.getInstance().loadByPrimaryKey(list[i].getSampletypeid());
        ContractsampleitemBean[] item = ContractsampleitemManager.getInstance().loadByWhere("WHERE parentid is null AND deleted=false AND contractsampletypeid="+list[i].getContractsampletypeid()+" ORDER BY contractsampleitemid");
        if (list[i].getQuantity()>1)
        {
            int count1 = SampleitemreseachManager.getInstance().countWhere(""
                + "WHERE deleted=false "
                + "AND contractsampleitemid IN ("
                +   "SELECT contractsampleitemid "
                +   "FROM contractsampleitem,contractsampletype "
                +   "WHERE contractsampleitem.contractsampletypeid=contractsampletype.contractsampletypeid "
                +   "AND contractsampletype.contractsampletypeid="+list[i].getContractsampletypeid()
                +   ")"
                );
            String parent = ""+list[i].getContractsampletypeid();
            JSONObject ob = new JSONObject();
            ob.put("id",    parent);
            ob.put("sample",trs.t(smp.getName()));
            ob.put("code",  "");
            ob.put("number","");
            ob.put("speciesid", spc);
            ob.put("animal","");
            ob.put("count", "<div class=\"input-group\"><label class=\"input\"><input id=\"quantity_"+list[i].getContractsampletypeid()+"\" value=\""+(list[i].getQuantity()>0 ? list[i].getQuantity() : "")+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success samplequantity\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-check\"></i></button></div></div>");
            ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
            ob.put("act",   ""
                + "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button> "
                + "<button class=\"btn btn-sm btn-default sampletypeinfo\" type=\"button\" data-original-title=\""+trs.t("შენიშვნა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-commenting-o\"></i></button>"
                );
            ob.put("cbb", "<input type=checkbox class=contactsampletype data-itemid="+list[i].getContractsampletypeid()+" >");
            ob.put("level", 0);
            ob.put("parent","NULL");
            ob.put("isLeaf", false);
            ob.put("loaded", true);
            ob.put("expanded", true);
            rows.add(ob);
        
            for (int n=0; n<item.length; n++)
            {
                count1 = SampleitemreseachManager.getInstance().countWhere(""
                + "WHERE deleted=false "
                + "AND contractsampleitemid IN ("
                +   "SELECT contractsampleitemid "
                +   "FROM contractsampleitem "
                +   "WHERE parentid="+item[n].getContractsampleitemid()+" OR contractsampleitemid="+item[n].getContractsampleitemid()
                +   ")"
                );
                //count1 = SampleitemreseachManager.getInstance().countWhere("where deleted = false and contractsampleitemid = "+item[n].getContractsampleitemid());
                String act = "<button class=\"btn btn-sm btn-danger delitem\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+item[n].getContractsampleitemid()+"\"><i class=\"fa fa-trash\"></i></button> ";
                if(count1 == 0)  act += "<button class=\"btn btn-sm btn-primary showcode\" type=\"button\" data-itemid=\""+item[n].getContractsampleitemid()+"\" data-original-title=\""+trs.t("ბეჭდვა")+"\"><i class=\"fa fa-print\"></i></button> ";
                act += "<button class=\"btn btn-sm btn-warning banitem\" data-itemid=\""+item[n].getContractsampleitemid()+"\" data-original-title=\""+trs.t("დაწუნება")+"\" type=\"button\"><i class=\"fa fa-ban\"></i></button> ";
                act += "<button class=\"btn btn-sm btn-default sampletypeinfo\" type=\"button\" data-original-title=\""+trs.t("შენიშვნა")+"\" data-itemid=\""+item[n].getContractsampleitemid()+"\"><i class=\"fa fa-commenting-o\"></i></button>";

                ob = new JSONObject();
                ob.put("id",    parent+"_"+n);
                ob.put("sample",trs.t(smp.getName()));
                ob.put("code",  item[n].getContractsampleitemid());
                ob.put("speciesid", spc);
                ob.put("number","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num1_"+item[n].getContractsampleitemid()+"\" value=\""+(item[n].getNum1()!=null ? item[n].getNum1() : "")+"\"></label></div>");
                ob.put("animal","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num2_"+item[n].getContractsampleitemid()+"\" value=\""+(item[n].getNum2()!=null ? item[n].getNum2() : "")+"\"></label></div>");
                ob.put("count", "<div class=\"input-group\"><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success samplenums\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"1\" data-itemid=\""+item[n].getContractsampleitemid()+"\"><i class=\"fa fa-check\"></i></button></div></div>");
                ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
                ob.put("act", act);
                ob.put("cbb", "<input type=checkbox data-itemid=\""+list[i].getContractsampletypeid()+"\" class=contactsampleitem value="+item[n].getContractsampleitemid()+" >");
                ob.put("level", 1);
                ob.put("parent", parent);
                ob.put("isLeaf", true);
                ob.put("loaded", true);
                ob.put("expanded", true);
                rows.add(ob);
            }
        }
        else
        {
            try{
            int count1 = SampleitemreseachManager.getInstance().countWhere(""
                + "WHERE deleted=false "
                + "AND contractsampleitemid IN ("
                +   "SELECT contractsampleitemid "
                +   "FROM contractsampleitem,contractsampletype "
                +   "WHERE contractsampleitem.contractsampletypeid=contractsampletype.contractsampletypeid "
                +   "AND contractsampletype.contractsampletypeid="+list[i].getContractsampletypeid()
                +   ")"
                );
            String act = "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button> ";
            if(count1 == 0)  
                act += "<button class=\"btn btn-sm btn-primary showcode\" type=\"button\" data-itemid=\""+item[0].getContractsampleitemid()+"\" data-original-title=\""+trs.t("ბეჭდვა")+"\"><i class=\"fa fa-print\"></i></button> ";
            act += "<button class=\"btn btn-sm btn-warning banitem\" data-itemid=\""+item[0].getContractsampleitemid()+"\" data-original-title=\""+trs.t("დაწუნება")+"\" type=\"button\"><i class=\"fa fa-ban\"></i></button> ";
            act += "<button class=\"btn btn-sm btn-default sampleiteminfo\" type=\"button\" data-original-title=\""+trs.t("შენიშვნა")+"\" data-itemid=\""+item[0].getContractsampleitemid()+"\"><i class=\"fa fa-commenting-o\"></i></button>";
            JSONObject ob = new JSONObject();
            ob.put("id",    ""+list[i].getContractsampletypeid());
            ob.put("sample",trs.t(smp.getName()));
            ob.put("code",  item[0].getContractsampleitemid());
            ob.put("speciesid", spc);
            ob.put("number","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num1_"+item[0].getContractsampleitemid()+"\" value=\""+(item[0].getNum1()!=null ? item[0].getNum1() : "")+"\"></label></div>");
            ob.put("animal","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num2_"+item[0].getContractsampleitemid()+"\" value=\""+(item[0].getNum2()!=null ? item[0].getNum2() : "")+"\"></label></div>");
            ob.put("count", "<div class=\"input-group\"><label class=\"input\"><input id=\"qnt_"+item[0].getContractsampleitemid()+"\" value=\""+(list[i].getQuantity()>0 ? list[i].getQuantity() : "")+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success updsample\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" data-itemid=\""+item[0].getContractsampleitemid()+"\"><i class=\"fa fa-check\"></i></button></div></div>");
            ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
            ob.put("act",   act);
            ob.put("cbb", "<input type=checkbox class=contactsampleitem value="+item[0].getContractsampleitemid()+" >");
            ob.put("level", 0);
            ob.put("parent","NULL");
            ob.put("isLeaf", true);
            ob.put("loaded", true);
            ob.put("expanded", true);
            rows.add(ob);
            }catch(Exception iiii){
                System.out.println("list[i].getContractsampletypeid()="+list[i].getContractsampletypeid());
            }
        }
    }
}
else
{
    ContractsampletypeBean[] list = ContractsampletypeManager.getInstance().loadByWhere("WHERE deleted<>true AND isbox=true AND parentid is null AND contractid="+request.getParameter("contractid"));
    for(int i=0; i<list.length;i++)
    { 
        String spc = "<label class=\"select\"><select class=\"selspicies\" id=\"spc_"+list[i].getContractsampletypeid()+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\">";
        spc += "<option value=''></option>";
        for(int j=0;j<sps.length;j++){
            String sel = "";
            if(list[i].getSpeciesid() != null && sps[j].getSpeciesid().intValue() == list[i].getSpeciesid().intValue())
                sel = "selected";
            spc += "<option value='"+sps[j].getSpeciesid()+"' "+sel+">"+sps[j].getName()+"</option>";
        }
        spc += "</select></label>";
        
        ContractsampleitemBean[] item = ContractsampleitemManager.getInstance().loadByContractsampletypeid(list[i].getContractsampletypeid());
        int count1 = SampleitemreseachManager.getInstance().countWhere("where deleted = false and contractsampleitemid = "+item[0].getContractsampleitemid());
        String parent = ""+list[i].getContractsampletypeid();
        JSONObject ob = new JSONObject();
        ob.put("id",    parent);
        ob.put("sample",trs.t("ყუთი")+" #"+list[i].getBoxnum());
        ob.put("code",  "");
        ob.put("speciesid", spc);
        ob.put("number","");
        ob.put("animal","");
        ob.put("count", "");
        ob.put("count1",  count1);
        ob.put("act",   "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button>");
        ob.put("cbb", "");
        ob.put("level", 0);
        ob.put("parent","NULL");
        ob.put("isLeaf", false);
        ob.put("loaded", true);
        ob.put("expanded", true);
        rows.add(ob);

        ContractsampletypeBean[] chld = ContractsampletypeManager.getInstance().loadByParentid(list[i].getContractsampletypeid());
        for(int i2=0; i2<chld.length;i2++)
        {
            SampletypeBean smp = SampletypeManager.getInstance().loadByPrimaryKey(chld[i2].getSampletypeid());
            item = ContractsampleitemManager.getInstance().loadByContractsampletypeid(chld[i2].getContractsampletypeid());
            count1 = SampleitemreseachManager.getInstance().countWhere("where deleted = false and contractsampleitemid = "+item[0].getContractsampleitemid());
            String parent1 = ""+chld[i2].getContractsampletypeid();
            if (chld[i2].getQuantity()>1)
            {
                ob = new JSONObject();
                ob.put("id",    parent1);
                ob.put("sample",trs.t(smp.getName()));
                ob.put("code",  "");
                ob.put("number","");
                ob.put("animal","");
                ob.put("speciesid", "");
                //ob.put("count", "<div class=\"input-group\"><label class=\"input\"><input id=\"quantity_"+chld[i2].getContractsampletypeid()+"\" value=\""+(chld[i2].getQuantity()>0 ? chld[i2].getQuantity() : "")+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" onclick=\"updSampleQuantity("+chld[i2].getContractsampletypeid()+"); return false;\"><i class=\"fa fa-check\"></i></button></div></div>");
                ob.put("count", "<div class=\"input-group\"><label class=\"input\"><input id=\"quantity_"+list[i].getContractsampletypeid()+"\" value=\""+(list[i].getQuantity()>0 ? list[i].getQuantity() : "")+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success samplequantity\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-check\"></i></button></div></div>");
                ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
                ob.put("act",   "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+chld[i2].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button>");
                ob.put("cbb", "");
                ob.put("level",  1);
                ob.put("parent", parent);
                ob.put("isLeaf", false);
                ob.put("loaded", true);
                ob.put("expanded", true);
                rows.add(ob);
        
                for (int n=0; n<item.length; n++)
                {
                    count1 = SampleitemreseachManager.getInstance().countWhere("where deleted = false and contractsampleitemid = "+item[n].getContractsampleitemid());
                    String act = "<button class=\"btn btn-sm btn-danger delitem\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+item[n].getContractsampleitemid()+"\"><i class=\"fa fa-trash\"></i></button>";
                    if(count1 == 0)  act += "<button class=\"btn btn-sm btn-primary showcode\" type=\"button\" data-itemid=\""+item[n].getContractsampleitemid()+"\" data-original-title=\""+trs.t("ბეჭდვა")+"\"><i class=\"fa fa-print\"></i></button>";
                    act += "<button class=\"btn btn-sm btn-warning banitem\" data-itemid=\""+item[n].getContractsampleitemid()+"\" data-original-title=\""+trs.t("დაწუნება")+"\" type=\"button\"><i class=\"fa fa-ban\"></i></button>";
                    ob = new JSONObject();
                    ob.put("id",    parent1+"_"+n);
                    ob.put("sample",trs.t(smp.getName()));
                    ob.put("code",  item[n].getContractsampleitemid());
                    ob.put("speciesid", "");
                    ob.put("number","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num1_"+item[n].getContractsampleitemid()+"\" value=\""+(item[n].getNum1()!=null ? item[n].getNum1() : "")+"\"></label></div>");
                    ob.put("animal","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num2_"+item[n].getContractsampleitemid()+"\" value=\""+(item[n].getNum2()!=null ? item[n].getNum2() : "")+"\"></label></div>");
                    ob.put("count", "<div class=\"input-group\"><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" onclick=\"updSampleNums("+item[n].getContractsampleitemid()+"); return false;\"><i class=\"fa fa-check\"></i></button></div></div>");
                    ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
                    ob.put("act",   act);
                    ob.put("cbb", "<input type=checkbox class=contactsampleitem value="+item[n].getContractsampleitemid()+" >");
                    ob.put("level", 2);
                    ob.put("parent", parent1);
                    ob.put("isLeaf", true);
                    ob.put("loaded", true);
                    ob.put("expanded", true);
                    rows.add(ob);
                }
            }
            else
            {
                String act = "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+chld[i2].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button>";
                if(count1 == 0)  act += "<button class=\"btn btn-sm btn-primary showcode\" type=\"button\" data-itemid=\""+item[0].getContractsampleitemid()+"\" data-original-title=\""+trs.t("ბეჭდვა")+"\"><i class=\"fa fa-print\"></i></button>";
                act += "<button class=\"btn btn-sm btn-warning banitem\" data-itemid=\""+item[0].getContractsampleitemid()+"\" data-original-title=\""+trs.t("დაწუნება")+"\" type=\"button\"><i class=\"fa fa-ban\"></i></button>";
                ob = new JSONObject();
                ob.put("id",    parent1);
                ob.put("sample",trs.t(smp.getName()));
                ob.put("code",  item[0].getContractsampleitemid());
                ob.put("speciesid", "");
                ob.put("number","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num1_"+item[0].getContractsampleitemid()+"\" value=\""+(item[0].getNum1()!=null ? item[0].getNum1() : "")+"\"></label></div>");
                ob.put("animal","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num2_"+item[0].getContractsampleitemid()+"\" value=\""+(item[0].getNum2()!=null ? item[0].getNum2() : "")+"\"></label></div>");
                ob.put("count", "<div class=\"input-group\"><label class=\"input\"><input id=\"quantity_"+item[0].getContractsampleitemid()+"\" value=\""+(chld[i2].getQuantity()>0 ? chld[i2].getQuantity() : "")+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" onclick=\"updSample("+item[0].getContractsampleitemid()+"); return false;\"><i class=\"fa fa-check\"></i></button></div></div>");
                ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
                ob.put("act",   act);
                ob.put("cbb", "<input type=checkbox class=contactsampleitem value="+item[0].getContractsampleitemid()+" >");
                ob.put("level",  1);
                ob.put("parent", parent);
                ob.put("isLeaf", true);
                ob.put("loaded", true);
                ob.put("expanded", true);
                rows.add(ob);
            }
        }
    }

    list = ContractsampletypeManager.getInstance().loadByWhere("WHERE deleted<>true AND isbox=false AND contractid="+request.getParameter("contractid")+" ORDER BY contractsampletypeid");
    for(int i=0; i<list.length;i++)
    {
        String spc = "<label class=\"select\"><select class=\"selspicies\" id=\"spc_"+list[i].getContractsampletypeid()+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\">";
        spc += "<option value=''></option>";
        for(int j=0;j<sps.length;j++){
            String sel = "";
            if(list[i].getSpeciesid() != null && sps[j].getSpeciesid().intValue() == list[i].getSpeciesid().intValue())
                sel = "selected";
            spc += "<option value='"+sps[j].getSpeciesid()+"' "+sel+">"+sps[j].getName()+"</option>";
        }
        spc += "</select></label>";
        
        SampletypeBean smp = SampletypeManager.getInstance().loadByPrimaryKey(list[i].getSampletypeid());
//      ContractsampleitemBean[] item = ContractsampleitemManager.getInstance().loadByContractsampletypeid(list[i].getContractsampletypeid());
        ContractsampleitemBean[] item = ContractsampleitemManager.getInstance().loadByWhere("WHERE deleted<>true AND contractsampletypeid="+list[i].getContractsampletypeid()+" ORDER BY contractsampleitemid");
        int count1 = SampleitemreseachManager.getInstance().countWhere("where deleted = false and contractsampleitemid = "+item[0].getContractsampleitemid());
        if (list[i].getQuantity()>1)
        {
            String parent = ""+list[i].getContractsampletypeid();
            JSONObject ob = new JSONObject();
            ob.put("id",    parent);
            ob.put("sample",trs.t(smp.getName()));
            ob.put("speciesid", spc);
            ob.put("code",  "");
            ob.put("number","");
            ob.put("animal","");
            ob.put("count", "<div class=\"input-group\"><label class=\"input\"><input id=\"quantity_"+list[i].getContractsampletypeid()+"\" value=\""+(list[i].getQuantity()>0 ? list[i].getQuantity() : "")+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" onclick=\"updSampleQuantity("+list[i].getContractsampletypeid()+"); return false;\"><i class=\"fa fa-check\"></i></button></div></div>");
            ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
            ob.put("act",   "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button>");
            ob.put("cbb", "");
            ob.put("level", 0);
            ob.put("parent","NULL");
            ob.put("isLeaf", false);
            ob.put("loaded", true);
            ob.put("expanded", true);
            rows.add(ob);
        
            for (int n=0; n<item.length; n++)
            {
                count1 = SampleitemreseachManager.getInstance().countWhere("where deleted = false and contractsampleitemid = "+item[n].getContractsampleitemid());
                String act = "<button class=\"btn btn-sm btn-danger delitem\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+item[n].getContractsampleitemid()+"\"><i class=\"fa fa-trash\"></i></button>";
                if(count1 == 0)  act += "<button class=\"btn btn-sm btn-primary showcode\" type=\"button\" data-itemid=\""+item[n].getContractsampleitemid()+"\" data-original-title=\""+trs.t("ბეჭდვა")+"\"><i class=\"fa fa-print\"></i></button>";
                act += "<button class=\"btn btn-sm btn-warning banitem\" data-itemid=\""+item[n].getContractsampleitemid()+"\" data-original-title=\""+trs.t("დაწუნება")+"\" type=\"button\"><i class=\"fa fa-ban\"></i></button>";
                ob = new JSONObject();
                ob.put("id",    parent+"_"+n);
                ob.put("sample",trs.t(smp.getName()));
                ob.put("code",  item[n].getContractsampleitemid());
                ob.put("speciesid", "");
                ob.put("number","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num1_"+item[n].getContractsampleitemid()+"\" value=\""+(item[n].getNum1()!=null ? item[n].getNum1() : "")+"\"></label></div>");
                ob.put("animal","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num2_"+item[n].getContractsampleitemid()+"\" value=\""+(item[n].getNum2()!=null ? item[n].getNum2() : "")+"\"></label></div>");
                ob.put("count", "<div class=\"input-group\"><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" onclick=\"updSampleNums("+item[n].getContractsampleitemid()+"); return false;\"><i class=\"fa fa-check\"></i></button></div></div>");
                ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
                ob.put("act",   act);
                ob.put("cbb", "<input type=checkbox class=contactsampleitem value="+item[n].getContractsampleitemid()+" >");
                ob.put("level", 1);
                ob.put("parent", parent);
                ob.put("isLeaf", true);
                ob.put("loaded", true);
                ob.put("expanded", true);
                rows.add(ob);
            }
        }
        else
        {
            String act = "<button class=\"btn btn-sm btn-danger delsample\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\" data-itemid=\""+list[i].getContractsampletypeid()+"\"><i class=\"fa fa-trash\"></i></button> ";
            if(count1 == 0)  act += "<button class=\"btn btn-sm btn-primary showcode\" type=\"button\" data-itemid=\""+item[0].getContractsampleitemid()+"\" data-original-title=\""+trs.t("ბეჭდვა")+"\"><i class=\"fa fa-print\"></i></button> ";
            act += "<button class=\"btn btn-sm btn-warning banitem\" data-itemid=\""+item[0].getContractsampleitemid()+"\" data-original-title=\""+trs.t("დაწუნება")+"\" type=\"button\"><i class=\"fa fa-ban\"></i></button>";
            JSONObject ob = new JSONObject();
            ob.put("id",    ""+list[i].getContractsampletypeid());
            ob.put("sample",trs.t(smp.getName()));
            ob.put("code",  item[0].getContractsampleitemid());
            ob.put("speciesid", spc);
            ob.put("number","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num1_"+item[0].getContractsampleitemid()+"\" value=\""+(item[0].getNum1()!=null ? item[0].getNum1() : "")+"\"></label></div>");
            ob.put("animal","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num2_"+item[0].getContractsampleitemid()+"\" value=\""+(item[0].getNum2()!=null ? item[0].getNum2() : "")+"\"></label></div>");
            ob.put("count", "<div class=\"input-group\"><label class=\"input\"><input id=\"quantity_"+item[0].getContractsampleitemid()+"\" value=\""+(list[i].getQuantity()>0 ? list[i].getQuantity() : "")+"\"></label><div class=\"input-group-btn\"><button class=\"btn btn-sm btn-success\" type=\"button\" data-original-title=\""+trs.t("შენახვა")+"\" onclick=\"updSample("+item[0].getContractsampleitemid()+"); return false;\"><i class=\"fa fa-check\"></i></button></div></div>");
            ob.put("count1",  "<a class=\"labtestcount\" data-itemid=\""+smp.getSampletypeid()+"\">"+count1+"</a>");
            ob.put("act",   act);
            ob.put("cbb", "<input type=checkbox class=contactsampleitem value="+item[0].getContractsampleitemid()+" >");
            ob.put("level", 0);
            ob.put("parent","NULL");
            ob.put("isLeaf", true);
            ob.put("loaded", true);
            ob.put("expanded", true);
            rows.add(ob);
        }
    }
}
//System.out.println(rows.toString());
out.print(rows.toString());
out.flush();
%>
