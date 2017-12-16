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
                throw new Exception(trs.t("ნიმუშების რაოდენობა არა შეიძლება ნაკლები იყოს გატარებული ნიმუშების რაოდენობაზე!"));
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
        ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (request.getParameter("status").equals("2"))
        {
            if (request.getParameter("reason").trim().length()==0)
                throw new Exception(trs.t("გთხოვთ შეიტანოთ დაწუნების მიზეზი"));
            ptp.setStatus(2);
            ptp = ContractsampleitemManager.getInstance().save(ptp);
            
            SampleitemstatushistoryBean tmp = SampleitemstatushistoryManager.getInstance().createSampleitemstatushistoryBean();
            tmp.setContractsampleitemid(ptp.getContractsampleitemid());
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
            ptp.setStatus(3);
            ptp = ContractsampleitemManager.getInstance().save(ptp);
            
            SampleitemstatushistoryBean tmp = SampleitemstatushistoryManager.getInstance().createSampleitemstatushistoryBean();
            tmp.setContractsampleitemid(ptp.getContractsampleitemid());
            tmp.setStatus(3);
            tmp.setMethod(request.getParameter("method"));
            tmp.setRegbyid(user.getPersonellid());
            SampleitemstatushistoryManager.getInstance().save(tmp);
            rspJsonMessage(response, "OK", trs.t("ჩანაწერის სტატუსი შეიცვალა."));
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
        if (request.getParameter("info").trim().length()==0)
            throw new Exception(trs.t("გთხოვთ შეიტანოთ შენიშვნა"));
        ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("sampleitemid")));
        ptp.setInfo(request.getParameter("info").trim());
        ContractsampleitemManager.getInstance().save(ptp);
        rspJsonMessage(response, "OK", trs.t("შენიშვნა დამატებულია."));

    } else if(oper.equalsIgnoreCase("deletebanitem")){ 
        
        ContractsampleitemBean ptp = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (ptp!=null)
        {
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
        
        ContractsampleitemBean tmp = ContractsampleitemManager.getInstance().createContractsampleitemBean();
        tmp.setContractsampletypeid(Long.parseLong(request.getParameter("sampleid")));
        tmp.setNum1(request.getParameter("samplenum").trim());
        tmp.setRegbyid(user.getPersonellid());
        ContractsampleitemManager.getInstance().save(tmp);
        tmp.setBarcode(""+tmp.getContractsampleitemid());
        ContractsampleitemManager.getInstance().save(tmp);
            
        rspJsonMessage(response, "OK", trs.t("ნიმუში დამატებულია."),sid);
    } else if(oper.equalsIgnoreCase("transit")){
        String ids = request.getParameter("id").trim();
        if(ids.length() == 0)
            throw new Exception(trs.t("აირჩიეთ ერთი ნიმუში მაინც!"));
        ContractsampleitemBean[] itms = ContractsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in ("+ids+")");
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
                tm2 = SampleitemreseachManager.getInstance().save(tmp);
            }
        }
            
        rspJsonMessage(response, "OK", trs.t("კვლევა/ტესტი დანიშნულია."),sid);
    
    } else if(oper.equalsIgnoreCase("researchtest")){

        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
        
        SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
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
            for (int i=0; i<subtest.length; i++)
            {
                SampleitemreseachBean tm2 = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                tm2.setRegbyid(user.getPersonellid());
                tm2.setContractid(sam.getContractid());
                tm2.setContractsampleitemid(itm.getContractsampleitemid());
                tm2.setLabtestid(Integer.parseInt(subtest[i]));
                tm2.setTotalsubtest(0);
                tm2.setParenttest(itm.getContractsampleitemid());
                tm2 = SampleitemreseachManager.getInstance().save(tmp);
            }
        }
            
        rspJsonMessage(response, "OK", trs.t("კვლევა/ტესტი დანიშნულია."),sid);
    
    } else if(oper.equalsIgnoreCase("researchtest2")){

        int labtestid = Integer.parseInt(request.getParameter("testparent"));
        int institutionid = Integer.parseInt(request.getParameter("institutionid"));
        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
        PriceBean[] prc = PriceManager.getInstance().loadByLabtestid(labtestid);
       
        SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
        tmp.setRegbyid(user.getPersonellid());
        tmp.setContractid(sam.getContractid());
        tmp.setContractsampleitemid(itm.getContractsampleitemid());
        tmp.setInstitutionid(institutionid);
        tmp.setLabtestid(labtestid);
        tmp.setPrice(prc.length>0 ? prc[0].getPrice() : 0.0);
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
                SampleitemreseachBean tm2 = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                tm2.setRegbyid(user.getPersonellid());
                tm2.setContractid(sam.getContractid());
                tm2.setContractsampleitemid(itm.getContractsampleitemid());
                tm2.setLabtestid(Integer.parseInt(subtest[i]));
                tm2.setPrice(prc.length>0 ? prc[0].getPrice() : 0.0);
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
            String chk = ""
                    + "SELECT sam.name "
                    + "FROM labtestsampletype labsam, sampletype sam, contractsampletype consam, contractsampleitem samitm"
                    + "WHERE labsam.sampletypeid=sam.sampletypeid"
                    + " AND consam.sampletypeid=sam.sampletypeid"
                    + " AND consam.contractsampletypeid=samitm.contractsampletypeid"
                    + " AND consam.deleted = false"
                    + " AND labsam.labtestid="+labtestid
                    + " AND samitm.contractsampleitemid ="+labtestid
                    + " AND consam.contractid="+request.getParameter("contactid");

            System.out.println(chk);
            
            PriceBean[] prc = PriceManager.getInstance().loadByLabtestid(labtestid);
            for (int i=0; i<smp.length; i++)
            {
                if (smp[i].equals(""))
                    continue;
                ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(smp[i]));
                ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());
                if(LabtestsampletypeManager.getInstance().countWhere("where labtestid = "+labtestid+" and sampletypeid = "+sam.getSampletypeid()) == 0)
                    throw new Exception("მოცემული ნიმუშის ტიპი არ შეესაბამება არჩეულ ტესტს");
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
                    
                    SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                    tmp.setRegbyid(user.getPersonellid());
                    tmp.setContractid(sam.getContractid());
                    tmp.setContractsampleitemid(newitm.getContractsampleitemid());
                    tmp.setLabtestid(labtestid);
                    tmp.setInstitutionid(institutionid);
                    tmp.setPrice(prc.length>0 ? prc[0].getPrice() : 0.0);
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
            for (int n=0; n<itm.length; n++)
            {
                    int ntst = SampleitemreseachManager.getInstance().countWhere("WHERE deleted=false AND contractsampleitemid="+itm[n].getContractsampleitemid());
System.out.println("N="+itm.length+" I="+n+" NTST="+ntst+" ITM="+itm[n].getContractsampleitemid());                    
                    if (ntst==0)
                    {
                        SampleitemreseachBean sir = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                        sir.setRegbyid(user.getPersonellid());
                        sir.setContractid(box.getContractid());
                        sir.setContractsampleitemid(itm[n].getContractsampleitemid());
                        sir.setLabtestid(labtestid);
                        sir.setInstitutionid(institutionid);
                        sir.setPrice(prc.length>0 ? prc[0].getPrice() : 0.0);
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
                        sir.setPrice(prc.length>0 ? prc[0].getPrice() : 0.0);
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
System.out.println(where);
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
System.out.println(where);
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
                if(smp[i].equals(""))
                    continue;
                ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(smp[i]));
                ContractsampletypeBean sam = ContractsampletypeManager.getInstance().loadByPrimaryKey(itm.getContractsampletypeid());

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
                    ContractsampleitemManager.getInstance().save(newitm);
                    newitm.setBarcode(""+newitm.getContractsampleitemid());
                    ContractsampleitemManager.getInstance().save(newitm);
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
