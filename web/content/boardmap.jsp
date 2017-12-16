<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
int w = Integer.parseInt(request.getParameter("h"));
int h = Integer.parseInt(request.getParameter("w"));
double wperc = 86/w;
int labtestid = Integer.parseInt(request.getParameter("labtestid"));
long plateid = Long.parseLong(request.getParameter("plateid"));
long platetemplateid = Integer.parseInt(request.getParameter("platetemplateid"));
boolean zdefault = Boolean.parseBoolean(request.getParameter("zdefault"));
String nm = request.getParameter("nm");
PlatetemplateBean ptp = PlatetemplateManager.getInstance().createPlatetemplateBean();
if(platetemplateid > 0)
    ptp = PlatetemplateManager.getInstance().loadByPrimaryKey(platetemplateid);
ptp.setLabtestid(labtestid);
ptp.setH(h);
ptp.setW(w);
ptp.setZdefault(zdefault);
ptp.setName(nm);
ptp = PlatetemplateManager.getInstance().save(ptp);
platetemplateid = ptp.getPlatetemplateid();
PlateBean plate = null;
if(plateid > 0) plate = PlateManager.getInstance().loadByPrimaryKey(plateid);
%>
<script>
    var cX = -1;
    var cY = -1;
    
    function getHval(c){
        var res = c%26;
        var times = Math.trunc(c/26);
        var f = "A"+String.fromCharCode(65+res);
        return f;
    }
    
    $("#barcode").attr("disabled","true");
    
    $("#barcode").on("keyup",function(e){
        if(e.keyCode == 13){
            var bcode = $("#barcode").val();
            $("#barcode").blur();
            $("#barcode").val("");
            $("#cellname").html("");
            $("#barcode").attr("disabled","true");
            $("#maprow").removeAttr("disabled");
            if(bcode == '') unsetCellVal(cX,cY);
            else {
                
                setCellVal(cX,cY,bcode);
            }
        }
    });
    
    
    function setCell(x,y){ getHval(y);
        cX = x;
        cY = y;
        var c = $("#cell_"+x+"_"+y);
        var isset = c.attr("set");
        var bcode = $("#cell_"+x+"_"+y).attr("set");
            $("#maprow").attr("disabled","true");
            $("#barcode").removeAttr("disabled");
            $("#barcode").focus();
            $("#barcode").val(bcode);
            $("#cellname").html(String.fromCharCode(65+y)+''+(x+1));
            setCellSelect(x,y);
        
    }
    
    function setCellVal(x,y,val){
        var tctrl = $("#cell_"+x+"_"+y).children();
        tctrl.css("background-color","#739E73");
        //tctrl.css("font-size","10px");
        tctrl.html('<span style="font-size: 10px; background-color: #739E73;">'+val+'</span>');
        $("#cell_"+x+"_"+y).attr("set",val);
    }
    
    function setCellSelect(x,y){
        var tctrl = $("#cell_"+x+"_"+y).children();
        tctrl.css("background-color","#A90329");
    }
    
    function unsetCellVal(x,y){
        var tctrl = $("#cell_"+x+"_"+y).children();
        tctrl.css("background-color","#3276B1");
        tctrl.html("<p>&nbsp;</p>");
        $("#cell_"+x+"_"+y).removeAttr("set");
    }
</script>
<style>
    .mysoft_grid-container{
        width: 100%; 
        max-width: 820px;      
    }

    /*-- our cleafix hack -- */ 
    .mysoft_row:before, 
    .mysoft_row:after {
        content:"";
        display: table ;
        clear:both;
    }

    [class*='mysoft_col-'] {
        float: left; 
        min-height: 1px; 
        width: <%=dc.format(wperc)%>%; 
        /*-- our gutter -- */
        padding: 1px; 
        background-color: #ADA8A8;
    }
<%
for(int i=0;i<w;i++){
    int n = i+1;
%>
    .mysoft_col-<%=n%>{ width: <%=dc.format(wperc*n)%>%; }
<%}%>
    .mysoft_outline, .mysoft_outline *{
        
    }

    /*-- some extra column content styling --*/
    [class*='mysoft_col-'] > p {
     background-color: #3276B1;
     padding: 0;
     margin: 0;
     text-align: center; 
     color: white; 
    }
    
    .mysoft_cell {
     background-color: #FFFFFF; 
     padding: 0;
     margin: 0;
     text-align: center; 
     color: black; 
     outline: 1px solid black;
    }
</style>
<input type="hidden" id="platetemplateid" value="<%=platetemplateid%>"/>
<div class='row'>
    <div class='col col-md-10'>
        <label class="input"> <i class="icon-append fa fa-barcode"></i><span class="icon-prepend" style='font-size: 12px; font-weight: bold;' id='cellname'></span> 
            <input id='barcode' placeholder="<%=trs.t("ბარკოდი")%>" type="text">
        </label>
    </div>
</div>
<div class='row'>
    <div class='col col-md-12'>&nbsp;</div>
</div>
<div class='row' id='maprow'>
    <div class='col col-md-12'>
        <div class="mysoft_grid-container mysoft_outline">
            <div class="mysoft_row">
                <div class="mysoft_col-1"><p style='background-color: #193B58 !important;'>#</p></div>
                <%
                for(int j=0;j<w;j++){
                    int nn = 65+j;
                    String prefix = "";
                    if(j>25)    {
                        prefix = "A";
                        nn = 65 + (j%26);
                    }
                %>
                <div class="mysoft_col-1"><p style='background-color: #193B58 !important;'><%=j+1%></p></div> 
                <%}%>
            </div>
            <%
            for(int i=0;i<h;i++){
                int nn = 65+i;
                String prefix = "";
                if(i>25)    {
                    prefix = "A";
                    nn = 65 + (i%26);
                }
                String name = prefix+((char)nn)+"";
            %>
            <div class="mysoft_row">
                <div class="mysoft_col-1"><p style='background-color: #193B58 !important;'><%=name%></p></div>
                <%
                for(int j=0;j<w;j++){
                    String name1 = ((char)(65+i))+String.valueOf(j+1);
                    String barcode = "<p>&nbsp;</p>";
                    String set = "";
                    PlatemapBean[] platemap = PlatemapManager.getInstance().loadByWhere("where plateid = "+plateid+" and wellno = '"+name1+"'");
                    if(platemap.length > 0){
                        barcode = "<p style=\"background-color: #739E73;\"><span style=\"font-size: 10px; color: white;\">"+platemap[0].getBarcode()+"</span></p>";
                        set = "set=\""+platemap[0].getBarcode()+"\"";
                    }
                %>
                <div id='cell_<%=i%>_<%=j%>' class="mysoft_col-1 wellval" style="cursor: pointer;" title="<%=name1%>" onclick="setCell(<%=i%>,<%=j%>)" <%=set%>><%=barcode%></div> 
                <%}%>
            </div> 
            <%}%>
        </div>
    </div>
</div>

