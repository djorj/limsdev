<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="includes/init.jsp"%>
<%
Manager.getInstance().beginTransaction();
try{
  String fname = "/home/djorj/saq_201710010023.json";
  FileInputStream fi = new FileInputStream(fname);
  byte[] b = new byte[fi.available()];
  fi.read(b);
  fi.close();
  JSONObject obj = JSONObject.fromObject(new String(b,"UTF-8"));
  JSONArray ar = obj.getJSONArray("saq");
  for(int i=0;i<ar.size();i++){
      JSONObject p = ar.getJSONObject(i);
      int cid = 40;
      if(p.getString("sa_ID") != null){
          ProductgroupBean[] pg = ProductgroupManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" and code = '"+p.getString("sa_ID")+"'");
          if(pg.length > 0)
              cid = pg[0].getProductgroupid().intValue();
      }
      ProductBean product = ProductManager.getInstance().createProductBean();
      product.setProductid(p.getLong("ID"));
      product.setCode(p.getString("b_code"));
      product.setName(p.getString("i_das"));
      product.setLimitqty(0);
      product.setProductgroupid(cid);
      if(p.getString("ze_ID") != null)
        product.setPunitid(p.getInt("ze_ID"));
            
      product = ProductManager.getInstance().save(product);
      System.out.println(i+"/"+ar.size());
  }
}catch(Exception e){
    e.printStackTrace();
}
%>