<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="org.apache.poi.xssf.usermodel.*" %>
<%@page import="sun.misc.BASE64Decoder" %>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    String oper = request.getParameter("oper");
    InventoryBean inv = InventoryManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    if(oper.equalsIgnoreCase("import")){
        String data = request.getParameter("xls");
        String xlsdata = data.split(",")[1];
        byte[] xlsbytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(xlsdata);
        InputStream is = new ByteArrayInputStream(xlsbytes);
        XSSFWorkbook wb = new XSSFWorkbook(is);
        XSSFSheet sheet=wb.getSheetAt(0);
	XSSFCell cell;
        Iterator rows = sheet.rowIterator();
        XSSFRow row=(XSSFRow) rows.next();
        while(rows.hasNext()){
            row=(XSSFRow) rows.next();
            Iterator cells = row.cellIterator();
            String productgroupcode = "";
            String invnum = "";
            String barcode = "";
            String name = "";
            String unitname = "";
            double amount = 0;
            double price = 0;
            String location = "";
            String serialnum = "";
            String brand = "";
            String model = "";
            String note = "";
            while(cells.hasNext()){
		cell=(XSSFCell) cells.next();
                int n = cell.getColumnIndex();
                String s = "";
		if(cell.getCellType() == XSSFCell.CELL_TYPE_STRING){
                    s = cell.getStringCellValue();
                } else if(cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC){
                    s = String.valueOf(cell.getNumericCellValue());
                    if(n == 0)  s = dcint.format(cell.getNumericCellValue());
                } else if(cell.getCellType() == XSSFCell.CELL_TYPE_BOOLEAN){
                    s = cell.getBooleanCellValue()+"";
                }
                if(s.trim().length() == 0)  continue;
                switch(n){
                    case 0: productgroupcode = s; break;
                    case 2: invnum = s.replaceAll("\\.0",""); break;
                    case 3: barcode = s; break;
                    case 4: name = s; break;
                    case 5: unitname = s; break;
                    case 6: amount = Double.parseDouble(s); break;
                    case 7: price = Double.parseDouble(s); break;
                    case 8: location = s; break;
                    case 9: serialnum = s; break;
                    case 10: brand = s; break;
                    case 11: model = s; break;
                    case 12: note = s; break;
                }
            }
            ProductBean product = ProductManager.getInstance().createProductBean();
            if(barcode.trim().length() > 0){
                ProductBean[] products = ProductManager.getInstance().loadByWhere("where code = '"+barcode.trim().replaceAll("'", "''") +"'");
                if(products.length > 0){
                    if(InventoryitemManager.getInstance().countWhere("where inventoryid = "+inv.getInventoryid()+" and productid = "+products[0].getProductid()) > 0)
                        throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("ასეთი ბარკოდი უკვე აღწერაშია: ")+barcode);
                    product = ProductManager.getInstance().loadByPrimaryKey(products[0].getProductid());
                }
            } else if(invnum.trim().length() > 0){
                ProductBean[] products = ProductManager.getInstance().loadByWhere("where invnumber = '"+invnum.trim().replaceAll("'", "''") +"'");
                if(products.length > 0) {
                    if(InventoryitemManager.getInstance().countWhere("where inventoryid = "+inv.getInventoryid()+" and productid = "+products[0].getProductid()) > 0)
                        throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("ასეთი ინვენტარის ნომერი უკვე აღწერაშია: ")+invnum);
                    product = ProductManager.getInstance().loadByPrimaryKey(products[0].getProductid());
                }
            }
            
            if(product.getProductid() == null){
                if(unitname.trim().length() == 0)
                    throw new Exception(trs.t("ხაზი: ")+(row.getRowNum()+1)+" "+trs.t("არასწორი ერთეული: ")+unitname);
                PunitBean[] punits = PunitManager.getInstance().loadByWhere("where name = '"+unitname.trim().replaceAll("'", "''") +"' or fullname = '"+unitname.trim().replaceAll("'", "''") +"'");
                if(punits.length == 0)
                    throw new Exception(trs.t("ხაზი: ")+(row.getRowNum()+1)+" "+trs.t("არასწორი ერთეული: ")+unitname);
                if(productgroupcode.trim().length() == 0)
                    throw new Exception(trs.t("ხაზი: ")+(row.getRowNum()+1)+" "+trs.t("არასწორი ანგარიში: ")+productgroupcode);
                ProductgroupBean[] pg = ProductgroupManager.getInstance().loadByWhere("where code = '"+productgroupcode.trim().replaceAll("'", "''") +"'");
                if(pg.length == 0)
                    throw new Exception(trs.t("ხაზი: ")+(row.getRowNum()+1)+" "+trs.t("არასწორი ანგარიში: ")+productgroupcode);

                product.setName(name);
                product.setBrandname(brand);
                product.setCode(barcode);
                product.setInvnumber(invnum);
                product.setModel(model);
                product.setSerialnum(serialnum);
                product.setPunitid(punits[0].getPunitid());
                product.setProductgroupid(pg[0].getProductgroupid());
                product = ProductManager.getInstance().save(product);
            }
            
            InventoryitemBean item = InventoryitemManager.getInstance().createInventoryitemBean();
            item.setAmount(amount);
            item.setInventoryid(inv.getInventoryid());
            item.setNote(note);
            item.setPrice(price);
            item.setLocation(location);
            item.setProductid(product.getProductid());
            item = InventoryitemManager.getInstance().save(item);
        }

    }
    
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>

