<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
try{
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    JSONArray docs = (JSONArray)session.getAttribute("CONTROLDOCS_"+labtest.getLabtestid());
    if(docs == null)    docs = new JSONArray();
    String oper = request.getParameter("oper");
    String dlist = "";
    if(oper.equalsIgnoreCase("add")){
        
        String data = request.getParameter("doc");
        String name = request.getParameter("name");
        String filename = request.getParameter("filename");
        String type = request.getParameter("type");
        long size = Long.parseLong(request.getParameter("size"));
        
        String base64data = data.split(",")[1];
        String filetype = ((data.split(",")[0]).split(";")[0]).split("/")[1];
        byte[] dataBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64data);
        File fl = File.createTempFile("control_"+labtest.getLabtestid()+"_", "."+filetype, new File(basedir+"documents/controls/"));
        FileOutputStream io = new FileOutputStream(fl);
        io.write(dataBytes);
        io.close();
        
        JSONObject doc = new JSONObject();
        doc.put("labtestid", labtest.getLabtestid());
        //doc.put("data", data);
        doc.put("name", name);
        doc.put("filename", filename);
        doc.put("path", fl.getAbsolutePath());
        doc.put("url", "documents/controls/"+fl.getName());
        doc.put("type", type);
        doc.put("size", size);
        doc.put("id", 0);
        docs.add(doc);
    } else if(oper.equalsIgnoreCase("del")){
        int n = Integer.parseInt(request.getParameter("n"));
        docs.remove(n);
    }
    session.setAttribute("CONTROLDOCS_"+labtest.getLabtestid(),(JSONArray)docs);
    for(int i=0;i<docs.size();i++){
        JSONObject doc = docs.getJSONObject(i);
        String docname = doc.getString("name");
        if(docname.length() == 0) docname = doc.getString("filename");
        dlist += "<li class=\"dd-item\" id=\"doc"+i+"\"><div class=\"dd-handle listdoc\"><a href='"+doc.getString("url") +"' target='_blank'>"+docname+"</a>";
        dlist += "<em style=\"cursor: pointer;\" class=\"pull-right badge bg-color-red padding-5\" rel=\"tooltip\" title=\"\" ";
        dlist += "data-placement=\"left\" data-original-title=\"\"><i class=\"fa fa-close fa-lg txt-color-white\" ";
        dlist += "onclick=\"deldoc("+i+")\"></i></em></div></li>";
    }
    res.put("result",1);
    res.put("dlist", dlist);
}catch(Exception e){
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>