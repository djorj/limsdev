<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
  InvoicetypeBean[] types = InvoicetypeManager.getInstance().loadByWhere("order by name");
%>
<script>
    $("#invoicedate").datepicker();
    $("#import_inv").change(function () {
        importInv(this);
    });
      
    function importInv(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                if(e.target.result.indexOf("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") < 0)
                    alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("არასწორი ექსელის ფაილი - უნდა იყოს .XLSX")%>','<%=trs.t("დახურვა")%>');
                else
                $.post("content/importinvoice.jsp",{ oper: "import", xls: e.target.result },function(data){
                    if(data.result == 0) {
                        alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                    } else {
                        $("#invoices").trigger("reloadGrid");
                        $.each(BootstrapDialog.dialogs, function(id, dialog){
                            dialog.close();
                        });
                    }
                },"json");
            }

            reader.readAsDataURL(input.files[0]);
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
            <%--
            <tr rowpos="2" class="FormData" id="tr_realamount">
                <td class="CaptionTD"><%=trs.t("ზედნადების ნომერი")%></td>
                <td class="DataTD"><input id="num" name="num" role="textbox" class="FormElement ui-widget-content ui-corner-all" type="text" value=""></td>
            </tr>
            <tr rowpos="2" class="FormData" id="tr_realamount">
                <td class="CaptionTD"><%=trs.t("ზედნადების თარიღი")%></td>
                <td class="DataTD"><input id="invoicedate" name="invoicedate" role="textbox" class="FormElement ui-widget-content ui-corner-all" type="text" value="<%=dt.format(new Date())%>"></td>
            </tr>
            <tr rowpos="2" class="FormData" id="tr_realamount">
                <td class="CaptionTD"><%=trs.t("მომწოდებელი")%></td>
                <td class="DataTD">
                    <input id="contragentname" name="contragentname" role="textbox" class="FormElement ui-widget-content ui-corner-all" type="text" value="">
                </td>
            </tr>
            <tr rowpos="4" class="FormData" id="tr_ownerid">
                <td class="CaptionTD"><%=trs.t("წყარო")%></td>
                <td class="DataTD">
                    <select role="select" class="FormElement ui-widget-content ui-corner-all" style="width: 200px;" id="newinventoryid" name="newinventoryid">
                        <option value="0" role="option">-- <%=trs.t("აირჩიეთ")%> --</option>
                        <%
                        for(int i=0;i<types.length;i++){
                        %>
                        <option value="<%=types[i].getInvoicetypeid()%>" role="option"><%=trs.t(types[i].getName())%></option>
                        <%
                        }
                        %>
                    </select>
                </td>
            </tr>
            --%>
            <tr rowpos="2" class="FormData" id="tr_realamount">
                <td class="DataTD" colspan="2">
                    <label class="btn btn-success pull-right" style="margin-right: 5px;">
                        <i class="fa fa-upload"></i> <%=trs.t("აირჩიეთ ფაილი")%>
                        <input type="file" id="import_inv" class="upload"/>
                    </label>
                </td>
            </tr>
        </tbody>
    </table>
</div>