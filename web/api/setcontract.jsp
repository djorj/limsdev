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
Manager.getInstance().beginTransaction();
try 
{
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (isMultipart) 
    {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        java.util.List items = null;
        try 
        {
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

        Map<String, String> labtest = new HashMap<String, String>();
        Map<String, String> sample  = new HashMap<String, String>();
        Map<String, String> maxprice = new HashMap<String, String>();
        Map<String, String> maxnum  = new HashMap<String, String>();
        Map<String, String> minday  = new HashMap<String, String>();
        Map<String, String> maxday  = new HashMap<String, String>();
        Map<String, String> comment = new HashMap<String, String>();
        
        Map<Long, String> elabtest = new HashMap<Long, String>();
        Map<Long, String> esample  = new HashMap<Long, String>();
        Map<Long, String> emaxprice = new HashMap<Long, String>();
        Map<Long, String> emaxnum  = new HashMap<Long, String>();
        Map<Long, String> eminday  = new HashMap<Long, String>();
        Map<Long, String> emaxday  = new HashMap<Long, String>();
        Map<Long, String> ecomment = new HashMap<Long, String>();
        String id =null;
        String contractid=null;
        String contragentid=null;
        String contracttype=null;
        String sampletypeid=null;
        String price=null;
        String startdate=null;
        String enddate=null;
        String num=null;
        String path=null;
        String info=null;
        String owner=null;
        String transfer=null;
        String owner_fname=null;
        String owner_lname=null;
        String owner_address=null;
        String owner_idn=null;
        String stamp = null;
        Vector bills = new Vector();
        Vector docs  = new Vector();
        FileItem docfile  =null;

        Iterator itr = items.iterator();
        while (itr.hasNext()) 
        {
            FileItem item = (FileItem) itr.next();
            if (item.isFormField()) 
            {
                String f = item.getFieldName();
                String v = item.getString("UTF-8");

                if      (f.equalsIgnoreCase("id"))            id=v;
                else if (f.equalsIgnoreCase("contractid"))    contractid=v;
                else if (f.equalsIgnoreCase("contragentid"))  contragentid=v;
                else if (f.equalsIgnoreCase("contracttype"))  contracttype=v;
                else if (f.equalsIgnoreCase("sampletypeid"))  sampletypeid=v;
                else if (f.equalsIgnoreCase("contractprice"))         price=v;
                else if (f.equalsIgnoreCase("startdate"))     startdate=v;
                else if (f.equalsIgnoreCase("enddate"))       enddate=v;
                else if (f.equalsIgnoreCase("num"))           num=v;
                else if (f.equalsIgnoreCase("path"))          path=v;
                else if (f.equalsIgnoreCase("info"))          info=v;
                else if (f.equalsIgnoreCase("owner"))         owner=v;
                else if (f.equalsIgnoreCase("transfer"))      transfer=v;
                else if (f.equalsIgnoreCase("fname"))         owner_fname=v;
                else if (f.equalsIgnoreCase("lname"))         owner_lname=v;
                else if (f.equalsIgnoreCase("idn"))           owner_idn=v;
                else if (f.equalsIgnoreCase("address"))       owner_address=v;
                else if (f.equalsIgnoreCase("contractstamp")) stamp=v;
                else if (f.startsWith("labtest"))             labtest.put(f.substring(7), v);
                else if (f.startsWith("sampletype"))          sample.put(f.substring(10), v);
                else if (f.startsWith("maxprice"))            maxprice.put(f.substring(8), v);
                else if (f.startsWith("maxnum"))              maxnum.put(f.substring(6), v);
                else if (f.startsWith("minday"))              minday.put(f.substring(6), v);
                else if (f.startsWith("maxday"))              maxday.put(f.substring(6), v);
                else if (f.startsWith("comment"))             comment.put(f.substring(7), v);
                else if (f.startsWith("edlab"))               elabtest.put(Long.parseLong(f.substring(5)), v);
                else if (f.startsWith("edsample"))            esample.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edmaxpri"))            emaxprice.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edmaxnum"))            emaxnum.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edminday"))            eminday.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edmaxday"))            emaxday.put(Long.parseLong(f.substring(8)), v);
                else if (f.startsWith("edcomment"))           ecomment.put(Long.parseLong(f.substring(9)), v);
                else if (f.startsWith("bill_")) {
                    String[] nms = f.split("_");
                    BillBean bill = BillManager.getInstance().createBillBean();
                    if(v.startsWith("ID_")){
                        String[] ids = v.split("_");
                        bill = BillManager.getInstance().loadByPrimaryKey(new Long(ids[1]));
                    } else {
                        String base64Image = v.split(",")[1];
                        String imagetype = ((v.split(",")[0]).split(";")[0]).split("/")[1];
                        byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
                        File fl = File.createTempFile("bill", "."+imagetype, new File(basedir+"documents/acts/"));
                        FileOutputStream io = new FileOutputStream(fl);
                        io.write(imageBytes);
                        io.close();
                        bill.setPath("documents/acts/"+fl.getName());
                    }
                    bill.setNum(nms[1]);
                    bill.setRegbyid(user.getPersonellid());
                    bills.addElement((BillBean)bill);
                }
                else if (f.startsWith("docs_")) {
                    String[] nms = f.split("_");
                    DocsBean doc = DocsManager.getInstance().createDocsBean();
                    if(v.startsWith("ID_")){
                        String[] ids = v.split("_");
                        doc = DocsManager.getInstance().loadByPrimaryKey(new Long(ids[1]));
                    } else {
                        String base64Image = v.split(",")[1];
                        String imagetype = ((v.split(",")[0]).split(";")[0]).split("/")[1];
                        byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
                        File fl = File.createTempFile("docs", "."+imagetype, new File(basedir+"documents/acts/"));
                        FileOutputStream io = new FileOutputStream(fl);
                        io.write(imageBytes);
                        io.close();
                        doc.setPath("documents/acts/"+fl.getName());
                    }
                    doc.setDoctypeid(Integer.parseInt(nms[1]));
                    doc.setRegbyid(user.getPersonellid());
                    docs.addElement((DocsBean)doc);
                }
            } 
            else
            {
                docfile = item;
                //System.out.println(">FILE:"+item.getName());
            }
        }
/*
                if      (f.equalsIgnoreCase("contractid"))    { try { obj.setContractid(Long.parseLong(v));} catch(Exception ign) {}}
                else if (f.equalsIgnoreCase("path"))          obj.setPath(v);
*/
        ContractBean  obj   = ContractManager.getInstance().createContractBean();
        if (contractid!=null&&!contractid.isEmpty())
            obj = ContractManager.getInstance().loadByPrimaryKey(Long.parseLong(contractid));
        else
            obj = ContractManager.getInstance().createContractBean();
     

        obj.setNum(num.replace("\\","\\\\"));
        if(obj.getNum().length() == 0)  
            throw new Exception(trs.t("ხელშეკრულების ნომერი შეტანილი არ არის!"));
        else
        {
            ContractBean[] obj2 = ContractManager.getInstance().loadByWhere("WHERE upper(num) = '"+num.toUpperCase().replace("'", "''").replace("\\","\\\\") +"'");
            if(obj2.length>0 && (obj.getContractid()!=null)&&(obj.getContractid().longValue()!=obj2[0].getContractid().longValue()))
                throw new Exception(trs.t("ხელშეკრულება ნომრით ~NAME~ უკვე არსებობს!",obj.getNum()));
        }
        
        try { obj.setContragentid(Long.parseLong(contragentid));} catch(Exception ign) {}
        if (contracttype.equals("1"))
        {
            obj.setContracttype(1);
            obj.setStartdate(string2date(startdate,_DATEFORMAT_,"თარიღი არ არის მითითებული"));
            obj.setEnddate(string2date(enddate,_DATEFORMAT_,"დასრულების ვადა არ არის მითითებული"));
            obj.setPrice(0.0);
            obj.setStamp(stamp);
            obj.setTransfer(transfer!=null);
        }
        else if (contracttype.equals("2"))
        {
            obj.setContracttype(2);
            obj.setTransfer(true);
            obj.setStartdate(string2date(startdate,_DATEFORMAT_,"თარიღი არ არის მითითებული"));
            obj.setEnddate(string2date(enddate,_DATEFORMAT_,"დასრულების ვადა არ არის მითითებული"));
            if (price!=null&&!price.isEmpty())    
            { 
                try { obj.setPrice(Double.parseDouble(price));} catch(Exception ign) {throw new Exception(trs.t("ფასი არ არის სწორად შეტანილი!"));}
            }
            else
                obj.setPrice(0);
            
            if (docfile!=null) 
            {
                try {
                    String itemName = new String(docfile.getName().getBytes("ISO8859_1"), "UTF-8");
                    obj.setPath(num+"."+FilenameUtils.getExtension(itemName));
                } catch (Exception e) {
                    throw new Exception(trs.t("შეცდომა, ხელშეკრულების დოკუმენტის შენახვისას. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას"));
                }
            }
            if (labtest.size()!=maxprice.size() || labtest.size()!=maxnum.size() ) 
            {
                throw new Exception(trs.t("არჩეული კვლევების ყველა ველი არ არის შევსებული"));
            }
        }
        else
            throw new Exception(trs.t("ხელშეკრულების ტიპი არჩეული არ არის!"));
        
        obj.setInfo(info);
        obj.setCompanyid(user.getCompanyid());
        obj.setRegbyid(user.getPersonellid());
        obj = ContractManager.getInstance().save(obj);
        if (obj.getContracttype()==1)
        {
            if (owner!=null)
            {
                if (owner_fname.length()==0) throw new Exception(trs.t("მფლობელის სახელი არ არის შეტანილი"));
                if (owner_lname.length()==0) throw new Exception(trs.t("მფლობელის გვარი არ არის შეტანილი"));
                //if (owner_idn.length()==0) throw new Exception(trs.t("მფლობელის პირადი ნომერი არ არის შეტანილი"));
                if (owner_address.length()==0) throw new Exception(trs.t("მფლობელის მისამართი არ არის შეტანილი"));
                ContractownerBean  own   = ContractownerManager.getInstance().createContractownerBean();
                own.setCompanyid(user.getCompanyid());
                own.setRegbyid(user.getPersonellid());
                own.setFname(owner_fname);
                own.setLname(owner_lname);
                own.setIdn(owner_idn);
                own.setAddress(owner_address);
                own = ContractownerManager.getInstance().save(own);
                obj.setContractownerid(own.getContractownerid());
                obj = ContractManager.getInstance().save(obj);
            }
        
            String dels = "";
            for(int i=0;i<bills.size();i++){

                BillBean bill = (BillBean)bills.elementAt(i);
                if(bill.getBillid() != null){
                    if(dels.length() > 0)    dels += ",";
                    dels += bill.getBillid();
                }
                bill.setContractid(obj.getContractid());
                bill = BillManager.getInstance().save(bill);
            }
            
            if(dels.length() > 0)
            {
                dels = " and billid not in ("+dels+")";
                BillManager.getInstance().deleteByWhere("where contractid = "+obj.getContractid()+dels);
            }
        
            dels = "";
            for(int i=0;i<docs.size();i++){
                DocsBean doc = (DocsBean)docs.elementAt(i);
                if(doc.getDocsid() != null){
                    if(dels.length() > 0)    dels += ",";
                    dels += doc.getDocsid();
                }
                doc.setContractid(obj.getContractid());
                DocsManager.getInstance().save(doc);
            }
            if(dels.length() > 0)
                DocsManager.getInstance().deleteByWhere("where contractid = "+obj.getContractid()+" AND docsid NOT IN ("+dels+")");
        }

        String notdels = "";
        double totprice = 0;
        boolean checkprice = false;
        if (obj.getContracttype()==2)
        {
            for (Map.Entry<String, String> entry : labtest.entrySet()) {
               try { 
                ContractlabtestBean lab = ContractlabtestManager.getInstance().createContractlabtestBean();
                double dmaxprice=0.0;
                long imaxcnt=0;
                long imaxday=0;
                long iminday=0;
                int  isample=0;
                int  itestid=0;
                String v = entry.getKey();
                try {dmaxprice=Double.parseDouble(maxprice.get(v)); }  catch (Exception ign) {}
                try {imaxcnt=Long.parseLong(maxnum.get(v)); } catch (Exception ign) {}
                try {imaxday=Long.parseLong(maxday.get(v)); } catch (Exception ign) {}
                try {iminday=Long.parseLong(minday.get(v)); } catch (Exception ign) {}
                try {isample=Integer.parseInt(sample.get(v)); } catch (Exception ign) {}
                try {itestid=Integer.parseInt(entry.getValue()); } catch (Exception ign) {}
                lab.setContractid(obj.getContractid());
                try {lab.setLabtestid(Long.parseLong(entry.getValue())); } catch (Exception ign) {}
                
                if (isample==0 && itestid==0)
                    continue;
                
                lab.setSampletypeid(isample);
                lab.setMaxprice(dmaxprice);
                lab.setMaxcnt(imaxcnt);
                lab.setMaxday(imaxday);
                lab.setMinday(iminday);
                lab.setInfo(comment.get(v));
                lab.setRegbyid(user.getPersonellid());
                lab = ContractlabtestManager.getInstance().save(lab);
                totprice += dmaxprice;
                checkprice = true;
                if(notdels.length() > 0)    notdels += ",";
                notdels += lab.getContractlabtestid();
              } catch (Exception e) {
                e.printStackTrace();
              }
            }
            
            for (Map.Entry<Long, String> entry : elabtest.entrySet()) {
               try { 
                Long v = entry.getKey();
                ContractlabtestBean lab = ContractlabtestManager.getInstance().loadByPrimaryKey(v);
                double dmaxprice=0.0;
                long imaxcnt=0;
                long imaxday=0;
                long iminday=0;
                int  isample=0;
                try {dmaxprice=Double.parseDouble(emaxprice.get(v)); }  catch (Exception ign) {}
                try {imaxcnt=Long.parseLong(emaxnum.get(v)); } catch (Exception ign) {}
                try {imaxday=Long.parseLong(emaxday.get(v)); } catch (Exception ign) {}
                try {iminday=Long.parseLong(eminday.get(v)); } catch (Exception ign) {}
                try {isample=Integer.parseInt(esample.get(v)); } catch (Exception ign) {}
                lab.setContractid(obj.getContractid());
                try {lab.setLabtestid(Long.parseLong(entry.getValue())); } catch (Exception ign) {}
                
                lab.setSampletypeid(isample);
                lab.setMaxprice(dmaxprice);
                lab.setMaxcnt(imaxcnt);
                lab.setMaxday(imaxday);
                lab.setMinday(iminday);
                lab.setInfo(ecomment.get(v));
                lab.setRegbyid(user.getPersonellid());
                lab = ContractlabtestManager.getInstance().save(lab);
                totprice += dmaxprice;
                checkprice = true;
                if(notdels.length() > 0)    notdels += ",";
                notdels += lab.getContractlabtestid();
              } catch (Exception e) {
                e.printStackTrace();
              }
            }
            
        }
        
        if(notdels.length() > 0)
            ContractlabtestManager.getInstance().deleteByWhere("where contractid = "+obj.getContractid()+" and contractlabtestid not in ("+notdels+")");
       
        if (obj.getContractid()!=null&&docfile!=null) 
        {
            try {
                String fp =config.getServletContext().getRealPath("/")+"documents/contracts/"+obj.getPath();
                File savedFile = new File(fp);
                docfile.write(savedFile);  
 	    } catch (Exception e) {
//throw new Exception(trs.t("შეცდომა, ხელშეკრულების დოკუმენტის შენახვისას. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას"));
            }
        }
        
        if(checkprice && obj.getPrice().doubleValue() != totprice)
            throw new Exception("სრული ფასი არასწორია: "+obj.getPrice()+" &ne; "+totprice);
        
        JSONObject res  = new JSONObject();
        res.put("id", obj.getContractid());
        res.put("num", obj.getNum());
        rspJsonMessage(response, "OK", "ხელშეკრულება დამატებულია",res);
        Manager.getInstance().endTransaction(true);
        return;
    }
    else
        rspJsonMessage(response, "ER", "სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას");
}
catch (Exception e) 
{
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    rspJsonMessage(response, "ER", e.getMessage());
}
%>
