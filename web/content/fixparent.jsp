<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
Manager.getInstance().beginTransaction();
try{
    

    ContractsampleitemBean[] parents = ContractsampleitemManager.getInstance().loadByWhere("where parentid is null and contractsampleitemid in (select contractsampleitemid from sampleitemreseach where contractsampleitemid > 0)");
    for(int i=0;i<parents.length;i++){
        ContractsampleitemBean parent = ContractsampleitemManager.getInstance().createContractsampleitemBean();
        parent.setContractsampletypeid(parents[i].getContractsampletypeid());
        parent.setNum1(parents[i].getNum1());
        parent.setNum2(parents[i].getNum2());
        parent.setRegbyid(user.getPersonellid());
        parent = ContractsampleitemManager.getInstance().save(parent);
        parent.setBarcode(""+parent.getContractsampleitemid());
        parent = ContractsampleitemManager.getInstance().save(parent);

        parents[i].setParentid(parent.getContractsampleitemid());
        parents[i] = ContractsampleitemManager.getInstance().save(parents[i]);

        ContractsampleitemBean[] children = ContractsampleitemManager.getInstance().loadByWhere("where parentid = "+parents[i].getContractsampleitemid());
        for(int j=0;j<children.length;j++){
            children[j].setParentid(parent.getContractsampleitemid());
            children[j] = ContractsampleitemManager.getInstance().save(children[j]);
        }
    }
Manager.getInstance().endTransaction(true);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
}
%>
