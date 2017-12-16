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
        String appealdate =null;
        String samplenum  =null;
        String content    =null;
        String region     =null;
        String raion      =null;
        String city       =null;
        String stamp      =null;
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
                else if (f.equalsIgnoreCase("appealdate"))    appealdate=v;
                else if (f.equalsIgnoreCase("samplenum"))     samplenum=v;
                else if (f.equalsIgnoreCase("region"))        region=v;
                else if (f.equalsIgnoreCase("raion"))         raion=v;
                else if (f.equalsIgnoreCase("city"))          city=v;
                else if (f.equalsIgnoreCase("appealstamp"))   stamp=v;
                else if (f.equalsIgnoreCase("bringer"))       bringer=v;
            }
            else
            {
                docfile = item;
                System.out.println(">FILE:"+item.getName());
            }
        }

        AppealBean obj = null;
        if (id!=null&&!id.isEmpty())
            obj = AppealManager.getInstance().loadByPrimaryKey(Long.parseLong(id));
        else
            obj = AppealManager.getInstance().createAppealBean();
        
        obj.setNum(num);
        obj.setStamp(stamp);
        obj.setBringer(bringer);
        if(obj.getNum().length() == 0)  
            throw new Exception(trs.t("მიმართვის ნომერი შეტანილი არ არის!"));
        else
        {
            AppealBean[] obj2 = AppealManager.getInstance().loadByWhere("WHERE upper(num) = '"+num.toUpperCase().replace("'", "''") +"'");
            if (obj2.length>0 && (obj.getAppealid()==null || obj2[0].getAppealid().compareTo(obj.getAppealid()) != 0))
                throw new Exception(trs.t("მიმართვა ნომრით ~NAME~ უკვე არსებობს!",obj.getNum()));
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

        obj.setAppealdate(str2date(appealdate,"თარიღი არ არის მითითებული"));
        try { 
            obj.setSamplenum(Integer.parseInt(samplenum));
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

        if (docfile!=null) 
        {
            try {
                String itemName = new String(docfile.getName().getBytes("ISO8859_1"), "UTF-8");
                obj.setPath(FilenameUtils.getExtension(itemName));
 	    } catch (Exception e) {
                e.printStackTrace();
                throw new Exception(trs.t("შეცდომა, აქტის დოკუმენტის შენახვისას. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას"));
            }
        }
        
        obj.setRegbyid(user.getPersonellid());
        obj = AppealManager.getInstance().save(obj);
        JSONObject res  = new JSONObject();
        if (obj.getAppealid()!=null&&docfile!=null) 
        {
            try {
                String fp =config.getServletContext().getRealPath("/")+"/documents/appeals/"+obj.getAppealid()+"."+obj.getPath();
                File savedFile = new File(fp);
                docfile.write(savedFile);  
 	    } catch (Exception e) {
                e.printStackTrace();
                throw new Exception(trs.t("შეცდომა, აქტის დოკუმენტის შენახვისას. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას"));
            }
        }
        res.put("id", obj.getAppealid());
        res.put("num", obj.getNum());
        rspJsonMessage(response, "OK", "მიმართვა დამატებულია",res);
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
