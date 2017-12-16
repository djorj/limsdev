<%-- 
    Document   : getremoteip
    Created on : Aug 23, 2017, 11:11:32 PM
    Author     : djorj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>IP</title>
    </head>
    <body>
        <h1><%=request.getRemoteAddr()%></h1>
    </body>
</html>
