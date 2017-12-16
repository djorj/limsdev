<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    JSONObject data = JSONObject.fromObject(request.getParameter("pars"));
    String normtext = "";
    switch(labtest.getRestypeid().intValue()){
        case 1:
            String normpositive = data.getString("normpositive");
            String normnegative = data.getString("normnegative");
            labtest.setBnormval1(normpositive);
            labtest.setBnormval2(normnegative);
            labtest = LabtestManager.getInstance().save(labtest);
            normtext = normpositive;
            break;
        case 2:
            String normmin = data.getString("normmin");
            String normmax = data.getString("normmax");
            if(normmin.length() > 0){
                try{
                    labtest.setNormmin(new Double(normmin.trim()));
                    normtext += dc.format(labtest.getNormmin());
                }catch(Exception ex){
                    throw new Exception(trs.t("არასწორი მინიმალური მნიშვნელობა"));
                }
            }
            if(normmax.length() > 0){
                try{
                    labtest.setNormmax(new Double(normmax.trim()));
                    if(labtest.getNormmin() != null) normtext += " - ";
                    normtext += dc.format(labtest.getNormmax());
                }catch(Exception ex){
                    throw new Exception(trs.t("არასწორი მაქსიმალური მნიშვნელობა"));
                }
            }
            
            
            labtest = LabtestManager.getInstance().save(labtest);
            break;
        case 3:
            int txttype = data.getInt("txttype");
            if(txttype == 1){
                String freetextnorm = data.getString("freetextnorm");
                labtest.setTnorm(freetextnorm);
                normtext = freetextnorm;
            } else {
                String listsessionname = data.getString("listsessionname");
                JSONArray v = (JSONArray)session.getAttribute(listsessionname);
                if(v == null) v = new JSONArray();
                LabtestanswerManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
                for(int i=0;i<v.size();i++){
                    JSONObject ob = v.getJSONObject(i);
                    LabtestanswerBean ans = LabtestanswerManager.getInstance().createLabtestanswerBean();
                    ans.setLabtestid(labtest.getLabtestid());
                    ans.setVal(ob.getString("name"));
                    if(ob.getString("checked").trim().length() == 0)    ans.setNorm(false);
                    else {
                        ans.setNorm(true);
                        labtest.setTnorm(ob.getString("name"));
                        normtext = ob.getString("name");
                    }
                    ans = LabtestanswerManager.getInstance().save(ans);
                }
                //session.removeAttribute(listsessionname);
            }
            labtest = LabtestManager.getInstance().save(labtest);
            break;
        default:
            throw new Exception(trs.t("არასწორი პასუხის ტიპი"));
    }
    
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
    res.put("normtext",normtext);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
