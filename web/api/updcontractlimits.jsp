<%-- 
    Document   : service
    Created on : Nov 22, 2014, 3:24:54 PM
    Author     : Gocha Tortladze
--%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@include file="api.inc.jsp"%>
<%
Manager.getInstance().beginTransaction();
try 
{
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (isMultipart) 
    {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        java.util.List items = null;
        try 
        {
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

        Map<String, String> labtest = new HashMap<String, String>();
        Map<String, String> sample  = new HashMap<String, String>();
        Map<String, String> maxprice = new HashMap<String, String>();
        Map<String, String> maxnum  = new HashMap<String, String>();
        Map<String, String> minday  = new HashMap<String, String>();
        Map<String, String> maxday  = new HashMap<String, String>();
        Map<String, String> comment = new HashMap<String, String>();
        
        Map<Long, String> elabtest = new HashMap<Long, String>();
        Map<Long, String> esample  = new HashMap<Long, String>();
        Map<Long, String> emaxprice = new HashMap<Long, String>();
        Map<Long, String> emaxnum  = new HashMap<Long, String>();
        Map<Long, String> eminday  = new HashMap<Long, String>();
        Map<Long, String> emaxday  = new HashMap<Long, String>();
        Map<Long, String> ecomment = new HashMap<Long, String>();
        
        String contractid=null;
        Iterator itr = items.iterator();
        while (itr.hasNext()) 
        {
            FileItem item = (FileItem) itr.next();
            if (item.isFormField()) 
            {
                String f = item.getFieldName();
                String v = item.getString("UTF-8");

                System.out.println("CHK:"+f+"="+v);

                if      (f.equalsIgnoreCase("contractid"))    contractid=v;
                else if (f.startsWith("labtest"))             labtest.put(f.substring(7), v);
                else if (f.startsWith("sampletype"))          labtest.put(f.substring(10), v);
                else if (f.startsWith("maxprice"))            maxprice.put(f.substring(8), v);
                else if (f.startsWith("maxnum"))              maxnum.put(f.substring(6), v);
                else if (f.startsWith("minday"))              minday.put(f.substring(6), v);
                else if (f.startsWith("maxday"))              maxday.put(f.substring(6), v);
                else if (f.startsWith("comment"))             comment.put(f.substring(7), v);
                else if (f.startsWith("edlab"))               elabtest.put(Long.parseLong(f.substring(5)), v);
                else if (f.startsWith("edsample"))            esample.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edmaxpri"))            emaxprice.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edmaxnum"))            emaxnum.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edminday"))            eminday.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edmaxday"))            emaxday.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edcomment"))           ecomment.put(Long.parseLong(f.substring(9)), v);
            } 
        }
        
        ContractBean  obj   = ContractManager.getInstance().createContractBean();
        try {
            obj = ContractManager.getInstance().loadByPrimaryKey(Long.parseLong(contractid));
        } catch (Exception e) {
            throw new Exception(trs.t("ხელშეკრულება არჩეული არ არის!"));
        }
        
        if (obj.getContracttype()==2)
        {
            for (Map.Entry<String, String> entry : labtest.entrySet()) {
               try { 
                ContractlabtestBean lab = ContractlabtestManager.getInstance().createContractlabtestBean();
                double dmaxprice=0.0;
                long imaxcnt=0;
                long imaxday=0;
                long iminday=0;
                int  isample=0;
                String v = entry.getKey();
                try {dmaxprice=Double.parseDouble(maxprice.get(v)); }  catch (Exception ign) {}
                try {imaxcnt=Long.parseLong(maxnum.get(v)); } catch (Exception ign) {}
                try {imaxday=Long.parseLong(maxday.get(v)); } catch (Exception ign) {}
                try {iminday=Long.parseLong(minday.get(v)); } catch (Exception ign) {}
                try {isample=Integer.parseInt(sample.get(v)); } catch (Exception ign) {}
                lab.setContractid(obj.getContractid());
                lab.setLabtestid(Long.parseLong(entry.getValue()));
                
                lab.setSampletypeid(isample);
                lab.setMaxprice(dmaxprice);
                lab.setMaxcnt(imaxcnt);
                lab.setMaxday(imaxday);
                lab.setMinday(iminday);
                lab.setInfo(comment.get(v));
                lab.setRegbyid(user.getPersonellid());
                lab = ContractlabtestManager.getInstance().save(lab);
              } catch (Exception e) {
                e.printStackTrace();
              }
            }
            
            for (Map.Entry<Long, String> entry : elabtest.entrySet()) {
               try { 
                Long v = entry.getKey();
                ContractlabtestBean lab = ContractlabtestManager.getInstance().loadByPrimaryKey(v);
                double dmaxprice=0.0;
                long imaxcnt=0;
                long imaxday=0;
                long iminday=0;
                int  isample=0;
                try {dmaxprice=Double.parseDouble(emaxprice.get(v)); }  catch (Exception ign) {}
                try {imaxcnt=Long.parseLong(emaxnum.get(v)); } catch (Exception ign) {}
                try {imaxday=Long.parseLong(emaxday.get(v)); } catch (Exception ign) {}
                try {iminday=Long.parseLong(eminday.get(v)); } catch (Exception ign) {}
                try {isample=Integer.parseInt(esample.get(v)); } catch (Exception ign) {}
                lab.setContractid(obj.getContractid());
                lab.setLabtestid(Long.parseLong(entry.getValue()));
                
                lab.setSampletypeid(isample);
                lab.setMaxprice(dmaxprice);
                lab.setMaxcnt(imaxcnt);
                lab.setMaxday(imaxday);
                lab.setMinday(iminday);
                lab.setInfo(ecomment.get(v));
                lab.setRegbyid(user.getPersonellid());
                lab = ContractlabtestManager.getInstance().save(lab);
              } catch (Exception e) {
                e.printStackTrace();
              }
            }
            
        }
       
        JSONObject res  = new JSONObject();
        res.put("id", obj.getContractid());
        res.put("num", obj.getNum());
        rspJsonMessage(response, "OK", "ხელშეკრულება დამატებულია",res);
        Manager.getInstance().endTransaction(true);
        return;
    }
    else
        rspJsonMessage(response, "ER", "სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას");
}
catch (Exception e) 
{
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    rspJsonMessage(response, "ER", e.getMessage());
}
%>
