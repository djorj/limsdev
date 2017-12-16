<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
  InventoryitemBean item = InventoryitemManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
  InventoryBean inventory = InventoryManager.getInstance().loadByPrimaryKey(item.getInventoryid());
  InventoryBean[] inv = InventoryManager.getInstance().loadByWhere("where enddate is null and institutionid <> "+inventory.getInstitutionid());
  String bcode = "";
  ProductBean product = ProductManager.getInstance().loadByPrimaryKey(item.getProductid());
  if(product.getCode() != null)
    bcode = product.getCode();
%>
<script>
    function getPers(){
        var id = $("#newinventoryid").val();
        if(id > 0){
            $.post("content/gettypes.jsp?edit=1&objname=Personell&cols=Personellid&cols=Fname&cols=Lname&where=where institutionid = "+id,{},function(data){
                $("#newownerid").html(data);
            },"html");
        } else {
            $("#newownerid").html("");
        }
    }
</script>
<div class="smart-form ui-jqdialog-content ui-widget-content">
    <table id="TblGrid_inventoryitem" class="EditTable" cellspacing="0" cellpadding="0" border="0">
        <tbody>
            <tr id="FormError" style="display:none">
                <td class="ui-state-error" id="errormsg" colspan="2"></td>
            </tr>
            <tr style="display:none" class="tinfo">
                <td class="topinfo" colspan="2"></td>
            </tr>
            <tr rowpos="4" class="FormData" id="tr_ownerid">
                <td class="CaptionTD"><%=trs.t("განყოფილება (ღია აღწერა)")%></td>
                <td class="DataTD">
                    <select role="select" class="FormElement ui-widget-content ui-corner-all" style="width: 200px;" id="newinventoryid" name="newinventoryid" onchange="getPers()">
                        <option value="0" role="option">-- <%=trs.t("აირჩიეთ")%> --</option>
                        <%
                        for(int i=0;i<inv.length;i++){
                            InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(inv[i].getInstitutionid());
                        %>
                        <option value="<%=inv[i].getInventoryid()%>" role="option"><%=dt.format(inv[i].getStartdate())%> <%=getFullLabName(inst,"->")%></option>
                        <%
                        }
                        %>
                    </select>
                </td>
            </tr>
            <tr rowpos="2" class="FormData" id="tr_realamount">
                <td class="CaptionTD"><%=trs.t("აღწერილი")%></td>
                <td class="DataTD"><input id="newrealamount" name="newrealamount" role="textbox" class="FormElement ui-widget-content ui-corner-all" type="text" value="1"></td>
            </tr>
            <tr rowpos="3" class="FormData" id="tr_room">
                <td class="CaptionTD"><%=trs.t("ოთახი")%></td>
                <td class="DataTD"><input id="newroom" name="newroom" role="textbox" class="FormElement ui-widget-content ui-corner-all" type="text"></td>
            </tr>
            <tr rowpos="4" class="FormData" id="tr_ownerid">
                <td class="CaptionTD"><%=trs.t("მფლობელი")%></td>
                <td class="DataTD">
                    <select role="select" class="FormElement ui-widget-content ui-corner-all" style="width: 200px;" id="newownerid" name="newownerid">
                        
                    </select>
                </td>
            </tr>
            <tr rowpos="5" class="FormData" id="tr_note">
                <td class="CaptionTD"><%=trs.t("შენიშვნა")%></td>
                <td class="DataTD"><input id="newnote" name="newnote" role="textbox" class="FormElement ui-widget-content ui-corner-all" type="text"></td>
            </tr>
            <tr rowpos="11" class="FormData" id="tr_barcode">
                <td class="CaptionTD"><%=trs.t("ბარკოდი")%></td>
                <td class="DataTD"><input id="newbarcode" name="newbarcode" role="textbox" class="FormElement ui-widget-content ui-corner-all" type="text" value="<%=bcode%>"></td>
            </tr>
        </tbody>
    </table>
</div>