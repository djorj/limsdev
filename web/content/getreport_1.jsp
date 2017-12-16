<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page  import="java.util.*"%>
<%@ page  import="java.sql.Connection"%>
<%@ page  import="java.text.*"%>
<%@ page  import="java.io.*"%>
<%@ page  import="com.mysoft.*"%>
<%@ page  import="com.mysoft.lims.*"%>
<%@page import="net.sf.json.*" %>
<%@page import="net.sf.json.util.*" %>
<%@ page  import="net.sf.jasperreports.engine.*"%>
<%@ page  import="net.sf.jasperreports.engine.data.*"%>
<%@ page  import="net.sf.jasperreports.engine.export.*"%>
<%@include file="../includes/init.jsp" %>
<%!
public String getGeoGr(String iname) throws Exception {
    String lch = iname.substring(iname.length()-1);
    if(lch.equals("ა") || lch.equals("ე") || lch.equals("ი") || lch.equals("ო") || lch.equals("უ"))
        iname = iname.substring(0,iname.length()-1)+"ის";
    else
        iname = iname+"ს";
    return iname;
}
%>
<%
String[] months = {"იანვარი","თებერვალი","მარტი","აპრილი","მაისი","ივნისი","ივლისი","აგვისტო","სექტემბერი","ოქტომბერი","ნოემბერი","დეკემბერი"};
JSONObject o = new JSONObject();
try{    
    File fl = File.createTempFile("report", ".pdf", new File("/tmp"));
    JSONObject json = new JSONObject();
    String reportname = request.getParameter("name");
    JSONArray ar = new JSONArray();
    boolean isfile = false;
    if(reportname.equalsIgnoreCase("contract")){
        ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
        ContractsampletypeBean[] sampletypes = ContractsampletypeManager.getInstance().loadByWhere("where contractid = "+contract.getContractid()+" and deleted = false and parentid is null order by sampletypeid");
        Calendar cal = Calendar.getInstance();
        cal.setTime(contract.getStartdate());
        String text1 = "საქართველოს სოფლის მეურნეობის სამინისტროს ლაბორატორია, წარმოდგენილი მისი დირექტორის ირაკლი გულედანის სახით (შემდგომში \"ლაბორატორია\") ერთის მხრივ და მეორეს მხრივ ";
        if(contragent.getContragenttypeid().intValue() == 1)
            text1 += "ფიზიკური";
        else
            text1 += "იურდიული";
        text1 += " პირი (შემდგომში \"დამკვეთი\"), ";
        if(contragent.getContragenttypeid().intValue() <= 2)
            text1 += contragent.getName()+" (პ/ნ: "+contragent.getIdn()+")";
        else
            text1 += contragent.getName()+" (ს/კ: "+contragent.getIdn()+")";
        text1 += ", ვდებთ ხელშეკრულებას შემდეგზე:";
        
        String contragentdata = "დამკვეთის რეკვიზიტები:\nმისამართი და ტელეფონი: "+contragent.getAddress()+"\n";
        if(contragent.getContragenttypeid().intValue() <= 2)
            contragentdata += "პირადი № ";
        else
            contragentdata += "საიდენტ.კოდი: ";
        contragentdata += contragent.getIdn();
        
        String materials = "";
        for(int i=0;i<sampletypes.length;i++){
            SampletypeBean stype = SampletypeManager.getInstance().loadByPrimaryKey(sampletypes[i].getSampletypeid());
            if(i > 0)   materials += "; ";
            materials += sampletypes[i].getQuantity()+" "+stype.getName();
        }
        double price = contract.getPrice();
	if (contract.getContracttype()==1)
	{
	    Connection c   = Manager.getInstance().getConnection();
	    ResultSet rs;
	    try
	    {
		String sql = " SELECT sum(price) price "
		    + "FROM sampleitemreseach sr, labtest lt "
            	    + "WHERE sr.labtestid=lt.labtestid "
                    + " AND sr.deleted=false "
                    + " AND sr.contractsampleitemid IN ("
                    + "SELECT contractsampleitemid from contractsampleitem, contractsampletype "
                    + "WHERE contractsampleitem.contractsampletypeid=contractsampletype.contractsampletypeid "
                        + " AND contractsampletype.deleted = false "
                        + " AND contractsampleitem.deleted = false "
                    + ") "
                    +  "AND contractid = "+contract.getContractid();

		rs = c.createStatement().executeQuery(sql);
		if (rs.next())
		    price = rs.getDouble("price");
		rs.close();
	    }
	    catch(Exception e){
		e.printStackTrace();
	    }
	    finally {
		    Manager.getInstance().releaseConnection(c);
	    }
	}


        int days = (int)((contract.getEnddate().getTime() - contract.getStartdate().getTime())/86400000);

        JSONObject ob = new JSONObject();
        ob.put("name","contractnum");
        ob.put("value","ხელშეკრულება № "+contract.getNum());
        ob.put("type",3);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","contractdate");
        ob.put("value",cal.get(Calendar.DATE)+" "+months[cal.get(Calendar.MONTH)]+" "+cal.get(Calendar.YEAR));
        ob.put("type",3);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","text1");
        ob.put("value",text1);
        ob.put("type",3);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","contragentdata");
        ob.put("value",contragentdata);
        ob.put("type",3);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","price");
        ob.put("value",price);
        ob.put("type",2);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","days");
        ob.put("value",days);
        ob.put("type",1);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","materials");
        ob.put("value",materials);
        ob.put("type",3);
        ar.add(ob);
        
    } else if(reportname.equalsIgnoreCase("appeal")){
        
        AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        fl = new File(config.getServletContext().getRealPath("/")+"/documents/appeals/"+appeal.getAppealid()+"."+appeal.getPath());
        
    } else if(reportname.equalsIgnoreCase("act")){
        
        ActBean act = ActManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        Calendar cal = Calendar.getInstance();
        cal.setTime(act.getActdate());
        
        JSONObject ob = new JSONObject();
        ob.put("name","actnum");
        ob.put("value","აქტი № "+act.getNum());
        ob.put("type",3);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","actdate");
        ob.put("value",cal.get(Calendar.DATE)+" "+months[cal.get(Calendar.MONTH)]+" "+cal.get(Calendar.YEAR));
        ob.put("type",3);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","content");
        ob.put("value",act.getContent());
        ob.put("type",3);
        ar.add(ob);
    } else if(reportname.equalsIgnoreCase("inventory")){
        
        InventoryBean inv = InventoryManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
        InstitutionBean ins = InstitutionManager.getInstance().loadByPrimaryKey(inv.getInstitutionid());
        
        PersonellBean[] pers0 = PersonellManager.getInstance().loadByWhere("where personelltypeid in (select personelltypeid from personelltype where code = '52') order by lname, fname");
        PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where personelltypeid in (select personelltypeid from personelltype where code = '51') order by lname, fname");
        PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+ins.getParentid()+" order by lname, fname");
        
        String iname = getGeoGr(ins.getName());
        String headertext = "თანახმად სსიპ სოფლის მეურნეობის სამინისტროს ლაბორატორიის 2016 წლის 16 ნოემბრის #92/ძ ბრძანებისა, აღწერა და შეამოწმა "+iname+" ფაქტიური მდგომარეობა "
                +pers2[0].getPosition()+"ს "+pers2[0].getFname()+" "+pers2[0].getLname()+"ს (პასუხისმგებელი პირის) თანდასწრებით და აღმოჩნდა შემდეგი ინვენტარი:";
        JSONObject ob = new JSONObject();
        ob.put("name","title");
        ob.put("value","საინვენტარიზაციო აღწერილობა № "+inv.getInventoryid());
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","invdate");
        ob.put("value",dtrep.format(inv.getStartdate())+" წ-ს მდგომარეობით");
        ob.put("type",3);
        ar.add(ob);
        
        if(pers0.length > 0){
            ins = InstitutionManager.getInstance().loadByPrimaryKey(pers0[0].getInstitutionid());
            iname = getGeoGr(ins.getName());
        } else iname = "";
        ob.put("name","pers0");
        ob.put("value","კომისიამ შემადგენლობით: "+((pers0.length == 0) ? "":iname+" "+pers0[0].getPosition()+" - "+pers0[0].getFname()+" "+pers0[0].getLname()));
        ob.put("type",3);
        ar.add(ob);
        
        for(int i=0;i<4;i++){
            ob.put("name","pers"+String.valueOf(i+1));
            if(i<pers1.length) {
                ins = InstitutionManager.getInstance().loadByPrimaryKey(pers1[i].getInstitutionid());
                iname = getGeoGr(ins.getName());
                ob.put("value",String.valueOf(i+1)+". "+iname+" "+pers1[i].getPosition()+" - "+pers1[i].getFname()+" "+pers1[i].getLname());
            } else
                ob.put("value","");
            ob.put("type",3);
            ar.add(ob);
        }
        
        ob.put("name","headertext");
        ob.put("value",headertext);
        ob.put("type",3);
        ar.add(ob);
        
        ob = new JSONObject();
        ob.put("name","id");
        ob.put("value",inv.getInventoryid());
        ob.put("type",1);
        ar.add(ob);
    } else if(reportname.equalsIgnoreCase("F-061-206-G")){
        SampleitemreseachBean rs = SampleitemreseachManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(rs.getLabtestid());
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(rs.getInstitutionid());
        ContractsampleitemBean sm = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
        ContractsampletypeBean cm = ContractsampletypeManager.getInstance().loadByPrimaryKey(sm.getContractsampletypeid());
        SampletypeBean st = SampletypeManager.getInstance().loadByPrimaryKey(cm.getSampletypeid());
        PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rs.getRegbyid());
        PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
        ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(cm.getContractid());
        String standard = "";
        if(rs.getStandardid() != null){
            StandardBean std = StandardManager.getInstance().loadByPrimaryKey(rs.getStandardid());
            standard = std.getName();
        }
            
        //String departmentname = "";
        //String labname = inst.getName();
        String stamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                
        String num = contract.getNum();
        if(cm.getActid() != null){
            ActBean act = ActManager.getInstance().loadByPrimaryKey(cm.getActid());
            num = act.getNum();
            stamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
        }
        if(cm.getAppealid() != null){
            AppealBean act = AppealManager.getInstance().loadByPrimaryKey(cm.getAppealid());
            num = act.getNum();
            stamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
        }
        String regnum_date = "# "+num + "          "+dt.format(new Date());
        String samplegetdate = dt.format(rs.getRegdate());
        String sampletype = st.getName();
        String sampleamount = ""+cm.getQuantity();
        String fromwhomsample = stamp;
        if(contract.getContractownerid() != null){
            ContractownerBean owner = ContractownerManager.getInstance().loadByPrimaryKey(contract.getContractownerid());
            fromwhomsample += "\n"+owner.getFname()+" "+owner.getLname();
        }
        String getforresearch = (labtest != null) ? labtest.getName():"";
        String method = standard;
        String result = rs.getResult();
        String note = rs.getResultNote();
        if(rs.getResultdescr() != null && rs.getResultdescr().trim().length() > 0)
            result = rs.getResultdescr();
        String labhead = "";
	if(pers1.length > 0)
		labhead = pers1[0].getFname()+" "+pers1[0].getLname();
        String laborant = pers.getFname()+" "+pers.getLname();
        String departmenthead = "";
        if(inst.getParentid() != null){
            InstitutionBean dept = InstitutionManager.getInstance().loadByPrimaryKey(inst.getParentid());
            //departmentname = dept.getName();
            PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+dept.getInstitutionid()+" and personelltypeid = 9");
            if(pers2.length > 0)
                departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
        }
        
        JSONObject ob = new JSONObject();
        
        
        
        ob.put("name","regnum_date");
        ob.put("value",regnum_date);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","samplegetdate");
        ob.put("value",samplegetdate);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampletype");
        ob.put("value",sampletype);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampleamount");
        ob.put("value",sampleamount);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","fromwhomsample");
        ob.put("value",fromwhomsample);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","method");
        ob.put("value",method);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","result");
        ob.put("value",result);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","note");
        ob.put("value",(note == null) ? "":note);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","labhead");
        ob.put("value",labhead);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","laborant");
        ob.put("value",laborant);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","departmenthead");
        ob.put("value",departmenthead);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","getforresearch");
        ob.put("value",getforresearch);
        ob.put("type",3);
        ar.add(ob);

    } else if(reportname.equalsIgnoreCase("F-138-2016-G")){
        ContractsampleitemBean sm = ContractsampleitemManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        ContractsampleitemBean parent = ContractsampleitemManager.getInstance().loadByPrimaryKey(sm.getContractsampleitemid());
        if(sm.getParentid() != null)    parent = ContractsampleitemManager.getInstance().loadByPrimaryKey(sm.getParentid());
        
        String inst2 = "../img/checkbox_unchecked_32.jpg";
        String inst6 = "../img/checkbox_unchecked_32.jpg";
        
        SampleitemreseachBean[] rs = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid = "+sm.getContractsampleitemid()+" order by sampleitemreseachid limit 1");
        String testname = "";
        if(rs.length > 0){
            LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(rs[0].getLabtestid());
            testname = labtest.getName();
            if(rs[0].getInstitutionid().intValue() == 2) inst2 = "../img/checkbox_checked_32.jpg";
            else if(rs[0].getInstitutionid().intValue() == 6) inst6 = "../img/checkbox_checked_32.jpg";
            else if(rs[0].getInstitutionid().intValue() >= 11 && rs[0].getInstitutionid().intValue() <= 15)
                reportname = "F-138-2016-G_1";
            else if(rs[0].getInstitutionid().intValue() == 23)
                reportname = "F-138-2016-G";
        }
        ContractsampletypeBean cm = ContractsampletypeManager.getInstance().loadByPrimaryKey(sm.getContractsampletypeid());
        SampletypeBean st = SampletypeManager.getInstance().loadByPrimaryKey(cm.getSampletypeid());
        
        ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(cm.getContractid());
        /*String standard = "";
        if(rs[0].getStandardid() != null){
            StandardBean std = StandardManager.getInstance().loadByPrimaryKey(rs[0].getStandardid());
            standard = std.getName();
        }*/
            
        //String departmentname = "";
        //String labname = inst.getName();
        String stamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                
        String num = contract.getNum();
        if(cm.getActid() != null){
            ActBean act = ActManager.getInstance().loadByPrimaryKey(cm.getActid());
            num = act.getNum();
            stamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
        }
        if(cm.getAppealid() != null){
            AppealBean act = AppealManager.getInstance().loadByPrimaryKey(cm.getAppealid());
            num = act.getNum();
            stamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
        }
        String registrationnumber = parent.getBarcode();
        String regdate = dt.format(sm.getRegdate());
        String sampletype = st.getName();
        String collectiondate = dt.format(sm.getRegdate());
        
        String sampleemaunt = (cm.getQuantity() == null) ? "1 "+Num2Text(1):""+cm.getQuantity()+" "+Num2Text(cm.getQuantity().intValue());
        String getforresearch = testname;
        
        String bringer = "";
        String anamnesis = "";
        
        JSONObject ob = new JSONObject();
        
        ob.put("name","bringer");
        ob.put("value",bringer);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","anamnesis");
        ob.put("value",anamnesis);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","stamp");
        ob.put("value",stamp);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","inst2");
        ob.put("value",inst2);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","inst6");
        ob.put("value",inst6);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","registrationnumber");
        ob.put("value",registrationnumber);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","regdate");
        ob.put("value",regdate);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","collectiondate");
        ob.put("value",collectiondate);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampletype");
        ob.put("value",sampletype);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampleemaunt");
        ob.put("value",sampleemaunt);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","labtest");
        ob.put("value",getforresearch);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","fieldid");
        ob.put("value",(sm.getNum1() == null) ? "":sm.getNum1());
        ob.put("type",3);
        ar.add(ob);
        
        

    } else if(reportname.equalsIgnoreCase("finalanswer")){
        String[] ids = request.getParameter("id").split("_");
        long appealid = Long.parseLong(ids[0]);
        long actid = Long.parseLong(ids[1]);
        long contractid = Long.parseLong(ids[2]);
        int sampletypeid = Integer.parseInt(ids[3]);
        SampletypeBean sampletype = SampletypeManager.getInstance().loadByPrimaryKey(sampletypeid);
        reportname = "F-003-2016-G";
        ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(contractid);
        String regnum_date = "# ";
        String samplegetdate = "";
        String hasstamp = "";
        //SampletypeBean stp = SampletypeManager.getInstance().loadByPrimaryKey(sampletypeid);
        
        //VAnswersBean[] res = VAnswersManager.getInstance().loadByWhere("where ");
        String sql = "where sampletypeid > 0 "; //+sampletypeid;
        if(appealid > 0){
            AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(appealid);
            samplegetdate = dt.format(appeal.getAppealdate());
            regnum_date += appeal.getNum();
            sql += " and appealid = "+appealid;
            hasstamp = (appeal.getStamp() != null && appeal.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            //cm = ContractsampletypeManager.getInstance().loadByAppealid(appeal.getAppealid());
            //contr = ContractManager.getInstance().loadByPrimaryKey(appeal.getContractid());
            //sqlcontracts = "appealid = "+appeal.getAppealid();
        } else if(actid > 0){
            ActBean act = ActManager.getInstance().loadByPrimaryKey(actid);
            regnum_date += act.getNum();
            samplegetdate = dt.format(act.getActdate());
            sql += " and actid = "+actid;
            hasstamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            //cm = ContractsampletypeManager.getInstance().loadByActid(act.getActid());
            //contr = ContractManager.getInstance().loadByPrimaryKey(act.getContractid());
            //sqlcontracts = "actid = "+act.getActid();
        } else {
            sql += " and contractid = "+contractid;
            regnum_date += contract.getNum();
            samplegetdate = dt.format(contract.getRegdate());
            //cm = ContractsampletypeManager.getInstance().loadByContractid(contract.getContractid());
            hasstamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            //contr = ContractManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
            //sqlcontracts = "contractid = "+contract.getContractid();
        }
        
        ContractsampletypeBean[] cbs = ContractsampletypeManager.getInstance().loadByWhere(sql);
        ContractsampleitemBean[] items = ContractsampleitemManager.getInstance().loadByWhere("where contractsampletypeid in (select contractsampletypeid from contractsampletype "+sql+")");
        sql = "select r.labtestid from sampleitemreseach r, contractsampleitem i, contractsampletype t where "
                + "r.contractsampleitemid = i.contractsampleitemid and "
                + "i.contractsampletypeid = t.contractsampletypeid";    // and "
                //+ "t.sampletypeid = "+sampletypeid;
        if(appealid > 0)        sql += " and t.appealid = "+appealid;
        else if(appealid > 0)   sql += " and t.actid = "+actid;
        else                    sql += " and t.contractid = "+contractid;

        LabtestBean[] labtests = LabtestManager.getInstance().loadByWhere("where labtestid in ("+sql+")");
        StandardBean[] methods = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid in ("+sql+"))");
        String testnames = "";
        String method = "";
        
        for(int i=0;i<labtests.length;i++){
            if(i > 0)   {
                testnames += "\n";
                //insts += ",";
            }
            testnames += labtests[i].getName();
            
            
        }
        for(int i=0;i<methods.length;i++){
            if(i > 0)   method += "\n";
            method += methods[i].getName();
        }
        sql = "select i.contractsampleitemid from contractsampleitem i, contractsampletype t where "
                + "i.contractsampletypeid = t.contractsampletypeid";    // and "
//                + "t.sampletypeid = "+sampletypeid;
        if(appealid > 0)        sql += " and t.appealid = "+appealid;
        else if(appealid > 0)   sql += " and t.actid = "+actid;
        else                    sql += " and t.contractid = "+contractid;
        SampleitemreseachBean[] rs = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid in ("+sql+")");
        if(rs.length > 0 && rs[0].getInstitutionid() != null && rs[0].getInstitutionid().intValue() == 23)
                reportname = "F-061-206-G";
        String results = "";
        String insts = "";
        String note = "";
        for(int i=0;i<rs.length;i++){
            if(i>0){
                insts += ",";
                if(rs[i].getResultdescr() != null) results += "\n";
                if(rs[i].getResultNote() != null)  note += "\n";
            }
            insts += rs[i].getInstitutionid();
            if(rs[i].getResultdescr() != null) results += rs[i].getResultdescr();
            if(rs[i].getResultNote() != null)  note += rs[i].getResultNote();
        }
        
        
        JSONObject ob = new JSONObject();
        
        
        ob.put("name","regnum_date");
        ob.put("value",regnum_date+"   "+dt.format(new Date()));
        ob.put("type",3);
        ar.add(ob);
        
        
        ob.put("name","samplegetdate");
        ob.put("value",samplegetdate);
        ob.put("type",3);
        ar.add(ob);
        
        String sampleowner = "";

        if(contract.getContractownerid() != null){
            ContractownerBean owner = ContractownerManager.getInstance().loadByPrimaryKey(contract.getContractownerid());
            sampleowner = owner.getFname()+" "+owner.getLname()+" "+owner.getIdn();
        } else {
            ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
            if(contragent.getContragenttypeid().intValue() < 3 )
                sampleowner = contragent.getFname()+" "+contragent.getLname()+" "+contragent.getIdn();
            else
                sampleowner = contragent.getName() + " "+ contragent.getIdn();
        }

        ob.put("name","sampleowner");
        ob.put("value",sampleowner);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampletype");
        ob.put("value",sampletype.getName());
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","hasstamp");
        ob.put("value",hasstamp);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampleamount");
        ob.put("value",items.length);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","getforresearch");
        ob.put("value",testnames);
        ob.put("type",3);
        ar.add(ob);
        
        
        
        String Recipient = "";
        ob.put("name","Recipient");
        ob.put("value",Recipient);
        ob.put("type",3);
        ar.add(ob);
        
        String Director = "ირაკლი გულედანი";
        ob.put("name","Director");
        ob.put("value",Director);
        ob.put("type",3);
        ar.add(ob);
        
        String departmentheadid_1 = "";
        String departmentheadid_10 = "";
        String departmentheadid_2 = "";
        String departmentheadid_6 = "";
        PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = 1 and personelltypeid = 11");
        PersonellBean[] pers10 = PersonellManager.getInstance().loadByWhere("where institutionid = 10 and personelltypeid = 9 and institutionid in (select parentid from institution where institutionid in ("+insts+"))");
        PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = 2 and personelltypeid = 9 and institutionid in (select parentid from institution where institutionid in ("+insts+"))");
        PersonellBean[] pers6 = PersonellManager.getInstance().loadByWhere("where institutionid = 6 and personelltypeid = 9 and institutionid in (select parentid from institution where institutionid in ("+insts+"))");

        if(pers1.length > 0)        departmentheadid_1 = pers1[0].getFname()+" "+pers1[0].getLname();
        if(pers10.length > 0)       departmentheadid_10 = pers10[0].getFname()+" "+pers10[0].getLname();
        if(pers2.length > 0)        departmentheadid_2 = pers2[0].getFname()+" "+pers2[0].getLname();
        if(pers6.length > 0)        departmentheadid_6 = pers6[0].getFname()+" "+pers6[0].getLname();
        
        ob.put("name","departmentheadid_1");
        ob.put("value",departmentheadid_1);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","departmentheadid_10");
        ob.put("value",departmentheadid_10);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","departmentheadid_2");
        ob.put("value",departmentheadid_2);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","departmentheadid_6");
        ob.put("value",departmentheadid_6);
        ob.put("type",3);
        ar.add(ob);
        
        
        ob.put("name","method");
        ob.put("value",method);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","result");
        ob.put("value",results);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","note");
        ob.put("value",note);
        ob.put("type",3);
        ar.add(ob);
        
        
    } else if(reportname.equalsIgnoreCase("internalanswerungrouped")){
        String[] ids = request.getParameter("id").split("_");
        long appealid = Long.parseLong(ids[0]);
        long actid = Long.parseLong(ids[1]);
        long contractid = Long.parseLong(ids[2]);
        int sampletypeid = Integer.parseInt(ids[3]);
        SampletypeBean stp = SampletypeManager.getInstance().loadByPrimaryKey(sampletypeid);
        
        String sql = "select i.contractsampleitemid from contractsampleitem i, contractsampletype t where "
                + "i.contractsampletypeid = t.contractsampletypeid and "
                + "t.sampletypeid = "+sampletypeid;
        if(appealid > 0)        sql += " and t.appealid = "+appealid;
        else if(appealid > 0)   sql += " and t.actid = "+actid;
        else                    sql += " and t.contractid = "+contractid;
        SampleitemreseachBean[] rs = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid in ("+sql+")");
        SampleitemreseachBean[] rrss = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid in ("+sql+") and regbyid in (select personellid from personell where institutionid = "+rs[0].getInstitutionid()+") limit 1");

        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(rs[0].getInstitutionid());
        if(inst.getInstitutionid().intValue() == 11 || inst.getInstitutionid().intValue() == 13 || inst.getInstitutionid().intValue() == 14 || inst.getInstitutionid().intValue() == 15) {
            reportname = "F-038-2016-G-1";
            String inst11 = "../img/checkbox_unchecked_32.jpg";
            String inst13 = "../img/checkbox_unchecked_32.jpg";
            String inst14 = "../img/checkbox_unchecked_32.jpg";
            String inst15 = "../img/checkbox_unchecked_32.jpg";
            if(inst.getInstitutionid().intValue() == 11) inst11 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 13) inst13 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 14) inst14 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 15) inst15 = "../img/checkbox_checked_32.jpg";
            
            ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(contractid);
            String regnum_date = "# ";
            String samplegetdate = "";
            String hasstamp = "";
            sql = "where sampletypeid = "+sampletypeid;
            if(appealid > 0){
                AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(appealid);
                samplegetdate = dt.format(appeal.getAppealdate());
                regnum_date += appeal.getNum();
                sql += " and appealid = "+appealid;
                hasstamp = (appeal.getStamp() != null && appeal.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //cm = ContractsampletypeManager.getInstance().loadByAppealid(appeal.getAppealid());
                //contr = ContractManager.getInstance().loadByPrimaryKey(appeal.getContractid());
                //sqlcontracts = "appealid = "+appeal.getAppealid();
            } else if(actid > 0){
                ActBean act = ActManager.getInstance().loadByPrimaryKey(actid);
                regnum_date += act.getNum();
                samplegetdate = dt.format(act.getActdate());
                sql += " and actid = "+actid;
                hasstamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //cm = ContractsampletypeManager.getInstance().loadByActid(act.getActid());
                //contr = ContractManager.getInstance().loadByPrimaryKey(act.getContractid());
                //sqlcontracts = "actid = "+act.getActid();
            } else {
                sql += " and contractid = "+contractid;
                regnum_date += contract.getNum();
                samplegetdate = dt.format(contract.getRegdate());
                //cm = ContractsampletypeManager.getInstance().loadByContractid(contract.getContractid());
                hasstamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //contr = ContractManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
                //sqlcontracts = "contractid = "+contract.getContractid();
            }

            //ContractsampletypeBean[] cbs = ContractsampletypeManager.getInstance().loadByWhere(sql);
            ContractsampleitemBean[] items = ContractsampleitemManager.getInstance().loadByWhere("where contractsampletypeid in (select contractsampletypeid from contractsampletype "+sql+")");
            sql = "select r.labtestid from sampleitemreseach r, contractsampleitem i, contractsampletype t where "
                    + "r.contractsampleitemid = i.contractsampleitemid and "
                    + "i.contractsampletypeid = t.contractsampletypeid and "
                    + "t.sampletypeid = "+sampletypeid;
            if(appealid > 0)        sql += " and t.appealid = "+appealid;
            else if(appealid > 0)   sql += " and t.actid = "+actid;
            else                    sql += " and t.contractid = "+contractid;

            LabtestBean[] labtests = LabtestManager.getInstance().loadByWhere("where labtestid in ("+sql+")");
            StandardBean[] methods = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid in ("+sql+"))");
            String testnames = "";
            String method = "";

            for(int i=0;i<labtests.length;i++){
                if(i > 0)   {
                    testnames += "\n";
                    //insts += ",";
                }
                testnames += labtests[i].getName();


            }
            for(int i=0;i<methods.length;i++){
                if(i > 0)   method += "\n";
                method += methods[i].getName();
            }
            String results = "";
            String note = "";
            for(int i=0;i<rs.length;i++){
                if(i>0){
                    if(rs[i].getResultdescr() != null) results += "\n";
                    if(rs[i].getResultNote() != null)  note += "\n";
                }
                if(rs[i].getResultdescr() != null) results += rs[i].getResultdescr();
                if(rs[i].getResultNote() != null)  note += rs[i].getResultNote();
            }
            sql = "select count(r.sampleitemreseachid) as cnt, r.resultdescr from  "
                    + "sampleitemreseach r, contractsampleitem i, contractsampletype t where "
                    + "i.contractsampleitemid = r.contractsampleitemid and "
                    + "i.contractsampletypeid = t.contractsampletypeid and "
                    + "t.sampletypeid = "+sampletypeid;
            if(appealid > 0)        sql += " and t.appealid = "+appealid;
            else if(appealid > 0)   sql += " and t.actid = "+actid;
            else                    sql += " and t.contractid = "+contractid;
            sql += " group by r.resultdescr";
            results = "";
            Connection c = Manager.getInstance().beginTransaction();
            ResultSet rrs = c.createStatement().executeQuery(sql);
            for(int i=0;rrs.next();i++){
                int cnt = rrs.getInt(1);
                String res = rrs.getString(2);
                if(res == null) continue;
                if(results.trim().length() > 0)   results += "\n";
                results += cnt+" "+res;
            }
            rrs.close();
            Manager.getInstance().releaseConnection(c);
            
            
            JSONObject ob = new JSONObject();

            ob.put("name","appealid");
            ob.put("value",appealid);
            ob.put("type",1);
            ar.add(ob);

            ob.put("name","actid");
            ob.put("value",actid);
            ob.put("type",1);
            ar.add(ob);

            ob.put("name","contractid");
            ob.put("value",contractid);
            ob.put("type",1);
            ar.add(ob);

            ob.put("name","sampletypeid");
            ob.put("value",sampletypeid);
            ob.put("type",1);
            ar.add(ob);
            
            ob.put("name","inst11");
            ob.put("value",inst11);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","inst13");
            ob.put("value",inst13);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","inst14");
            ob.put("value",inst14);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","inst15");
            ob.put("value",inst15);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);
            
            String sampleowner = "";

            if(contract.getContractownerid() != null){
                ContractownerBean owner = ContractownerManager.getInstance().loadByPrimaryKey(contract.getContractownerid());
                sampleowner = owner.getFname()+" "+owner.getLname()+" "+owner.getIdn();
            } else {
                ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
                if(contragent.getContragenttypeid().intValue() < 3 )
                    sampleowner = contragent.getFname()+" "+contragent.getLname()+" "+contragent.getIdn();
                else
                    sampleowner = contragent.getName() + " "+ contragent.getIdn();
            }
            
            ob.put("name","owner");
            ob.put("value",sampleowner);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","method");
            ob.put("value",method);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","result");
            ob.put("value",results);
            ob.put("type",3);
            ar.add(ob);
            
            
            ob.put("name","sampletype");
            ob.put("value",stp.getName());
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampleamount");
            ob.put("value",items.length);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","fromwhomsample");
            ob.put("value","");
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","getforresearch");
            ob.put("value",testnames);
            ob.put("type",3);
            ar.add(ob);
            
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey( (rrss.length > 0) ? rrss[0].getRegbyid():rs[0].getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
            
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }
            
            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);
            
        } else if(inst.getInstitutionid().intValue() == 4 || inst.getInstitutionid().intValue() == 5) {
            reportname = "F-004-2016-G";
            String chemistry = "../img/checkbox_unchecked_32.jpg";
            String instrumental = "../img/checkbox_unchecked_32.jpg";
            if(inst.getInstitutionid().intValue() == 4) chemistry = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 5) chemistry = "../img/checkbox_checked_32.jpg";

            ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(contractid);
            String regnum_date = "# ";
            String samplegetdate = "";
            String hasstamp = "";
            sql = "where sampletypeid = "+sampletypeid;
            if(appealid > 0){
                AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(appealid);
                samplegetdate = dt.format(appeal.getAppealdate());
                regnum_date += appeal.getNum();
                sql += " and appealid = "+appealid;
                hasstamp = (appeal.getStamp() != null && appeal.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //cm = ContractsampletypeManager.getInstance().loadByAppealid(appeal.getAppealid());
                //contr = ContractManager.getInstance().loadByPrimaryKey(appeal.getContractid());
                //sqlcontracts = "appealid = "+appeal.getAppealid();
            } else if(actid > 0){
                ActBean act = ActManager.getInstance().loadByPrimaryKey(actid);
                regnum_date += act.getNum();
                samplegetdate = dt.format(act.getActdate());
                sql += " and actid = "+actid;
                hasstamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //cm = ContractsampletypeManager.getInstance().loadByActid(act.getActid());
                //contr = ContractManager.getInstance().loadByPrimaryKey(act.getContractid());
                //sqlcontracts = "actid = "+act.getActid();
            } else {
                sql += " and contractid = "+contractid;
                regnum_date += contract.getNum();
                samplegetdate = dt.format(contract.getRegdate());
                //cm = ContractsampletypeManager.getInstance().loadByContractid(contract.getContractid());
                hasstamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //contr = ContractManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
                //sqlcontracts = "contractid = "+contract.getContractid();
            }

            ContractsampletypeBean[] cbs = ContractsampletypeManager.getInstance().loadByWhere(sql);
            ContractsampleitemBean[] items = ContractsampleitemManager.getInstance().loadByWhere("where contractsampletypeid in (select contractsampletypeid from contractsampletype "+sql+")");
            sql = "select r.labtestid from sampleitemreseach r, contractsampleitem i, contractsampletype t where "
                    + "r.contractsampleitemid = i.contractsampleitemid and "
                    + "i.contractsampletypeid = t.contractsampletypeid and "
                    + "t.sampletypeid = "+sampletypeid;
            if(appealid > 0)        sql += " and t.appealid = "+appealid;
            else if(appealid > 0)   sql += " and t.actid = "+actid;
            else                    sql += " and t.contractid = "+contractid;

            LabtestBean[] labtests = LabtestManager.getInstance().loadByWhere("where labtestid in ("+sql+")");
            StandardBean[] methods = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid in ("+sql+"))");
            String testnames = "";
            String method = "";

            for(int i=0;i<labtests.length;i++){
                if(i > 0)   {
                    testnames += "\n";
                    //insts += ",";
                }
                testnames += labtests[i].getName();


            }
            for(int i=0;i<methods.length;i++){
                if(i > 0)   method += "\n";
                method += methods[i].getName();
            }
            sql = "select i.contractsampleitemid from contractsampleitem i, contractsampletype t where "
                    + "i.contractsampletypeid = t.contractsampletypeid and "
                    + "t.sampletypeid = "+sampletypeid;
            if(appealid > 0)        sql += " and t.appealid = "+appealid;
            else if(appealid > 0)   sql += " and t.actid = "+actid;
            else                    sql += " and t.contractid = "+contractid;
            SampleitemreseachBean[] rss = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid in ("+sql+")");
            String results = "";
            String insts = "";
            String note = "";
            for(int i=0;i<rs.length;i++){
                if(i>0){
                    insts += ",";
                    if(rs[i].getResultdescr() != null) results += "\n";
                    if(rs[i].getResultNote() != null)  note += "\n";
                }
                insts += rs[i].getInstitutionid();
                if(rs[i].getResultdescr() != null) results += rs[i].getResultdescr();
                if(rs[i].getResultNote() != null)  note += rs[i].getResultNote();
            }
            
            JSONObject ob = new JSONObject();

            ob.put("name","chemistry");
            ob.put("value",chemistry);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","instrumental");
            ob.put("value",instrumental);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);
            
            String sampleowner = "";

            if(contract.getContractownerid() != null){
                ContractownerBean owner = ContractownerManager.getInstance().loadByPrimaryKey(contract.getContractownerid());
                sampleowner = owner.getFname()+" "+owner.getLname()+" "+owner.getIdn();
            } else {
                ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
                if(contragent.getContragenttypeid().intValue() < 3 )
                    sampleowner = contragent.getFname()+" "+contragent.getLname()+" "+contragent.getIdn();
                else
                    sampleowner = contragent.getName() + " "+ contragent.getIdn();
            }
            
            ob.put("name","owner");
            ob.put("value",sampleowner);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","method");
            ob.put("value",method);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","result");
            ob.put("value",results);
            ob.put("type",3);
            ar.add(ob);
            
            
            ob.put("name","sampletype");
            ob.put("value",stp.getName());
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampleamount");
            ob.put("value",items.length);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","fromwhomsample");
            ob.put("value","");
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","getforresearch");
            ob.put("value",testnames);
            ob.put("type",3);
            ar.add(ob);
            
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rss[0].getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
            
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }
            
            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);
            
        } else if(inst.getInstitutionid().intValue() == 3) {
            reportname = "F-005-2016-G";
            String chemistry = "../img/checkbox_unchecked_32.jpg";
            String instrumental = "../img/checkbox_unchecked_32.jpg";
            if(inst.getInstitutionid().intValue() == 4) chemistry = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 5) chemistry = "../img/checkbox_checked_32.jpg";

            ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(contractid);
            String regnum_date = "# ";
            String samplegetdate = "";
            String hasstamp = "";
            sql = "where sampletypeid = "+sampletypeid;
            if(appealid > 0){
                AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(appealid);
                samplegetdate = dt.format(appeal.getAppealdate());
                regnum_date += appeal.getNum();
                sql += " and appealid = "+appealid;
                hasstamp = (appeal.getStamp() != null && appeal.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //cm = ContractsampletypeManager.getInstance().loadByAppealid(appeal.getAppealid());
                //contr = ContractManager.getInstance().loadByPrimaryKey(appeal.getContractid());
                //sqlcontracts = "appealid = "+appeal.getAppealid();
            } else if(actid > 0){
                ActBean act = ActManager.getInstance().loadByPrimaryKey(actid);
                regnum_date += act.getNum();
                samplegetdate = dt.format(act.getActdate());
                sql += " and actid = "+actid;
                hasstamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //cm = ContractsampletypeManager.getInstance().loadByActid(act.getActid());
                //contr = ContractManager.getInstance().loadByPrimaryKey(act.getContractid());
                //sqlcontracts = "actid = "+act.getActid();
            } else {
                sql += " and contractid = "+contractid;
                regnum_date += contract.getNum();
                samplegetdate = dt.format(contract.getRegdate());
                //cm = ContractsampletypeManager.getInstance().loadByContractid(contract.getContractid());
                hasstamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //contr = ContractManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
                //sqlcontracts = "contractid = "+contract.getContractid();
            }

            //ContractsampletypeBean[] cbs = ContractsampletypeManager.getInstance().loadByWhere(sql);
            ContractsampleitemBean[] parents = ContractsampleitemManager.getInstance().loadByWhere("where parentid is null and contractsampleitemid in (select contractsampletypeid from contractsampletype "+sql+")");
            ContractsampleitemBean[] items = ContractsampleitemManager.getInstance().loadByWhere("where parentid is not null and contractsampletypeid in (select contractsampletypeid from contractsampletype "+sql+")");
            //ContractsampleitemBean[] pitems = ContractsampleitemManager.getInstance().loadByWhere("where contractsampletypeid = "+items[0].getParentid());
            sql = "select r.labtestid from sampleitemreseach r, contractsampleitem i, contractsampletype t where "
                    + "r.contractsampleitemid = i.contractsampleitemid and "
                    + "i.contractsampletypeid = t.contractsampletypeid and "
                    + "t.sampletypeid = "+sampletypeid;
            if(appealid > 0)        sql += " and t.appealid = "+appealid;
            else if(appealid > 0)   sql += " and t.actid = "+actid;
            else                    sql += " and t.contractid = "+contractid;

            LabtestBean[] labtests = LabtestManager.getInstance().loadByWhere("where labtestid in ("+sql+")");
            StandardBean[] methods = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid in ("+sql+"))");
            String testnames = "";
            String method = "";

            for(int i=0;i<labtests.length;i++){
                if(i > 0)   {
                    testnames += "\n";
                    //insts += ",";
                }
                testnames += labtests[i].getName();


            }
            for(int i=0;i<methods.length;i++){
                if(i > 0)   method += "\n";
                method += methods[i].getName();
            }
            sql = "select i.contractsampleitemid from contractsampleitem i, contractsampletype t where "
                    + "i.contractsampletypeid = t.contractsampletypeid and "
                    + "t.sampletypeid = "+sampletypeid;
            if(appealid > 0)        sql += " and t.appealid = "+appealid;
            else if(appealid > 0)   sql += " and t.actid = "+actid;
            else                    sql += " and t.contractid = "+contractid;
            SampleitemreseachBean[] rss = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid in ("+sql+")");
            String results = "";
            String insts = "";
            String note = "";
            for(int i=0;i<rs.length;i++){
                if(i>0){
                    insts += ",";
                    if(rs[i].getResultdescr() != null) results += "\n";
                    if(rs[i].getResultNote() != null)  note += "\n";
                }
                insts += rs[i].getInstitutionid();
                if(rs[i].getResultdescr() != null) results += rs[i].getResultdescr();
                if(rs[i].getResultNote() != null)  note += rs[i].getResultNote();
            }
            
            JSONObject ob = new JSONObject();
            
            ob.put("name","sampleitemreseachid");
            ob.put("value",0);
            ob.put("type",1);
            ar.add(ob);
            
            ob.put("name","parentid");
            ob.put("value",items[0].getParentid().longValue());
            ob.put("type",1);
            ar.add(ob);

            ob.put("name","instrumental");
            ob.put("value",instrumental);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","chemistry");
            ob.put("value",chemistry);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);
            
            String sampleowner = "";

            if(contract.getContractownerid() != null){
                ContractownerBean owner = ContractownerManager.getInstance().loadByPrimaryKey(contract.getContractownerid());
                sampleowner = owner.getFname()+" "+owner.getLname()+" "+owner.getIdn();
            } else {
                ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
                if(contragent.getContragenttypeid().intValue() < 3 )
                    sampleowner = contragent.getFname()+" "+contragent.getLname()+" "+contragent.getIdn();
                else
                    sampleowner = contragent.getName() + " "+ contragent.getIdn();
            }
            
            ob.put("name","owner");
            ob.put("value",sampleowner);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","method");
            ob.put("value",method);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","result");
            ob.put("value",results);
            ob.put("type",3);
            ar.add(ob);
            
            
            ob.put("name","sampletype");
            ob.put("value",stp.getName());
            ob.put("type",3);
            ar.add(ob);
            
            int amt = parents.length;
            if(amt == 0)    amt = 1;
            ob.put("name","sampleamount");
            ob.put("value",amt+" ("+Num2Text(amt)+")");
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","fromwhomsample");
            ob.put("value","");
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","getforresearch");
            ob.put("value",testnames);
            ob.put("type",3);
            ar.add(ob);
            
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rss[0].getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
            
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }
            
            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);
            
        } else if(inst.getInstitutionid().intValue() == 7 || inst.getInstitutionid().intValue() == 8 || inst.getInstitutionid().intValue() == 9) {
            // 8 ფიტოპათოლოგია
            // 7 ენტომოლოგიის ლაბორატორია
            // 9 მოლეკულური
            
            reportname = "F-061-2016-G";
            String check8 = "../img/checkbox_unchecked_32.jpg";
            String check7 = "../img/checkbox_unchecked_32.jpg";
            String check9 = "../img/checkbox_unchecked_32.jpg";
            if(inst.getInstitutionid().intValue() == 8) check8 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 7) check7 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 9) check9 = "../img/checkbox_checked_32.jpg";
            
            ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(contractid);
            String regnum_date = "# ";
            String samplegetdate = "";
            String hasstamp = "";
            sql = "where sampletypeid = "+sampletypeid;
            if(appealid > 0){
                AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(appealid);
                samplegetdate = dt.format(appeal.getAppealdate());
                regnum_date += appeal.getNum();
                sql += " and appealid = "+appealid;
                hasstamp = (appeal.getStamp() != null && appeal.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //cm = ContractsampletypeManager.getInstance().loadByAppealid(appeal.getAppealid());
                //contr = ContractManager.getInstance().loadByPrimaryKey(appeal.getContractid());
                //sqlcontracts = "appealid = "+appeal.getAppealid();
            } else if(actid > 0){
                ActBean act = ActManager.getInstance().loadByPrimaryKey(actid);
                regnum_date += act.getNum();
                samplegetdate = dt.format(act.getActdate());
                sql += " and actid = "+actid;
                hasstamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //cm = ContractsampletypeManager.getInstance().loadByActid(act.getActid());
                //contr = ContractManager.getInstance().loadByPrimaryKey(act.getContractid());
                //sqlcontracts = "actid = "+act.getActid();
            } else {
                sql += " and contractid = "+contractid;
                regnum_date += contract.getNum();
                samplegetdate = dt.format(contract.getRegdate());
                //cm = ContractsampletypeManager.getInstance().loadByContractid(contract.getContractid());
                hasstamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
                //contr = ContractManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
                //sqlcontracts = "contractid = "+contract.getContractid();
            }

            //ContractsampletypeBean[] cbs = ContractsampletypeManager.getInstance().loadByWhere(sql);
System.out.println(sql);
            ContractsampleitemBean[] items = ContractsampleitemManager.getInstance().loadByWhere("where contractsampletypeid in (select contractsampletypeid from contractsampletype "+sql+")");
            sql = "select r.labtestid from sampleitemreseach r, contractsampleitem i, contractsampletype t where "
                    + "r.contractsampleitemid = i.contractsampleitemid and "
                    + "i.contractsampletypeid = t.contractsampletypeid and "
                    + "t.sampletypeid = "+sampletypeid;
            if(appealid > 0)        sql += " and t.appealid = "+appealid;
            else if(appealid > 0)   sql += " and t.actid = "+actid;
            else                    sql += " and t.contractid = "+contractid;

            LabtestBean[] labtests = LabtestManager.getInstance().loadByWhere("where labtestid in ("+sql+")");
            StandardBean[] methods = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid in ("+sql+"))");
            String testnames = "";
            String method = "";

            for(int i=0;i<labtests.length;i++){
                if(i > 0)   {
                    testnames += "\n";
                    //insts += ",";
                }
                testnames += labtests[i].getName();


            }
            for(int i=0;i<methods.length;i++){
                if(i > 0)   method += "\n";
                method += methods[i].getName();
            }
            sql = "select i.contractsampleitemid from contractsampleitem i, contractsampletype t where "
                    + "i.contractsampletypeid = t.contractsampletypeid and "
                    + "t.sampletypeid = "+sampletypeid;
            if(appealid > 0)        sql += " and t.appealid = "+appealid;
            else if(appealid > 0)   sql += " and t.actid = "+actid;
            else                    sql += " and t.contractid = "+contractid;
            SampleitemreseachBean[] rss = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid in ("+sql+")");
            String results = "";
            String insts = "";
            String note = "";
            for(int i=0;i<rs.length;i++){
                if(i>0){
                    insts += ",";
                    if(rs[i].getResultdescr() != null) results += "\n";
                    if(rs[i].getResultNote() != null)  note += "\n";
                }
                insts += rs[i].getInstitutionid();
                if(rs[i].getResultdescr() != null) results += rs[i].getResultdescr();
                if(rs[i].getResultNote() != null)  note += rs[i].getResultNote();
            }
            
            JSONObject ob = new JSONObject();

            ob.put("name","check8");
            ob.put("value",check8);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","check7");
            ob.put("value",check7);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","check9");
            ob.put("value",check9);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);
            
            String sampleowner = "";

            if(contract.getContractownerid() != null){
                ContractownerBean owner = ContractownerManager.getInstance().loadByPrimaryKey(contract.getContractownerid());
                sampleowner = owner.getFname()+" "+owner.getLname()+" "+owner.getIdn();
            } else {
                ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
                if(contragent.getContragenttypeid().intValue() < 3 )
                    sampleowner = contragent.getFname()+" "+contragent.getLname()+" "+contragent.getIdn();
                else
                    sampleowner = contragent.getName() + " "+ contragent.getIdn();
            }
            
            ob.put("name","owner");
            ob.put("value",sampleowner);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","method");
            ob.put("value",method);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","result");
            ob.put("value",results);
            ob.put("type",3);
            ar.add(ob);
            
            
            ob.put("name","sampletype");
            ob.put("value",stp.getName());
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampleamount");
            ob.put("value",items.length);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","fromwhomsample");
            ob.put("value","");
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","getforresearch");
            ob.put("value",testnames);
            ob.put("type",3);
            ar.add(ob);
            
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rss[0].getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
            
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }
            
            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);
            
        }
        
    } else if(reportname.equalsIgnoreCase("internalanswer")){

        
        
        SampleitemreseachBean rs = SampleitemreseachManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(rs.getInstitutionid());

        if(inst.getInstitutionid().intValue() == 4 || inst.getInstitutionid().intValue() == 5) {
            reportname = "F-004-2016-G";
            String chemistry = "../img/checkbox_unchecked_32.jpg";
            String instrumental = "../img/checkbox_unchecked_32.jpg";
            if(inst.getInstitutionid().intValue() == 4) chemistry = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 5) chemistry = "../img/checkbox_checked_32.jpg";

            VF0052016GBean[] rec = VF0052016GManager.getInstance().loadByWhere("where sampleitemreseachid = "+rs.getSampleitemreseachid());
            
            //String regnum_date = "";
            
            ContractsampleitemBean sm = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
            ContractsampletypeBean cm = ContractsampletypeManager.getInstance().loadByPrimaryKey(sm.getContractsampletypeid());
            String regnum_date = sm.getBarcode();
            if(cm.getParentid() != null){
                ContractsampletypeBean cmp = ContractsampletypeManager.getInstance().loadByPrimaryKey(cm.getParentid());
                ContractsampleitemBean[] smp = ContractsampleitemManager.getInstance().loadByContractsampletypeid(cmp.getContractsampletypeid());
                if(smp.length > 0)
                    regnum_date = smp[0].getBarcode();
            }
            
            String samplegetdate = "";
            String sampletype = "";
            String sampleamount = "";
            String fromwhomsample = "";
            String getforresearch = "";
            if(rec.length > 0){
                //if(rec[0].getNum() != null) regnum_date = rec[0].getNum();
                if(rec[0].getOutdate() != null) regnum_date += "                        "+dt.format(rec[0].getOutdate().getTime());
                if(rec[0].getRegdate()!= null) samplegetdate = rec[0].getRegdate();
                if(rec[0].getSampletype()!= null) sampletype = rec[0].getSampletype();
                if(rec[0].getSampleamount()!= null) sampleamount = ""+rec[0].getSampleamount();
                if(rec[0].getStamp()!= null) fromwhomsample = rec[0].getStamp();
                if(rec[0].getTestname()!= null) getforresearch = rec[0].getTestname();
            }
            
            ContractsampleitemBean item = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
            
            JSONObject ob = new JSONObject();

            ob.put("name","sampleitemreseachid");
            ob.put("value",rs.getSampleitemreseachid().longValue());
            ob.put("type",1);
            ar.add(ob);
            
            ob.put("name","parentid");
            ob.put("value",item.getParentid().longValue());
            ob.put("type",1);
            ar.add(ob);

            ob.put("name","chemistry");
            ob.put("value",chemistry);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","instrumental");
            ob.put("value",instrumental);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampletype");
            ob.put("value",sampletype);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampleamount");
            ob.put("value",sampleamount);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","fromwhomsample");
            ob.put("value",fromwhomsample);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","getforresearch");
            ob.put("value",getforresearch);
            ob.put("type",3);
            ar.add(ob);
            
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rs.getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
            String note = (rs.getResultNote() != null) ? rs.getResultNote():"";
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }
            
            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);
            
        } else if(inst.getInstitutionid().intValue() == 3) {
            reportname = "F-005-2016-G";
            String chemistry = "../img/checkbox_unchecked_32.jpg";
            String instrumental = "../img/checkbox_unchecked_32.jpg";
            if(inst.getInstitutionid().intValue() == 4) chemistry = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 5) chemistry = "../img/checkbox_checked_32.jpg";

            VF0052016GBean[] rec = VF0052016GManager.getInstance().loadByWhere("where sampleitemreseachid = "+rs.getSampleitemreseachid());
            
            ContractsampleitemBean sm = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
            ContractsampletypeBean cm = ContractsampletypeManager.getInstance().loadByPrimaryKey(sm.getContractsampletypeid());
            String regnum_date = sm.getBarcode();
            if(cm.getParentid() != null){
                ContractsampletypeBean cmp = ContractsampletypeManager.getInstance().loadByPrimaryKey(cm.getParentid());
                ContractsampleitemBean[] smp = ContractsampleitemManager.getInstance().loadByContractsampletypeid(cmp.getContractsampletypeid());
                if(smp.length > 0)
                    regnum_date = smp[0].getBarcode();
            }
            
            String samplegetdate = "";
            String sampletype = "";
            String sampleamount = "";
            String fromwhomsample = "";
            String getforresearch = "";
            if(rec.length > 0){
                //if(rec[0].getNum() != null) regnum_date = rec[0].getNum();
                if(rec[0].getOutdate() != null) regnum_date += "                        "+dt.format(rec[0].getOutdate().getTime());
                if(rec[0].getRegdate()!= null) samplegetdate = rec[0].getRegdate();
                if(rec[0].getSampletype()!= null) sampletype = rec[0].getSampletype();
                if(rec[0].getSampleamount()!= null) sampleamount = ""+rec[0].getSampleamount();
                if(rec[0].getStamp()!= null) fromwhomsample = rec[0].getStamp();
                if(rec[0].getTestname()!= null) getforresearch = rec[0].getTestname();
            }
            
            ContractsampleitemBean item = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
            
            JSONObject ob = new JSONObject();

            ob.put("name","sampleitemreseachid");
            ob.put("value",rs.getSampleitemreseachid().longValue());
            ob.put("type",1);
            ar.add(ob);
            
            long pid = 0;
            //if(item.getParentid() != null)
            //    pid = item.getParentid().longValue();
            
            ob.put("name","parentid");
            ob.put("value",pid);
            ob.put("type",1);
            ar.add(ob);

            ob.put("name","chemistry");
            ob.put("value",chemistry);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","instrumental");
            ob.put("value",instrumental);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampletype");
            ob.put("value",sampletype);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampleamount");
            ob.put("value","1 (ერთი)");
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","fromwhomsample");
            ob.put("value",fromwhomsample);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","getforresearch");
            ob.put("value",getforresearch);
            ob.put("type",3);
            ar.add(ob);
            
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rs.getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
            String note = (rs.getResultNote() != null) ? rs.getResultNote():"";
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }
            
            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);
            
        } else if(inst.getInstitutionid().intValue() == 7 || inst.getInstitutionid().intValue() == 8 || inst.getInstitutionid().intValue() == 9) {
            // 8 ფიტოპათოლოგია
            // 7 ენტომოლოგიის ლაბორატორია
            // 9 მოლეკულური
            
            reportname = "F-061-2016-G";
            if(inst.getInstitutionid().intValue() == 14)
                reportname = "F-061-206-G";
            String check8 = "../img/checkbox_unchecked_32.jpg";
            String check7 = "../img/checkbox_unchecked_32.jpg";
            String check9 = "../img/checkbox_unchecked_32.jpg";
            if(inst.getInstitutionid().intValue() == 8) check8 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 7) check7 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 9) check9 = "../img/checkbox_checked_32.jpg";
            
            VF0052016GBean[] rec = VF0052016GManager.getInstance().loadByWhere("where sampleitemreseachid = "+rs.getSampleitemreseachid());
            
            
            ContractsampleitemBean sm = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
            ContractsampletypeBean cm = ContractsampletypeManager.getInstance().loadByPrimaryKey(sm.getContractsampletypeid());
            String regnum_date = sm.getBarcode();
            if(cm.getParentid() != null){
                ContractsampletypeBean cmp = ContractsampletypeManager.getInstance().loadByPrimaryKey(cm.getParentid());
                ContractsampleitemBean[] smp = ContractsampleitemManager.getInstance().loadByContractsampletypeid(cmp.getContractsampletypeid());
                if(smp.length > 0)
                    regnum_date = smp[0].getBarcode();
            }
            
            
            String samplegetdate = "";
            String sampletype = "";
            String sampleamount = "";
            String fromwhomsample = "";
            String getforresearch = "";
            if(rec.length > 0){
                //if(rec[0].getNum() != null) regnum_date = rec[0].getNum();
                if(rec[0].getOutdate() != null) regnum_date += "                        "+dt.format(rec[0].getOutdate().getTime());
                if(rec[0].getRegdate()!= null) samplegetdate = rec[0].getRegdate();
                if(rec[0].getSampletype()!= null) sampletype = rec[0].getSampletype();
                if(rec[0].getSampleamount()!= null) sampleamount = ""+rec[0].getSampleamount();
                if(rec[0].getStamp()!= null) fromwhomsample = rec[0].getStamp();
                if(rec[0].getTestname()!= null) getforresearch = rec[0].getTestname();
            }
            String method = "";
            StandardBean[] std = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid = "+rs.getLabtestid()+")");
            if(std.length > 0)
                method = std[0].getName();
            String result = (rs.getResultdescr()== null) ? "":rs.getResultdescr();
            
            JSONObject ob = new JSONObject();

            ob.put("name","sampleitemreseachid");
            ob.put("value",rs.getSampleitemreseachid().longValue());
            ob.put("type",1);
            ar.add(ob);

            ob.put("name","check7");
            ob.put("value",check7);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","check8");
            ob.put("value",check8);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","check9");
            ob.put("value",check9);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampletype");
            ob.put("value",sampletype);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampleamount");
            ob.put("value",sampleamount);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","fromwhomsample");
            ob.put("value",fromwhomsample);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","getforresearch");
            ob.put("value",getforresearch);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","method");
            ob.put("value",method);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","result");
            ob.put("value",result);
            ob.put("type",3);
            ar.add(ob);
            
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rs.getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
            String note = (rs.getResultNote() != null) ? rs.getResultNote():"";
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }
            
            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);
            
        } else if(inst.getInstitutionid().intValue() == 11 || inst.getInstitutionid().intValue() == 13 || inst.getInstitutionid().intValue() == 14 || inst.getInstitutionid().intValue() == 15) {
            reportname = "F-038-2016-G";
            
            String inst11 = "../img/checkbox_unchecked_32.jpg";
            String inst13 = "../img/checkbox_unchecked_32.jpg";
            String inst14 = "../img/checkbox_unchecked_32.jpg";
            String inst15 = "../img/checkbox_unchecked_32.jpg";
            if(inst.getInstitutionid().intValue() == 11) inst11 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 13) inst13 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 14) inst14 = "../img/checkbox_checked_32.jpg";
            if(inst.getInstitutionid().intValue() == 15) inst15 = "../img/checkbox_checked_32.jpg";
            
            ContractsampleitemBean item = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
            ContractsampletypeBean stype = ContractsampletypeManager.getInstance().loadByPrimaryKey(item.getContractsampletypeid());
            SampletypeBean stp = SampletypeManager.getInstance().loadByPrimaryKey(stype.getSampletypeid());
            
            ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(stype.getContractid());
            String regnum_date = "# "+item.getBarcode();
            String samplegetdate = ""+dt.format(item.getRegdate());
            String hasstamp = "";
            if(stype.getAppealid() != null){
                AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(stype.getAppealid());
                samplegetdate = dt.format(appeal.getAppealdate());
                //regnum_date += appeal.getNum();
                hasstamp = (appeal.getStamp() != null && appeal.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            } else if(stype.getActid() != null){
                ActBean act = ActManager.getInstance().loadByPrimaryKey(stype.getActid());
                //regnum_date += act.getNum();
                samplegetdate = dt.format(act.getActdate());
                hasstamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            } else {
                //regnum_date += contract.getNum();
                samplegetdate = dt.format(contract.getRegdate());
                hasstamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            }

            LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(rs.getLabtestid());
            StandardBean[] methods = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid = "+rs.getLabtestid()+")");
            String testnames = labtest.getName();
            String method = "";

            for(int i=0;i<methods.length;i++){
                if(i > 0)   method += "\n";
                method += methods[i].getName();
            }
            
            String results = (rs.getResultdescr() != null) ? rs.getResultdescr():"";
            String insts = rs.getInstitutionid().toString();
            String note = (rs.getResultNote() != null) ? rs.getResultNote():"";
            
            JSONObject ob = new JSONObject();

            ob.put("name","sampleitemreseachid");
            ob.put("value",rs.getSampleitemreseachid());
            ob.put("type",1);
            ar.add(ob);
            
            ob.put("name","inst11");
            ob.put("value",inst11);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","inst13");
            ob.put("value",inst13);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","inst14");
            ob.put("value",inst14);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","inst15");
            ob.put("value",inst15);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);
            
            String sampleowner = "";

            if(contract.getContractownerid() != null){
                ContractownerBean owner = ContractownerManager.getInstance().loadByPrimaryKey(contract.getContractownerid());
                sampleowner = owner.getFname()+" "+owner.getLname()+" "+owner.getIdn();
            } else {
                ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
                if(contragent.getContragenttypeid().intValue() < 3 )
                    sampleowner = contragent.getFname()+" "+contragent.getLname()+" "+contragent.getIdn();
                else
                    sampleowner = contragent.getName() + " "+ contragent.getIdn();
            }
            
            ob.put("name","owner");
            ob.put("value",sampleowner);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","method");
            ob.put("value",method);
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","result");
            ob.put("value",results);
            ob.put("type",3);
            ar.add(ob);
            
            
            ob.put("name","sampletype");
            ob.put("value",stp.getName());
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","sampleamount");
            ob.put("value",stype.getQuantity());
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","fromwhomsample");
            ob.put("value","");
            ob.put("type",3);
            ar.add(ob);
            
            ob.put("name","getforresearch");
            ob.put("value",testnames);
            ob.put("type",3);
            ar.add(ob);
            
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rs.getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
            
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }
            
            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);
            
        } else {
            reportname = "answer1";
            LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(rs.getLabtestid());
            ContractsampleitemBean sm = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
            ContractsampletypeBean cm = ContractsampletypeManager.getInstance().loadByPrimaryKey(sm.getContractsampletypeid());
            SampletypeBean st = SampletypeManager.getInstance().loadByPrimaryKey(cm.getSampletypeid());
            PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rs.getRegbyid());
            PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");

            String fromwhomsample = "";
            //String num = "";
            String regdate = "";
            
            String num = sm.getBarcode();
            if(cm.getParentid() != null){
                ContractsampletypeBean cmp = ContractsampletypeManager.getInstance().loadByPrimaryKey(cm.getParentid());
                ContractsampleitemBean[] smp = ContractsampleitemManager.getInstance().loadByContractsampletypeid(cmp.getContractsampletypeid());
                if(smp.length > 0)
                    num = smp[0].getBarcode();
            }
            
            if(cm.getAppealid() != null){
                AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(cm.getAppealid());
                //num = appeal.getNum();
                regdate = dt.format(appeal.getRegdate());
                fromwhomsample = (appeal.getStamp() != null && appeal.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            } else if(cm.getActid() != null){
                ActBean act = ActManager.getInstance().loadByPrimaryKey(cm.getActid());
                //num = act.getNum();
                regdate = dt.format(act.getRegdate());
                fromwhomsample = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            } else {
                ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(cm.getContractid());
                //num = contract.getNum();
                regdate = dt.format(contract.getRegdate());
                fromwhomsample = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            }

            String departmentname = "";
            String labname = inst.getName();
            String regnum_date = "# "+num+"                       "+regdate;
            String samplegetdate = dt.format(rs.getRegdate());
            String sampletype = st.getName();
            String sampleamount = ""+cm.getQuantity();

            String getforresearch = labtest.getName();
            String method = "";
            StandardBean[] std = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid = "+labtest.getLabtestid()+")");
            if(std.length > 0)
                method = std[0].getName();
            String result = (rs.getResultdescr()== null) ? "":rs.getResultdescr();
            String note = rs.getResultNote();
            String labhead = "";
            if(pers1.length > 0)
                    labhead = pers1[0].getFname()+" "+pers1[0].getLname();
            String laborant = pers.getFname()+" "+pers.getLname();
            String departmenthead = "";
            if(inst.getParentid() != null){
                InstitutionBean dept = InstitutionManager.getInstance().loadByPrimaryKey(inst.getParentid());
                departmentname = dept.getName();
                PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getParentid()+" and personelltypeid = 9");
                if(pers2.length > 0)
                    departmenthead = pers2[0].getFname()+" "+pers2[0].getLname();
            }

            JSONObject ob = new JSONObject();

            ob.put("name","departmentname");
            ob.put("value",departmentname);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labname");
            ob.put("value",labname);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","regnum_date");
            ob.put("value",regnum_date);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","samplegetdate");
            ob.put("value",samplegetdate);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","sampletype");
            ob.put("value",sampletype);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","sampleamount");
            ob.put("value",sampleamount);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","fromwhomsample");
            ob.put("value",fromwhomsample);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","method");
            ob.put("value",method);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","result");
            ob.put("value",result);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","note");
            ob.put("value",(note == null) ? "":note);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","labhead");
            ob.put("value",labhead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","laborant");
            ob.put("value",laborant);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","departmenthead");
            ob.put("value",departmenthead);
            ob.put("type",3);
            ar.add(ob);

            ob.put("name","getforresearch");
            ob.put("value",getforresearch);
            ob.put("type",3);
            ar.add(ob);
        }
        
    } else if(reportname.equalsIgnoreCase("F-061-2016-G000")){
        SampleitemreseachBean rs = SampleitemreseachManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(rs.getContractid());
        LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(rs.getLabtestid());
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(rs.getInstitutionid());
        ContractsampleitemBean sm = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getContractsampleitemid());
        ContractsampletypeBean cm = ContractsampletypeManager.getInstance().loadByPrimaryKey(sm.getContractsampletypeid());
        SampletypeBean st = SampletypeManager.getInstance().loadByPrimaryKey(cm.getSampletypeid());
        PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rs.getRegbyid());
        PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
        
        String num = sm.getBarcode();
        if(cm.getParentid() != null){
            ContractsampletypeBean cmp = ContractsampletypeManager.getInstance().loadByPrimaryKey(cm.getParentid());
            ContractsampleitemBean[] smp = ContractsampleitemManager.getInstance().loadByContractsampletypeid(cmp.getContractsampletypeid());
            if(smp.length > 0)
                num = smp[0].getBarcode();
        }
        /*
        String num = contract.getNum();
        if(cm.getActid() != null){
            ActBean act = ActManager.getInstance().loadByPrimaryKey(cm.getActid());
            num = act.getNum();
            //stamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
        }
        if(cm.getAppealid() != null){
            AppealBean act = AppealManager.getInstance().loadByPrimaryKey(cm.getAppealid());
            num = act.getNum();
            //stamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
        }
        */
        String registrationnumber = "# "+num;
        String regdate = dt.format(new Date());
        String sampleowner = dt.format(new Date());
        String collectiondate = dt.format(rs.getRegdate());
        String sampletype = st.getName();
        String stamp = ""+cm.getQuantity();
        String bringer = "";
        String anamnesis = "";
        String sampleemaunt = (cm.getQuantity() == null) ? "1":""+cm.getQuantity();
        
        
        JSONObject ob = new JSONObject();
        
        ob.put("name","registrationnumber");
        ob.put("value",registrationnumber);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","regdate");
        ob.put("value",regdate);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampletype");
        ob.put("value",sampletype);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampletype");
        ob.put("value",sampletype);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","collectiondate");
        ob.put("value",collectiondate);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","stamp");
        ob.put("value",stamp);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","labtest");
        ob.put("value",labtest.getName());
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","bringer");
        ob.put("value",bringer);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","anamnesis");
        ob.put("value",anamnesis);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampleemaunt");
        ob.put("value",sampleemaunt);
        ob.put("type",3);
        ar.add(ob);
        
        
      

    } else if(reportname.equalsIgnoreCase("F-003-2016-G")){
        String sid = request.getParameter("id");
        String[] sids = sid.split("_");
        String num = "";
        String regdate = dt.format(new Date());
        String hasstamp = "";
        ContractsampletypeBean[] cm = new ContractsampletypeBean[0];
        String sqlcontracts = "";
        ContractBean contr = null;
        if(sids[0].equalsIgnoreCase("contract")){
            ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
            num = contract.getNum();
            regdate = dt.format(contract.getRegdate());
            cm = ContractsampletypeManager.getInstance().loadByContractid(contract.getContractid());
            hasstamp = (contract.getStamp() != null && contract.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            contr = ContractManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
            sqlcontracts = "contractid = "+contract.getContractid();
        } else if(sids[0].equalsIgnoreCase("act")){
            ActBean act = ActManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
            num = act.getNum();
            regdate = dt.format(act.getActdate());
            hasstamp = (act.getStamp() != null && act.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            cm = ContractsampletypeManager.getInstance().loadByActid(act.getActid());
            contr = ContractManager.getInstance().loadByPrimaryKey(act.getContractid());
            sqlcontracts = "actid = "+act.getActid();
        } else if(sids[0].equalsIgnoreCase("appeal")){
            AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(new Long(sids[1]));
            regdate = dt.format(appeal.getAppealdate());
            num = appeal.getNum();
            hasstamp = (appeal.getStamp() != null && appeal.getStamp().trim().length() > 0) ? "დალუქული":"დაულუქავი";
            cm = ContractsampletypeManager.getInstance().loadByAppealid(appeal.getAppealid());
            contr = ContractManager.getInstance().loadByPrimaryKey(appeal.getContractid());
            sqlcontracts = "appealid = "+appeal.getAppealid();
        }
        
        JSONObject ob = new JSONObject();
        
        String regnum_date = "# "+num+"                       "+regdate;
        ob.put("name","regnum_date");
        ob.put("value",regnum_date);
        ob.put("type",3);
        ar.add(ob);
        
        String samplegetdate = regdate;
        ob.put("name","samplegetdate");
        ob.put("value",samplegetdate);
        ob.put("type",3);
        ar.add(ob);
        
        String sampleowner = "";

        if(contr.getContractownerid() != null){
            ContractownerBean owner = ContractownerManager.getInstance().loadByPrimaryKey(contr.getContractownerid());
            sampleowner = owner.getFname()+" "+owner.getLname()+" "+owner.getIdn();
        } else {
            ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contr.getContragentid());
            if(contragent.getContragenttypeid().intValue() < 3 )
                sampleowner = contragent.getFname()+" "+contragent.getLname()+" "+contragent.getIdn();
            else
                sampleowner = contragent.getName() + " "+ contragent.getIdn();
        }

        ob.put("name","sampleowner");
        ob.put("value",sampleowner);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","hasstamp");
        ob.put("value",hasstamp);
        ob.put("type",3);
        ar.add(ob);
        
        String Recipient = "";
        ob.put("name","Recipient");
        ob.put("value",Recipient);
        ob.put("type",3);
        ar.add(ob);
        
        String Director = "ირაკლი გულედანი";
        ob.put("name","Director");
        ob.put("value",Director);
        ob.put("type",3);
        ar.add(ob);
        
        String sampletype = "";
        int sampleamount = 0;
        String getforresearch = "";
        String method = "";
        String result = "";
        String note = "";
        
        String insts = "";
        Hashtable res = new Hashtable();
        String sqltests = "where labtestid in (select labtestid from "
                + "sampleitemreseach r, contractsampleitem t, contractsampletype c where "
                + "r.contractsampleitemid = t.contractsampleitemid and "
                + "t.contractsampletypeid = c.contractsampletypeid and "
                + "c."+sqlcontracts
                + ")";

        LabtestBean[] tests = LabtestManager.getInstance().loadByWhere(sqltests);
        for(int i=0;i<tests.length;i++){
            if(i > 0)   getforresearch += "; ";
            getforresearch += tests[i].getName();
        }
        for(int i=0;i<cm.length;i++){
            SampletypeBean st = SampletypeManager.getInstance().loadByPrimaryKey(cm[i].getSampletypeid());
            
            if(i > 0)   {
                sampletype += "\n";
                method += "\n";
                result += "\n";
                note += "\n";
                //getforresearch += "\n";
            }
            sampletype += st.getName();
            sampleamount += cm[i].getQuantity().intValue();
            ContractsampleitemBean[] si = ContractsampleitemManager.getInstance().loadByContractsampletypeid(cm[i].getContractsampletypeid());
            for(int j=0;j<si.length;j++){
                SampleitemreseachBean rs[] = SampleitemreseachManager.getInstance().loadByContractsampleitemid(si[j].getContractsampleitemid());
                for(int k=0;k<rs.length;k++){
                    if(rs[k].getStandardid() != null){
                        StandardBean sb = StandardManager.getInstance().loadByPrimaryKey(rs[k].getStandardid());
                        method += sb.getName()+" ";
                    }
                    if(rs[k].getResultdescr() != null)
                        result += rs[k].getResultdescr()+" ";
                    if(rs[k].getResultNote() != null)
                        note += rs[k].getResultNote()+" ";
                    //LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(rs[k].getLabtestid());
                    //if(getforresearch.trim().length() > 0)  getforresearch += "; ";
                    //getforresearch += labtest.getName();
                    
                    if(insts.length() > 0)  insts += ",";
                    insts += rs[k].getInstitutionid();
                }
                
            }
            
        }
        
        /*
        LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(rs.getLabtestid());
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(rs.getInstitutionid());
        PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(rs.getRegbyid());
        PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = "+inst.getInstitutionid()+" and personelltypeid = 12");
        */
        
        
        
        String departmentheadid_1 = "";
        String departmentheadid_10 = "";
        String departmentheadid_2 = "";
        String departmentheadid_6 = "";
        PersonellBean[] pers1 = PersonellManager.getInstance().loadByWhere("where institutionid = 1 and personelltypeid = 11");
        PersonellBean[] pers10 = PersonellManager.getInstance().loadByWhere("where institutionid = 10 and personelltypeid = 9 and institutionid in (select parentid from institution where institutionid in ("+insts+"))");
        PersonellBean[] pers2 = PersonellManager.getInstance().loadByWhere("where institutionid = 2 and personelltypeid = 9 and institutionid in (select parentid from institution where institutionid in ("+insts+"))");
        PersonellBean[] pers6 = PersonellManager.getInstance().loadByWhere("where institutionid = 6 and personelltypeid = 9 and institutionid in (select parentid from institution where institutionid in ("+insts+"))");

        if(pers1.length > 0)        departmentheadid_1 = pers1[0].getFname()+" "+pers1[0].getLname();
        if(pers10.length > 0)        departmentheadid_10 = pers10[0].getFname()+" "+pers10[0].getLname();
        if(pers2.length > 0)        departmentheadid_2 = pers2[0].getFname()+" "+pers2[0].getLname();
        if(pers6.length > 0)        departmentheadid_6 = pers6[0].getFname()+" "+pers6[0].getLname();
        
        ob.put("name","departmentheadid_1");
        ob.put("value",departmentheadid_1);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","departmentheadid_10");
        ob.put("value",departmentheadid_10);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","departmentheadid_2");
        ob.put("value",departmentheadid_2);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","departmentheadid_6");
        ob.put("value",departmentheadid_6);
        ob.put("type",3);
        ar.add(ob);
        
        
        ob.put("name","sampletype");
        ob.put("value",sampletype);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampleamount");
        ob.put("value",sampleamount);
        ob.put("type",3);
        ar.add(ob);
        
        
        ob.put("name","getforresearch");
        ob.put("value",getforresearch);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","method");
        ob.put("value",method);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","result");
        ob.put("value",result);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","note");
        ob.put("value",note);
        ob.put("type",3);
        ar.add(ob);
        
        
        
    } else if(reportname.equalsIgnoreCase("F-002-2016-G")){
        TransitactBean tact = TransitactManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        //TransitsampleitemBean[] tb = TransitsampleitemManager.getInstance().loadByWhere("where transitsampleitemid in ("+tids+")");
        
        String regdate = "";
        String regperson = tact.getResponsible();
        String senddate = dt.format(tact.getSenddate());
        String sendreason = tact.getSendreason();
        String sendcondition = tact.getSendcondition();
        String getdate = (tact.getGetdate() != null) ? dt.format(tact.getGetdate()):"";
        
        InstitutionBean finst = InstitutionManager.getInstance().loadByPrimaryKey(tact.getFromlocationid());
        InstitutionBean tinst = InstitutionManager.getInstance().loadByPrimaryKey(tact.getTolocationid());
        int instid = (int)getSum("select rootansestor("+finst.getInstitutionid()+")");
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(instid);

        ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(tact.getContractid());
        ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
        String labids = contragent.getName();
        if(tact.getAppealid() != null){
            AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(tact.getAppealid());
            labids += " მომართვა #"+appeal.getNum();
            regdate = dt.format(appeal.getRegdate().getTime());
        } else if(tact.getActid() != null){
            ActBean act = ActManager.getInstance().loadByPrimaryKey(tact.getActid());
            labids += " აქტი #"+act.getNum();
            regdate = dt.format(act.getRegdate().getTime());
        } else {
            labids += " ხელშეკრულება #"+contract.getNum();
            regdate = dt.format(contract.getRegdate().getTime());
        }
        labids += "\n";
        String registrationnumber = tact.getTransitactid().toString();
        String fromlab = getFullLabName(inst," - ")+", "+user.getFname()+" "+user.getLname();
        String samplequantity = "";
        String sampletype = "";
        String samplereceiver = getFullLabName(tinst, " - ");
        String sqlsample = "where sampletypeid in ("
                + "select "
                + " c.sampletypeid "
                + "from "
                + " contractsampletype c, "
                + " contractsampleitem i, "
                + " transitsampleitem t "
                + "where"
                + " c.contractsampletypeid = i.contractsampletypeid and "
                + " i.contractsampleitemid = t.contractsampleitemid and "
                + " t.transitactid = "+tact.getTransitactid()
                + ")";
        String sqlamount = "select "
                + " count(i.contractsampleitemid) "
                + "from "
                + " contractsampletype c, "
                + " contractsampleitem i, "
                + " transitsampleitem t "
                + "where"
                + " c.contractsampletypeid = i.contractsampletypeid and "
                + " i.contractsampleitemid = t.contractsampleitemid and "
                + " t.transitactid = "+tact.getTransitactid()+" and "
                + " c.sampletypeid = ";
        SampletypeBean[] ssampletypes = SampletypeManager.getInstance().loadByWhere(sqlsample);
        for(int i=0;i<ssampletypes.length;i++){
            if(i > 0)   {
                sampletype += "\n";
                samplequantity += "; ";
            }
            sampletype += ssampletypes[i].getName();
            if(ssampletypes.length > 1)
                samplequantity += ssampletypes[i].getName()+" ";
            samplequantity += (int)getSum(sqlamount+ssampletypes[i].getSampletypeid())+" ნიმუში";
        }
        ContractsampleitemBean[] tb = ContractsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in (select contractsampleitemid from transitsampleitem where transitactid = "+tact.getTransitactid()+")");
        for(int i=0;i<tb.length;i++){
            ContractsampletypeBean sample = ContractsampletypeManager.getInstance().loadByPrimaryKey(tb[i].getContractsampletypeid());
            if(i > 0)   {
                labids += "; ";
            }
            labids += tb[i].getBarcode();
        }
        
        JSONObject ob = new JSONObject();
        
        ob.put("name","registrationnumber");
        ob.put("value",registrationnumber);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","regdate");
        ob.put("value",regdate);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","fromlab");
        ob.put("value",fromlab);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","regperson");
        ob.put("value",regperson);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","senddate");
        ob.put("value",senddate);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sendreason");
        ob.put("value",sendreason);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","labids");
        ob.put("value",labids);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","samplequantity");
        ob.put("value",samplequantity);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sampletype");
        ob.put("value",sampletype);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","sendcondition");
        ob.put("value",sendcondition);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","samplereceiver");
        ob.put("value",samplereceiver);
        ob.put("type",3);
        ar.add(ob);
        
        ob.put("name","receivedate");
        ob.put("value",getdate);
        ob.put("type",3);
        ar.add(ob);

    }
    if(!isfile){
        json.put("reportname", reportname);
        json.put("data",ar);
        json.put("dburl",getServletContext().getInitParameter("url"));
        json.put("dbuser",getServletContext().getInitParameter("user"));
        json.put("dbpass",getServletContext().getInitParameter("pass"));
        json.put("reppath",session.getServletContext().getRealPath("/")+"/forms/");
        json.put("ofile",fl.getAbsolutePath());

        File jsonfl = File.createTempFile("report", ".json", new File("/tmp"));
        FileOutputStream fo = new FileOutputStream(jsonfl);
        fo.write(json.toString().getBytes("UTF-8"));
        fo.close();
        String gendir = "/home/ireport";
        String javadir = "/usr/java/bin/java";
        String strcommand = "cd "+gendir+"\n"+javadir+" -Djava.awt.headless=true -jar generateIReport.jar "+jsonfl.getAbsolutePath();
        File flsh = File.createTempFile("genrep", ".sh", new File("/tmp"));
        fo = new FileOutputStream(flsh);
        fo.write(strcommand.getBytes("UTF-8"));
        fo.close();
        CommandRunner cr = new CommandRunner();
        String[] command = {"/bin/sh",flsh.getAbsolutePath()};
        int res = cr.executeProgram(command);
        if(res != 0){
            InputStream is = cr.getProccessErrorStream();
            byte[] b = new byte[is.available()];
            is.read(b);
            System.out.println("შეცდომა: "+new String(b,"UTF-8"));
            //throw new Exception("შეცდომა: "+new String(b,"UTF-8"));
        }
        flsh.deleteOnExit();
        jsonfl.deleteOnExit();
//System.out.println(flsh.getAbsolutePath());
    }
    o.put("result",1);
    o.put("filename",fl.getAbsolutePath());
}catch(Exception e){
    e.printStackTrace();
    o.put("result",0);
    o.put("error",e.getMessage());
}
out.print(o.toString());
%>
