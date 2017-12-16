<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    LabtestBean control = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("cid")));
    String[] weekdays = {trs.t("ორშაბათს"), trs.t("სამშაბათს"), trs.t("ოთხშაბათს"),trs.t("ხუთშაბათს"),trs.t("პარასკევს")};
    String suff = "_"+control.getLabtestid();
    int sctype = 0;
    String positive = "";
    String negative = "";
    String extra = "";
    LabtestcontrolBean lc = LabtestcontrolManager.getInstance().loadByPrimaryKey(labtest.getLabtestid(),control.getLabtestid());
    if(lc != null){
        JSONObject o = JSONObject.fromObject(lc.getSchedule());
        sctype = o.getInt("val");
        if(o.containsKey("positive"))   positive = o.getString("positive");
        if(o.containsKey("negative"))   negative = o.getString("negative");
        if(o.containsKey("extra"))   extra = o.getString("extra");
    }
    boolean hasplate = false;
    if(DevicelabtestManager.getInstance().countWhere("where deviceid in (select deviceid from device where hasplate = true) and labtestid = "+labtest.getLabtestid()) > 0)
        hasplate = true;
%>
<script src="js/plugin/masked-input/jquery.maskedinput.min.js" type="text/javascript"></script>
<script src="js/plugin/clockpicker/clockpicker.min.js" type="text/javascript"></script>
<script>
    
    function disen<%=suff%>(){
        var sel = $("input[name='radio1<%=suff%>']:checked").val();
        if(sel == 1){
            $("#time2<%=suff%>").prop('disabled', true);
            $(".time3<%=suff%>").prop('disabled', true);
            $("input[name='weekdays<%=suff%>']").prop('disabled', true);
            $("#minutesbefore<%=suff%>").prop('disabled', true);
            $("#minutesafter<%=suff%>").prop('disabled', true);
            $("#controlchk<%=control.getLabtestid()%>").removeClass("pull-right badge bg-color-green padding-5").html("");
        } else if(sel == 2){
            $("#time2<%=suff%>").prop('disabled', false);
            $("#time2<%=suff%>").focus();
            $(".time3<%=suff%>").prop('disabled', true);
            $("input[name='weekdays<%=suff%>']").prop('disabled', true);
            $("#minutesbefore<%=suff%>").prop('disabled', true);
            $("#minutesafter<%=suff%>").prop('disabled', true);
            $("#controlchk<%=control.getLabtestid()%>").addClass("pull-right badge bg-color-green padding-5").html('<i class="fa fa-check fa-lg txt-color-white"></i>');
        } else if(sel == 3){
            $("#time2<%=suff%>").prop('disabled', true);
            //$(".time3").prop('disabled', false);
            $("input[name='weekdays<%=suff%>']").prop('disabled', false);
            $("#minutesbefore<%=suff%>").prop('disabled', true);
            $("#minutesafter<%=suff%>").prop('disabled', true);
            disen1<%=suff%>();
            $("#controlchk<%=control.getLabtestid()%>").addClass("pull-right badge bg-color-green padding-5").html('<i class="fa fa-check fa-lg txt-color-white"></i>');
        } else if(sel == 4){
            $("#time2<%=suff%>").prop('disabled', true);
            $(".time3<%=suff%>").prop('disabled', true);
            $("input[name='weekdays<%=suff%>']").prop('disabled', true);
            $("#minutesbefore<%=suff%>").prop('disabled', false);
            $("#minutesbefore<%=suff%>").focus();
            $("#minutesafter<%=suff%>").prop('disabled', true);
            $("#controlchk<%=control.getLabtestid()%>").addClass("pull-right badge bg-color-green padding-5").html('<i class="fa fa-check fa-lg txt-color-white"></i>');
        } else if(sel == 5){
            $("#time2<%=suff%>").prop('disabled', true);
            $(".time3<%=suff%>").prop('disabled', true);
            $("input[name='weekdays<%=suff%>']").prop('disabled', true);
            $("#minutesbefore<%=suff%>").prop('disabled', true);
            $("#minutesafter<%=suff%>").prop('disabled', false);
            $("#minutesafter<%=suff%>").focus();
            $("#controlchk<%=control.getLabtestid()%>").addClass("pull-right badge bg-color-green padding-5").html('<i class="fa fa-check fa-lg txt-color-white"></i>');
        } else if(sel == 6){
            $("#time2<%=suff%>").prop('disabled', true);
            $(".time3<%=suff%>").prop('disabled', true);
            $("input[name='weekdays<%=suff%>']").prop('disabled', true);
            $("#minutesbefore<%=suff%>").prop('disabled', true);
            $("#minutesafter<%=suff%>").prop('disabled', true);
            $("#controlchk<%=control.getLabtestid()%>").addClass("pull-right badge bg-color-green padding-5").html('<i class="fa fa-check fa-lg txt-color-white"></i>');
        }
    }
    
    function disen1<%=suff%>(){
        $(".time3<%=suff%>").prop('disabled', true);
        $("input[name='weekdays<%=suff%>']:checked").map(function() { 
            var n = $(this).val();
            $("#time3"+n+"<%=suff%>").prop('disabled', false);
            $("#time3"+n+"<%=suff%>").focus();
        });
    }
    
    var time2<%=suff%> = 1;
    function deltime2<%=suff%>(n){
        var sel = $("input[name='radio1<%=suff%>']:checked").val();
        if(sel == 2){
            $("#time2<%=suff%>group"+n).remove();
            time2<%=suff%>--;
            $("#type2cnt<%=suff%>").val(time2<%=suff%>);
        }
    }
    
    function addtime2<%=suff%>(){
        var sel = $("input[name='radio1<%=suff%>']:checked").val();
        if(sel == 2){
            var s = '<div class="input-group" id="time2<%=suff%>group'+time2<%=suff%>+'">';
            s += '<input class="form-control text-align-center time clockpicker" id="time2<%=suff%>'+time2<%=suff%>+'" placeholder= "HH:MM" data-autoclose="true" type="text">';
            s += '<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>';
            s += '<span class="input-group-addon" style="cursor: pointer;" onclick="deltime2<%=suff%>('+time2<%=suff%>+')"><i class="fa fa-minus txt-color-green"></i></span>';
            s += '</div>';
            $("#tdtime2<%=suff%>").append(s);
            $(".time").mask("99:99",{placeholder:"HH:MM"});
            time2<%=suff%>++;
            $("#type2cnt<%=suff%>").val(time2<%=suff%>);
        }
    }
    
    $("input[name='weekdays<%=suff%>']").on('click',function(){ disen1<%=suff%>(); })
    $("input[name='radio1<%=suff%>']").on('click',function(){ disen<%=suff%>(); })
    $(".time").mask("99:99",{placeholder:"HH:MM"});
    $('.clockpicker').clockpicker();
    disen<%=suff%>();
    <%if(sctype > 0){%>
        $("input[name='radio1<%=suff%>']").val(<%=sctype%>);
        $("input[name='radio1<%=suff%>']").trigger("click");
    <%}%>
</script>
<label class="label font-md"><%=trs.t("ჩატარების გრაფიკი:")%></label>
            <table class="table">
                <tr>
                    <td colspan="2"><label class="radio"><input testid="<%=control.getLabtestid()%>" name="radio1<%=suff%>" class="scdtype" type="radio" checked value="1"><i></i><%=trs.t("არ ტარდება")%></label></td>
                </tr>
                <tr>
                    <td><label class="radio"><input testid="<%=control.getLabtestid()%>" name="radio1<%=suff%>" class="scdtype" type="radio" value="2"><i></i><%=trs.t("ყოველ დღე")%></label></td>
                    <td width="80%" id="tdtime2<%=suff%>">
                        <input type="hidden" id="type2cnt<%=suff%>" value="1"/>
                        <div class="input-group">
                            <input class="form-control text-align-center time clockpicker" id="time2<%=suff%>" placeholder= "HH:MM" data-autoclose="true" type="text">
                            <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                            <span class="input-group-addon" style="cursor: pointer;" onclick="addtime2<%=suff%>()"><i class="fa fa-plus txt-color-green"></i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="radio"><input testid="<%=control.getLabtestid()%>" name="radio1<%=suff%>" class="scdtype" type="radio" value="3"><i></i><%=trs.t("ყოველ")%></label></td>
                    <td>
                        <table>
                        <%
                        for(int i=0;i<weekdays.length;i++){
                        %>
                        <tr>
                            <td>
                                <label class="checkbox" style="padding-right: 5px;"><input testid="<%=control.getLabtestid()%>" name="weekdays<%=suff%>" type="checkbox" value="<%=i%>"><i></i><%=weekdays[i]%></label>
                            </td>
                            <td>
                                <div class="input-group">
                                    <input class="form-control text-align-center time clockpicker time3<%=suff%>" id="time3<%=i%><%=suff%>" placeholder= "HH:MM" data-autoclose="true" type="text">
                                    <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                                </div>
                            </td>
                        </tr>
                        <%
                        }
                        %>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td><label class="radio"><input testid="<%=control.getLabtestid()%>" name="radio1<%=suff%>" class="scdtype" type="radio" value="4"><i></i><%=trs.t("შესრულებამდე")%></label></td>
                    <td>
                        <div class="input-group">
                            <input class="form-control text-align-center minutes<%=suff%>" id="minutesbefore<%=suff%>" placeholder="წუთები" data-autoclose="true" type="text">
                            <span class="input-group-addon"><i class="">&nbsp;t&nbsp;</i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="radio"><input testid="<%=control.getLabtestid()%>" name="radio1<%=suff%>" class="scdtype" type="radio" value="5"><i></i><%=trs.t("შემდეგ")%></label></td>
                    <td>
                        <div class="input-group">
                            <input class="form-control text-align-center minutes<%=suff%>" id="minutesafter<%=suff%>" placeholder="წუთები" data-autoclose="true" type="text">
                            <span class="input-group-addon"><i class="">&nbsp;t&nbsp;</i></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <label class="radio">
                            <input testid="<%=control.getLabtestid()%>" name="radio1<%=suff%>" class="scdtype" type="radio" value="6"><i></i><%=trs.t("ანალიზის შესრულების პარალელურად")%>
                        </label>
                        <%if(hasplate){%>
                        <table>
                            <tr>
                                <td><b><%=trs.t("დადებითი")%></b></td>
                                <td>
                                    <input class="form-control" id="positive<%=suff%>" placeholder= "<%=trs.t("გამოყავით მძიმეებით")%>" type="text" value="<%=positive%>">
                                </td>
                            </tr>
                            <tr>
                                <td><b><%=trs.t("უარყოფითი")%></b></td>
                                <td>
                                    <input class="form-control" id="negative<%=suff%>" placeholder= "<%=trs.t("გამოყავით მძიმეებით")%>" type="text" value="<%=negative%>">
                                </td>
                            </tr>
                            <tr>
                                <td><b><%=trs.t("დამატებითი")%></b></td>
                                <td>
                                    <input class="form-control" id="extra<%=suff%>" placeholder= "<%=trs.t("გამოყავით მძიმეებით")%>" type="text" value="<%=extra%>">
                                </td>
                            </tr>
                        </table>
                        <%}%>
                    </td>
                </tr>
            </table>