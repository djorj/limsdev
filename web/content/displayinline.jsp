<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="javax.swing.text.*"%>
<%@page import="javax.swing.text.rtf.*"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="java.lang.reflect.*" %>
<%@page import="java.net.URL"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.CharacterData"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="java.lang.*"%>
<%@page import="org.apache.commons.lang.*"%>
<%@page import="com.itextpdf.text.*" %>
<%@page import="com.itextpdf.text.pdf.*" %>
<%@page import="com.itextpdf.text.pdf.draw.*" %>
<%@page import="net.sf.json.*" %>
<%@page import="com.mysoft.*"%>
<%@page import="com.mysoft.lims.*"%>
<%@page import="com.mysoft.serviceclient.adclient"%>
<%@page import="java.util.logging.*" %>
<%@page import="javax.naming.*" %>
<%@page import="javax.naming.directory.*" %>
<%@page import="java.sql.DatabaseMetaData" %>
<%@page import="javax.imageio.stream.ImageOutputStream" %>
<jsp:useBean id="user" scope="session" class="com.mysoft.lims.PersonellBean"/>
<jsp:useBean id="trs" scope="application" class="com.mysoft.lims.translation"/>
<%@page import="java.nio.file.*" %>
<%
try{
String fileName = request.getParameter("name");
File my_file = new File(fileName);
String fn = my_file.getName();
Path path = FileSystems.getDefault().getPath(fileName);
String fileType = Files.probeContentType(path);
response.setContentType(fileType+"; charset=UTF-8");
response.setCharacterEncoding("UTF-8");
OutputStream oout = response.getOutputStream();
FileInputStream in = new FileInputStream(my_file);
byte[] buffer = new byte[4096];
int length;
while ((length = in.read(buffer)) > 0){
oout.write(buffer, 0, length);
}
in.close();
oout.flush();
}catch(Exception e){
    e.printStackTrace();
}
%>