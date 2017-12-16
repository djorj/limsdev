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
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if (isMultipart) 
{
    try 
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


        String actdate    ="";
        String actnum     ="";
        String content    ="";
        String sample     ="";
        String contractid ="";
        
        Iterator itr = items.iterator();
        while (itr.hasNext()) 
        {
            FileItem item = (FileItem) itr.next();
            if (item.isFormField()) 
            {
                String f = item.getFieldName();
                String v = item.getString();

                System.out.println("CHK:"+f+"="+v);

                if      (f.equalsIgnoreCase("actdate"))    actdate=v;
                else if (f.equalsIgnoreCase("actnum"))   actnum=v;
                else if (f.equalsIgnoreCase("content")) content=v;
                else if (f.equalsIgnoreCase("sample")) sample=v;
                else if (f.equalsIgnoreCase("contractid")) contractid=v;
            } 
        }

        ActBean  act   = ActManager.getInstance().createActBean();
        act.setNum(actnum);
        act.setContent(content);
        act.setRegbyid(user.getPersonellid());
//        act.setActdate(actdate);
//        act.setSampleamount(sample);
//        act.setContractid(contractid);
        act = ActManager.getInstance().save(act);
        
        itr = items.iterator();
        while (itr.hasNext()) 
        {
            FileItem item = (FileItem) itr.next();
            if (!item.isFormField()) 
            {
		try {
System.out.println(">FILE:"+item.getName());
                    String itemName = new String(item.getName().getBytes("ISO8859_1"), "UTF-8");
                    String ext = FilenameUtils.getExtension(itemName);
                    File savedFile = new File(config.getServletContext().getRealPath("/")+DIR_ACTFILE+"/"+act.getActid()+"."+ext);
                    item.write(savedFile);  
		} catch (Exception e) {
                    e.printStackTrace();
		}
              }
            }
        JSONObject res  = new JSONObject();
        res.put("status", "OK");
        res.put("message", "");
        out.println(res.toString());
        return;
    }
    catch (Exception er) 
    {
        er.printStackTrace();
        JSONObject obj  = new JSONObject();
        obj.put("status", "OK");
        obj.put("message", "სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას");
        out.println(obj.toString());
        System.out.println(obj.toString());
    }
    return;
} 
%>
