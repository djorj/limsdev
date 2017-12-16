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
System.out.println("SETSAMPLETYPE");
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try
{
    if(oper.equalsIgnoreCase("updSampleQuantity")){
        ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        int cnt = ContractsampleitemManager.getInstance().countWhere("WHERE deleted=false AND contractsampletypeid="+sam.getContractsampletypeid());
        int lim = Integer.parseInt(request.getParameter("quantity"));
        if (sam.getIsbox())
        {
            if (lim<=cnt)
                throw new Exception(trs.t("ნიმუშების რაოდენობა არ შეიძლება ნაკლები იყოს გატარებული ნიმუშების რაოდენობაზე!"));
            sam.setQuantity(lim);
            sam.setRegbyid(user.getPersonellid());
            sam = ContractsampletypeManager.getInstance().save(sam);
        }
        else
        {    
            sam.setQuantity(lim);
            sam.setRegbyid(user.getPersonellid());
            sam = ContractsampletypeManager.getInstance().save(sam);
            for (int i=cnt; i<sam.getQuantity(); i++)
            {
                ContractsampleitemBean tmp = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                tmp.setContractsampletypeid(sam.getContractsampletypeid());
                tmp.setRegbyid(user.getPersonellid());
                ContractsampleitemManager.getInstance().save(tmp);
                tmp.setBarcode(""+tmp.getContractsampleitemid());
                ContractsampleitemManager.getInstance().save(tmp);
            }
        }
        rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),sam.getContractsampletypeid().toString());
    } else if(oper.equalsIgnoreCase("updSampleNums")){
        ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
	String num1 = request.getParameter("num1");
	if(num1 == null) num1 = "";
        ptp.setNum1(num1);
        String num2 = request.getParameter("num2");
        if(num2 == null) num2 = "";

        ptp.setNum2(num2);
        ptp.setRegbyid(user.getPersonellid());
        ptp = ContractsampleitemManager.getInstance().save(ptp);
        rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),ptp.getContractsampletypeid().toString());
    } else if(oper.equalsIgnoreCase("updSampleBoxNum")){
        ContractsampletypeBean ptp = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ptp.setBoxnum(request.getParameter("num1"));
        ptp.setRegbyid(user.getPersonellid());
        ptp = ContractsampletypeManager.getInstance().save(ptp);
        rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),ptp.getContractsampletypeid().toString());
    } else if(oper.equalsIgnoreCase("updSpecies")){
        
        //if(request.getParameter("spcid").length() > 0){
            int spcid = 0;
            try{
                spcid = Integer.parseInt(request.getParameter("spcid"));
            }catch(Exception ex){}
            //String num1 = request.getParameter("num1").trim();
            //String num2 = request.getParameter("num2").trim();
            ContractsampletypeBean ptp = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
            if(spcid > 0)        ptp.setSpeciesid(spcid);
            else                 ptp.setSpeciesid(null);
            ptp.setRegbyid(user.getPersonellid());
            ptp = ContractsampletypeManager.getInstance().save(ptp);
            rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),ptp.getContractsampletypeid().toString());
        //}
    } else if(oper.equalsIgnoreCase("updSpeciesItem")){
        
        //if(request.getParameter("spcid").length() > 0){
            int spcid = 0;
            try{
                spcid = Integer.parseInt(request.getParameter("spcid"));
            }catch(Exception ex){}
            ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
            if(spcid > 0)        ptp.setSpeciesid(spcid);
            else                 ptp.setSpeciesid(null);
            ptp.setRegbyid(user.getPersonellid());
            ptp =ContractsampleitemManager.getInstance().save(ptp);
            rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),ptp.getContractsampleitemid().toString());
        //}
    } else if(oper.equalsIgnoreCase("updSample")){
        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        String num1 = request.getParameter("num1");
        if(num1 == null) num1 = "";
        itm.setNum1(num1);
        String num2 = request.getParameter("num2");
        if(num2 == null) num2 = "";
        itm.setNum1(num1);
        itm.setNum2(num2);
        itm.setRegbyid(user.getPersonellid());
        itm = ContractsampleitemManager.getInstance().save(itm);
        itm.setBarcode(""+itm.getContractsampleitemid());
        ContractsampleitemManager.getInstance().save(itm);

        ContractsampletypeBean ptp = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
        ptp.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        ptp.setRegbyid(user.getPersonellid());
        ptp = ContractsampletypeManager.getInstance().save(ptp);

        int cnt = ContractsampleitemManager.getInstance().countWhere("WHERE deleted=false AND contractsampletypeid="+itm.getContractsampletypeid());
        for (int i=cnt; i<ptp.getQuantity(); i++)
        {
            ContractsampleitemBean tmp = ContractsampleitemManager.getInstance().createContractsampleitemBean();
            tmp.setContractsampletypeid(ptp.getContractsampletypeid());
            tmp.setRegbyid(user.getPersonellid());
            ContractsampleitemManager.getInstance().save(tmp);
            tmp.setBarcode(""+tmp.getContractsampleitemid());
            ContractsampleitemManager.getInstance().save(tmp);
        }
        rspJsonMessage(response, "OK", trs.t("ნიმუში დამატებულია."),sid);
    } else if(oper.equalsIgnoreCase("add")){
        ContractsampletypeBean ptp = ContractsampletypeManager.getInstance().createContractsampletypeBean();
        ContractsampleitemBean tmp = ContractsampleitemManager.getInstance().createContractsampleitemBean();
        long actid = 0;
        long appealid = 0;
        long contractid = Long.parseLong(request.getParameter("contractid"));
        try{ actid = Long.parseLong(request.getParameter("actid")); }catch(Exception e){}
        try{ appealid = Long.parseLong(request.getParameter("appealid")); }catch(Exception e){}
        String sqlcheck = " AND contractid="+contractid;
        if(actid > 0)   sqlcheck += " and actid = "+actid;
        if(appealid > 0)   sqlcheck += " and appealid = "+appealid;
        if (request.getParameter("isbox")==null)
        {
            
            if ( ContractsampletypeManager.getInstance().countWhere("WHERE deleted=false AND isbox=false AND sampletypeid="+request.getParameter("sampleid")+sqlcheck) > 0)
                    throw new Exception(trs.t("ასეთი ნიმუშის ტიპი, უკვე დამატებულია!"));
            int quantity = 1;
            if (request.getParameter("quantity")!=null)
                quantity = Integer.parseInt(request.getParameter("quantity"));
            ptp.setContractid(contractid);
            ptp.setSampletypeid(Integer.parseInt(request.getParameter("sampleid")));
            ptp.setRegbyid(user.getPersonellid());
            ptp.setQuantity(quantity);
            ptp.setBoxnum("");
            ptp.setIsbox(false);
            if(actid > 0)   ptp.setActid(actid);
            if(appealid > 0)   ptp.setAppealid(appealid);
            ptp = ContractsampletypeManager.getInstance().save(ptp);
            sid = ptp.getContractsampletypeid().toString();
            for (int i=0; i<ptp.getQuantity(); i++)
            {
                tmp = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                tmp.setContractsampletypeid(ptp.getContractsampletypeid());
                tmp.setRegbyid(user.getPersonellid());
                ContractsampleitemManager.getInstance().save(tmp);
                tmp.setBarcode(""+tmp.getContractsampleitemid());
                ContractsampleitemManager.getInstance().save(tmp);
            }
        }
        else
        {
            if (ContractsampletypeManager.getInstance().countWhere("WHERE deleted=false AND isbox=true "+sqlcheck+"  AND boxnum='"+request.getParameter("boxnum").trim().toUpperCase().replaceAll("'", "''")+"' AND sampletypeid="+request.getParameter("sampleid"))>0)
                throw new Exception(trs.t("ასეთი ნიმუშის ტიპი, უკვე დამატებულია!"));
                
            int quantity=0;
            if (request.getParameter("quantity")!=null)
            {
                try { 
                    quantity = Integer.parseInt(request.getParameter("quantity")); 
                } catch (Exception e) {
                    throw new Exception(trs.t("რაოდენობა არ არის კორექტული!"));
                }
            }
            ContractsampletypeBean[] box = ContractsampletypeManager.getInstance().loadByWhere("WHERE isbox=true AND parentid is null AND contractid="+request.getParameter("contractid")+"  AND boxnum='"+request.getParameter("boxnum").trim().toUpperCase().replaceAll("'", "''")+"'");
            if (box.length>0)
            {
                ptp=box[0];
                sid = ptp.getContractsampletypeid().toString();
            }
            else
            {
                ptp.setContractid(contractid);
                ptp.setRegbyid(user.getPersonellid());
                ptp.setQuantity(1);
                ptp.setIsbox(true);
                ptp.setBoxnum(request.getParameter("boxnum"));
                if(actid > 0)   ptp.setActid(actid);
                if(appealid > 0)   ptp.setAppealid(appealid);
                ptp = ContractsampletypeManager.getInstance().save(ptp);
            
                sid = ptp.getContractsampletypeid().toString();

                tmp = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                tmp.setContractsampletypeid(ptp.getContractsampletypeid());
                tmp.setRegbyid(user.getPersonellid());
                ContractsampleitemManager.getInstance().save(tmp);
                tmp.setBarcode(""+tmp.getContractsampleitemid());
                ContractsampleitemManager.getInstance().save(tmp);
            }
            
            ContractsampletypeBean chl = ContractsampletypeManager.getInstance().createContractsampletypeBean();
            chl.setContractid(contractid);
            chl.setSampletypeid(Integer.parseInt(request.getParameter("sampleid")));
            chl.setRegbyid(user.getPersonellid());
            chl.setIsbox(true);
            if(actid > 0)   chl.setActid(actid);
            if(appealid > 0)   chl.setAppealid(appealid);
            chl.setBoxnum(request.getParameter("boxnum"));
            if (request.getParameter("quantity")!=null)
                chl.setQuantity(quantity);
            chl.setParentid(ptp.getContractsampletypeid());
            chl = ContractsampletypeManager.getInstance().save(chl);
/*
            for (int i=0; i<chl.getQuantity(); i++)
            {
                tmp = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                tmp.setContractsampletypeid(chl.getContractsampletypeid());
                tmp.setRegbyid(user.getPersonellid());
                ContractsampleitemManager.getInstance().save(tmp);
            }
*/
        }
            
        rspJsonMessage(response, "OK", trs.t("ნიმუში დამატებულია."),sid);

    } else if(oper.equalsIgnoreCase("banitem")){
        if (request.getParameter("reason").trim().length()==0)
            throw new Exception(trs.t("გთხოვთ შეიტანოთ დაწუნების მიზეზი"));
        ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ptp.setDisclaim(true);
        ptp = ContractsampleitemManager.getInstance().save(ptp);

        DisclaimsampleitemBean tmp = DisclaimsampleitemManager.getInstance().createDisclaimsampleitemBean();
        tmp.setContractsampleitemid(ptp.getContractsampleitemid());
        tmp.setReason(request.getParameter("reason"));
        tmp.setRegbyid(user.getPersonellid());
        DisclaimsampleitemManager.getInstance().save(tmp);
        rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),ptp.getContractsampletypeid().toString());

    } else if(oper.equalsIgnoreCase("cancelbanitem")){
        ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ptp.setDisclaim(false);
        ptp = ContractsampleitemManager.getInstance().save(ptp);

        DisclaimsampleitemBean tmp = DisclaimsampleitemManager.getInstance().createDisclaimsampleitemBean();
        tmp.setContractsampleitemid(ptp.getContractsampleitemid());
        tmp.setReason("დაწუნებულის უკან დაბრუნება");
        tmp.setRegbyid(user.getPersonellid());
        DisclaimsampleitemManager.getInstance().save(tmp);
        rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),ptp.getContractsampletypeid().toString());

    } else if (oper.equalsIgnoreCase("status")) {
        ContractsampleitemBean[] ptp = ContractsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in ("+request.getParameter("id")+")");
        for(int i=0;i<ptp.length;i++){
            if (request.getParameter("status").equals("1"))
            {
                ptp[i].setStatus(1);
                ptp[i] = ContractsampleitemManager.getInstance().save(ptp[i]);

                SampleitemstatushistoryBean tmp = SampleitemstatushistoryManager.getInstance().createSampleitemstatushistoryBean();
                tmp.setContractsampleitemid(ptp[i].getContractsampleitemid());
                tmp.setStatus(1);
                tmp.setReason("დაწუნების გაუქმება");
                tmp.setRegbyid(user.getPersonellid());
                SampleitemstatushistoryManager.getInstance().save(tmp);
                rspJsonMessage(response, "OK", trs.t("ჩანაწერის სტატუსი შეიცვალა."));
            } else if (request.getParameter("status").equals("2"))
            {
                if (request.getParameter("reason").trim().length()==0)
                    throw new Exception(trs.t("გთხოვთ შეიტანოთ დაწუნების მიზეზი"));
                ptp[i].setStatus(2);
                ptp[i] = ContractsampleitemManager.getInstance().save(ptp[i]);

                SampleitemstatushistoryBean tmp = SampleitemstatushistoryManager.getInstance().createSampleitemstatushistoryBean();
                tmp.setContractsampleitemid(ptp[i].getContractsampleitemid());
                tmp.setStatus(2);
                tmp.setReason(request.getParameter("reason"));
                tmp.setRegbyid(user.getPersonellid());
                SampleitemstatushistoryManager.getInstance().save(tmp);
                rspJsonMessage(response, "OK", trs.t("ჩანაწერის სტატუსი შეიცვალა."));
            }
            else if (request.getParameter("status").equals("3"))
            {
                if (request.getParameter("method").trim().length()==0)
                    throw new Exception(trs.t("გთხოვთ შეიტანოთ განადგურების მეთოდი"));
                ptp[i].setStatus(3);
                ptp[i] = ContractsampleitemManager.getInstance().save(ptp[i]);

                SampleitemstatushistoryBean tmp = SampleitemstatushistoryManager.getInstance().createSampleitemstatushistoryBean();
                tmp.setContractsampleitemid(ptp[i].getContractsampleitemid());
                tmp.setStatus(3);
                tmp.setMethod(request.getParameter("method"));
                tmp.setRegbyid(user.getPersonellid());
                SampleitemstatushistoryManager.getInstance().save(tmp);
                rspJsonMessage(response, "OK", trs.t("ჩანაწერის სტატუსი შეიცვალა."));
            }
            else if (request.getParameter("status").equals("6"))
            {
                if (request.getParameter("method").trim().length()==0)
                    throw new Exception(trs.t("გთხოვთ შეიტანოთ განადგურების მეთოდი"));
                ptp[i].setStatus(6);
                ptp[i] = ContractsampleitemManager.getInstance().save(ptp[i]);

                SampleitemstatushistoryBean[] tmp = SampleitemstatushistoryManager.getInstance().loadByContractsampleitemid(ptp[i].getContractsampleitemid());
                tmp[0].setContractsampleitemid(ptp[i].getContractsampleitemid());
                tmp[0].setStatus(6);
                tmp[0].setMethod(request.getParameter("method"));
                tmp[0].setRegbyid(user.getPersonellid());
                tmp[0] = SampleitemstatushistoryManager.getInstance().save(tmp[0]);
                rspJsonMessage(response, "OK", trs.t("ჩანაწერის სტატუსი შეიცვალა."));
            }
        }
    } else if (oper.equalsIgnoreCase("sampletypeinfo")) {
        //if (request.getParameter("info").trim().length()==0)
        //    throw new Exception(trs.t("გთხოვთ შეიტანოთ შენიშვნა"));
        
        ContractsampletypeBean ptp = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("sampletypeid")));
        ptp.setInfo(request.getParameter("info").trim());
        //ptp.setStamp(request.getParameter("stamp").trim());
        ContractsampletypeManager.getInstance().save(ptp);
        rspJsonMessage(response, "OK", trs.t("შენიშვნა დამატებულია."));

    } else if (oper.equalsIgnoreCase("sampleiteminfo")) {
        //if (request.getParameter("info").trim().length()==0)
        //    throw new Exception(trs.t("გთხოვთ შეიტანოთ შენიშვნა"));
        ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("sampleitemid")));
        ptp.setInfo(request.getParameter("info").trim());
        ContractsampleitemManager.getInstance().save(ptp);
        
        ContractsampletypeBean stp = ContractsampletypeManager.getInstance().loadByPrimaryKey(ptp.getContractsampletypeid());
        ExtraparamBean[] params = ExtraparamManager.getInstance().loadByWhere("where sampletypeid = "+stp.getSampletypeid()+" order by name, description");
        for(int i=0;i<params.length;i++){
            String val = request.getParameter("param_"+params[i].getExtraparamid()).trim();
            ExtravalBean ev = ExtravalManager.getInstance().loadByPrimaryKey(params[i].getExtraparamid(), ptp.getContractsampleitemid());
            if(ev == null){
                ev = ExtravalManager.getInstance().createExtravalBean();
                ev.setExtraparamid(params[i].getExtraparamid());
                ev.setContractsampleid(ptp.getContractsampleitemid());
            }
            if(params[i].getRestypeid().intValue() == 1){
                if(val.equalsIgnoreCase("1"))   ev.setBval(true);
                else if(val.equalsIgnoreCase("2"))   ev.setBval(false);
                else ev.setBval(null);
            } else if(params[i].getRestypeid().intValue() == 2){
                if(val.length() == 0)   ev.setDval(null);
                else                    ev.setDval(new Double(val));
            } else if(params[i].getRestypeid().intValue() == 3){
                if(val.length() == 0)   ev.setTval(null);
                else                    ev.setTval(val);
            }
            ev = ExtravalManager.getInstance().save(ev);
        }
        
        rspJsonMessage(response, "OK", trs.t("შენიშვნა დამატებულია."));

    } else if(oper.equalsIgnoreCase("deletebanitem")){ 
        
        ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (ptp!=null)
        {
            SampleitemreseachManager.getInstance().deleteByContractsampleitemid(ptp.getContractsampleitemid());
            DisclaimsampleitemManager.getInstance().deleteByContractsampleitemid(ptp.getContractsampleitemid());
            ContractsampleitemManager.getInstance().deleteByPrimaryKey(ptp.getContractsampleitemid());
        }
        rspJsonMessage(response, "OK", trs.t("ჩანაწერი წაიშალა."));

    } else if(oper.equalsIgnoreCase("deletesubmittedsample")){
        
        ContractsampletypeBean obj   = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("sampleid")));
        DisclaimsampleitemManager.getInstance().deleteByWhere("WHERE contractsampleitemid in (SELECT contractsampleitemid FROM contractsampleitem WHERE contractsampletypeid="+obj.getContractsampletypeid()+")");
        ContractsampleitemManager.getInstance().deleteByContractsampletypeid(obj.getContractsampletypeid());
        rspJsonMessage(response, "OK", trs.t("ჩანაწერი წაიშალა."));

    } else if(oper.equalsIgnoreCase("addsampleboxitem")){

        if (request.getParameter("samplenum").trim().length()==0)
            throw new Exception(trs.t("გთხოვთ შეიტანოთ ნიმუშის ნომერი"));
        int labtestid = 0;
        try{
            labtestid = Integer.parseInt(request.getParameter("labtestid"));
        }catch(Exception ign){}
        
        ContractsampleitemBean tmp = ContractsampleitemManager.getInstance().createContractsampleitemBean();
        tmp.setContractsampletypeid(Long.parseLong(request.getParameter("sampleid")));
        tmp.setNum1(request.getParameter("samplenum").trim());
        tmp.setRegbyid(user.getPersonellid());
        ContractsampleitemManager.getInstance().save(tmp);
        tmp.setBarcode(""+tmp.getContractsampleitemid());
        ContractsampleitemManager.getInstance().save(tmp);
        
        if(labtestid > 0){
            ContractsampletypeBean cb = ContractsampletypeManager.getInstance().loadByPrimaryKey(tmp.getContractsampletypeid());
            SampleitemreseachBean tm2 = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
            tm2.setRegbyid(user.getPersonellid());
            tm2.setContractid(cb.getContractid());
            tm2.setContractsampleitemid(tmp.getContractsampleitemid());
            tm2.setLabtestid(labtestid);
            tm2.setTotalsubtest(0);
            tm2 = SampleitemreseachManager.getInstance().save(tm2);
        }
            
        rspJsonMessage(response, "OK", trs.t("ნიმუში დამატებულია."),sid);
    } else if(oper.equalsIgnoreCase("transit")){
        String ids = request.getParameter("id").trim();
        if(ids.length() == 0)
            throw new Exception(trs.t("აირჩიეთ ერთი ნიმუში მაინც!"));
System.out.println("ids = "+ids);
        ContractsampleitemBean[] itms = ContractsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in ("+ids+")");
        ContractsampletypeBean stpp = ContractsampletypeManager.getInstance().loadByPrimaryKey(itms[0].getContractsampletypeid());
        TransitactBean[] tacts = TransitactManager.getInstance().loadByWhere("where transitactid in (select transitactid from transitsampleitem where contractsampleitemid in ("+ids+"))");
        if(tacts.length > 1)
            throw new Exception(trs.t("ნიმუშები არაა ერთი გადაცემის აქტის!"));
        TransitactBean tact = TransitactManager.getInstance().createTransitactBean();
        TransitsampleitemBean[] tmps = null;
        if(tacts.length > 0){
            tact = TransitactManager.getInstance().loadByPrimaryKey(tacts[0].getTransitactid());
            itms = ContractsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in (select contractsampleitemid from transitsampleitem where transitactid = "+tact.getTransitactid()+")");
            tmps = TransitsampleitemManager.getInstance().loadByTransitactid(tact.getTransitactid());
        } else {
            long gid = 0;
            int tpp = 0;
            tmps = new TransitsampleitemBean[itms.length];
            for(int i=0;i<itms.length;i++){
                tmps[i] = TransitsampleitemManager.getInstance().createTransitsampleitemBean();
                tmps[i].setContractsampleitemid(itms[i].getContractsampleitemid());
                ContractsampletypeBean tp = ContractsampletypeManager.getInstance().loadByPrimaryKey(itms[i].getContractsampletypeid());
                if(tp.getAppealid() != null){
                    if(tpp > 0 && tpp != 1)
                        throw new Exception(trs.t("ნიმუშები არაა ერთი მიმართვის!"));
                    tpp = 1;
                    if(gid > 0 && tp.getAppealid().longValue() != gid)
                        throw new Exception(trs.t("ნიმუშები არაა ერთი მიმართვის!"));
                    gid = tp.getAppealid().longValue();
                    tact.setAppealid(tp.getAppealid());
                } else if(tp.getActid() != null){
                    if(tpp > 0 && tpp != 2)
                        throw new Exception(trs.t("ნიმუშები არაა ერთი აქტის!"));
                    tpp = 2;
                    if(gid > 0 && tp.getActid().longValue() != gid)
                        throw new Exception(trs.t("ნიმუშები არაა ერთი აქტის!"));
                    gid = tp.getActid().longValue();
                    tact.setActid(tp.getActid());
                } else {
                    if(tpp > 0 && tpp != 3)
                        throw new Exception(trs.t("ნიმუშები არაა ერთი ხელშეკრულების!"));
                    tpp = 3;
                    if(gid > 0 && tp.getContractid().longValue() != gid)
                        throw new Exception(trs.t("ნიმუშები არაა ერთი ხელშეკრულების!"));
                    gid = tp.getContractid().longValue();
                }
                tact.setContractid(tp.getContractid());
            }
        }
        
        tact.setFromlocationid(user.getInstitutionid());
        if (request.getParameter("departamentid").trim().length()==0)
            throw new Exception(trs.t("დეპარტამენტი არ არის არჩეული"));
        tact.setTolocationid(new Integer(request.getParameter("departamentid").trim()));
        tact.setSenddate(str2date(request.getParameter("senddate").trim(),"თარიღი არ არის მითითებული").getTime());
        if (request.getParameter("sendoutside")!=null){
            tact.setResponsible(request.getParameter("personells").trim());
            tact.setSendreason(request.getParameter("sendreason").trim());
            tact.setSendcondition(request.getParameter("sendcondition").trim());
        }
        tact.setAmount("");
        tact.setVolume("");
        tact.setContractid(stpp.getContractid());
        tact.setRegbyid(user.getPersonellid());
        tact = TransitactManager.getInstance().save(tact);
        
        sid = "";
        
        for(int i=0;i<tmps.length;i++){
            tmps[i].setFromlocationid(user.getInstitutionid());
            if (request.getParameter("departamentid").trim().length()==0)
                    throw new Exception(trs.t("დეპარტამენტი არ არის არჩეული"));
            tmps[i].setLocationid(new Integer(request.getParameter("departamentid").trim()));
            if (request.getParameter("sendoutside")==null)
            {
                tmps[i].setOutside(false);
                tmps[i].setTransitdate(str2date(request.getParameter("senddate").trim(),"თარიღი არ არის მითითებული"));
                tmps[i].setTransittime(str2time(request.getParameter("sendtime").trim(),"დრო არ არის მითითებული"));
                String refregerator = request.getParameter("refregerator");
                String shelf = request.getParameter("shelf");
                String box = request.getParameter("box");
                JSONObject obj = new JSONObject();
                obj.put("refregerator",refregerator);
                obj.put("shelf",shelf);
                obj.put("box",box);
                tmps[i].setContainer(obj.toString());
                if(refregerator.trim().length() > 0){
                    tmps[i].setStatus(7);
                    itms[i].setStatus(7);
                } else {
                    tmps[i].setStatus(1);
                    itms[i].setStatus(1);
                }
                
                itms[i] = ContractsampleitemManager.getInstance().save(itms[i]);
            }
            else
            {
                tmps[i].setOutside(true);
                tmps[i].setContainer(request.getParameter("container").trim());
                //tmp.setResearcher(request.getParameter("researcher").trim());
                tmps[i].setPersonals(request.getParameter("personells").trim());
                tmps[i].setTransitdate(str2date(request.getParameter("senddate").trim(),"გადაცემის თარიღი არ არის მითითებული"));
                tmps[i].setSendreason(request.getParameter("sendreason").trim());
                tmps[i].setSendcondition(request.getParameter("sendcondition").trim());
            }
            tmps[i].setRegbyid(user.getPersonellid());
            tmps[i].setTransitactid(tact.getTransitactid());
            tmps[i] = TransitsampleitemManager.getInstance().save(tmps[i]);
            if(i > 0)   sid += ",";
            sid += tmps[i].getTransitsampleitemid();
        }
        rspJsonMessage(response, "OK", trs.t("გადაცემა დაფიქსირებულია."),tact.getTransitactid().toString());
        
    } else if(oper.equalsIgnoreCase("gettest")){

        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
        
        TransitsampleitemBean[] tb = TransitsampleitemManager.getInstance().loadByWhere("where contractsampleitemid = "+itm.getContractsampleitemid());
        if(tb.length > 0){
            tb[0].setGetbyid(user.getPersonellid());
            tb[0].setGetdate(new Date().getTime());
            tb[0] = TransitsampleitemManager.getInstance().save(tb[0]);
            TransitactBean ta = TransitactManager.getInstance().loadByPrimaryKey(tb[0].getTransitactid());
            ta.setGetbyid(user.getPersonellid());
            ta.setGetdate(new Date().getTime());
            ta = TransitactManager.getInstance().save(ta);
        }
        SampleitemreseachBean[] sb = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid = "+itm.getContractsampleitemid());
        SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
        if(sb.length > 0){
            tmp = SampleitemreseachManager.getInstance().loadByPrimaryKey(sb[0].getSampleitemreseachid());
        }
        tmp.setRegbyid(user.getPersonellid());
        tmp.setContractid(sam.getContractid());
        tmp.setContractsampleitemid(itm.getContractsampleitemid());
        tmp.setLabtestid(Integer.parseInt(request.getParameter("testparent")));
        String[] subtest=request.getParameterValues("testchild");
        if (subtest==null){
            tmp.setTotalsubtest(0);
            tmp = SampleitemreseachManager.getInstance().save(tmp);
        }
        else
        {
            tmp.setTotalsubtest(subtest.length);
            tmp = SampleitemreseachManager.getInstance().save(tmp);
            for (int i=0; i<subtest.length; i++)
            {
                SampleitemreseachBean tm2 = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                tm2.setRegbyid(user.getPersonellid());
                tm2.setContractid(sam.getContractid());
                tm2.setContractsampleitemid(itm.getContractsampleitemid());
                tm2.setLabtestid(Integer.parseInt(subtest[i]));
                tm2.setTotalsubtest(0);
                tm2.setParenttest(itm.getContractsampleitemid());
                tm2 = SampleitemreseachManager.getInstance().save(tm2);
            }
        }
            
        rspJsonMessage(response, "OK", trs.t("კვლევა/ტესტი დანიშნულია."),sid);
    
    } else if(oper.equalsIgnoreCase("researchtest")){

        String ids = request.getParameter("id");
        String[] idd = ids.split(",");
        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(idd[0]));
        ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());

        TransitsampleitemBean[] titem = TransitsampleitemManager.getInstance().loadByWhere("where contractsampleitemid = "+itm.getContractsampleitemid());
        if(titem.length > 0){
            titem[0].setGetbyid(user.getPersonellid());
            //titem[0].setGetdate(dt.parse(request.getParameter("getdate")).getTime());
            titem[0].setGetdate(new Date().getTime());
            titem[0] = TransitsampleitemManager.getInstance().save(titem[0]);
        }
        
        int instid = 0;
        SampleitemreseachBean[] tmp0 = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid = "+itm.getContractsampleitemid());
        SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
        if(tmp0.length > 0){
            tmp = SampleitemreseachManager.getInstance().loadByPrimaryKey(tmp0[0].getSampleitemreseachid());
            instid = tmp.getInstitutionid();
        }
        tmp.setRegbyid(user.getPersonellid());
        tmp.setContractid(sam.getContractid());
        tmp.setContractsampleitemid(itm.getContractsampleitemid());
        tmp.setLabtestid(Integer.parseInt(request.getParameter("testparent")));

        String[] subtest=request.getParameterValues("testchild");
        if (subtest==null)
        {
            tmp.setTotalsubtest(0);
            tmp = SampleitemreseachManager.getInstance().save(tmp);
        }
        else
        {
            tmp.setTotalsubtest(subtest.length);
            tmp = SampleitemreseachManager.getInstance().save(tmp);
            if(instid == 0){
                LabtestinstitutionBean[] li = LabtestinstitutionManager.getInstance().loadByLabtestid(tmp.getLabtestid());
                if(li.length > 0)   instid = li[0].getInstitutionid();
            }
            for (int i=0; i<subtest.length; i++)
            {
                ContractsampleitemBean it = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                it.setContractsampletypeid(itm.getContractsampletypeid());
                it.setNum1(itm.getNum1());
                it.setNum2(itm.getNum2());
                it.setRegbyid(user.getPersonellid());
                it.setSpeciesid(itm.getSpeciesid());
                it.setParentid(itm.getContractsampleitemid());
                it = ContractsampleitemManager.getInstance().save(it);
                it.setBarcode(it.getContractsampleitemid().toString());
                it = ContractsampleitemManager.getInstance().save(it);
                
                SampleitemreseachBean tm2 = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                tm2.setRegbyid(user.getPersonellid());
                tm2.setContractid(sam.getContractid());
                tm2.setContractsampleitemid(it.getContractsampleitemid());
                tm2.setLabtestid(Integer.parseInt(subtest[i]));
                tm2.setTotalsubtest(0);
                if(instid > 0)  tm2.setInstitutionid(instid);
                tm2.setParenttest(itm.getContractsampleitemid());
                tm2 = SampleitemreseachManager.getInstance().save(tm2);
            }
        }
            
        rspJsonMessage(response, "OK", trs.t("კვლევა/ტესტი დანიშნულია."),sid);
    
    } else if(oper.equalsIgnoreCase("researchtest2")){

        int labtestid = Integer.parseInt(request.getParameter("testparent"));
        int institutionid = Integer.parseInt(request.getParameter("institutionid"));
        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
        PriceBean[] prc = PriceManager.getInstance().loadByLabtestid(labtestid);
        ContractlabtestBean[] cb = ContractlabtestManager.getInstance().loadByWhere("where contractid = "+sam.getContractid()+" and labtestid = "+labtestid);
        double price = 0;
        if(cb.length > 0 && cb[0].getMaxprice() != null)   price = cb[0].getMaxprice();
        if(price == 0 && prc.length > 0)
            price = prc[0].getPrice();
        SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
        tmp.setRegbyid(user.getPersonellid());
        tmp.setContractid(sam.getContractid());
        tmp.setContractsampleitemid(itm.getContractsampleitemid());
        tmp.setInstitutionid(institutionid);
        tmp.setLabtestid(labtestid);
        tmp.setPrice(price);
        String[] subtest=request.getParameterValues("testchild");
        if (subtest==null)
        {
            tmp.setTotalsubtest(0);
            tmp = SampleitemreseachManager.getInstance().save(tmp);
        }
        else
        {
            tmp.setTotalsubtest(subtest.length);
            tmp = SampleitemreseachManager.getInstance().save(tmp);
            for (int i=0; i<subtest.length; i++)
            {
                prc = PriceManager.getInstance().loadByLabtestid(Integer.parseInt(subtest[i]));
                cb = ContractlabtestManager.getInstance().loadByWhere("where contractid = "+sam.getContractid()+" and labtestid = "+subtest[i]);
                price = 0;
                if(cb.length > 0 && cb[0].getMaxprice() != null)   price = cb[0].getMaxprice();
                if(price == 0 && prc.length > 0)
                    price = prc[0].getPrice();
                SampleitemreseachBean tm2 = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                tm2.setRegbyid(user.getPersonellid());
                tm2.setContractid(sam.getContractid());
                tm2.setContractsampleitemid(itm.getContractsampleitemid());
                tm2.setLabtestid(Integer.parseInt(subtest[i]));
                tm2.setPrice(price);
                tm2.setTotalsubtest(0);
                tm2.setParenttest(itm.getContractsampleitemid());
                tm2 = SampleitemreseachManager.getInstance().save(tmp);
            }
        }
            
        rspJsonMessage(response, "OK", trs.t("კვლევა/ტესტი დანიშნულია."),sid);
        
    } else if(oper.equalsIgnoreCase("researchtest3")) {

        int labtestid = Integer.parseInt(request.getParameter("testparent"));
        int institutionid = 0;
        try {
            institutionid = Integer.parseInt(request.getParameter("institutionid"));
        } catch(Exception ign){
            institutionid = 0;
        }
        LabtestinstitutionBean[] lab = LabtestinstitutionManager.getInstance().loadByLabtestid(labtestid);
        
        if (lab.length==0)
            rspJsonMessage(response, "ER", trs.t("არჩეული კვლევისთვის ლაბორატორია არ იძებნება. შეავსეთ მონაცემთა ბაზა"));
        else if (lab.length>1&&(institutionid==0))
            rspJsonMessage(response, "ER", "multiplelab");
        else
        {
            if (institutionid==0)
                institutionid = lab[0].getInstitutionid();
            
            String ids  = request.getParameter("ids").trim();
            String ids2 = request.getParameter("ids2").trim();
            if (!ids.isEmpty()&&!ids.isEmpty())
                ids += ","+ids2;
            else if (ids.isEmpty())
                ids = ids2;
           
            String smp[]  = ids.split(",");
            String box[] = request.getParameter("box").trim().split(",");
            if(box.length > 0 && box[0] != null && box[0].trim().length() > 0)
                throw new Exception(trs.t("ყუთის შემთხვევაში კვლევის დანიშვნა ხდება მასიური მიღებიდან"));
            
            String chk = ""
                    + "SELECT sam.name "
                    + "FROM labtestsampletype labsam, sampletype sam, contractsampletype consam, contractsampleitem samitm"
                    + "WHERE labsam.sampletypeid=sam.sampletypeid"
                    + " AND consam.sampletypeid=sam.sampletypeid"
                    + " AND consam.contractsampletypeid=samitm.contractsampletypeid"
                    + " AND consam.deleted = false"
                    + " AND labsam.labtestid="+labtestid
                    + " AND samitm.contractsampleitemid ="+labtestid
                    + " AND consam.contractid="+request.getParameter("contractid");

            //System.out.println(chk);
            
            PriceBean[] prc = PriceManager.getInstance().loadByLabtestid(labtestid);
            ContractlabtestBean[] cb = ContractlabtestManager.getInstance().loadByWhere("where contractid = "+request.getParameter("contractid")+" and labtestid = "+labtestid);
            double price = 0;
            if(cb.length > 0 && cb[0].getMaxprice() != null)   price = cb[0].getMaxprice();
            if(price == 0 && prc.length > 0)
                price = prc[0].getPrice();
            for (int i=0; i<smp.length; i++)
            {
                if (smp[i].equals(""))
                    continue;
                ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(smp[i]));
                ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
                if(LabtestsampletypeManager.getInstance().countWhere("where labtestid = "+labtestid+" and sampletypeid = "+sam.getSampletypeid()) == 0)
                    throw new Exception("მოცემული ნიმუშის ტიპი არ შეესაბამება არჩეულ ტესტს");
                if(SampleitemreseachManager.getInstance().countWhere("where contractsampleitemid = "+itm.getContractsampleitemid()+" and labtestid = "+labtestid) > 0)
                    throw new Exception("მოცემულ ნიმუშზე ასეთი ტესტი უკვე დანიშნულია");
                
                //int ntst = SampleitemreseachManager.getInstance().countWhere("WHERE deleted=false AND contractsampleitemid="+smp[i]);
                //if (ntst==0)
                /*{
                    SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                    tmp.setRegbyid(user.getPersonellid());
                    tmp.setContractid(sam.getContractid());
                    tmp.setContractsampleitemid(itm.getContractsampleitemid());
                    tmp.setLabtestid(labtestid);
                    tmp.setInstitutionid(institutionid);
                    tmp.setPrice(prc.length>0 ? prc[0].getPrice() : 0.0);
                    tmp.setTotalsubtest(0);
                    tmp = SampleitemreseachManager.getInstance().save(tmp);
                }
                else
                {*/
                    ContractsampleitemBean newitm = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                    newitm.setContractsampletypeid(itm.getContractsampletypeid());
                    newitm.setParentid(itm.getContractsampleitemid());
                    newitm.setNum1(itm.getNum1());
                    newitm.setNum2(itm.getNum2());
                    newitm.setRegbyid(user.getPersonellid());
                    ContractsampleitemManager.getInstance().save(newitm);
                    newitm.setBarcode(""+newitm.getContractsampleitemid());
                    ContractsampleitemManager.getInstance().save(newitm);
                    
                    if(SampleitemreseachManager.getInstance().countWhere("where contractsampleitemid = "+newitm.getContractsampleitemid()+" and labtestid = "+labtestid) > 0)
                        throw new Exception(trs.t("ამ ნიმუშზე ასეთი კვლევა უკვე დანიშნულია"));
                    //if(SampleitemreseachManager.getInstance().countWhere("where contractsampleitemid in (select contractsampleitemid from contractsampleitem where parentid = "+itm.getContractsampleitemid()+") and labtestid = "+labtestid) > 0)
                    //    throw new Exception(trs.t("ამ ნიმუშზე ასეთი კვლევა უკვე დანიშნულია"));
                    
                    SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                    tmp.setRegbyid(user.getPersonellid());
                    tmp.setContractid(sam.getContractid());
                    tmp.setContractsampleitemid(newitm.getContractsampleitemid());
                    tmp.setLabtestid(labtestid);
                    tmp.setInstitutionid(institutionid);
                    tmp.setPrice(price);
                    tmp.setTotalsubtest(0);
                    tmp = SampleitemreseachManager.getInstance().save(tmp);
                //}
            }
            
            for (int i=0; i<box.length; i++)
            {
                if (box[i].equals(""))
                    continue;
                ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(box[i]));
                SampleboxreseachBean tmp = SampleboxreseachManager.getInstance().createSampleboxreseachBean();
                tmp.setRegbyid(user.getPersonellid());
                tmp.setContractsampletypeid(sam.getContractsampletypeid());
                tmp.setLabtestid(labtestid);
                tmp.setInstitutionid(institutionid);
                tmp.setTotalsubtest(0);
                SampleboxreseachManager.getInstance().save(tmp);
            }
            rspJsonMessage(response, "OK", trs.t("კვლევა/ტესტი დანიშნულია."),sid);
        }
        
    } else if(oper.equalsIgnoreCase("boxsampletest")) {

        String[] sampleids = request.getParameterValues("sampleids");
        ContractsampletypeBean box = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        
        for (int i=0; i<sampleids.length;  i++)
        {
            if (request.getParameter("testparent_"+sampleids[i]).trim().isEmpty())
                continue;
            int labtestid = Integer.parseInt(request.getParameter("testparent_"+sampleids[i]));
            PriceBean[] prc = PriceManager.getInstance().loadByLabtestid(labtestid);
            int institutionid = 0;
            try {
                institutionid = Integer.parseInt(request.getParameter("institutionid"));
            } catch(Exception ign){
                institutionid = 0;
            }

            
            SampleboxreseachBean tmp = SampleboxreseachManager.getInstance().createSampleboxreseachBean();
            tmp.setRegbyid(user.getPersonellid());
            tmp.setContractsampletypeid(box.getContractsampletypeid());
            tmp.setLabtestid(labtestid);
            tmp.setInstitutionid(institutionid);
            tmp.setTotalsubtest(0);
            SampleboxreseachManager.getInstance().save(tmp);
                
            ContractsampleitemBean[] itm = ContractsampleitemManager.getInstance().loadByWhere("WHERE deleted=false AND contractsampletypeid="+sampleids[i]);
            ContractlabtestBean[] cb = ContractlabtestManager.getInstance().loadByWhere("where contractid = "+box.getContractid()+" and labtestid = "+labtestid);
            double price = 0;
            if(cb.length > 0 && cb[0].getMaxprice() != null)   price = cb[0].getMaxprice();
            if(price == 0 && prc.length > 0)
                price = prc[0].getPrice();
            for (int n=0; n<itm.length; n++)
            {
                    int ntst = SampleitemreseachManager.getInstance().countWhere("WHERE deleted=false AND contractsampleitemid="+itm[n].getContractsampleitemid());
                    if (ntst==0)
                    {
                    
                        SampleitemreseachBean sir = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                        sir.setRegbyid(user.getPersonellid());
                        sir.setContractid(box.getContractid());
                        sir.setContractsampleitemid(itm[n].getContractsampleitemid());
                        sir.setLabtestid(labtestid);
                        sir.setInstitutionid(institutionid);
                        sir.setPrice(price);
                        sir.setTotalsubtest(0);
                        sir = SampleitemreseachManager.getInstance().save(sir);
                    }
                    else
                    {
                        ContractsampleitemBean newitm = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                        newitm.setContractsampletypeid(itm[n].getContractsampletypeid());
                        newitm.setParentid(itm[n].getContractsampleitemid());
                        newitm.setNum1(itm[n].getNum1());
                        newitm.setNum2(itm[n].getNum2());
                        newitm.setRegbyid(user.getPersonellid());
                        ContractsampleitemManager.getInstance().save(newitm);
                        
                        newitm.setBarcode(""+newitm.getContractsampleitemid());
                        ContractsampleitemManager.getInstance().save(newitm);
                    
                        SampleitemreseachBean sir = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                        sir.setRegbyid(user.getPersonellid());
                        sir.setContractid(box.getContractid());
                        sir.setContractsampleitemid(newitm.getContractsampleitemid());
                        sir.setLabtestid(labtestid);
                        sir.setInstitutionid(institutionid);
                        sir.setPrice(price);
                        sir.setTotalsubtest(0);
                        sir = SampleitemreseachManager.getInstance().save(sir);
                    }
                }
            //}
            rspJsonMessage(response, "OK", trs.t("კვლევა/ტესტი დანიშნულია."),sid);
        }
        
    } else if(oper.equalsIgnoreCase("setitemresult")) {

        String boxid = request.getParameter("boxid");
        String itemid = request.getParameter("itemid");
        String testid = request.getParameter("testid");
        String value = request.getParameter("value");

        String where = ""
                + " WHERE labtestid="+testid
                + " AND  contractsampleitemid="+itemid
                + " AND  deleted<>true "
                + " AND  contractsampleitemid IN ("
                        + "SELECT itm.contractsampleitemid "
                        + "FROM  contractsampletype sam, contractsampleitem itm "
                        + "WHERE itm.contractsampletypeid=sam.contractsampletypeid AND  sam.parentid="+boxid
                        + ")";
        SampleitemreseachBean[] tmp = SampleitemreseachManager.getInstance().loadByWhere(where);
        if (tmp.length!=1)
            rspJsonMessage(response, "ER", trs.t("ნიმუშის ნომერი არ არის სწორი"));
        else if (tmp[0].getResult()!=null)
            rspJsonMessage(response, "ER", trs.t("ნიმუშის ამ ნომერზე შედეგი უკვე დაფიქსირებულია."));
        else
        {
            tmp[0].setRegbyid(user.getPersonellid());
            tmp[0].setResult(value);
            tmp[0].setResultDatetime((new Date()).getTime());
            SampleitemreseachManager.getInstance().save(tmp[0]);
            rspJsonMessage(response, "OK", trs.t("ტესტის შედეგი დაფიქსირებულია."));
        }
        
    } else if(oper.equalsIgnoreCase("setboxitemresult")) {

        String boxid = request.getParameter("boxid");
        String itemid = request.getParameter("itemid");
        String testid = request.getParameter("testid");
        String value = request.getParameter("value");

        String where = ""
                + " WHERE labtestid="+testid
                + " AND  contractsampleitemid="+itemid
                + " AND  deleted<>true "
                + " AND  contractsampleitemid IN ("
                        + "SELECT itm.contractsampleitemid "
                        + "FROM  contractsampletype sam, contractsampleitem itm "
                        + "WHERE itm.contractsampletypeid=sam.contractsampletypeid AND  sam.parentid="+boxid
                        + ")";
        SampleitemreseachBean[] tmp = SampleitemreseachManager.getInstance().loadByWhere(where);
        if (tmp.length!=1)
            rspJsonMessage(response, "ER", trs.t("ნიმუშის ნომერი არ არის სწორი"));
        else if (tmp[0].getResult()!=null)
            rspJsonMessage(response, "ER", trs.t("ნიმუშის ამ ნომერზე შედეგი უკვე დაფიქსირებულია."));
        else
        {
            String person = request.getParameter("person").trim();
            if (person.length()==0)
                throw new Exception(trs.t("ვინ ჩაატარა არ არის არჩეული"));
            str2date(request.getParameter("qcdate"),"ჩატარების თარიღი არ არის მითითებული");
            str2time(request.getParameter("qctime"),"ჩატარების დრო არ არის მითითებული");
            String qcts = request.getParameter("qcdate")+" "+request.getParameter("qctime");
            
            QualitycontrolBean ptp = QualitycontrolManager.getInstance().createQualitycontrolBean();
            ptp.setContractsampleitemid(tmp[0].getContractsampleitemid());
            ptp.setQcPerson(Integer.parseInt(person));
            ptp.setQcDatetime(str2datetime(qcts, "ჩატარების თარიღი და დრო არასწორია"));
            ptp.setPositive(request.getParameter("positive")==null ? "უარყოფითი" : "დადებითი" );
            ptp.setNegative(request.getParameter("negative")==null ? "უარყოფითი" : "დადებითი" );
            ptp.setRegbyid(user.getPersonellid());
            if (request.getParameter("device")!=null && !request.getParameter("device").isEmpty())
                ptp.setDeviceid(Integer.parseInt(request.getParameter("device")));
            QualitycontrolManager.getInstance().save(ptp);

            tmp[0].setRegbyid(user.getPersonellid());
            tmp[0].setResult(value);
            tmp[0].setResultDatetime((new Date()).getTime());
            SampleitemreseachManager.getInstance().save(tmp[0]);
            rspJsonMessage(response, "OK", trs.t("ტესტის შედეგი დაფიქსირებულია."));
        }
        
    } else if (oper.equalsIgnoreCase("cancelrestore")) {

        SampleitemreseachBean ptp;
        if (request.getParameter("other")!=null)
            ptp = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        else
        {
            SampleitemreseachBean[] ptps = SampleitemreseachManager.getInstance().loadByContractsampleitemid(Long.parseLong(request.getParameter("id")));
            ptp = ptps[0];
        }
        
        if (request.getParameter("status").equals("2"))
        {
            if (request.getParameter("reason").trim().length()==0)
                throw new Exception(trs.t("გთხოვთ შეიტანოთ გაუქმების მიზეზი"));
            
            SampleitemreseachstatushistoryBean tmp = SampleitemreseachstatushistoryManager.getInstance().createSampleitemreseachstatushistoryBean();
            tmp.setSampleitemreseachid(ptp.getSampleitemreseachid());
            tmp.setStatus(2);
            tmp.setReason(request.getParameter("reason"));
            tmp.setRegbyid(user.getPersonellid());
            SampleitemreseachstatushistoryManager.getInstance().save(tmp);
            
            ptp.setStatus(2);
            ptp = SampleitemreseachManager.getInstance().save(ptp);
            rspJsonMessage(response, "OK", trs.t("ჩანაწერის სტატუსი შეიცვალა."));
        }
        else if (request.getParameter("status").equals("1"))
        {
//            if (request.getParameter("reason").trim().length()==0)
//                throw new Exception(trs.t("გთხოვთ შეიტანოთ აღდგენის მიზეზი"));
            
            SampleitemreseachstatushistoryBean tmp = SampleitemreseachstatushistoryManager.getInstance().createSampleitemreseachstatushistoryBean();
            tmp.setSampleitemreseachid(ptp.getSampleitemreseachid());
            tmp.setStatus(1);
            tmp.setReason(request.getParameter("reason")==null ? "" : request.getParameter("reason"));
            tmp.setRegbyid(user.getPersonellid());
            SampleitemreseachstatushistoryManager.getInstance().save(tmp);
            
            ptp.setStatus(1);
            ptp = SampleitemreseachManager.getInstance().save(ptp);
            rspJsonMessage(response, "OK", trs.t("ჩანაწერის სტატუსი შეიცვალა."));
        }
    } else if (oper.equalsIgnoreCase("postphone")) {
        SampleitemreseachBean ptp = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (ptp==null)
                throw new Exception(trs.t("ტესტი არ არის არჩეული"));

        PostponeitemBean tmp = PostponeitemManager.getInstance().createPostponeitemBean();
        tmp.setContractsampleitemid(ptp.getContractsampleitemid());
        tmp.setEnddate(str2date(request.getParameter("enddate").trim(),"ახალი ვადა არ არის მითითებული"));
        tmp.setRegbyid(user.getPersonellid());
        PostponeitemManager.getInstance().save(tmp);

        rspJsonMessage(response, "OK", trs.t("ვადა შეიცვალა."));
        
    } else if(oper.equalsIgnoreCase("qualitycontrol")){

        String person = request.getParameter("person").trim();
        String answer = request.getParameter("answer").trim();
        SampleitemreseachBean ptp = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (person.length()==0)
            throw new Exception(trs.t("ვინ ჩაატარა არ არის არჩეული"));
        
        str2date(request.getParameter("crdate"),"ჩატარების თარიღი არ არის მითითებული");
        str2time(request.getParameter("crtime"),"ჩატარების დრო არ არის მითითებული");
        String dtm = request.getParameter("crdate")+" "+request.getParameter("crtime");
        if (answer.length()==0)
            throw new Exception(trs.t("პასუხი არ არის მითითებული"));

        ptp.setQualitycontrolDatetime(str2datetime(dtm," ჩატარების თარიღი არ არის მითითებული"));
        ptp.setQualitycontrolAnswer(answer);
        ptp.setQualitycontrolPerson(Integer.parseInt(request.getParameter("person")));
        SampleitemreseachManager.getInstance().save(ptp);
            
        rspJsonMessage(response, "OK", trs.t("მონაცემები დაფიქსირებულია."),sid);
        
    } else if (oper.equalsIgnoreCase("researchanswer")) {
        
        for(Enumeration e=request.getParameterNames();e.hasMoreElements();){
            String name = (String)e.nextElement();
            String[] vals = request.getParameterValues(name);
            System.out.print(name+" = ");
            for(int j=0;j<vals.length;j++)
                System.out.print(vals[j]+"; ");
            System.out.println("");
        }
        
        
        SampleitemreseachBean ptp = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (ptp==null)
                throw new Exception(trs.t("ტესტი არ არის არჩეული"));
        int deviceid = Integer.parseInt(request.getParameter("device").trim());
        LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(ptp.getLabtestid());
        String finalresult = request.getParameter("result").trim();
        if(finalresult.length()==0)
            throw new Exception(trs.t("შედეგი არ არის შეტანილი"));
        if(labtest.getRestypeid().intValue() == 1){
            if(finalresult.equalsIgnoreCase("true")){
                finalresult = "დადებითი";
                ptp.setBresult(true);
            } else {
                finalresult = "უარყოფითი";
                ptp.setBresult(false);
            }
        } else if(labtest.getRestypeid().intValue() == 1){
            ptp.setNresult(new Double(finalresult));
        } else ptp.setTresult(finalresult);

        ptp.setResult(finalresult);
        
        str2date(request.getParameter("resultdate"),"ჩატარების თარიღი არ არის მითითებული");
        str2time(request.getParameter("resulttime"),"ჩატარების დრო არ არის მითითებული");
        ptp.setResultDatetime(str2datetime(request.getParameter("resultdate")+" "+request.getParameter("resulttime")," ჩატარების თარიღი არ არის მითითებული"));
        ptp.setResultInfo(request.getParameter("resultinfo").trim());
        ptp.setResultNote(request.getParameter("resultnote").trim());
        ptp.setNorm(request.getParameter("norm").trim());
        if(request.getParameter("standard") != null && !request.getParameter("standard").equals("0"))
            ptp.setStandardid(new Integer(request.getParameter("standard")));
        if(deviceid > 0)
            ptp.setDeviceid(deviceid);
        ptp.setRegbyid(user.getPersonellid());
        ptp.setResultdescr(request.getParameter("resultdescr").trim());
        ptp.setConfirmation1id(user.getPersonellid());
        ptp.setConfiramtion1date(new Date().getTime());
        ptp = SampleitemreseachManager.getInstance().save(ptp);

        TestgroupBean[] grp = TestgroupManager.getInstance().loadByLabtestid(labtest.getLabtestid());
        if(grp.length > 0){
            ContractsampleitemBean item = ContractsampleitemManager.getInstance().loadByPrimaryKey(ptp.getContractsampleitemid());
            if(item.getParentid() != null){
                SampleitemreseachBean[] parent = SampleitemreseachManager.getInstance().loadByContractsampleitemid(item.getParentid());
                if(parent.length > 0){
                    String answer = getTestAns(parent[0].getSampleitemreseachid());
                    parent[0].setResult(answer);
                    parent[0] = SampleitemreseachManager.getInstance().save(parent[0]);
                }
            }
        } else {
            ContractsampleitemBean item = ContractsampleitemManager.getInstance().loadByPrimaryKey(ptp.getContractsampleitemid());
            if(item.getParentid() != null){
                SampleitemreseachBean[] parent = SampleitemreseachManager.getInstance().loadByContractsampleitemid(item.getParentid());
                if(parent.length > 0 && parent[0].getLabtestid().intValue() == ptp.getLabtestid().intValue()){
                    parent[0].setBresult(ptp.getBresult());
                    parent[0].setNorm(ptp.getNorm());
                    parent[0].setNresult(ptp.getNresult());
                    parent[0].setQualitycontrolAnswer(ptp.getQualitycontrolAnswer());
                    parent[0].setQualitycontrolDatetime(ptp.getQualitycontrolDatetime());
                    parent[0].setQualitycontrolPerson(ptp.getQualitycontrolPerson());
                    parent[0].setResult(ptp.getResult());
                    parent[0].setResultInfo(ptp.getResultInfo());
                    parent[0].setResultNorm(ptp.getResultNorm());
                    parent[0].setResultNote(ptp.getResultNote());
                    parent[0].setResultdescr(ptp.getResultdescr());
                    parent[0].setResultDatetime(ptp.getResultDatetime());
                    parent[0].setRegbyid(ptp.getRegbyid());
                    parent[0].setStandardid(ptp.getStandardid());
                    parent[0].setTresult(ptp.getTresult());
                    parent[0].setResult(ptp.getResult());
                    parent[0] = SampleitemreseachManager.getInstance().save(parent[0]);
                }
            }
        }
        
        rspJsonMessage(response, "OK", trs.t("მონაცემები წარმატებით შეიცვალა."));
        
    } else if (oper.equalsIgnoreCase("confirmation")) {
        SampleitemreseachBean ptp = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (ptp==null)
                throw new Exception(trs.t("ტესტი არ არის არჩეული"));

        PersonelltypeBean lev = PersonelltypeManager.getInstance().loadByPrimaryKey(user.getPersonelltypeid());
        ConfirmationBean tmp = ConfirmationManager.getInstance().createConfirmationBean();
        tmp.setContractsampleitemid(ptp.getContractsampleitemid());
        tmp.setStatus(true);
        tmp.setRegbyid(user.getPersonellid());
        tmp = ConfirmationManager.getInstance().save(tmp);
        

        if (lev.getDescription().equalsIgnoreCase("level1"))
            ptp.setConfirmation1id(tmp.getConfirmationid());
        else if (lev.getDescription().equalsIgnoreCase("level2"))
            ptp.setConfirmation1id(tmp.getConfirmationid());
        else if (lev.getDescription().equalsIgnoreCase("level3"))
            ptp.setConfirmation1id(tmp.getConfirmationid());
        else if (ptp.getResult().length()==0)
            throw new Exception(trs.t("თქვენ არ გაქვთ მოთხოვნილი ოპერაციის შესრულების უფლება"));
        
        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
        
    } else if(oper.equalsIgnoreCase("aliqderiold")){

        String itemaction = request.getParameter("itemaction");
        String number = request.getParameter("number").trim();
        if (itemaction==null)
            throw new Exception(trs.t("გთხოვთ აირჩიოთ მოქმედება"));
        else if (itemaction.trim().length()==0)
            throw new Exception(trs.t("გთხოვთ აირჩიოთ მოქმედება"));
        else if (number.length()==0)
            throw new Exception(trs.t("გთხოვთ, შეიტანოთ რაოდენობა"));

        int n=0;
        try { n = Integer.parseInt(number); } catch(Exception e) {}
        if (n<1 || n>1000)
            throw new Exception(trs.t("რაოდენობა არ არის სწორი"));
       
        if (itemaction.equals("1"))
        {
            String ids  = request.getParameter("ids").trim();
            String smp[]  = ids.split(",");
            for (int i=0; i<smp.length; i++)
            {
                if (smp[i].equals(""))
                    continue;
                ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(smp[i]));
                ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());

                for (int j=0; j<n; j++)
                {
                    ContractsampleitemBean newitm = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                    newitm.setContractsampletypeid(itm.getContractsampletypeid());
                    newitm.setParentid(itm.getContractsampleitemid());
                    newitm.setNum1(itm.getNum1());
                    newitm.setNum2(itm.getNum2());
                    newitm.setRegbyid(user.getPersonellid());
                    ContractsampleitemManager.getInstance().save(newitm);
                    newitm.setBarcode(""+newitm.getContractsampleitemid());
                    ContractsampleitemManager.getInstance().save(newitm);
                }
            }
        }    
        else if (itemaction.equals("2") || itemaction.equals("3"))
        {
            String nid = itemaction.equals("2") ? request.getParameter("nid2").trim() : request.getParameter("nid3").trim();
            if (nid.trim().length()==0)
                throw new Exception(trs.t("გთხოვთ აირჩიოთ ტიპი"));
            String ids  = request.getParameter("ids").trim();
            String smp[]  = ids.split(",");
            for (int i=0; i<smp.length; i++)
            {
                if (smp[i].equals(""))
                    continue;
                ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(smp[i]));
                ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());

                for (int j=0; j<n; j++)
                {
                    ContractsampletypeBean newsam = ContractsampletypeManager.getInstance().createContractsampletypeBean();
                    newsam.setContractid(sam.getContractid());
                    newsam.setSampletypeid(Integer.parseInt(nid));
                    newsam.setRegbyid(user.getPersonellid());
                    newsam.setQuantity(1);
                    newsam.setBoxnum("");
                    newsam.setIsbox(false);
                    newsam = ContractsampletypeManager.getInstance().save(newsam);
                
                    ContractsampleitemBean newitm = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                    newitm.setContractsampletypeid(newsam.getContractsampletypeid());
                    newitm.setParentid(itm.getContractsampleitemid());
                    newitm.setNum1(itm.getNum1());
                    newitm.setNum2(itm.getNum2());
                    newitm.setRegbyid(user.getPersonellid());
                    ContractsampleitemManager.getInstance().save(newitm);
                    newitm.setBarcode(""+newitm.getContractsampleitemid());
                    ContractsampleitemManager.getInstance().save(newitm);
                }

            }
        }
        else
            throw new Exception(trs.t("გთხოვთ აირჩიოთ მოქმედება"));
       
        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
        
    } else if(oper.equalsIgnoreCase("aliqderi")){

        String itemaction = request.getParameter("itemaction");
        String number = request.getParameter("number").trim();
        String regdate = request.getParameter("regdate").trim();
        String sharedresearch = request.getParameter("sharedresearch");
        if (itemaction==null)
            throw new Exception(trs.t("გთხოვთ აირჩიოთ მოქმედება"));
        else if (itemaction.trim().length()==0)
            throw new Exception(trs.t("გთხოვთ აირჩიოთ მოქმედება"));
        else if (number.length()==0)
            throw new Exception(trs.t("გთხოვთ, შეიტანოთ რაოდენობა"));

        int n=0;
        try { n = Integer.parseInt(number); } catch(Exception e) {}
        if (n<1 || n>1000)
            throw new Exception(trs.t("რაოდენობა არ არის სწორი"));
       
        if (itemaction.equals("1"))
        {
            String ids  = request.getParameter("ids").trim();
            String smp[]  = ids.split(",");
            for (int i=0; i<smp.length; i++)
            {
                if (smp[i].equals(""))
                    continue;
                ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(smp[i]));
                ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
                SampleitemreseachBean[] sms = SampleitemreseachManager.getInstance().loadByContractsampleitemid(itm.getContractsampleitemid());
                for (int j=0; j<n; j++)
                {
                    ContractsampleitemBean newitm = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                    newitm.setContractsampletypeid(itm.getContractsampletypeid());
                    newitm.setParentid(itm.getContractsampleitemid());
                    newitm.setNum1(itm.getNum1());
                    newitm.setNum2(itm.getNum2());
                    newitm.setRegbyid(user.getPersonellid());
                    if(sms.length > 0) newitm.setInstitutionid(sms[0].getInstitutionid());
                    else newitm.setInstitutionid(itm.getInstitutionid());
                    newitm = ContractsampleitemManager.getInstance().save(newitm);
                    newitm.setBarcode(""+newitm.getContractsampleitemid());
                    newitm = ContractsampleitemManager.getInstance().save(newitm);
                    
                    if(sharedresearch != null){
                        if(sms.length == 0 || sms[0].getLabtestid() == null)
                            throw new Exception(trs.t("ნიმუშზე კვლევა არაა დანიშნული"));
                        SampleitemreseachBean sm = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                        sm.setContractsampleitemid(newitm.getContractsampleitemid());
                        sm.setContractid(sam.getContractid());
                        if(sms.length > 0){
                            sm.setInstitutionid(sms[0].getInstitutionid());
                            sm.setLabtestid(sms[0].getLabtestid());
                            sm.setSpeciesid(sms[0].getSpeciesid());
                            sm.setStandardid(sms[0].getStandardid());
                        }
                        sm.setRegbyid(user.getPersonellid());
                        sm.setRegdate(dt.parse(regdate).getTime());
                        sm = SampleitemreseachManager.getInstance().save(sm);
                    }
                }
            }
        }    
        else if (itemaction.equals("2") || itemaction.equals("3"))
        {
            String nid = itemaction.equals("2") ? request.getParameter("nid2").trim() : request.getParameter("nid3").trim();
            if (nid.trim().length()==0)
                throw new Exception(trs.t("გთხოვთ აირჩიოთ ტიპი"));
            String ids  = request.getParameter("ids").trim();
            String smp[]  = ids.split(",");
            for (int i=0; i<smp.length; i++)
            {
                if(smp[i].equals(""))
                    continue;
                ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(smp[i]));
                ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
                SampleitemreseachBean[] sms = SampleitemreseachManager.getInstance().loadByContractsampleitemid(itm.getContractsampleitemid());
                
                for (int j=0; j<n; j++)
                {
                    ContractsampletypeBean newsam = ContractsampletypeManager.getInstance().createContractsampletypeBean();
                    newsam.setContractid(sam.getContractid());
                    newsam.setSampletypeid(sam.getSampletypeid());
                    newsam.setRegbyid(user.getPersonellid());
                    newsam.setSpeciesid(sam.getSpeciesid());
                    newsam.setQuantity(1);
                    newsam.setBoxnum("");
                    newsam.setIsbox(false);
                    newsam = ContractsampletypeManager.getInstance().save(newsam);
                
                    ContractsampleitemBean newitm = ContractsampleitemManager.getInstance().createContractsampleitemBean();
                    newitm.setContractsampletypeid(newsam.getContractsampletypeid());
                    newitm.setParentid(itm.getContractsampleitemid());
                    newitm.setNum1(itm.getNum1());
                    newitm.setNum2(itm.getNum2());
                    newitm.setRegbyid(user.getPersonellid());
                    newitm.setDerivatetypeid(Integer.parseInt(nid));
                    if(sms.length > 0) newitm.setInstitutionid(sms[0].getInstitutionid());
                    else newitm.setInstitutionid(itm.getInstitutionid());
                    ContractsampleitemManager.getInstance().save(newitm);
                    newitm.setBarcode(""+newitm.getContractsampleitemid());
                    ContractsampleitemManager.getInstance().save(newitm);
                    
                    if(sharedresearch != null){
                        if(sms.length == 0 || sms[0].getLabtestid() == null)
                            throw new Exception(trs.t("ნიმუშზე კვლევა არაა დანიშნული"));
                        SampleitemreseachBean sm = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                        sm.setContractsampleitemid(newitm.getContractsampleitemid());
                        sm.setContractid(sam.getContractid());
                        if(sms.length > 0){
                            sm.setInstitutionid(sms[0].getInstitutionid());
                            sm.setLabtestid(sms[0].getLabtestid());
                            sm.setSpeciesid(sms[0].getSpeciesid());
                            sm.setStandardid(sms[0].getStandardid());
                        }
                        sm.setRegbyid(user.getPersonellid());
                        sm.setRegdate(dt.parse(regdate).getTime());
                        sm = SampleitemreseachManager.getInstance().save(sm);
                    }
                }

            }
        }
        else
            throw new Exception(trs.t("გთხოვთ აირჩიოთ მოქმედება"));
       
        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
        
    } else if (oper.equalsIgnoreCase("deleteresearch")) {
        
        SampleitemreseachBean[] ptp = SampleitemreseachManager.getInstance().loadByContractsampleitemid(Long.parseLong(request.getParameter("id")));
        ptp[0].setResult(null);
        SampleitemreseachManager.getInstance().save(ptp[0]);

        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
        
    } else if (oper.equalsIgnoreCase("resetboxresult")) {
        
        try {
            long boxid  = Long.parseLong(request.getParameter("boxid"));
            long testid = Long.parseLong(request.getParameter("testid"));
            Connection c  = Manager.getInstance().getConnection();
            try
            {
                String sql = ""
                + " UPDATE  sampleitemreseach SET RESULT=null "
                + " WHERE labtestid="+testid
                + " AND  deleted<>true"
                + " AND  result IS NOT NULL"
                + " AND  contractsampleitemid IN ("
                        + "SELECT itm.contractsampleitemid "
                        + "FROM  contractsampletype sam, contractsampleitem itm "
                        + "WHERE itm.contractsampletypeid=sam.contractsampletypeid AND  sam.parentid="+boxid
                        + ")";
                
                c.createStatement().executeUpdate(sql);
            }
            catch (Exception e){e.printStackTrace();}
            finally {Manager.getInstance().releaseConnection( c );}
            
        }
        catch(Exception e){
            e.printStackTrace();
        }
        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
    }    
    else
        throw new Exception(trs.t("ოპერაციის კოდი არასწორია!"));

    Manager.getInstance().endTransaction(true);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    rspJsonMessage(response, "ER", e.getMessage());
}
out.flush();
%>       
