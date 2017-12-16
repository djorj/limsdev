<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    
%>

<div class="smart-form col-sm-12">
    <section class="col col-sm-6">
        <label class="select">
            <select>
                <option value="0"><%=trs.t("შემომტანი")%>:</option>
                <option value="0"><%=trs.t("იურიდიული პირი")%></option>
                <option value="0"><%=trs.t("კერძო პირი")%></option>
            </select><i></i> 
        </label>
    </section>
    <section class="col col-sm-3">
        <div class="inline-group">
            <label class="radio"><input type="radio" name="secondhand" value="1" checked><i></i><%=trs.t("ახალი")%></label>
            <label class="radio"><input type="radio" name="secondhand" value="2"><i></i><%=trs.t("მეორადი")%></label>
        </div>
    </section>
    <section class="col col-sm-3">
        <div class="inline-group">
            <label class="radio"><input type="radio" name="complect" value="1" checked><i></i><%=trs.t("არაა კომპლექტი")%></label>
            <label class="radio"><input type="radio" name="complect" value="2"><i></i><%=trs.t("კომპლექტია")%></label>
        </div>
    </section>
        
    <section class="col col-sm-3">
        <mysoft:textInput icon="list-ol" id="num" placeholder="ზედნ. N"/>
    </section>
    <section class="col col-sm-3">
        <mysoft:select cols="Invoicetypeid,Name" edit="false" id="invoicetypeid" nmand="ზედნ. ტიპი:" objname="Invoicetype" where="order by name"/>
    </section>
    <section class="col col-sm-3">
        <mysoft:textInput value="<%=dt.format(new Date())%>" icon="calendar" id="invoicedate" placeholder="თარიღი"/>
    </section>
    <section class="col col-sm-3">
        <mysoft:select cols="Invoicesourcetypeid,Name" edit="false" id="invoicesourcetypeid" nmand="დაფინანსების წყარო:" objname="Invoicesourcetype" where="order by name"/>
    </section>
    
    <section class="col col-sm-3">
        <mysoft:select cols="Productgroupid,Name" edit="false" id="productgroupid" nmand="კატეგორია:" objname="Productgroup" where="where productgroupid in (select productgroupid from product where productid > 0) order by name"/>
    </section>
    <section class="col col-sm-4">
        <%-- mysoft:textInput icon="address-book" id="productid" placeholder="პროდუქტი"/ --%>
        <label class="input"> <i class="icon-append fa fa-institution" onclick="alert(mySoftAutocomplete.getDataListVal())"></i>
            <input id="productid" list="products" productsearch placeholder="<%=trs.t("პროდუქტი")%>" type="text">
            <datalist id="products" productlist></datalist>
        </label>
    </section>
    <section class="col col-sm-2">
        <mysoft:select cols="Punitid,Name" edit="true" id="punitid" objname="Punit" where="order by name"/>
    </section>
    <section class="col col-sm-3">
        <mysoft:textInput icon="money" id="productacc" placeholder="ანგარიში"/>
    </section>
    
    <section class="col col-sm-4">
        <mysoft:textInput icon="calculator" id="quantity" placeholder="რაოდენობა"/>
    </section>
    <section class="col col-sm-4">
        <mysoft:textInput icon="money" id="unitprice" placeholder="ერთეულის ფასი"/>
    </section>
    <section class="col col-sm-4">
        <mysoft:textInput icon="calendar-check-o" id="expdate" placeholder="ვადა"/>
    </section>
    
    <section class="col col-sm-4">
        <mysoft:textInput icon="home" id="room" placeholder="ოთახი"/>
    </section>
    <section class="col col-sm-4">
        <mysoft:textInput icon="home" id="shelf" placeholder="თარო"/>
    </section>
    <section class="col col-sm-4">
        <mysoft:textInput icon="home" id="place" placeholder="ადგილი თაროზე"/>
    </section>
    
    <section class="col col-sm-4">
        <mysoft:textInput icon="id-card" id="supplierid" placeholder="ფირმის საიდენტიფიკაციო კოდი"/>
    </section>
    <section class="col col-sm-4">
        <mysoft:textInput icon="university" id="suppliername" placeholder="ფირმის დასახელება"/>
    </section>
    <section class="col col-sm-4">
        <mysoft:textInput icon="phone" id="supplierphone" placeholder="ფირმის ტელეფონი"/>
    </section>
    <section class="col col-sm-3">
        <mysoft:textInput icon="envelope" id="supplieremail" placeholder="ფირმის ელ-ფოსტა"/>
    </section>
    <section class="col col-sm-9">
        <mysoft:textInput icon="map-marker" id="supplieraddress" placeholder="ფირმის მისამართი"/>
    </section>
    
    
    <section class="col col-sm-3">
        <mysoft:textInput icon="id-card" id="ownerid" placeholder="უფლებამოსილი პირის პირადი N"/>
    </section>
    <section class="col col-sm-3">
        <mysoft:textInput icon="user" id="owherfname" placeholder="უფლებამოსილი პირის სახელი"/>
    </section>
    <section class="col col-sm-3">
        <mysoft:textInput icon="user" id="ownerlname" placeholder="უფლებამოსილი პირის გვარი"/>
    </section>
    <section class="col col-sm-3">
        <mysoft:textInput icon="phone" id="ownerphone" placeholder="უფლებამოსილი პირის ტელეფონი"/>
    </section>
    
    <section class="col col-sm-12">
        <mysoft:textInput icon="barcode" id="barcode" placeholder="ბარკოდი"/>
    </section>
</div>
<script>
    'use strict';

    var mySoftAutocomplete = {
      
      url: '',
      delay: 0,
      timer: 0,
      input: {},
      list: {},
      init: function() {
        this.input = $('#productid');
        this.list = $('#'+this.input.attr('list'));
        this.delay = 300;
        this.url = 'content/searchproduct.jsp';
        this.input.on('keyup', this.setTimer.bind(this));
      },

      setTimer: function() {
        if ( this.timer ) {
          clearTimeout(this.timer);
        }

        this.timer = setTimeout( this.processQuery.bind(this), this.delay );
      },

      processQuery: function() {
        var query = this.input.val();

        if ( ! query ) {
          return false;
        }

        $.ajax({
          dataType: 'json',
          url: this.url,
          method: "post",
          data: {
            q: query
          },
          success: this.updateProductList.bind(this)
        });
      },

      getDataListVal: function(){
          return this.list.find('option').filter(function() { return $.trim( $(this).text() ) === this.input.val(); }).attr('id');
      },

      updateProductList: function( response ) {
        if ( 'object' === typeof( response.products ) ) {
          var products = response.products;

          // Clear the list
          this.list.html('');

          $.each( products, function(idx, product) {
            this.list.append('<option id="'+product.id+'">' + product.name + '</option>');
          }.bind(this));
        }
      }
    };
    
    function getDataListVal(input){
        var g = $("#"+input).val();
        var lid = $("#"+input).attr("list");
        return $('#'+lid).find('option').filter(function() { return $.trim( $(this).text() ) === g; }).attr('id');
    }
    
    jQuery().ready(function (){
        //pageSetup();
    
        $("#punitid").attr("disabled","disabled");
        //$("#productid")
        mySoftAutocomplete.init();
    });
    
</script>