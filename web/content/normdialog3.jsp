<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%-- restypeid = 3 ტექსტი --%>
<%
LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
LabtestanswerBean[] ans = LabtestanswerManager.getInstance().loadByWhere("where labtestid = "+labtest.getLabtestid()+" order by val");
String normtxt = "";
boolean freetext = true;
if(ans.length > 0)  freetext = false;
if(freetext && labtest.getTnorm() != null)
    normtxt = labtest.getTnorm();
JSONArray v = new JSONArray();
for(int i=0;i<ans.length;i++){
    JSONObject ob = new JSONObject();
    ob.put("name",ans[i].getVal());
    ob.put("checked",(ans[i].getNorm().booleanValue()) ? "checked":"");
    v.add(ob);
}
session.setAttribute("NORMTXT", (JSONArray)v);
%>
<script>
    function addNorm(){
        $.post("content/addtextnorm.jsp",{ add: $("#normname").val() },function(data){ $("#normlist").html(data); $("#normname").val(""); });
    }
    
    function delNorm(n){
        $.post("content/addtextnorm.jsp",{ del: n },function(data){ $("#normlist").html(data); });
    }
    
    function setNorm(n){
        $.post("content/addtextnorm.jsp",{ norm: n },function(data){ $("#normlist").html(data); });
    }
    
    <%if(freetext){%>
        $("#listsect").hide();
        $("#freetextsect").show();
    <%}else{%>
        $.post("content/addtextnorm.jsp",{  },function(data){ $("#normlist").html(data); });
        $("#listsect").show();
        $("#freetextsect").hide();
    <%}%>
    
    $("#txtfreetext").on("click",function(){
        $("#freetextsect").show();
        $("#listsect").hide();
    });
    
    $("#txtlist").on("click",function(){
        $("#listsect").show();
        $("#freetextsect").hide();
    });
    
</script>
<div class="widget-body padding-10">
    <form action="" id="checkout-form" class="smart-form" novalidate="novalidate">
        <fieldset>
            <section>
                <div class="inline-group">
                    <label class="radio">
                        <input name="texttype" id="txtfreetext" <%=(freetext) ? "checked":""%> type="radio" value="1"><i></i><%=trs.t("ნორმატივის ტექსტი")%>
                    </label>
                    <label class="radio">
                        <input name="texttype" id="txtlist" <%=(freetext) ? "":"checked"%> type="radio" value="2"><i></i><%=trs.t("შესაძლო პასუხების და ნორმატივების სია")%>
                    </label>
                </div>
            </section>
        </fieldset>
        <fieldset>
            <section id="freetextsect">
                <label class="textarea"> 										
                    <textarea rows="3" name="freetextnorm" id="freetextnorm" placeholder="ნორმატივი"><%=normtxt%></textarea> 
                </label>
            </section>
            <section id="listsect">
                <div class="table-responsive">
                    <label class="input"> <i class="icon-append fa fa-plus" style="cursor: pointer; color: #739E73;" onclick="addNorm()"></i>
                        <input name="normname" id="normname" placeholder="<%=trs.t("დასახელება")%>" type="text">
                    </label>
                    <div id="normlist"></div>
		</div>
            </section>
        </fieldset>
    </form>
</div>