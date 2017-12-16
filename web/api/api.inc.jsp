<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.mysoft.lims.*"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="net.sf.json.JSONObject"%>
<%
request.setCharacterEncoding("UTF-8");
String DIR_ACTFILE = "acts";
out.clearBuffer();
response.setContentType("application/json");
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
%>

<%!
String _DATEFORMAT_ = "dd/MM/yyyy";
SimpleDateFormat _DT_  = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat _DTF_ = new SimpleDateFormat("dd/MM/yyyy HH:mm");


public int str2int(String name, String excmsg)  throws Exception
{
    try
    {
        return Integer.parseInt(name.trim());
    }
    catch(Exception ig)
    {
        throw new Exception(excmsg);
    }
}

public long str2long(String name, String excmsg)  throws Exception
{
    try
    {
        return Long.parseLong(name.trim());
    }
    catch(Exception ig)
    {
        throw new Exception(excmsg);
    }
}

public double str2double(String name, String excmsg)  throws Exception
{
    try
    {
        return Double.parseDouble(name.trim());
    }
    catch(Exception ig)
    {
        throw new Exception(excmsg);
    }
}

public Date str2time(String name, String excmsg)  throws Exception
{
    try
    {
        String fmt = "HH:mm";
        SimpleDateFormat dt = new SimpleDateFormat(fmt);
        return dt.parse(name.trim());
    }
    catch(Exception ig)
    {
        throw new Exception(excmsg);
    }
}

public Date str2date(String name, String excmsg)  throws Exception
{
    try
    {
        String fmt = "dd.MM.yyyy";
        SimpleDateFormat dt = new SimpleDateFormat(fmt);
        return dt.parse(name.trim());
    }
    catch(Exception ig)
    {
        try
        {
            String fmt = "dd/MM/yyyy";
            SimpleDateFormat dt = new SimpleDateFormat(fmt);
            return dt.parse(name.trim());
        }
        catch(Exception e)
        {
            throw new Exception(excmsg);
        }   
    }
}

public long str2datetime(String name, String excmsg)  throws Exception
{
    try
    {
        String fmt = "dd.MM.yyyy HH:mm";
        SimpleDateFormat dt = new SimpleDateFormat(fmt);
        return dt.parse(name.trim()).getTime();
    }
    catch(Exception ig)
    {
        try
        {
            String fmt = "dd/MM/yyyy HH:mm";
            SimpleDateFormat dt = new SimpleDateFormat(fmt);
            return dt.parse(name.trim()).getTime();
        }
        catch(Exception e)
        {
            throw new Exception(excmsg);
        }   
    }
}

public Date string2date(String name) throws Exception
{
    SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy");
    return dt.parse(name.trim());
}

public Date string2date(String name,String fmt) throws Exception
{
    SimpleDateFormat dt = new SimpleDateFormat(fmt);
    return dt.parse(name.trim());
}

public Date string2date(String name,String fmt, String excmsg)  throws Exception
{
    try
    {
        SimpleDateFormat dt = new SimpleDateFormat(fmt);
        return dt.parse(name.trim());
    }
    catch(Exception e)
    {
        throw new Exception(excmsg);
    }
}

public String double2currency(double d)
{
    NumberFormat numberFormat = new DecimalFormat("#,###.00");
    
    return numberFormat.format(d);
}

public void rspJsonMessage(HttpServletResponse response, String status, String message)
{
  try {
    JSONObject rsp = new JSONObject();
    rsp.put("status", status);
    rsp.put("message", message);
    PrintWriter wrt = response.getWriter();
    wrt.write(rsp.toString());
    wrt.close();
    System.out.println(rsp.toString());
    return;
  } catch (Exception e) {
    e.printStackTrace();
  }
}
public void rspJsonMessage(HttpServletResponse response, String status, String message,String data)
{
  try {
    JSONObject rsp = new JSONObject();
    rsp.put("status", status);
    rsp.put("message", message);
    rsp.put("data", data);
    PrintWriter wrt = response.getWriter();
    wrt.write(rsp.toString());
    wrt.close();
    System.out.println(rsp.toString());
    return;
  } catch (Exception e) {
    e.printStackTrace();
  }
}

public void rspJsonMessage(HttpServletResponse response, int status, String message)
{
  try {
    JSONObject rsp = new JSONObject();
    rsp.put("status", status);
    rsp.put("message", message);
    PrintWriter wrt = response.getWriter();
    wrt.write(rsp.toString());
    wrt.close();
    System.out.println(rsp.toString());
    return;
  } catch (Exception e) {
    e.printStackTrace();
  }
}

public void rspJsonMessage(HttpServletResponse response, int status, int message)
{
  try {
    JSONObject rsp = new JSONObject();
    rsp.put("status", status);
    rsp.put("message", message);
    PrintWriter wrt = response.getWriter();
    wrt.write(rsp.toString());
    wrt.close();
    System.out.println(rsp.toString());
    return;
  } catch (Exception e) {
    e.printStackTrace();
  }
}
public void rspJsonMessage(HttpServletResponse response, int status, int message, int data)
{
  try {
    JSONObject rsp = new JSONObject();
    rsp.put("status", status);
    rsp.put("message", message);
    rsp.put("data", data);
    PrintWriter wrt = response.getWriter();
    wrt.write(rsp.toString());
    wrt.close();
    System.out.println(rsp.toString());
    return;
  } catch (Exception e) {
    e.printStackTrace();
  }
}
public void rspJsonMessage(HttpServletResponse response, String status, String message, JSONObject data)
{
  try {
    JSONObject rsp = new JSONObject();
    rsp.put("status", status);
    rsp.put("message", message);
    rsp.put("data", data);
    PrintWriter wrt = response.getWriter();
    wrt.write(rsp.toString());
    wrt.close();
    System.out.println(rsp.toString());
    return;
  } catch (Exception e) {
    e.printStackTrace();
  }
}
public long getContrAgent(String ca, long companyid) throws Exception
{
    String tmp[] = ca.trim().split(" ");
    String x = new String(tmp[0].getBytes("ISO8859_1"), "UTF-8");
//System.out.println(ca);
//System.out.println(x);
    x = tmp[0];
//System.out.println(x);
    ContragentBean[] obj = ContragentManager.getInstance().loadByWhere("WHERE idn='"+x+"' AND companyid="+companyid);
    return obj[0].getContragentid();
}
%>