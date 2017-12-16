<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%
String pid = request.getParameter("pid");
String mid = request.getParameter("mid");
String st1 = request.getParameter("st1");
String st2 = request.getParameter("st2");
String st3 = request.getParameter("st3");
String st4 = request.getParameter("st4");

PlevelManager.getInstance().deleteByWhere("where personelltypeid = "+pid+" and menuid = "+mid);
PlevelBean pl = PlevelManager.getInstance().createPlevelBean();
pl.setMenuid(new Integer(mid));
pl.setPersonelltypeid(new Integer(pid));
if(st1.equalsIgnoreCase("true")) pl.setRead(true);
else                             pl.setRead(false);
if(st2.equalsIgnoreCase("true")) pl.setWrite(true);
else                             pl.setWrite(false);
if(st3.equalsIgnoreCase("true")) pl.setPrint(true);
else                             pl.setPrint(false);
if(st4.equalsIgnoreCase("true")) pl.setExport(true);
else                             pl.setExport(false);
pl = PlevelManager.getInstance().save(pl);
%>
