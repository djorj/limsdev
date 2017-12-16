<%@ page language="java" import="java.util.*"%>
<%@ page import="com.mysoft.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mysoft.lims.*"%>
<jsp:useBean id="user" scope="session" class="com.mysoft.lims.PersonellBean"/>
<jsp:useBean id="trs" scope="application" class="com.mysoft.lims.translation"/>
<%
request.setCharacterEncoding("UTF-8");
out.clearBuffer();
if (user == null || user.getPersonellid() == null || user.getPersonellid().intValue() == 0) {
    JSONObject rsp = new JSONObject();
    rsp.put("status", 0);
    rsp.put("message", "Invalid Session");
    return;
}

Enumeration  parameterList = request.getParameterNames();
System.out.println("\n\n\nStarting>>>>>>>>>>>>>\n"+request.getRequestURI()+"\n");
while( parameterList.hasMoreElements() )
{
    String sName = parameterList.nextElement().toString();
    String[] sMultiple = request.getParameterValues( sName );
    if( 1 >= sMultiple.length ) {
        // parameter has a single value. print it.
        System.out.println("\t  " + sName + " = = " + request.getParameter( sName ));
    }
   else
    {
        for( int i=0; i<sMultiple.length; i++ ) {
            System.out.println("\t  " +sName + "[" + i + "] = " + sMultiple[i]);
        }
    }
}



String home = "/data/"+user.getLoginid();

File file = new File(home);
if (!file.isDirectory()) 
{
    if (!file.mkdir()){
        return;
    }
}

FileManager fm = new FileManager(getServletContext(), request, home);
JSONObject responseData = null;
String mode = "";
boolean putTextarea = false;
if(request.getMethod().equals("GET")) 
{
    if(request.getParameter("mode") != null && request.getParameter("mode") != "") 
    {
        mode = request.getParameter("mode");
	if (mode.equals("getinfo")){
            if(fm.setGetVar("path", request.getParameter("path"))) {
                responseData = fm.getInfo();
            }
	}
	else if (mode.equals("getfolder")){
            if(fm.setGetVar("path", request.getParameter("path"))) {
                responseData = fm.getFolder();
            }
	}
	else if (mode.equals("rename")){
            if(fm.setGetVar("old", request.getParameter("old")) && fm.setGetVar("new", request.getParameter("new"))) {
		responseData = fm.rename();
            }
	}
	else if (mode.equals("delete")){
            if(fm.setGetVar("path", request.getParameter("path"))) {
                responseData = fm.delete();
            }
	}
	else if (mode.equals("addfolder")){
            if(fm.setGetVar("path", request.getParameter("path")) && fm.setGetVar("name", request.getParameter("name"))) {
		responseData = fm.addFolder();
            }
	}
	else if (mode.equals("download")){
            if(fm.setGetVar("path", request.getParameter("path"))) {
                fm.download(response);
            }
	}
	else if (mode.equals("preview")){
            if(fm.setGetVar("path", request.getParameter("path"))) {
                fm.preview(response);
            }
	}
	else {
            fm.error(fm.lang("MODE_ERROR"));
	}
    }
}
else if(request.getMethod().equals("POST")){
    if (ServletFileUpload.isMultipartContent(request))
    {
    mode = "upload";
    responseData = fm.add();
    System.out.println("Upload: "+responseData);
    System.out.println("Upload: "+fm.getError());
    putTextarea = true;
    }
}

if (responseData == null) {
    responseData = fm.getError();
}

System.out.println("\t  responseData= " + responseData);

if (responseData != null){
    PrintWriter pw = response.getWriter();
    String responseStr = responseData.toString();
    if (putTextarea)
        responseStr = "<textarea>" + responseStr + "</textarea>";
    //fm.log("c:\\logfilej.txt", "mode:" + mode + ",response:" + responseStr);
    pw.print(responseStr);
    pw.close();
}
%>	
