<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    InventoryitemBean item = InventoryitemManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
    ProductBean product = ProductManager.getInstance().loadByPrimaryKey(item.getProductid());
    String oper = request.getParameter("oper");
    if(oper.equalsIgnoreCase("set")){
        if(product.getCode() != null && product.getCode().length() > 0)
            throw new Exception(trs.t("პროდუქტს უკვე მინიჭებული აქვს ბარკოდი!"));
        long newbarcode = (long)getSum("select nextval('barcode_seq')");
        while(ProductManager.getInstance().countWhere("where code = '"+newbarcode+"'") > 0){
            newbarcode = (long)getSum("select nextval('barcode_seq')");
        }
        product.setCode(String.valueOf(newbarcode));
        product = ProductManager.getInstance().save(product);
    } else if(oper.equalsIgnoreCase("print")){
        String bcode = product.getCode();
        if(bcode == null || bcode.length() == 0){
            bcode = String.valueOf((long)getSum("select nextval('barcode_seq')"));
            while(ProductManager.getInstance().countWhere("where code = '"+bcode+"'") > 0){
                bcode = String.valueOf((long)getSum("select nextval('barcode_seq')"));
            }
            product.setCode(bcode);
            product = ProductManager.getInstance().save(product);
        }

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
        String url = "getbcode?notxt=false&barheight="+barheight+"&height="+height+"&width="+width+"&fontsize="+fontsize+"&mm=";
        if(units.equalsIgnoreCase("mm")) url += "true";
        else                             url += "false";
        url += "&productid="+product.getProductid();
        res.put("url",url);

    }
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>

