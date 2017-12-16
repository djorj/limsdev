<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="jxl.*"%>
<%@page import="jxl.write.*"%>
<%@page import="sun.misc.BASE64Decoder" %>
<%
String[] wls = {"A","B","C","D","E","F","G","H"};
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    String[] contenttypes = {"data:application/vnd.ms-excel;base64"};
    int deviceid = Integer.parseInt(request.getParameter("deviceid"));
    if(deviceid == 0)
        throw new Exception(trs.t("აირჩიეთ აპარატი"));
    long plateid = Long.parseLong(request.getParameter("plateid"));
    if(plateid == 0)
        throw new Exception(trs.t("აირჩიეთ დაფა"));
    String uploadedresults = "";
    //String ids = request.getParameter("id");
    //ContractsampleitemBean[] itm = ContractsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in ("+ids+")");
    DeviceBean device = DeviceManager.getInstance().loadByPrimaryKey(deviceid);
    PlateBean plate = PlateManager.getInstance().loadByPrimaryKey(plateid);
    if(device.getName().equalsIgnoreCase("ELIZA Reader Ivymen System")){
        Vector v = new Vector();
        String data = request.getParameter("content");
        String[] dat = data.split(",");
        String contenttype = dat[0];
        byte[] content = javax.xml.bind.DatatypeConverter.parseBase64Binary(dat[1]);
//        if(!contenttype.equalsIgnoreCase(contenttypes[0]))
//            throw new Exception(trs.t("ასატვირთი ფაილის არასწორი ფორმატი"));
        WorkbookSettings ws = new WorkbookSettings();
        ws.setEncoding("ISO-8859-1");
        Workbook workbook = Workbook.getWorkbook(new ByteArrayInputStream(content),ws);
        Sheet sheet = workbook.getSheet(0);
        int cols = sheet.getColumns();
        int rows = sheet.getRows();
        LabtestcontrolBean[] lc = null;
        JSONArray ar = new JSONArray();
        for(int i=1;i<rows;i++){
            jxl.Cell cell = sheet.getCell(0,i);
            if(cell.getContents().trim().length() == 0) continue;
            DateCell datecell = (DateCell) cell;
            Date testdate = datecell.getDate();
            cell = sheet.getCell(1,i);
            String plateno = cell.getContents().trim();
            cell = sheet.getCell(2,i);
            String wellno = cell.getContents().trim();
            cell = sheet.getCell(3,i);
            String barcode = cell.getContents().trim();
            cell = sheet.getCell(4,i);
            String itemname = cell.getContents().trim();
            cell = sheet.getCell(5,i);
            double quantitative = Double.parseDouble(cell.getContents().trim());
            cell = sheet.getCell(6,i);
            String qualitative = cell.getContents().trim();
            cell = sheet.getCell(7,i);
            double absorbency = Double.parseDouble(cell.getContents().trim());
            PlatemapBean pm = PlatemapManager.getInstance().loadByPrimaryKey(plateid, wellno);
            if(pm != null)  barcode = pm.getBarcode();
            else            barcode = "";
            JSONObject result = new JSONObject();
            result.put("testdate",dt.format(testdate));
            result.put("plateno",plateno);
            result.put("wellno",wellno);
            result.put("barcode",barcode);
            result.put("itemname",itemname);
            result.put("quantitative",quantitative);
            result.put("qualitative",qualitative);
            result.put("absorbency",absorbency);
            DeviceresultBean dr = DeviceresultManager.getInstance().createDeviceresultBean();
            dr.setDeviceid(deviceid);
            dr.setRegbyid(user.getPersonellid());
            dr.setRegdate(new Date().getTime());
            dr.setResultdate(testdate.getTime());
            dr.setResult(result.toString());
            
            SampleitemreseachBean[] itms = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid in (select contractsampleitemid from contractsampleitem where barcode = '"+barcode+"')");
            if(itms.length > 0){
                dr.setSampleitemreseachid(itms[0].getSampleitemreseachid());
                lc = LabtestcontrolManager.getInstance().loadByLabtestid(itms[0].getLabtestid());
                
            }
            /*
            for(int j=0;j<itm.length;j++){
                if(itm[j].getBarcode().equals(barcode)){
                    dr.setContractsampleitemid(itm[j].getContractsampleitemid());
                    break;
                }
            }
            */
            ar.add(result);
            v.addElement((DeviceresultBean)dr);
        }
        session.setAttribute("UPLOADEDRESULTS", (Vector)v);
        session.setAttribute("UPLOADEDRESULTSARRAY", (JSONArray)ar);
        
        Vector ctest = new Vector();
        boolean passed = true;
        if(lc != null && lc.length > 0){
            JSONObject o = JSONObject.fromObject(lc[0].getSchedule());
            if(o.containsKey("positive")) {
                String[] positives = o.getString("positive").split(",");
                for(int i=0;i<positives.length;i++){
                    for(int j=0;j<ar.size();j++){
                        JSONObject adt = ar.getJSONObject(j);
                        if(adt.getString("wellno").equalsIgnoreCase(positives[i])){
                            JSONObject cl = new JSONObject();
                            cl.put("WELLNO", adt.getString("wellno"));
                            if(adt.getString("qualitative").toUpperCase().indexOf("NEG") >= 0){
                                cl.put("PASSED", false);
                                passed = false;
                            } else {
                                cl.put("PASSED", true);
                            }
                            ctest.addElement((JSONObject)cl);
                        }
                    }
                }
            }
            if(o.containsKey("negative")) {
                String[] negatives = o.getString("negative").split(",");
                for(int i=0;i<negatives.length;i++){
                    for(int j=0;j<ar.size();j++){
                        JSONObject adt = ar.getJSONObject(j);
                        if(adt.getString("wellno").equalsIgnoreCase(negatives[i])){
                            JSONObject cl = new JSONObject();
                            cl.put("WELLNO", adt.getString("wellno"));
                            if(adt.getString("qualitative").toUpperCase().indexOf("POS") >= 0){
                                passed = false;
                                cl.put("PASSED", false);
                            } else {
                                cl.put("PASSED", true);
                            }
                            ctest.addElement((JSONObject)cl);
                        }
                    }
                }
            }
        }
        session.setAttribute("UPLOADEDCONTROLS", (Vector)ctest);
        session.setAttribute("UPLOADEDCONTROLSPASSED", (java.lang.Boolean)new java.lang.Boolean(passed));
        
        //String base64Image = data.split(",")[1];
        //String imagetype = ((data.split(",")[0]).split(";")[0]).split("/")[1];
        //byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
    
        //FileOutputStream io = new FileOutputStream(basedir+"documents/pictures/pic_"+pers.getPersonellid()+"."+imagetype);
        //io.write(imageBytes);
        //io.close();
    
        
    } else if(device.getName().equalsIgnoreCase("BioTek") && device.getModel().equalsIgnoreCase("ELx808")){
        Vector v = new Vector();
        String data = request.getParameter("content");
        String[] dat = data.split(",");
        String contenttype = dat[0];
        byte[] content = javax.xml.bind.DatatypeConverter.parseBase64Binary(dat[1]);
//        if(!contenttype.equalsIgnoreCase(contenttypes[0]))
//            throw new Exception(trs.t("ასატვირთი ფაილის არასწორი ფორმატი"));
        WorkbookSettings ws = new WorkbookSettings();
        ws.setEncoding("ISO-8859-1");
        Workbook workbook = Workbook.getWorkbook(new ByteArrayInputStream(content),ws);
        Sheet sheet = workbook.getSheet(0);
        int cols = sheet.getColumns();
        int rows = sheet.getRows();
        LabtestcontrolBean[] lc = null;
        JSONArray ar = new JSONArray();
        int wn = 0;
        for(int i=1;i<rows;i++){
            jxl.Cell cell = sheet.getCell(1,i);
            if(cell.getContents().trim().length() == 0) continue;
            String barcode = cell.getContents().trim();
            cell = sheet.getCell(2,i);
            String wellno = cell.getContents().trim();
            cell = sheet.getCell(4,i);
            String rst = cell.getContents().trim();

            JSONObject result = new JSONObject();
            result.put("testdate",dt.format(new Date()));
            result.put("plateno","");
            result.put("wellno",wellno);
            result.put("barcode",barcode);
            result.put("itemname","");
            result.put("quantitative",0);
            result.put("qualitative",rst);
            result.put("absorbency",0);
            DeviceresultBean dr = DeviceresultManager.getInstance().createDeviceresultBean();
            dr.setDeviceid(deviceid);
            dr.setRegbyid(user.getPersonellid());
            dr.setRegdate(new Date().getTime());
            dr.setResultdate(new Date().getTime());
            dr.setResult(result.toString());
            
            SampleitemreseachBean[] itms = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid in (select contractsampleitemid from contractsampleitem where barcode = '"+barcode+"')");
            if(itms.length > 0){
                dr.setSampleitemreseachid(itms[0].getSampleitemreseachid());
                lc = LabtestcontrolManager.getInstance().loadByLabtestid(itms[0].getLabtestid());
                
            }
            /*
            for(int j=0;j<itm.length;j++){
                if(itm[j].getBarcode().equals(barcode)){
                    dr.setContractsampleitemid(itm[j].getContractsampleitemid());
                    break;
                }
            }
            */
            ar.add(result);
            v.addElement((DeviceresultBean)dr);
        }
    }
    
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
    res.put("uploadedresults",uploadedresults);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>

