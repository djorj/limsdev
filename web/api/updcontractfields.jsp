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

        String contractid=null;
        String contragentid=null;
        String contracttype=null;
        String sampletypeid=null;
        String price=null;
        String startdate=null;
        String enddate=null;
        String num=null;
        String path=null;
        String info=null;
        FileItem docfile  =null;

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
                else if (f.equalsIgnoreCase("contragentid"))  contragentid=v;
                else if (f.equalsIgnoreCase("contracttype"))  contracttype=v;
                else if (f.equalsIgnoreCase("sampletypeid"))  sampletypeid=v;
                else if (f.equalsIgnoreCase("price"))         price=v;
                else if (f.equalsIgnoreCase("startdate"))     startdate=v;
                else if (f.equalsIgnoreCase("enddate"))       enddate=v;
                else if (f.equalsIgnoreCase("num"))           num=v;
                else if (f.equalsIgnoreCase("path"))          path=v;
                else if (f.equalsIgnoreCase("info"))          info=v;
            } 
            else
            {
                docfile = item;
                System.out.println(">FILE:"+item.getName());
            }
        }

        ContractBean  obj   = ContractManager.getInstance().createContractBean();
        try {
            obj = ContractManager.getInstance().loadByPrimaryKey(Long.parseLong(contractid));
        } catch (Exception e) {
            throw new Exception(trs.t("ხელშეკრულება არჩეული არ არის!"));
        }
     

        obj.setNum(num.replace("\\","\\\\"));
        if(obj.getNum().length() == 0)  
            throw new Exception(trs.t("ხელშეკრულების ნომერი შეტანილი არ არის!"));
        else
        {
  //          ContractBean[] obj2 = ContractManager.getInstance().loadByWhere("WHERE upper(num) = '"+num.toUpperCase().replace("'", "''").replace("\\","\\\\") +"'");
 ///           if(obj2.length>0 && (obj.getContractid()!=null)&&(obj.getContractid().longValue()!=obj2[0].getContractid().longValue()))
     //           throw new Exception(trs.t("ხელშეკრულება ნომრით ~NAME~ უკვე არსებობს!",obj.getNum()));
        }
        
        try { obj.setContragentid(Long.parseLong(contragentid));} catch(Exception ign) {}
        if (contracttype.equals("1"))
        {
            obj.setContracttype(1);
            obj.setStartdate(string2date(startdate,_DATEFORMAT_,"თარიღი არ არის მითითებული"));
            obj.setEnddate(string2date(enddate,_DATEFORMAT_,"თარიღი არ არის მითითებული"));
            obj.setPrice(0.0);
        }
        else if (contracttype.equals("2"))
        {
            obj.setContracttype(2);
            obj.setStartdate(string2date(startdate,_DATEFORMAT_,"თარიღი არ არის მითითებული"));
            obj.setEnddate(string2date(enddate,_DATEFORMAT_,"თარიღი არ არის მითითებული"));
            if (price!=null&&!price.isEmpty())    
            { 
                try { obj.setPrice(Double.parseDouble(price));} catch(Exception ign) {throw new Exception(trs.t("ფასი არ არის სწორად შეტანილი!"));}
            }
            else
                obj.setPrice(0);
            
            if (docfile!=null) 
            {
                try {
                    String itemName = new String(docfile.getName().getBytes("ISO8859_1"), "UTF-8");
                    obj.setPath(num+"."+FilenameUtils.getExtension(itemName));
                } catch (Exception e) {
                    throw new Exception(trs.t("შეცდომა, ხელშეკრულების დოკუმენტის შენახვისას. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას"));
                }
            }
        }
        else
            throw new Exception(trs.t("ხელშეკრულების ტიპი არჩეული არ არის!"));
        
        obj.setInfo(info);
        obj.setCompanyid(user.getCompanyid());
        obj.setRegbyid(user.getPersonellid());
        obj = ContractManager.getInstance().save(obj);

        if (obj.getContractid()!=null&&docfile!=null) 
        {
            try {
                String fp =config.getServletContext().getRealPath("/")+"documents/contracts/"+obj.getPath();
                File savedFile = new File(fp);
                docfile.write(savedFile);  
 	    } catch (Exception e) {
//throw new Exception(trs.t("შეცდომა, ხელშეკრულების დოკუმენტის შენახვისას. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას"));
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
