<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="org.krysalis.barcode4j.*" %>
<%
JSONObject obj = getFromFile(basedir + "json/barcodes.json");
double barheight = obj.getDouble("barheight");
double width = obj.getDouble("width");
double height = obj.getDouble("height");
int fontsize = obj.getInt("fontsize");
String units = obj.getString("units");
ConfBean[] conf = ConfManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" and upper(name) = 'BARCODE'");
if(conf.length > 0){
    JSONObject obj1 = JSONObject.fromObject(conf[0].getVal());
    try{
        barheight = obj1.getDouble("barheight");
        width = obj1.getDouble("width");
        height = obj1.getDouble("height");
        fontsize = obj1.getInt("fontsize");
        units = obj1.getString("units");
    }catch(Exception ign){
        barheight = obj.getDouble("barheight");
        width = obj.getDouble("width");
        height = obj.getDouble("height");
        fontsize = obj.getInt("fontsize");
        units = obj.getString("units");
    }
}


%>
<script>
    function getBcode(save){
        var units = $("input[name='units']:checked"). val();
        $.post("content/getbarcode.jsp",{ 
            barheight: $("#barheight").val(),
            height: $("#height").val(),
            width: $("#width").val(),
            fontsize: $("#fontsize").val(),
            units: units,
            msg: $("#msg").val(),
            lmsg: $("#lmsg").val(),
            rmsg: $("#rmsg").val(),
            save: save
        },function(data){
            $("#bcodesample").attr("src",data.src);
        },"json");
    }
    
    function chUnits(units){
        var koeff = 25.4;
        var n = 0;
        if(units == "inch"){
            koeff = 1/25.5;
            n = 1;
        }
        var height = Number($("#height").val())*koeff;
        var width = Number($("#width").val())*koeff;
        $("#height").val(height.toFixed(n));
        $("#width").val(width.toFixed(n));
    }
    
    getBcode(0);
    
    
    
    <%--if(n.length() > 0){%>
        $("#bcodetype").val('<%=n%>');
        $.post("content/getbarcode.jsp",{ 
            n: $("#bcodetype").val()
        },function(data){
            $("#bcodesample").attr("src",data.src);
            //$("#bcresult").show();
            $("#codedata").html(data.codedata);
            $("#btitle").html(data.title);
            //$("#bcodesample").resizable();
        },"json");
    <%}--%>
    
</script>
<div class="smart-form" style='height: calc(100vh - 170px);'>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <h2>Code 128</h2>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6" id='codedata'>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class='col col-sm-4'>
                    <%=trs.t("ერთეული")%>
                </div>
                <div class='col col-sm-8'>
                    <div class="inline-group">
                        <label class="radio">
                            <input name="units" <%=(units.equalsIgnoreCase("inch")) ? "checked":""%> type="radio" value="inch" onclick="chUnits('inch')">
                            <i></i><%=trs.t("დუიმი")%>
                        </label>
                        <label class="radio">
                            <input name="units" <%=(units.equalsIgnoreCase("mm")) ? "checked":""%> type="radio" value="mm" onclick="chUnits('mm')">
                            <i></i><%=trs.t("მილიმეტრი")%>
                        </label>
                    </div>
                </div>
            </div>            
            <div class="row" style="margin-bottom: 5px !important;">
                <div class='col col-sm-4'>
                    <%=trs.t("ბარკოდის სიმაღლე")%>
                </div>
                <div class='col col-sm-8'>
                    <label class='input'> <i class='icon-append fa fa-barcode'></i>
                    <input id='barheight' placeholder='<%=trs.t("ბარკოდის სიმაღლე")%>' type='number' step='1' value='<%=barheight%>'>
                    <b class='tooltip tooltip-bottom-right'><i class='fa fa-text-barcode txt-color-teal'></i> <%=trs.t("ბარკოდის სიმაღლე")%></b>
                    </label>
                </div>
            </div>            
            <div class="row" style="margin-bottom: 5px !important;">
                <div class='col col-sm-4'>
                    <%=trs.t("ეტიკეტის ზომები")%>
                </div>
                <div class='col col-sm-3'>
                    <label class='input'> <i class='icon-append fa fa-text-width'></i>
                    <input id='width' placeholder='<%=trs.t("ეტიკეტის სიგანე")%>' type='number' step='0.1' value='<%=width%>'>
                    <b class='tooltip tooltip-bottom-right'><i class='fa fa-text-width txt-color-teal'></i> <%=trs.t("ეტიკეტის სიგანე")%></b>
                    </label>
                </div>
                <div class='col col-sm-2 text-align-center'>
                    <i class='fa fa-times fa-2x'></i>
                </div>
                <div class='col col-sm-3'>
                    <label class='input'> <i class='icon-append fa fa-text-height'></i>
                    <input id='height' placeholder='<%=trs.t("ეტიკეტის სიმაღლე")%>' type='number' step='0.1' value='<%=height%>'>
                    <b class='tooltip tooltip-bottom-right'><i class='fa fa-text-height txt-color-teal'></i> <%=trs.t("ეტიკეტის სიმაღლე")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class='col col-sm-4'>
                    <%=trs.t("ფონტის ზომა")%>
                </div>
                <div class='col col-sm-8'>
                    <label class='input'> <i class='icon-append fa fa-font'></i>
                    <input id='fontsize' placeholder='<%=trs.t("ფონტის ზომა")%>' type='number' step='1' value='<%=fontsize%>'>
                    <b class='tooltip tooltip-bottom-right'><i class='fa fa-fornt txt-color-teal'></i> <%=trs.t("ფონტის ზომა")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class='col col-sm-4'>
                    <%=trs.t("ზედა ტექსტი")%>
                </div>
                <div class='col col-sm-4'>
                    <label class='input'> <i class='icon-append fa'>T</i>
                    <input id='lmsg' placeholder='<%=trs.t("მარცხენა ტექსტი")%>' type='text' value='123456'>
                    <b class='tooltip tooltip-bottom-right'><i class='fa txt-color-teal'>T</i> <%=trs.t("მარცხენა ტექსტი")%></b>
                    </label>
                </div>
                <div class='col col-sm-4'>
                    <label class='input'> <i class='icon-append fa'>T</i>
                    <input id='rmsg' placeholder='<%=trs.t("მარჯვენა ტექსტი")%>' type='text' value='654321'>
                    <b class='tooltip tooltip-bottom-right'><i class='fa txt-color-teal'>T</i> <%=trs.t("მარჯვენა ტექსტი")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class='col col-sm-4'>
                    <%=trs.t("კოდი")%>
                </div>
                <div class='col col-sm-8'>
                    <label class='input'> <i class='icon-append'>N</i>
                    <input id='msg' placeholder='<%=trs.t("კოდი")%>' type='text' value='123456789'>
                    <b class='tooltip tooltip-bottom-right'><i class='txt-color-teal'></i> <%=trs.t("კოდი")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class='col col-sm-12'>
                    <label class="btn btn-success pull-right" onclick="getBcode(1);"><i class="fa fa-save"></i> <%=trs.t("შენახვა")%></label>
                    <label class="btn btn-primary pull-right" onclick="getBcode(0);" style='margin-right: 10px;'><i class="fa fa-folder-open"></i> <%=trs.t("ნახვა")%></label>
                </div>
            </div>
        </div>
        <div class="col col-sm-6 text-align-center" id='bcresult'>
            <br><div id='btitle'>Code 128</div><br>
            <%--img id='bcodesample' src="" style='max-height: 200px; max-width: 200px;'/--%>
            <iframe style="text-align: center; border: 0;" width="400" height="250" id="bcodesample" src=""></iframe>
        </div>
    </div>
</div>