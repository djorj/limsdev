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

        String id         =null;
        String contractid =null;
        String contractnum=null;
        String num        =null;
        String actdate    =null;
        String samplenum  =null;
        String content    =null;
        String region     =null;
        String raion      =null;
        String city       =null;
        String bringer    =null;
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

                if      (f.equalsIgnoreCase("id"))            id=v;
                else if (f.equalsIgnoreCase("contractid"))    contractid=v;
                else if (f.equalsIgnoreCase("contractnum"))   contractnum=v;
                else if (f.equalsIgnoreCase("num"))           num=v;
                else if (f.equalsIgnoreCase("actdate"))       actdate=v;
                else if (f.equalsIgnoreCase("samplenum"))     samplenum=v;
                else if (f.equalsIgnoreCase("content"))       content=v;
                else if (f.equalsIgnoreCase("region"))        region=v;
                else if (f.equalsIgnoreCase("raion"))         raion=v;
                else if (f.equalsIgnoreCase("city"))          city=v;
                else if (f.equalsIgnoreCase("bringer"))       bringer=v;
            }
            else
            {
                docfile = item;
                System.out.println(">FILE:"+item.getName());
            }
        }

        ActBean  obj   = ActManager.getInstance().createActBean();
        if (id!=null&&!id.isEmpty())
            obj = ActManager.getInstance().loadByPrimaryKey(Long.parseLong(id));
        else
            obj = ActManager.getInstance().createActBean();
        
        obj.setNum(num);
        obj.setBringer(bringer);
        if(obj.getNum().length() == 0)  
            throw new Exception(trs.t("აქტის ნომერი შეტანილი არ არის!"));
        else
        {
            ActBean[] obj2 = ActManager.getInstance().loadByWhere("WHERE upper(num) = '"+num.toUpperCase().replace("'", "''") +"'");
            if (obj2.length>0 && (obj.getActid()==null || obj2[0].getActid().compareTo(obj.getActid()) != 0))
                throw new Exception(trs.t("აქტი ნომრით ~NAME~ უკვე არსებობს!",obj.getNum()));
        }

        if(contractnum != null)
        {
            ContractBean[] obj2 = ContractManager.getInstance().loadByWhere("WHERE upper(num) = '"+contractnum.toUpperCase().replace("'", "''") +"'");
            if (obj2.length != 1)
                throw new Exception(trs.t("ხელშეკრულენის ნომერი არ იძებნება."));
            obj.setContractid(obj2[0].getContractid());
        }
        else if(contractid != null)
        {
            ContractBean obj2 = ContractManager.getInstance().loadByPrimaryKey(new Long(contractid));
            if (obj2==null)
                throw new Exception(trs.t("ხელშეკრულენის იდენტიფიკატორი არ იძებნება."));

            obj.setContractid(obj2.getContractid());
        }
        else
            throw new Exception(trs.t("ხელშეკრულენის ნომერი/იდენტიფიკატორი მითითებული არ არის."));
        
        obj.setActdate(str2date(actdate,"თარიღი არ არის მითითებული"));
        
        try { 
            obj.setSampleamount(Integer.parseInt(samplenum));
        } 
        catch(Exception ign) {
            trs.t("ნიმუშების რაოდენობა არასწორია ან მითითებული არ არის.");
        }

        try { 
            if (region != null) obj.setRegionid(new Integer(region));
            if (raion  != null) obj.setRaionid(new Integer(raion));
            if (city   != null) obj.setVillageid(new Integer(city));
        } 
        catch(Exception ign) {
        }

        if ((docfile!=null) &&(docfile.getName()!=null)&&(docfile.getName().isEmpty()==false))
        {
            try {
                String itemName = new String(docfile.getName().getBytes("ISO8859_1"), "UTF-8");
                obj.setDocfile(FilenameUtils.getExtension(itemName));
 	    } catch (Exception e) {
                throw new Exception(trs.t("შეცდომა, აქტის დოკუმენტის შენახვისას. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას"));
            }
        }
        
        obj.setContent(content);
        obj.setRegbyid(user.getPersonellid());
        obj = ActManager.getInstance().save(obj);

        if ((obj.getActid()!=null)&&(docfile!=null) &&(docfile.getName()!=null)&&(docfile.getName().isEmpty()==false))
        {
            try {
                String fp =config.getServletContext().getRealPath("/")+"documents/acts/"+obj.getActid()+"."+obj.getDocfile();
                File savedFile = new File(fp);
                docfile.write(savedFile);  
 	    } catch (Exception e) {
                throw new Exception(trs.t("შეცდომა, აქტის დოკუმენტის შენახვისას. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას"));
            }
        }
        
        JSONObject res  = new JSONObject();
        res.put("id", obj.getActid());
        res.put("num", obj.getNum());
        rspJsonMessage(response, "OK", (id!=null&&!id.isEmpty()) ? "ჩანაწერი განახლებულია" : "აქტი დამატებულია",res);
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
