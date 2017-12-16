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
        ptp.setNum1(request.getParameter("num1"));
        ptp.setNum2(request.getParameter("num2"));
        ptp.setRegbyid(user.getPersonellid());
        ptp = ContractsampleitemManager.getInstance().save(ptp);
        rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),ptp.getContractsampletypeid().toString());
    } else if(oper.equalsIgnoreCase("updSampleBoxNum")){
        ContractsampletypeBean ptp = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ptp.setBoxnum(request.getParameter("num1"));
        ptp.setRegbyid(user.getPersonellid());
        ptp = ContractsampletypeManager.getInstance().save(ptp);
        rspJsonMessage(response, "OK", trs.t("მონაცემები განახლებულია."),ptp.getContractsampletypeid().toString());
    } else if(oper.equalsIgnoreCase("updSample")){
        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        itm.setNum1(request.getParameter("num1"));
        itm.setNum2(request.getParameter("num2"));
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
        if (request.getParameter("isbox")==null)
        {
            if ( ContractsampletypeManager.getInstance().countWhere("WHERE deleted=false AND isbox=false AND sampletypeid="+request.getParameter("sampleid")+" AND contractid="+request.getParameter("contractid")) > 0)
                    throw new Exception(trs.t("ცხრილში, ეს ნიმუშის ტიპი, უკვე დამატებულია!"));
            int quantity = 1;
            if (request.getParameter("quantity")!=null)
                quantity = Integer.parseInt(request.getParameter("quantity"));
            ptp.setContractid(Long.parseLong(request.getParameter("contractid")));
            ptp.setSampletypeid(Integer.parseInt(request.getParameter("sampleid")));
            ptp.setRegbyid(user.getPersonellid());
            ptp.setQuantity(quantity);
            ptp.setBoxnum("");
            ptp.setIsbox(false);
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
            if (ContractsampletypeManager.getInstance().countWhere("WHERE deleted=false AND isbox=true AND contractid="+request.getParameter("contractid")+"  AND boxnum='"+request.getParameter("boxnum").trim().toUpperCase().replaceAll("'", "''")+"' AND sampletypeid="+request.getParameter("sampleid"))>0)
                throw new Exception(trs.t("ცხრილში, ეს ნიმუშის ტიპი, უკვე დამატებულია!"));
                
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
                ptp.setContractid(Long.parseLong(request.getParameter("contractid")));
                ptp.setRegbyid(user.getPersonellid());
                ptp.setQuantity(1);
                ptp.setIsbox(true);
                ptp.setBoxnum(request.getParameter("boxnum"));
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
            chl.setContractid(Long.parseLong(request.getParameter("contractid")));
            chl.setSampletypeid(Integer.parseInt(request.getParameter("sampleid")));
            chl.setRegbyid(user.getPersonellid());
            chl.setIsbox(true);
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
        if (request.getParameter("info").trim().length()==0)
            throw new Exception(trs.t("გთხოვთ შეიტანოთ შენიშვნა"));
        ContractsampletypeBean ptp = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("sampletypeid")));
        ptp.setInfo(request.getParameter("info").trim());
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

        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        TransitsampleitemBean tmp = TransitsampleitemManager.getInstance().createTransitsampleitemBean();
        tmp.setContractsampleitemid(itm.getContractsampleitemid());
        if (request.getParameter("sendoutside")==null)
        {
            if (request.getParameter("departamentid").trim().length()==0)
                throw new Exception(trs.t("დეპარტამენტი არ არის არჩეული"));
            tmp.setOutside(false);
            tmp.setLocationid(Integer.parseInt(request.getParameter("departamentid")));
            tmp.setTransitdate(str2date(request.getParameter("senddate").trim(),"თარიღი არ არის მითითებული"));
            tmp.setTransittime(str2time(request.getParameter("sendtime").trim(),"დრო არ არის მითითებული"));
        }
        else
        {
            tmp.setOutside(true);
            tmp.setContainer(request.getParameter("container").trim());
            tmp.setReceiver(request.getParameter("receiver").trim());
            tmp.setResearcher(request.getParameter("researcher").trim());
            tmp.setPersonals(request.getParameter("personells").trim());
        }
        tmp.setRegbyid(user.getPersonellid());
        TransitsampleitemManager.getInstance().save(tmp);
            
        rspJsonMessage(response, "OK", trs.t("გადაცემა დაფიქსირებულია."),sid);
    } else if(oper.equalsIgnoreCase("aliqderi")){

        if (request.getParameter("itemaction").trim().length()==0)
            throw new Exception(trs.t("გთხოვთ აირჩიოთ მოქმედება"));
        else if (request.getParameter("number").trim().length()==0)
            throw new Exception(trs.t("გთხოვთ, შეიტანოთ რაოდენობა"));
        ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        rspJsonMessage(response, "OK", trs.t("დაფიქსირებულია."),sid);
        
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
        ContractlabtestBean[] cb = ContractlabtestManager.getInstance().loadByWhere("where contractid = "+itm.getContracttypeid()+" and labtestid = "+labtestid);
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
                cb = ContractlabtestManager.getInstance().loadByWhere("where contractid = "+itm.getContracttypeid()+" and labtestid = "+subtest[i]);
                prc = PriceManager.getInstance().loadByLabtestid(Integer.parseInt(subtest[i]));
                price = 0;
                if(cb.length > 0 && cb[0].getMaxprice() != null)   price = cb[0].getMaxprice();
                if(price == 0 && prc.length > 0)                   price = prc[0].getPrice();
                
                SampleitemreseachBean tm2 = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                tm2.setRegbyid(user.getPersonellid());
                tm2.setContractid(sam.getContractid());
                tm2.setContractsampleitemid(itm.getContractsampleitemid());
                tm2.setLabtestid(Integer.parseInt(subtest[i]));
                tm2.setPrice(price);
                tm2.setTotalsubtest(0);
                tm2.setParenttest(itm.getContractsampleitemid());
                tm2 = SampleitemreseachManager.getInstance().save(tm2);
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
            ContractlabtestBean[] cb = ContractlabtestManager.getInstance().loadByWhere("where contractid = "+itm.getContracttypeid()+" and labtestid = "+labtestid);
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
                int ntst = SampleitemreseachManager.getInstance().countWhere("WHERE deleted=false AND contractsampleitemid="+smp[i]);
                if (ntst==0)
                {
                    
                    SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                    tmp.setRegbyid(user.getPersonellid());
                    tmp.setContractid(sam.getContractid());
                    tmp.setContractsampleitemid(itm.getContractsampleitemid());
                    tmp.setLabtestid(labtestid);
                    tmp.setInstitutionid(institutionid);
                    tmp.setPrice(price);
                    tmp.setTotalsubtest(0);
                    tmp = SampleitemreseachManager.getInstance().save(tmp);
                }
                else
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
                    
                    SampleitemreseachBean tmp = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                    tmp.setRegbyid(user.getPersonellid());
                    tmp.setContractid(sam.getContractid());
                    tmp.setContractsampleitemid(newitm.getContractsampleitemid());
                    tmp.setLabtestid(labtestid);
                    tmp.setInstitutionid(institutionid);
                    tmp.setPrice(price);
                    tmp.setTotalsubtest(0);
                    tmp = SampleitemreseachManager.getInstance().save(tmp);
                }
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

            
            //LabtestinstitutionBean[] lab = LabtestinstitutionManager.getInstance().loadByLabtestid(labtestid);
            //if (lab.length==0)
            //    rspJsonMessage(response, "ER", trs.t("არჩეული კვლევისთვის ლაბორატორია არ იძებნება. შეავსეთ მონაცემთა ბაზა"));
            //else if (lab.length>1&&(institutionid==0))
            //    rspJsonMessage(response, "ER", "multiplelab");
            //else
            //{
            //    if (institutionid==0)
            //        institutionid = lab[0].getInstitutionid();
            
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
System.out.println("N="+itm.length+" I="+n+" NTST="+ntst);                    
                    if (ntst==0)
                    {
                        SampleitemreseachBean sir = SampleitemreseachManager.getInstance().createSampleitemreseachBean();
                        sir.setRegbyid(user.getPersonellid());
                        sir.setContractid(box.getContractid());
                        sir.setContractsampleitemid(itm[i].getContractsampleitemid());
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
        
    } else if (oper.equalsIgnoreCase("cancelrestore")) {
        SampleitemreseachBean ptp = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
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
            if (request.getParameter("reason").trim().length()==0)
                throw new Exception(trs.t("გთხოვთ შეიტანოთ აღდგენის მიზეზი"));
            
            SampleitemreseachstatushistoryBean tmp = SampleitemreseachstatushistoryManager.getInstance().createSampleitemreseachstatushistoryBean();
            tmp.setSampleitemreseachid(ptp.getSampleitemreseachid());
            tmp.setStatus(1);
            tmp.setReason(request.getParameter("reason"));
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
        SampleitemreseachBean ptp = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (ptp==null)
                throw new Exception(trs.t("ტესტი არ არის არჩეული"));

        ptp.setResult(request.getParameter("result").trim());
        if (ptp.getResult().length()==0)
            throw new Exception(trs.t("შედეგი არ არის შეტანილი"));
        str2date(request.getParameter("resultdate"),"ჩატარების თარიღი არ არის მითითებული");
        str2time(request.getParameter("resulttime"),"ჩატარების დრო არ არის მითითებული");
        ptp.setResultDatetime(str2datetime(request.getParameter("resultdate")+" "+request.getParameter("resulttime")," ჩატარების თარიღი არ არის მითითებული"));
        ptp.setResultInfo(request.getParameter("resultinfo").trim());
        ptp.setResultNote(request.getParameter("resultnote").trim());
        SampleitemreseachManager.getInstance().save(ptp);

        rspJsonMessage(response, "OK", trs.t("მონაცემები შეიცვალა."));
        
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