<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
Manager.getInstance().beginTransaction();
JSONObject res = new JSONObject();
try{
    String oper = request.getParameter("oper");
    if(oper.equalsIgnoreCase("transititem")){
        String ids = request.getParameter("ids").trim();
        if(ids.length() == 0)
            throw new Exception(trs.t("აირჩიეთ ერთი ნიმუში მაინც!"));
        if(SampleitemreseachManager.getInstance().countWhere("where contractsampleitemid in ("+ids+") and labtestid is not null") > 0)
            throw new Exception(trs.t("ნიმუშზე კვლევაა დანიშნული!"));
        TransitactBean[] tacts = TransitactManager.getInstance().loadByWhere("where transitactid in (select transitactid from transitsampleitem where contractsampleitemid in ("+ids+"))");
        if(tacts.length > 1)
            throw new Exception(trs.t("ნიმუშები არაა ერთი გადაცემის აქტის!"));
        else if(tacts.length == 1){
            ContractsampleitemBean[] itms = ContractsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in (select contractsampleitemid from transitsampleitem where transitactid = "+tacts[0].getTransitactid()+")");
            for(int i=0;i<itms.length;i++){
                //if(ids.length() > 0)   
                    ids += ",";
                ids += itms[i].getContractsampleitemid();
            }
        }
        String senddate = dt.format(new Date());
        String sendtime = dtime.format(new Date());
        long departamentid = 0;
        String container = "";
        String personells = "";
        String sendreason = "";
        String sendcondition = "";
        int transit = 0;
        String sids = "";
        String cids = "";
        int candelete = 1;
        int canedit = 1;
        if(tacts.length == 1){
            senddate = dt.format(tacts[0].getSenddate());
            departamentid = tacts[0].getTolocationid();
            //container = tacts[i].getContainer();
            personells = tacts[0].getResponsible();
            sendreason = tacts[0].getSendreason();
            sendcondition = tacts[0].getSendcondition();
            transit = 1;
            if(tacts[0].getGetbyid() != null){
                candelete = 0;
                canedit = 0;
            }
        }

        if(candelete == 1 && tacts.length == 0)
            candelete = 0;
        
        res.put("canedit",canedit);
        res.put("candelete",candelete);
        res.put("transit",transit);
        res.put("ids",ids);
        res.put("senddate",senddate);
        res.put("sendtime",sendtime);
        res.put("departamentid",departamentid);
        res.put("container",container);
        res.put("personells",personells);
        res.put("sendreason",sendreason);
        res.put("sendcondition",sendcondition);
    } else if(oper.equalsIgnoreCase("delete")){
        String ids = request.getParameter("ids").trim();
        if(ids.length() == 0)
            throw new Exception(trs.t("აირჩიეთ ერთი ნიმუში მაინც!"));
        TransitactBean[] tacts = TransitactManager.getInstance().loadByWhere("where transitactid in (select transitactid from transitsampleitem where contractsampleitemid in ("+ids+"))");
        if(tacts.length > 0){
            if(tacts[0].getGetbyid() != null)
                throw new Exception(trs.t("ნიმუშები მიღებულია - წაშლა შეუძლებელია!"));
            TransitsampleitemManager.getInstance().deleteByTransitactid(tacts[0].getTransitactid());
            TransitactManager.getInstance().deleteByPrimaryKey(tacts[0].getTransitactid());
        }
    }
    
    res.put("result",1);
    Manager.getInstance().endTransaction(true);
}catch(Exception e){
    e.printStackTrace();
    Manager.getInstance().endTransaction(false);
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>