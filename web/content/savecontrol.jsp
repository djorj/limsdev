<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
try{
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    String procdescr = request.getParameter("procdescr").trim();
    JSONArray schedule = JSONArray.fromObject(request.getParameter("schedule").trim());
    JSONArray docs = (JSONArray)session.getAttribute("CONTROLDOCS_"+labtest.getLabtestid());
    if(docs == null)    docs = new JSONArray();
    for(int i=0;i<docs.size();i++){
        JSONObject doc = docs.getJSONObject(i);
        DocumentBean document = DocumentManager.getInstance().createDocumentBean();
        if(doc.getLong("id") > 0)    document = DocumentManager.getInstance().loadByPrimaryKey(doc.getLong("id"));
        document.setName(doc.getString("name"));
        document.setFilename(doc.getString("filename"));
        document.setPath(doc.getString("path"));
        document.setUrl(doc.getString("url"));
        document.setType(doc.getString("type"));
        document.setSize(doc.getLong("size"));
        document = DocumentManager.getInstance().save(document);
        if(LabtestcontroldocumentManager.getInstance().loadByPrimaryKey(labtest.getLabtestid(), document.getDocumentid()) == null){
            LabtestcontroldocumentBean ld = LabtestcontroldocumentManager.getInstance().createLabtestcontroldocumentBean();
            ld.setLabtestid(labtest.getLabtestid());
            ld.setDocumentid(document.getDocumentid());
            ld = LabtestcontroldocumentManager.getInstance().save(ld);
        }
    }
    File folder = new File(basedir+"documents/controls/");
    File[] listOfFiles = folder.listFiles();
    for(int i = 0; i < listOfFiles.length; i++) {
        if(listOfFiles[i].isFile()) {
            if(listOfFiles[i].getName().indexOf("control_"+labtest.getLabtestid()+"_") != 0)
                continue;
            String path = basedir+"documents/controls/"+listOfFiles[i].getName();
            DocumentBean[] documents = DocumentManager.getInstance().loadByWhere("where path = '"+path.replaceAll("'", "''") +"'");
            if(documents.length > 0){
                LabtestcontroldocumentManager.getInstance().deleteByPrimaryKey(labtest.getLabtestid(), documents[0].getDocumentid());
                File fl = new File(path);
                fl.deleteOnExit();
            }
        }
    }
    labtest.setControlprocedure(procdescr);
    labtest = LabtestManager.getInstance().save(labtest);
    LabtestcontrolManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
    for(int i=0;i<schedule.size();i++){
        JSONObject sc = schedule.getJSONObject(i);
        int controlid = sc.getInt("testid");
        LabtestcontrolBean lc = LabtestcontrolManager.getInstance().createLabtestcontrolBean();
        lc.setLabtestid(labtest.getLabtestid());
        lc.setControlid(controlid);
        lc.setSchedule(sc.toString());
        lc = LabtestcontrolManager.getInstance().save(lc);
    }
    res.put("result",1);
}catch(Exception e){
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>