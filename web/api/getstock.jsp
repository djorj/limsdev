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
try 
{
    if (request.getParameter("obj").equals("productlist")) 
    {
        String key = request.getParameter("q");
        JSONArray res  = new JSONArray();
        Connection c   = Manager.getInstance().getConnection();
        ResultSet rs;
        try
        {
            String sql = ""
            + " SELECT productid, name"
            + " FROM product "
            + " WHERE "
                    + "code like '%"+key+"%'"
                    + " OR name like '%"+key+"%'"
                    + " OR model like '%"+key+"%'"
                    + " OR serialnum like '%"+key+"%'"
                    + " OR brandname like '%"+key+"%'"
            + " ORDER BY name "
            + "DESC LIMIT 20";
System.out.println(sql);

            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                JSONObject ob = new JSONObject();
                ob.put("id",    rs.getInt(1));
                ob.put("text",  rs.getString(2));
                res.add(ob);
            }
            rs.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally {
            Manager.getInstance().releaseConnection(c);
        }
        
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("contragentlist")) 
    {
        String key = request.getParameter("q");
        JSONArray res  = new JSONArray();
        Connection c   = Manager.getInstance().getConnection();
        ResultSet rs;
        try
        {
            String sql = ""
            + " SELECT contragentid, name"
            + " FROM contragent "
            + " WHERE "
                    + "idn like '%"+key+"%'"
                    + " OR name like '%"+key+"%'"
            + " ORDER BY name "
            + "DESC LIMIT 20";
System.out.println(sql);

            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                JSONObject ob = new JSONObject();
                ob.put("id",    rs.getInt(1));
                ob.put("text",  rs.getString(2));
                res.add(ob);
            }
            rs.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally {
            Manager.getInstance().releaseConnection(c);
        }
        
        out.print(res.toString());
        out.flush();
        return;
    }
    else if(request.getParameter("oper").equalsIgnoreCase("stockpush"))
    {
        Manager.getInstance().beginTransaction();
        try
        {
            StockmovementBean ptp = StockmovementManager.getInstance().createStockmovementBean();
            InvoiceBean inv = InvoiceManager.getInstance().createInvoiceBean();
            String invoicenum  = request.getParameter("invoicenum").trim();
            long invoicedate  = str2date(request.getParameter("invoicedate").trim(),"ზედნადების თარიღი არ არის მითითებული").getTime();
            long quantity = str2long(request.getParameter("quantity").trim(),"რაოდენობა არ არის მითითებული");
            long productid = str2long(request.getParameter("productid").trim(),"საქონელი არ არის მითითებული");
            long expdate1  = str2date(request.getParameter("expdate1").trim(),"ვადა არ არის მითითებული").getTime();
            long expdate2  = str2date(request.getParameter("expdate2").trim(),"ვადა არ არის მითითებული").getTime();
            double price = str2double(request.getParameter("price").trim(),"ერთ. ფასი არ არის მითითებული");

            inv.setOperid(2);  //პროდუქციის მიღება
            inv.setNum(invoicenum);
            inv.setInvoicedate(invoicedate);
            inv.setInvoicetypeid(str2int(request.getParameter("invoicetype").trim(),"ზედნადების ტიპი არ არის მითითებული"));
            inv.setContragentid(str2long(request.getParameter("senddate").trim(),"მომწოდებელი არ არის მითითებული"));
            inv.setPrice(quantity*price);
//          inv.setInvoicesourcetypeid(0);
//          inv.setVat(0);
            inv.setRegbyid(user.getPersonellid());
            inv = InvoiceManager.getInstance().save(inv);
        
            ptp.setOperid(2);
            ptp.setQuantity(quantity);
            ptp.setCurquantity(quantity);
            ptp.setProductid(productid);
            ptp.setUnitprice(price);
            ptp.setExpdate1(expdate1);
            ptp.setExpdate1(expdate2);
            ptp.setOperdate(invoicedate);
            ptp.setNote(request.getParameter("note").trim());
            ptp.setRegbyid(user.getPersonellid());
//          ptp.setMcontragentid(newVal);
            ptp = StockmovementManager.getInstance().save(ptp);
            
            rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
            Manager.getInstance().endTransaction(true);
        }
        catch(Exception e)
        {
            Manager.getInstance().endTransaction(false);
            e.printStackTrace();
            rspJsonMessage(response, "ER", e.getMessage());
        }
    }
    else
    {
        JSONObject ret  = new JSONObject();
        ret.put("status", "ER");
        ret.put("message", "სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას");
        out.println(ret.toString());
        System.out.println(ret.toString());
    }
    return;
}
catch (Exception er) 
{
    er.printStackTrace();
    JSONObject obj  = new JSONObject();
    obj.put("status", "ER");
    obj.put("message", "სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას");
    out.println(obj.toString());
    System.out.println(obj.toString());
}
%>
