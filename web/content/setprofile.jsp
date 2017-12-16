<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="sun.misc.BASE64Decoder" %>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    String oper = request.getParameter("oper");
    PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    if(oper.equalsIgnoreCase("picture")){
        String data = request.getParameter("pic");
    
        String base64Image = data.split(",")[1];
        String imagetype = ((data.split(",")[0]).split(";")[0]).split("/")[1];
        byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
    
        FileOutputStream io = new FileOutputStream(basedir+"documents/pictures/pic_"+pers.getPersonellid()+"."+imagetype);
        io.write(imageBytes);
        io.close();
    
        pers.setPicture("pic_"+pers.getPersonellid()+"."+imagetype);
        user.setPicture("pic_"+pers.getPersonellid()+"."+imagetype);
    } else if(oper.equalsIgnoreCase("signature")){
        String data = request.getParameter("pic");
    
        String base64Image = data.split(",")[1];
        String imagetype = ((data.split(",")[0]).split(";")[0]).split("/")[1];
        byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
    
        FileOutputStream io = new FileOutputStream(basedir+"documents/signatures/sig_"+pers.getPersonellid()+"."+imagetype);
        io.write(imageBytes);
        io.close();
    
        pers.setSignature("sig_"+pers.getPersonellid()+"."+imagetype);
        user.setSignature("sig_"+pers.getPersonellid()+"."+imagetype);
    } else if(oper.equalsIgnoreCase("delpicture")){
        
        File fl = new File(basedir+"documents/pictures/"+pers.getPicture());
        if(fl.exists()) fl.delete();
    
        pers.setPicture(null);
        user.setPicture(null);
        res.put("picture","documents/pictures/"+((user.getGender().equalsIgnoreCase("M")) ? "male":"female")+".png");
    } else if(oper.equalsIgnoreCase("delsignature")){
        
        File fl = new File(basedir+"documents/signatures/"+pers.getPicture());
        if(fl.exists()) fl.delete();
    
        pers.setSignature(null);
        user.setSignature(null);
        res.put("picture","documents/signatures/signature.png");
    } else if(oper.equalsIgnoreCase("fname")){
        
        pers.setFname(request.getParameter("val"));
        user.setFname(request.getParameter("val"));
    } else if(oper.equalsIgnoreCase("lname")){
        
        pers.setLname(request.getParameter("val"));
        user.setLname(request.getParameter("val"));
    } else if(oper.equalsIgnoreCase("phone")){
        
        pers.setPhone(request.getParameter("val"));
        user.setPhone(request.getParameter("val"));
    } else if(oper.equalsIgnoreCase("email")){
        
        pers.setEmail(request.getParameter("val"));
        user.setEmail(request.getParameter("val"));
    } else if(oper.equalsIgnoreCase("loginid")){
        
        pers.setLoginid(request.getParameter("val"));
        user.setLoginid(request.getParameter("val"));
    }
    
    pers = PersonellManager.getInstance().save(pers);
    
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
    res.put("id",pers.getPersonellid());
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>

