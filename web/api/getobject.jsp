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
    if      (request.getParameter("obj").equals("contragent"))  out.print(ObjOptions.GetContragent (request.getParameter("key"), 20).toString());
    else if (request.getParameter("obj").equals("exactcontragent"))  {
        JSONObject res = new JSONObject();
        ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("contragentid")));
        res.put("address",contragent.getAddress());
        res.put("bankdata",contragent.getBankdata());
        res.put("companyid",contragent.getCompanyid());
        res.put("contact",contragent.getContact());
        res.put("contragentid",contragent.getContragentid());
        res.put("contragenttypeid",contragent.getContragenttypeid());
        res.put("deleted",contragent.getDeleted());
        res.put("email",contragent.getEmail());
        res.put("fname",contragent.getFname());
        res.put("idn",contragent.getIdn());
        res.put("lname",contragent.getLname());
        res.put("name",contragent.getName());
        res.put("note",contragent.getNote());
        res.put("phone",contragent.getPhone());
        res.put("raionid",contragent.getRaionid());
        res.put("regbyid",contragent.getRegbyid());
        res.put("regdate",contragent.getRegdate());
        res.put("regionid",contragent.getRegionid());
        res.put("type",contragent.getType());
        res.put("url",contragent.getUrl());
        res.put("vat",contragent.getVat());
        res.put("villageid",contragent.getVillageid());
        out.print(res.toString());
    }
    else if (request.getParameter("obj").equals("contract"))    out.print(ObjOptions.GetContragentContract(request.getParameter("contragent")).toString());
    else if (request.getParameter("obj").equals("appeal"))      out.print(ObjOptions.GetContractAppeal(request.getParameter("contract")).toString());
    else if (request.getParameter("obj").equals("act"))         out.print(ObjOptions.GetContractAct(request.getParameter("contract")).toString());
    else if (request.getParameter("obj").equals("contractlist")) 
    {
        String key = request.getParameter("contragentid");
        JSONArray res  = new JSONArray();
        ContractBean[] lst = ContractManager.getInstance().loadByWhere("WHERE contragentid="+key+" AND companyid="+user.getCompanyid()+" ORDER BY contractid DESC");
        for (int i=0;  i<lst.length; i++)
        {
            JSONObject tmp  = new JSONObject();
            tmp.put("id",  lst[i].getContractid());
            tmp.put("num",lst[i].getNum());
            res.add(tmp);
        }
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("contragentlist")) 
    {
        String key = request.getParameter("q");
        JSONArray res  = new JSONArray();
        ContragentBean[] lst = ContragentManager.getInstance().loadByWhere("WHERE idn like '%"+key+"%' OR name like '%"+key+"%' ORDER BY contragentid DESC LIMIT 10");
        for (int i=0;  i<lst.length; i++)
        {
            JSONObject tmp  = new JSONObject();
            tmp.put("id",  lst[i].getContragentid());
            tmp.put("text",lst[i].getIdn()+" "+lst[i].getName());
            res.add(tmp);
        }
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(res.toString());
        return;
    }
    else if (request.getParameter("obj").equals("contractdetails")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        try {
            long cid = Long.parseLong(request.getParameter("contractid"));
            ContractBean con = ContractManager.getInstance().loadByPrimaryKey(cid);
            double leftamount = con.getPrice();
            data.put("type", con.getContracttype());
            
            JSONArray opt = new JSONArray();
            AppealBean[] app = AppealManager.getInstance().loadByWhere("WHERE contractid="+cid+" ORDER BY appealid DESC");
            for (int i=0;  i<app.length; i++)
            {
                JSONObject tmp  = new JSONObject();
                tmp.put("id",app[i].getAppealid());
                tmp.put("num",app[i].getNum());
                opt.add(tmp);
            }
            data.put("appeals", opt);
            
            opt = new JSONArray();
            ActBean[] act = ActManager.getInstance().loadByWhere("WHERE contractid="+cid+" ORDER BY actid DESC");
            for (int i=0;  i<act.length; i++)
            {
                JSONObject tmp  = new JSONObject();
                tmp.put("id",act[i].getActid());
                tmp.put("num",act[i].getNum());
                opt.add(tmp);
            }
            data.put("acts", opt);

            if (con.getContracttype()==1 || 2>1)
            {
                opt = new JSONArray();
                SampletypeBean[] sam = SampletypeManager.getInstance().loadByWhere("where companyid = " + user.getCompanyid() + " order by name");
                for (int i=0;  i<sam.length; i++)
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id", sam[i].getSampletypeid());
                    tmp.put("name",(sam[i].getName()));
                    opt.add(tmp);
                }
                data.put("sampletypes", opt);
            }
            else if (con.getContracttype()==2)
            {
                opt = new JSONArray();
                try
                {
                    String sql = "where companyid = "+user.getCompanyid()+" and sampletypeid in ("
                            + "select labsam.sampletypeid from "
                            + "labtestsampletype labsam, contractlabtest conlab "
                            + "where labsam.labtestid=conlab.labtestid and "
                            + "conlab.contractid="+cid+") "
                            + "order by name";
                    SampletypeBean[] stypes = SampletypeManager.getInstance().loadByWhere(sql);
                    for(int i=0;i<stypes.length;i++)
                    {
                        JSONObject tmp = new JSONObject();
                        tmp.put("id",   stypes[i].getSampletypeid());
                        tmp.put("name", stypes[i].getName());
                        opt.add(tmp);
                    }
                }
                catch(Exception e){
                    e.printStackTrace();
                }
                data.put("sampletypes", opt);
            }


            try
            {
                opt = new JSONArray();
                String sql = "where deleted=false "
                        + "and contractsampleitemid in (select contractsampleitemid from contractsampleitem, contractsampletype "
                        + "where contractsampleitem.contractsampletypeid=contractsampletype.contractsampletypeid "
                        + " AND contractsampletype.deleted = false"
                        + " AND contractsampleitem.deleted = false ) "
                        + "and labtestid in (select labtestid from labtest where deleted = false) and "
                        + "contractid = "+cid+" order by "
                        + "(select l.name from labtest l where l.labtestid = sampleitemreseach.labtestid limit 1)";

                SampleitemreseachBean[] sres = SampleitemreseachManager.getInstance().loadByWhere(sql);
                
                for(int i=0;i<sres.length;i++)
                {
                    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(sres[i].getLabtestid());
                    JSONObject tmp = new JSONObject();
                    tmp.put("id",   sres[i].getSampleitemreseachid());
                    tmp.put("name",  labtest.getName());
                    leftamount -= sres[i].getPrice().doubleValue();
                    opt.add(tmp);
                }
                data.put("contractanalysis", opt);
                
                

                opt = new JSONArray();
                sql = "where companyid = "+user.getCompanyid()+" and sampletypeid in ("
                    + "select sampletypeid from "
                    + "contractsampletype "
                    + "where deleted = false "
                    + "and contractid="+cid+") "
                    + "order by name";
System.out.println(sql);                
                SampletypeBean[] stypes = SampletypeManager.getInstance().loadByWhere(sql);
                for(int i=0;i<stypes.length;i++)
                {
                    JSONObject tmp = new JSONObject();
                    tmp.put("id",   stypes[i].getSampletypeid());
                    tmp.put("name", stypes[i].getName());
                    opt.add(tmp);
                }
                
                data.put("contractsample", opt);
            }
            catch(Exception e){
                e.printStackTrace();
            }
            
            String lefamountname = trs.t("დარჩენილია");
            if(con.getContracttype()==1)
            {
                lefamountname = trs.t("გადასახდელია");
                leftamount = Math.abs(leftamount);
            }
            data.put("leftamount",lefamountname +" "+double2currency(leftamount)+" "+trs.t("ლარი"));
            res.put("status", "OK");
            res.put("data", data);
        }
        catch(Exception e){
            e.printStackTrace();
            res.put("status", "ER");
            res.put("message", "Error Code 1");
        }
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("sampletype")) 
    {
        JSONObject res  = new JSONObject();
        JSONArray opt = new JSONArray();
        if (request.getParameter("labtest")==null || request.getParameter("labtest").isEmpty())
        {
                SampletypeBean[] sam = SampletypeManager.getInstance().loadByWhere("where companyid = " + user.getCompanyid() + " order by name");
                for (int i=0;  i<sam.length; i++)
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id", sam[i].getSampletypeid());
                    tmp.put("name",(sam[i].getName()));
                    opt.add(tmp);
                }
            res.put("status", "OK");
            res.put("data", opt);
        }
        else
        {
                try
                {
                    int n = Integer.parseInt(request.getParameter("labtest"));
                    String sql = "where companyid = "+user.getCompanyid()+" and sampletypeid in ("
                            + "select sampletypeid from labtestsampletype where  labtestid="+n+") "
                            + "order by name";
                    SampletypeBean[] stypes = SampletypeManager.getInstance().loadByWhere(sql);
                    for(int i=0;i<stypes.length;i++)
                    {
                        JSONObject tmp = new JSONObject();
                        tmp.put("id",   stypes[i].getSampletypeid());
                        tmp.put("name", stypes[i].getName());
                        opt.add(tmp);
                    }
                res.put("status", "OK");
                res.put("data", opt);
                }
                catch(Exception e){
                    e.printStackTrace();
                }
        }

        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("labtest")) 
    {
        JSONObject res  = new JSONObject();
        JSONArray opt = new JSONArray();
        if (request.getParameter("sample")==null || request.getParameter("sample").isEmpty())
        {
                LabtestBean[] sam = LabtestManager.getInstance().loadByWhere("where companyid = " + user.getCompanyid() + " order by name");
                for (int i=0;  i<sam.length; i++)
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id", sam[i].getLabtestid());
                    tmp.put("name",(sam[i].getName()));
                    opt.add(tmp);
                }
            res.put("status", "OK");
            res.put("data", opt);
        }
        else
        {
                try
                {
                    int n = Integer.parseInt(request.getParameter("sample"));
                    String sql = "where companyid = "+user.getCompanyid()+" and labtestid in ("
                            + "select labtestid from labtestsampletype where  sampletypeid ="+n+") "
                            + "order by name";
                    LabtestBean[] stypes = LabtestManager.getInstance().loadByWhere(sql);
                    for(int i=0;i<stypes.length;i++)
                    {
                        JSONObject tmp = new JSONObject();
                        tmp.put("id",   stypes[i].getLabtestid());
                        tmp.put("name", stypes[i].getName());
                        opt.add(tmp);
                    }
                res.put("status", "OK");
                res.put("data", opt);
                }
                catch(Exception e){
                    e.printStackTrace();
                }
        }

        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("contractbill")) 
    {
        long cid = Long.parseLong(request.getParameter("contractid"));
        ContractBean con  = ContractManager.getInstance().loadByPrimaryKey(cid);
        BillBean[] bills = BillManager.getInstance().loadByContractid(con.getContractid());
        JSONArray bls = new JSONArray();
        for(int i=0;i<bills.length;i++){
            JSONObject o = new JSONObject();
            o.put("id", bills[i].getBillid());
            o.put("num", bills[i].getNum());
            o.put("path", bills[i].getPath());
            bls.add(o);
        }
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", bls);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("contractdocs")) 
    {
        long cid = Long.parseLong(request.getParameter("contractid"));
        ContractBean con  = ContractManager.getInstance().loadByPrimaryKey(cid);
        DocsBean[] docs = DocsManager.getInstance().loadByContractid(con.getContractid());
        JSONArray data = new JSONArray();
        for(int i=0;i<docs.length;i++){
            DoctypeBean dct = DoctypeManager.getInstance().loadByPrimaryKey(docs[i].getDoctypeid());
            JSONObject o = new JSONObject();
            o.put("id", docs[i].getDocsid());
            o.put("doctypeid", docs[i].getDoctypeid());
            o.put("path", docs[i].getPath());
            o.put("doctype", dct.getName());
            data.add(o);
        }
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", data);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("contractreport")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data = new JSONObject();
        JSONArray opt   = new JSONArray();
        Connection c   = Manager.getInstance().getConnection();
        ResultSet rs;
        try
        {
            long cid = Long.parseLong(request.getParameter("contractid"));
            long appealid = 0;
            long actid = 0;
            try{ appealid = Long.parseLong(request.getParameter("appealid")); }catch(Exception ign){}
            try{ actid = Long.parseLong(request.getParameter("actid")); }catch(Exception ign){}
            String sql0 = " AND contractid="+cid;
            if(appealid > 0)  sql0 += " and appealid = "+appealid;
            if(actid > 0)  sql0 += " and actid = "+actid;
            
            ContractBean con  = ContractManager.getInstance().loadByPrimaryKey(cid);
            double leftamount = con.getPrice();
            data.put("type", con.getContracttype());

            String sql = " SELECT distinct lt.labtestid,lt.name labtestname "
                + "FROM sampleitemreseach sr, labtest lt "
                + "WHERE sr.labtestid=lt.labtestid "
                    + " AND sr.deleted=false "
                    + " AND sr.contractsampleitemid IN ("
                    + "SELECT contractsampleitemid from contractsampleitem, contractsampletype "
                    + "WHERE contractsampleitem.contractsampletypeid=contractsampletype.contractsampletypeid "
                        + " AND contractsampletype.deleted = false "
                        + " AND contractsampleitem.deleted = false "
                    + sql0
                    + ") "
                    +  "AND contractid = "+cid
                +" ORDER BY lt.name";
System.out.println(sql);
            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                JSONObject tmp = new JSONObject();
                tmp.put("id",    rs.getLong("labtestid"));
                tmp.put("name",  rs.getString("labtestname"));
                opt.add(tmp);
            }
            rs.close();
            data.put("contractanalysis", opt);
            
            
            opt = new JSONArray();
            sql = "SELECT * FROM sampletype "
                + "WHERE companyid = "+user.getCompanyid()
                + " AND sampletypeid in ("
                + " SELECT sampletypeid FROM "
                    + "contractsampletype "
                    + "WHERE deleted = false AND ((isbox=true AND parentid is null) or isbox = false) "
                    + "AND contractid="+cid
                    + sql0
                    + ") "
                + "ORDER BY name";
            sql = "SELECT * FROM sampletype "
                + "WHERE companyid = "+user.getCompanyid()
                + " AND sampletypeid in ("
                + " SELECT distinct sampletypeid FROM "
                    + "contractsampletype "
                    + "WHERE deleted = false "
                    + "AND contractid="+cid
                    + sql0
                    + ") "
                + "ORDER BY name";
System.out.println(sql);
            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                JSONObject tmp = new JSONObject();
                tmp.put("id",   rs.getInt("sampletypeid"));
                tmp.put("name", rs.getString("name"));
                opt.add(tmp);
            }
            rs.close();
            data.put("contractsample", opt);
            
            
            opt = new JSONArray();
            VContractTestlistBean[] ctests = VContractTestlistManager.getInstance().loadByWhere("where contractid = "+cid+sql0+" order by labtestname");
            for(int i=0;i<ctests.length;i++)
            {
                JSONObject tmp = new JSONObject();
                tmp.put("id",  ctests[i].getLabtestid());
                tmp.put("text",ctests[i].getLabtestname());
                opt.add(tmp);
            }
            data.put("testlist", opt);
            
            sql = " SELECT sum(price) price "
                + "FROM sampleitemreseach sr, labtest lt "
                + "WHERE sr.labtestid=lt.labtestid "
                    + " AND sr.deleted=false "
                    + " AND sr.contractsampleitemid IN ("
                    + "SELECT contractsampleitemid from contractsampleitem, contractsampletype "
                    + "WHERE contractsampleitem.contractsampletypeid=contractsampletype.contractsampletypeid "
                        + " AND contractsampletype.deleted = false "
                        + " AND contractsampleitem.deleted = false "
                    + sql0
                    + ") "
                    +  "AND contractid = "+cid;
System.out.println(sql);
            rs = c.createStatement().executeQuery(sql);
            if (rs.next())
                leftamount -= rs.getDouble("price");
            rs.close();
            String lefamountname = trs.t("დარჩენილია");
            if(con.getContracttype()==1)
            {
                lefamountname = trs.t("გადასახდელია");
                leftamount = Math.abs(leftamount);
            }
            data.put("leftamount",lefamountname +" "+dc.format(leftamount)+" "+trs.t("ლარი"));
            res.put("status", "OK");
            res.put("data", data);
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
    else if (request.getParameter("obj").equals("contractreport_to_remove")) 
    {
        
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        try {
            long cid = Long.parseLong(request.getParameter("contractid"));
            ContractBean con  = ContractManager.getInstance().loadByPrimaryKey(cid);
            double leftamount = con.getPrice();
            data.put("type", con.getContracttype());
            
            JSONArray opt = new JSONArray();
            try
            {
                opt = new JSONArray();
                String sql = "where deleted=false "
                        + "and contractsampleitemid in (select contractsampleitemid from contractsampleitem, contractsampletype "
                        + "where contractsampleitem.contractsampletypeid=contractsampletype.contractsampletypeid "
                        + " AND contractsampletype.deleted = false"
                        + " AND contractsampleitem.deleted = false ) "
                        + "and labtestid in (select labtestid from labtest where deleted = false) and "
                        + "contractid = "+cid+" order by "
                        + "(select l.name from labtest l where l.labtestid = sampleitemreseach.labtestid limit 1)";
System.out.println(sql);                
                SampleitemreseachBean[] sres = SampleitemreseachManager.getInstance().loadByWhere(sql);
                for(int i=0;i<sres.length;i++)
                {
                    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(sres[i].getLabtestid());
                    JSONObject tmp = new JSONObject();
                    tmp.put("id",   sres[i].getSampleitemreseachid());
                    tmp.put("name",  labtest.getName());
                    leftamount -= sres[i].getPrice().doubleValue();
                    opt.add(tmp);
                }

                data.put("contractanalysis", opt);
                                
                opt = new JSONArray();
                sql = "where companyid = "+user.getCompanyid()+" and sampletypeid in ("
                    + "select sampletypeid from "
                    + "contractsampletype "
                    + "where deleted = false AND ((isbox=true AND parentid is null) or isbox = false)"
                    + "and contractid="+cid+") "
                    + "order by name";
                SampletypeBean[] stypes = SampletypeManager.getInstance().loadByWhere(sql);
                for(int i=0;i<stypes.length;i++)
                {
                    JSONObject tmp = new JSONObject();
                    tmp.put("id",   stypes[i].getSampletypeid());
                    tmp.put("name", stypes[i].getName());
                    opt.add(tmp);
                }
                data.put("contractsample", opt);

                opt = new JSONArray();
                VContractTestlistBean[] ctests = VContractTestlistManager.getInstance().loadByWhere("where contractid = "+cid+" order by labtestname");
                for(int i=0;i<ctests.length;i++)
                {
                    JSONObject tmp = new JSONObject();
                    tmp.put("id",  ctests[i].getLabtestid());
                    tmp.put("text",ctests[i].getLabtestname());
                    opt.add(tmp);
                }
                data.put("testlist", opt);
            }
            catch(Exception e){
                e.printStackTrace();
            }

            String lefamountname = trs.t("დარჩენილია");
            if(con.getContracttype()==1)
            {
                lefamountname = trs.t("გადასახდელია");
                leftamount = Math.abs(leftamount);
            }
            data.put("leftamount",lefamountname +" "+dc.format(leftamount)+" "+trs.t("ლარი"));
            res.put("status", "OK");
            res.put("data", data);
        }
        catch(Exception e){
            e.printStackTrace();
            res.put("status", "ER");
            res.put("message", "Error Code 1");
        }
        out.print(res.toString());
        out.flush();
        return;
    }        
    else if (request.getParameter("obj").equals("contractlabtest")) 
    {
        JSONArray res  = new JSONArray();
        try
        {
            long cid = Long.parseLong(request.getParameter("contractid"));
            VContractTestBean[] ctests = VContractTestManager.getInstance().loadByWhere("where contractid = "+cid+" order by labtestname, samplename");
            for(int i=0;i<ctests.length;i++)
            {
                JSONObject tmp = new JSONObject();
                tmp.put("id",  ctests[i].getLabtestid()+"."+ctests[i].getSampletypeid());
                tmp.put("text",ctests[i].getLabtestname()+" - "+ctests[i].getSamplename());
                res.add(tmp);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("contractanalysis")) 
    {
        JSONArray res  = new JSONArray();
        try
        {
            long cid = Long.parseLong(request.getParameter("contractid"));
            String sql = "where deleted=false and labtestid in (select labtestid from labtest where deleted = false) and "
                        + "contractid = "+cid+" order by "
                        + "(select l.name from labtest l where l.labtestid = sampleitemreseach.labtestid limit 1)";
                SampleitemreseachBean[] sres = SampleitemreseachManager.getInstance().loadByWhere(sql);
                
            for(int i=0;i<sres.length;i++)
            {
                LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(sres[i].getLabtestid());
                JSONObject ob = new JSONObject();
                ob.put("id",   sres[i].getSampleitemreseachid());
                ob.put("text",  labtest.getName());
                res.add(ob);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("institution")) 
    {
        JSONArray res  = new JSONArray();
        Connection c   = Manager.getInstance().getConnection();
        ResultSet rs;
        try
        {
            String tmp[] = request.getParameter("analysis").trim().split("\\.");
            long cid = Long.parseLong(tmp[0]);

            String sql = ""
            + " SELECT ins.institutionid, ins.name"
            + " FROM institution ins, labtestinstitution labins, labtest lab"
            + " WHERE ins.institutionid=labins.institutionid"
            + " AND labins.labtestid=lab.labtestid"
            + " AND lab.labtestid="+cid
            + " ORDER BY lab.name";

            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                JSONObject ob = new JSONObject();
                ob.put("id",  rs.getInt(1));
                ob.put("text",  (rs.getString(2)));
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
    else if (request.getParameter("obj").equals("contractsample")) 
    {
        JSONArray res  = new JSONArray();
        JSONArray box  = new JSONArray();
        Connection c   = Manager.getInstance().getConnection();
        ResultSet rs;
        try
        {
            long cid = Long.parseLong(request.getParameter("contractid"));
            long appealid = 0;
            long actid = 0;
            try{ appealid = Long.parseLong(request.getParameter("appealid")); }catch(Exception ign){}
            try{ actid = Long.parseLong(request.getParameter("actid")); }catch(Exception ign){}
            String sql0 = " AND con.contractid="+cid;
            if(appealid > 0)  sql0 += " and con.appealid = "+appealid;
            if(actid > 0)  sql0 += " and con.actid = "+actid;

            String sql = ""
            + " SELECT distinct sam.sampletypeid, sam.name"
            + " FROM contractsampletype con, sampletype sam"
            + " WHERE con.sampletypeid=sam.sampletypeid"
            + " AND con.deleted = FALSE"
            + " AND isbox=false"
            + sql0
            + " ORDER BY sam.name";


            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                JSONObject ob = new JSONObject();
                ob.put("id",  rs.getInt(1));
                ob.put("name",  (rs.getString(2)));
                res.add(ob);
            }
            rs.close();
            
            
            sql = "SELECT con.contractsampletypeid,itm.contractsampleitemid"
                    + " FROM contractsampletype con, contractsampleitem itm "
                    + " WHERE con.contractsampletypeid=itm.contractsampletypeid "
                    + "  AND con.isbox=true "
                    + "  AND con.parentid is null "
                    + "  AND con.deleted = FALSE "
                    + "  AND itm.deleted = FALSE "
                    + sql0
                    + "ORDER BY con.contractsampletypeid,itm.contractsampleitemid ";

            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                sql = "SELECT sampleboxreseachid FROM sampleboxreseach "
                + "WHERE deleted=false "
                + "AND contractsampletypeid IN ("
                +   "SELECT contractsampletypeid "
                +   "FROM contractsampletype "
                +   "WHERE deleted=false AND parentid=" + rs.getLong(1) 
                +   ")";
System.out.println(sql);                
                ResultSet r2 = c.createStatement().executeQuery(sql);
                if (r2.next())
                {
                    JSONObject ob = new JSONObject();
                    ob.put("id",   rs.getInt(1));
                    ob.put("name", "ყუთი (#"+rs.getString(2)+")");
                    box.add(ob);
                }
            }
            rs.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally {
            Manager.getInstance().releaseConnection(c);
        }
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        ret.put("box",  box);
        out.print(ret.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("testlist")) 
    {
        JSONArray res  = new JSONArray();
        Connection c   = Manager.getInstance().getConnection();
        ResultSet rs;
        try
        {
            long id = Long.parseLong(request.getParameter("sampleitemid"));
            ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(id);
            ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
            String sql = ""
            + " SELECT lab.labtestid, lab.name"
            + " FROM labtestsampletype labsam, labtest lab"
            + " WHERE labsam.labtestid=lab.labtestid"
            + " AND labsam.sampletypeid="+sam.getSampletypeid()
            + " ORDER BY lab.name";

            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                JSONObject ob = new JSONObject();
                ob.put("id",  ""+rs.getInt(1));
                ob.put("text",  (rs.getString(2)));
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
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(ret.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("testgroup")) 
    {
        JSONArray res  = new JSONArray();
        JSONArray devices = new JSONArray();
        Connection c   = Manager.getInstance().getConnection();
        ResultSet rs;
        try
        {
            int id = Integer.parseInt(request.getParameter("id"));
            LabtestBean grp = LabtestManager.getInstance().loadByPrimaryKey(id);
            String sql = ""
            + " SELECT lab.labtestid, lab.name"
            + " FROM labtest lab, testgroup grp"
            + " WHERE lab.labtestid=grp.labtestid"
            + " AND grp.testgroupid="+id
            + " ORDER BY lab.name";

            rs = c.createStatement().executeQuery(sql);
            while(rs.next())
            {
                JSONObject ob = new JSONObject();
                ob.put("id",  ""+rs.getInt(1));
                ob.put("text",  (rs.getString(2)));
                res.add(ob);
            }
            rs.close();
            DeviceBean[] devs = DeviceManager.getInstance().loadByWhere("where deviceid in (select deviceid from devicelabtest where labtestid = "+id+")");
            
            for(int i=0;i<devs.length;i++){
                JSONObject ob = new JSONObject();
                ob.put("id",  devs[i].getDeviceid());
                ob.put("name", devs[i].getName());
                ob.put("hasplate", devs[i].getHasplate());
                devices.add(ob);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally {
            Manager.getInstance().releaseConnection(c);
        }
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        ret.put("devices",devices);
        out.print(ret.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("objcontragent")) 
    {
        JSONObject res  = new JSONObject();
        ContragentBean  obj   = ContragentManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("contragentid")));
        res.put("id",         obj.getContragentid());
        res.put("address",    obj.getAddress());
        res.put("bankdata",   obj.getBankdata());
        res.put("email",      obj.getEmail());
        res.put("idn",        obj.getIdn());
        res.put("name",       obj.getName());
        res.put("note",       obj.getNote());
        res.put("phone",      obj.getPhone());
        res.put("raion",      obj.getRaionid());
        res.put("region",     obj.getRegionid());
        res.put("city",       obj.getVillageid());
        res.put("contact",    obj.getContact());
        res.put("url",        obj.getUrl());
        res.put("contragenttypeid", obj.getContragenttypeid());

        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("objcontract")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject tmp  = new JSONObject();
        ContractBean   obj    = ContractManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("contract")));
        ContragentBean agent  = ContragentManager.getInstance().loadByPrimaryKey(obj.getContragentid());
        res.put("id",          obj.getContractid());
        res.put("num",         obj.getNum());
        res.put("contragentid",obj.getContragentid());
        res.put("agentname",   agent.getIdn()+" "+agent.getName());
        res.put("contractid",  obj.getContractid());
        res.put("contracttype",obj.getContracttype());
        res.put("sampletypeid",obj.getSampletypeid());
        res.put("contractprice",       obj.getPrice());
        res.put("info",        obj.getInfo());
        res.put("status",      obj.getStatus());
        res.put("startdate",  _DT_.format(obj.getStartdate()));
        res.put("enddate",    _DT_.format(obj.getEnddate()));

        if (obj.getContracttype()==2)
        {
            JSONArray lab  = new JSONArray();
            ContractlabtestBean[]  test   = ContractlabtestManager.getInstance().loadByWhere("WHERE contractid="+obj.getContractid());
            for (int i=0; i<test.length; i++)
            {
                tmp = new JSONObject();
                tmp.put("id",test[i].getContractlabtestid());    
                tmp.put("labtestid",test[i].getLabtestid());    
                tmp.put("sampleid",test[i].getSampletypeid());    
                tmp.put("maxprice",test[i].getMaxprice());    
                tmp.put("maxnum",test[i].getMaxcnt());    
                tmp.put("maxday",test[i].getMaxday());    
                tmp.put("minday",test[i].getMinday());    
                tmp.put("comment",test[i].getInfo());    
                lab.add(tmp);
            }
            res.put("labtest", lab);
        }
        else 
        {
            res.put("transfer",  obj.getTransfer());
            if (obj.getContractownerid()!=null)
            {
                ContractownerBean own  = ContractownerManager.getInstance().loadByPrimaryKey(obj.getContractownerid());
                if (own!=null)
                {
                    tmp = new JSONObject();
                    tmp.put("contractownerid",own.getContractownerid());
                    tmp.put("fname",  own.getFname());
                    tmp.put("lname",  own.getLname());
                    tmp.put("idn",    own.getIdn());
                    tmp.put("address",own.getAddress());
                    res.put("owner",  tmp);
                }
            }
        }
        BillBean[] bills = BillManager.getInstance().loadByContractid(obj.getContractid());
        JSONArray bls = new JSONArray();
        for(int i=0;i<bills.length;i++){
            JSONObject o = new JSONObject();
            o.put("id", bills[i].getBillid());
            o.put("num", bills[i].getNum());
            o.put("path", bills[i].getPath());
            bls.add(o);
        }
        res.put("bills",bls);
        
        DocsBean[] docs = DocsManager.getInstance().loadByContractid(obj.getContractid());
        JSONArray arr = new JSONArray();
        for(int i=0;i<docs.length;i++){
            DoctypeBean dct = DoctypeManager.getInstance().loadByPrimaryKey(docs[i].getDoctypeid());
            JSONObject o = new JSONObject();
            o.put("id", docs[i].getDocsid());
            o.put("doctypeid", docs[i].getDoctypeid());
            o.put("path", docs[i].getPath());
            o.put("doctype", dct.getName());
            arr.add(o);
        }
        res.put("docs",arr);
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("objappeal")) 
    {
        JSONObject res  = new JSONObject();
        AppealBean    obj   = AppealManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("appealid")));
        ContractBean  ob2   = ContractManager.getInstance().loadByPrimaryKey(obj.getContractid());
        res.put("id",          obj.getAppealid());
        res.put("contractid",  obj.getContractid());
        res.put("contractnum", ob2.getNum());
        res.put("num",         obj.getNum());
        res.put("appealdate",  _DT_.format(obj.getAppealdate()));
        res.put("samplenum",   obj.getSamplenum());
        res.put("region",      obj.getRegionid());
        res.put("raion",       obj.getRaionid());
        res.put("city",        obj.getVillageid());
        res.put("appealstamp", obj.getStamp());
        res.put("bringer",     (obj.getBringer() != null) ? obj.getBringer():"");
            
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("objact")) 
    {
        JSONObject res  = new JSONObject();
        ActBean  obj   = ActManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("actid")));
        ContractBean  ob2   = ContractManager.getInstance().loadByPrimaryKey(obj.getContractid());
        res.put("id",          obj.getActid());
        res.put("contractid",  obj.getContractid());
        res.put("contractnum", ob2.getNum());
        res.put("num",         obj.getNum());
        res.put("actdate",     _DT_.format(obj.getActdate()));
        res.put("samplenum",   obj.getSampleamount());
        res.put("content",     obj.getContent());
        res.put("region",      obj.getRegionid());
        res.put("raion",       obj.getRaionid());
        res.put("city",        obj.getVillageid());
        res.put("bringer",     (obj.getBringer() != null) ? obj.getBringer():"");
            
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("region")) 
    {
        JSONArray res  = new JSONArray();
        int countryid = (request.getParameter("countryid")==null) ? 76 : Integer.parseInt(request.getParameter("countryid"));
        int punitid   = 0;
        try{ punitid = (request.getParameter("punitid")==null) ? 0 : Integer.parseInt(request.getParameter("punitid")); }catch(Exception ignore){}
        String sql    = punitid > 0 ? "where countryid="+countryid+" and punitid="+punitid + " order by name" : "where countryid="+countryid+" and punitid is null order by name";
        TunitBean[] list = TunitManager.getInstance().loadByWhere(sql);
        for(int i=0; i<list.length;i++) {
            JSONObject ob = new JSONObject();
            ob.put("id",    list[i].getTunitid());
            ob.put("text",(list[i].getName()));
            res.add(ob);
        }

        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("blocknumlist")) 
    {
        String key = request.getParameter("q");
        JSONArray res  = new JSONArray();
        Connection c   = Manager.getInstance().getConnection();
        ResultSet rs;
        try
        {
            String sql = ""
            + " SELECT itm.contractsampletypeid, itm.barcode"
            + " FROM contractsampletype sam, contractsampleitem itm"
            + " WHERE sam.contractsampletypeid=itm.contractsampletypeid "
            + " AND sam.deleted = FALSE"
            + " AND sam.isbox=true AND sam.parentid is null AND itm.barcode like '%"+key+"%'"
            + " ORDER BY contractsampletypeid "
            + "DESC LIMIT 10";
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
    else if (request.getParameter("obj").equals("boxsamples")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        try {
            long id = Long.parseLong(request.getParameter("boxsample"));
            ContractsampletypeBean box = ContractsampletypeManager.getInstance().loadByPrimaryKey(id);
            ContractBean con = ContractManager.getInstance().loadByPrimaryKey(box.getContractid());
            data.put("contract", con.getNum());
            
            JSONArray optsample = new JSONArray();
            JSONArray opttest = new JSONArray();
            Connection c  = Manager.getInstance().getConnection();
            ResultSet rs;
            try
            {
                String sql = ""
            + " SELECT con.contractsampletypeid, sam.name, con.quantity"
            + " FROM contractsampletype  con, sampletype sam"
            + " WHERE con.sampletypeid=sam.sampletypeid AND con.isbox=true AND parentid="+id
            + " AND con.deleted = FALSE"
            + " ORDER BY sam.name";

                rs = c.createStatement().executeQuery(sql);
                while(rs.next())
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id",  rs.getInt(1));
                    tmp.put("name",(rs.getString(2)));
                    tmp.put("cnt", rs.getInt(3));
                    optsample.add(tmp);
                }
                rs.close();
                
                
                sql = ""
            + " SELECT con.contractsampletypeid, test.name"
            + " FROM sampleboxreseach  con, labtest test"
            + " WHERE con.labtestid=test.labtestid AND con.contractsampletypeid="+id
            + " AND con.deleted = FALSE"
            + " ORDER BY test.name";

                rs = c.createStatement().executeQuery(sql);
                while(rs.next())
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id",  rs.getInt(1));
                    tmp.put("name",(rs.getString(2)));
                    opttest.add(tmp);
                }
                rs.close();
                
            }
            catch (Exception e){e.printStackTrace();}
            finally {Manager.getInstance().releaseConnection( c );}
            
            data.put("sampletypes", optsample);
            data.put("labtest", opttest);
            res.put("status", "OK");
            res.put("data", data);
        }
        catch(Exception e){
            e.printStackTrace();
            res.put("status", "ER");
            res.put("message", "Error Code 1");
        }
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("boxsampledetails")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        int total = 0;
        int submited = 0;
        int disclaim = 0;
        try {
            long id       = Long.parseLong(request.getParameter("sampleid"));
            Connection c  = Manager.getInstance().getConnection();
            ResultSet rs;
            JSONArray optsample = new JSONArray();
            try
            {
                String sql = "SELECT quantity FROM contractsampletype WHERE isbox=true AND contractsampletypeid="+id+ " AND deleted = FALSE";
System.out.println(sql);
                rs = c.createStatement().executeQuery(sql);
                total = rs.next() ? rs.getInt("quantity") : 0;
                rs.close();
                
                sql = ""
            + " SELECT count(*),sum(CASE WHEN disclaim=true THEN 1 ELSE 0 END)"
            + " FROM contractsampletype  sam, contractsampleitem itm"
            + " WHERE sam.contractsampletypeid=itm.contractsampletypeid AND sam.isbox=true AND sam.contractsampletypeid="+id
            + " AND sam.deleted = FALSE"
            + " AND itm.num1 is not null";

                rs = c.createStatement().executeQuery(sql);
                if (rs.next())
                {
                    submited = rs.getInt(1);
                    disclaim = rs.getInt(2);
                }
                rs.close();
                
                ContractsampletypeBean cb = ContractsampletypeManager.getInstance().loadByPrimaryKey(id);
                LabtestBean[] lbs = LabtestManager.getInstance().loadByWhere("where labtestid in (select labtestid from labtestsampletype where sampletypeid = "+cb.getSampletypeid()+")");
                for(int i=0;i<lbs.length;i++){
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id",  lbs[i].getLabtestid());
                    tmp.put("name",lbs[i].getName());
                    optsample.add(tmp);
                }
                
                
            }
            catch (Exception e){e.printStackTrace();}
            finally {Manager.getInstance().releaseConnection( c );}

            data.put("labtests",    optsample);
            data.put("total",    total);
            data.put("submited", submited);
            data.put("approved", submited-disclaim);
            data.put("disclaim", disclaim);
            data.put("leftnum",  total-submited);
            res.put("status", "OK");
            res.put("data", data);
        }
        catch(Exception e){
            e.printStackTrace();
            res.put("status", "ER");
            res.put("message", "Error Code 1");
        }
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("boxtests")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        try {
            long id = Long.parseLong(request.getParameter("boxid"));
            ContractsampletypeBean box = ContractsampletypeManager.getInstance().loadByPrimaryKey(id);
            ContractBean con = ContractManager.getInstance().loadByPrimaryKey(box.getContractid());
            data.put("contract", con.getNum());
            
            JSONArray optsample = new JSONArray();
            JSONArray opttest = new JSONArray();
            Connection c  = Manager.getInstance().getConnection();
            ResultSet rs;
            try
            {
                String sql = ""
            + " SELECT distinct test.labtestid, test.name"
            + " FROM sampleitemreseach  con, contractsampleitem itm, contractsampletype sam, labtest test"
            + " WHERE con.contractsampleitemid=itm.contractsampleitemid "
                    + " AND itm.contractsampletypeid=sam.contractsampletypeid "
                    + " AND con.labtestid=test.labtestid "
                    + " AND itm.deleted = FALSE "
                    + " AND sam.deleted = FALSE "
                    + " AND con.deleted = FALSE "
                    + " AND sam.parentid="+id
            + " ORDER BY test.name";
System.out.println(sql);

                rs = c.createStatement().executeQuery(sql);
                while(rs.next())
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id",  rs.getInt(1));
                    tmp.put("name",(rs.getString(2)));
                    opttest.add(tmp);
                }
                rs.close();
                
            }
            catch (Exception e){e.printStackTrace();}
            finally {Manager.getInstance().releaseConnection( c );}
            
            data.put("sampletypes", optsample);
            data.put("labtest", opttest);
            res.put("status", "OK");
            res.put("data", data);
        }
        catch(Exception e){
            e.printStackTrace();
            res.put("status", "ER");
            res.put("message", "Error Code 1");
        }
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("boxtestinfo")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        try {
            long boxid  = Long.parseLong(request.getParameter("boxid"));
            long testid = Long.parseLong(request.getParameter("testid"));
            long submited   = 0;
            long disclaim = 0;
            ContractsampletypeBean box = ContractsampletypeManager.getInstance().loadByPrimaryKey(boxid);
            ContractBean con = ContractManager.getInstance().loadByPrimaryKey(box.getContractid());
            data.put("contract", con.getNum());
            
            JSONArray optsample = new JSONArray();
            JSONArray opttest = new JSONArray();
            Connection c  = Manager.getInstance().getConnection();
            ResultSet rs;
            try
            {
                String sql = ""
            + " SELECT con.sampleitemreseachid, con.contractsampleitemid, con.result, con.status"
            + " FROM sampleitemreseach  con, contractsampleitem itm, contractsampletype sam"
            + " WHERE con.contractsampleitemid=itm.contractsampleitemid "
                    + " AND itm.contractsampletypeid=sam.contractsampletypeid "
                    + " AND itm.deleted = FALSE "
                    + " AND sam.deleted = FALSE "
                    + " AND con.deleted = FALSE "
                    + " AND con.labtestid="+testid
                    + " AND sam.parentid="+boxid
            + " ORDER BY con.contractsampleitemid";
System.out.println(sql);

                rs = c.createStatement().executeQuery(sql);
                
                while(rs.next())
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id",   rs.getInt(1));
                    tmp.put("name", rs.getString(2));
                    opttest.add(tmp);
                    if (rs.getString(3)!=null)
                        submited++;
                    if (rs.getString(4)!=null && rs.getString(4).equals("2"))
                        disclaim++;
                }
                rs.close();
                
            }
            catch (Exception e){e.printStackTrace();}
            finally {Manager.getInstance().releaseConnection( c );}
            
            data.put("sampleitem", opttest);
            data.put("total", opttest.size());
            data.put("submited", submited);
            data.put("disclaim", disclaim);
            res.put("status", "OK");
            res.put("data", data);
        }
        catch(Exception e){
            e.printStackTrace();
            res.put("status", "ER");
            res.put("message", "Error Code 1");
        }
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("boxtestreport")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        try {
            long boxid  = Long.parseLong(request.getParameter("boxid"));
            long testid = Long.parseLong(request.getParameter("testid"));
            long submited = 0;
            long disclaim = 0;
            long total = 0;
            Connection c  = Manager.getInstance().getConnection();
            ResultSet rs;
            try
            {
                String sql = ""
                + " SELECT count(*) "
                + " FROM sampleitemreseach srh, contractsampletype sam, contractsampleitem itm"
                + " WHERE srh.labtestid="+testid
                + " AND  srh.contractsampleitemid=itm.contractsampleitemid "
                + " AND  itm.contractsampletypeid=sam.contractsampletypeid "
                + " AND  srh.deleted<>true"
                + " AND  srh.result IS NOT NULL"
                + " AND  srh.status=2 "
                + " AND  sam.parentid="+boxid;
                rs = c.createStatement().executeQuery(sql);
                if (rs.next())
                    disclaim = rs.getInt(1);
                
                    sql = ""
                + " SELECT count(*) "
                + " FROM sampleitemreseach srh, contractsampletype sam, contractsampleitem itm"
                + " WHERE srh.labtestid="+testid
                + " AND  srh.contractsampleitemid=itm.contractsampleitemid "
                + " AND  itm.contractsampletypeid=sam.contractsampletypeid "
                + " AND  srh.deleted<>true"
                + " AND  sam.parentid="+boxid;
                rs = c.createStatement().executeQuery(sql);
                if (rs.next())
                    total = rs.getInt(1);

                sql = ""
                + " SELECT count(*) "
                + " FROM sampleitemreseach srh, contractsampletype sam, contractsampleitem itm"
                + " WHERE srh.labtestid="+testid
                + " AND  srh.contractsampleitemid=itm.contractsampleitemid "
                + " AND  itm.contractsampletypeid=sam.contractsampletypeid "
                + " AND  srh.deleted<>true"
                + " AND  srh.result IS NOT NULL"
                + " AND  sam.parentid="+boxid;
                rs = c.createStatement().executeQuery(sql);
                if (rs.next())
                    submited = rs.getInt(1);
                
                rs.close();
                
            }
            catch (Exception e){e.printStackTrace();}
            finally {Manager.getInstance().releaseConnection( c );}
            
            data.put("total", total);
            data.put("submited", submited);
            data.put("disclaim", disclaim);
            res.put("status", "OK");
            res.put("data", data);
        }
        catch(Exception e){
            e.printStackTrace();
            res.put("status", "ER");
            res.put("message", "Error Code 1");
        }
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("boxitemresult")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        long itemid = Long.parseLong(request.getParameter("id"));
        SampleitemreseachBean[] rsh = SampleitemreseachManager.getInstance().loadByContractsampleitemid(itemid);
        if (rsh.length==0)
            throw new Exception(trs.t("ტესტი არ მოიძებნა!"));
                
        QualitycontrolBean[] qcs = QualitycontrolManager.getInstance().loadByWhere("WHERE contractsampleitemid="+itemid+" ORDER BY qualitycontrolid desc LIMIT 1" );
        if (qcs.length==1)    
        {
            data.put("person", qcs[0].getQcPerson());
            data.put("qcdate", dt.format(qcs[0].getQcDatetime()));
            data.put("qctime", dtime.format(qcs[0].getQcDatetime()));
            data.put("positive", qcs[0].getPositive());
            data.put("negative", qcs[0].getNegative());
            res.put("QC", data);
        }
        res.put("itemid", itemid);
        res.put("status", "OK");
        res.put("result", rsh[0].getResult());
        out.print(res.toString());
        out.flush();
        return;
    }
    else if (request.getParameter("obj").equals("departamentlist")) 
    {
        JSONArray res  = new JSONArray();
        boolean transit = false;
        if(request.getParameter("transit") != null)
            transit = Boolean.parseBoolean(request.getParameter("transit"));
        long sampleitemid = 0;
        if(request.getParameter("sampleitemid")!=null || request.getParameter("sampleitemid").trim().length() > 0){
            String[] sid = request.getParameter("sampleitemid").trim().split(",");
            
            sampleitemid = Long.parseLong(sid[0]);
        }
        String sql = "";
        if(sampleitemid > 0){
            ContractsampleitemBean item = ContractsampleitemManager.getInstance().loadByPrimaryKey(sampleitemid);
            ContractsampletypeBean samp = ContractsampletypeManager.getInstance().loadByPrimaryKey(item.getContractsampletypeid());
            sql = "WHERE contractid="+samp.getContractid()+" AND sampletypeid="+samp.getSampletypeid();
        }
        ContractanalysisBean[] test = ContractanalysisManager.getInstance().loadByWhere(sql);
        if (test.length >= 0)
        {
            sql = "WHERE provider = true and companyid="+user.getCompanyid();  //+" and institutionid not in (select parentid from institution where parentid is not null)";
            if(user.getPersonelltypeid().intValue() > 1){
                sql += " and rootansestor("+user.getInstitutionid()+") ";
                if(transit) sql += "!=";
                else        sql += "=";
                sql += " rootansestor(institutionid)";
            }

            InstitutionBean[] list = InstitutionManager.getInstance().loadByWhere(sql);
            for (int i=0; i<list.length;i++) {
                JSONObject ob = new JSONObject();
                ob.put("id",    list[i].getInstitutionid());
                ob.put("text",getFullLabName(list[i]," - "));
                res.add(ob);
            }
        }
        else
        {
            InstitutionBean curr = InstitutionManager.getInstance().loadByPrimaryKey(test[0].getInstitutionid());
            InstitutionBean[] list = InstitutionManager.getInstance().loadByWhere("WHERE parentid="+curr.getInstitutionid());
            for (int i=0; i<list.length;i++) {
                JSONObject ob = new JSONObject();
                ob.put("id",    list[i].getInstitutionid());
                ob.put("text",(list[i].getName()));
                res.add(ob);
            }
        }
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("data", res);
        out.print(ret.toString());
        return;
    }
    else if (request.getParameter("obj").equals("boxdetails")) 
    {
        JSONObject res  = new JSONObject();
        JSONObject data  = new JSONObject();
        int total = 0;
        int submited = 0;
        int disclaim = 0;
        try {
            long id = Long.parseLong(request.getParameter("boxsample"));
            ContractsampletypeBean box = ContractsampletypeManager.getInstance().loadByPrimaryKey(id);
            ContractBean con = ContractManager.getInstance().loadByPrimaryKey(box.getContractid());
            data.put("contract", con.getNum());
            
            JSONArray optsample = new JSONArray();
            JSONArray opttest = new JSONArray();
            Connection c  = Manager.getInstance().getConnection();
            ResultSet rs;
            try
            {
                String sql = ""
            + " SELECT con.contractsampletypeid, sam.name, con.quantity"
            + " FROM contractsampletype  con, sampletype sam"
            + " WHERE con.sampletypeid=sam.sampletypeid AND con.isbox=true AND parentid="+id+ " AND con.deleted = FALSE"
            + " ORDER BY sam.name";
            

                rs = c.createStatement().executeQuery(sql);
                while(rs.next())
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id",  rs.getInt(1));
                    tmp.put("name",(rs.getString(2)));
                    tmp.put("cnt", rs.getInt(3));
                    total += rs.getInt(3);
                    optsample.add(tmp);
                }
                rs.close();
                
                sql = ""
            + " SELECT con.contractsampletypeid, test.name"
            + " FROM sampleboxreseach  con, labtest test"
            + " WHERE con.labtestid=test.labtestid AND con.contractsampletypeid="+id
            + " AND con.deleted = FALSE"
            + " ORDER BY test.name";

                rs = c.createStatement().executeQuery(sql);
                while(rs.next())
                {
                    JSONObject tmp  = new JSONObject();
                    tmp.put("id",  rs.getInt(1));
                    tmp.put("name",(rs.getString(2)));
                    opttest.add(tmp);
                }
                rs.close();
                
                sql = ""
            + " SELECT count(*),sum(CASE WHEN disclaim=true THEN 1 ELSE 0 END)"
            + " FROM contractsampletype  sam, contractsampleitem itm"
            + " WHERE sam.contractsampletypeid=itm.contractsampletypeid AND sam.isbox=true AND sam.parentid="+id+" AND itm.num1 is not null"+ " AND sam.deleted = FALSE";

                rs = c.createStatement().executeQuery(sql);
                if (rs.next())
                {
                    submited = rs.getInt(1);
                    disclaim = rs.getInt(2);
                }
                rs.close();
            }
            catch (Exception e){e.printStackTrace();}
            finally {Manager.getInstance().releaseConnection( c );}
            
            data.put("sampletypes", optsample);
            data.put("labtest",  opttest);
            data.put("total",    total);
            data.put("submited", submited);
            data.put("approved", submited-disclaim);
            data.put("disclaim", disclaim);
            data.put("leftnum",  total-submited);
            res.put("status", "OK");
            res.put("data", data);
        }
        catch(Exception e){
            e.printStackTrace();
            res.put("status", "ER");
            res.put("message", "Error Code 1");
        }
        out.print(res.toString());
        out.flush();
        return;
    } else {
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
