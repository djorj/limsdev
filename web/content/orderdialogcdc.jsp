<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%

%>
<script>
$.post("content/ordercdcgeneral.jsp", {}, function(data) { $("#s2").html(data); });
$('[data-toggle="tab"]').on('click', function(){
    var $this = $(this),
        source = $this.attr('href'),
        pane = $this.attr('data-target');

    if($(pane).is(':empty')) {  // check if pane is empty, if so get data
      $.post(source, {}, function(data) {
          $(pane).html(data);
      });

      $(this).tab('show');
      return false;
    }
});
</script>
<div class="smart-form">
<ul class="nav nav-tabs bordered" id="ptabs">
    <li class="active">
        <a data-toggle="tab" href="content/ordercdcgeneral.jsp" data-target="#s2"><%=trs.t("ზოგადი ინფორმაცია")%></a>
    </li>
    <li>
        <a data-toggle="tab" href="content/ordercdccustomer.jsp" data-target="#s3"><%=trs.t("დამკვეთის მოთხოვნები")%></a>
    </li>
    <li>
        <a data-toggle="tab" href="content/ordercdcepid.jsp" data-target="#s4"><%=trs.t("ნიმუშის ინფორმაცია")%></a>
    </li>
</ul>

<div class="tab-content padding-10"  id="pTabContent" style='height: calc(100vh - 400px); overflow-y: scroll; overflow-x: hidden;'>
    <div class="tab-pane fade in active" id="s2" style="padding-left: 20px;"></div>
    <div class="tab-pane fade" id="s3" style="padding-left: 20px;"></div>
    <div class="tab-pane fade" id="s4" style="padding-left: 20px;"></div>
</div>
</div>