<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="org.apache.poi.xssf.usermodel.*" %>
<%@page import="sun.misc.BASE64Decoder" %>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    SimpleDateFormat dtacc = new SimpleDateFormat("d/MM/yyyy");

        String data = request.getParameter("xls");
        String xlsdata = data.split(",")[1];
        byte[] xlsbytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(xlsdata);
        InputStream is = new ByteArrayInputStream(xlsbytes);
        XSSFWorkbook wb = new XSSFWorkbook(is);
        XSSFSheet sheet=wb.getSheetAt(0);
	XSSFCell cell;
        Iterator rows = sheet.rowIterator();
        XSSFRow row=(XSSFRow) rows.next();
        int nn = 1;
        String oldinv = "";
        long invoiceid = 0;
        while(rows.hasNext()){
            row=(XSSFRow) rows.next();
            Iterator cells = row.cellIterator();
            
            String num = "";
            Date invdate = null;
            String accnum = "";
            String name = "";
            double price = 0;
            double amount = 0;
            String unitname = "";
            String sourcetype = "";
            String cname = "";
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
                s = utf.convert(s);
                switch(n){
                    case 0: num = s; break;
                    case 1: invdate = dtacc.parse(s); break;
                    case 2: accnum = s; break;
                    case 3: name = s; break;
                    case 5: cname = s; break;
                    case 6: price = Double.parseDouble(s); break;
                    case 9: amount = Double.parseDouble(s); break;
                    case 10: unitname = s; break;
                    case 11: sourcetype = s; break;
                    case 13: note = s; break;
                }
            }
            if(num.trim().length() == 0)   break;
            String code = "";
            String productgroup = "";
            String[] accs = accnum.split(" ");
            if(accs.length == 0){
                throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("სადებ.ანგარიში ცარიელია"));
            } else if(accs.length == 1){
                productgroup = accs[0];
            } else if(accs.length == 2){
                productgroup = accs[0];
                code = accs[1];
            } else if(accs.length == 3){
                productgroup = Integer.parseInt(accs[0])+"/"+Integer.parseInt(accs[1]);
                code = accs[2];
            }
            if(code.length() == 0)
                throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("პროდუქტს კოდი არ აქვს!"));
            
            
            
            ProductBean product = ProductManager.getInstance().createProductBean();
            ProductBean[] products = ProductManager.getInstance().loadByWhere("where invnumber = '"+code.trim().replaceAll("'", "''") +"'");
            if(products.length > 0){
                product = ProductManager.getInstance().loadByPrimaryKey(products[0].getProductid());
            } else {
                ProductgroupBean[] pg = ProductgroupManager.getInstance().loadByWhere("where code = '"+productgroup+"'");
                if(pg.length == 0)
                    throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("პროდუქტის ანგარიშის კოდი არასწორია: "+productgroup));
                if(unitname.length() == 0)
                    throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("პროდუქტის ერთეული ცარიელია"));
                PunitBean[] pu = PunitManager.getInstance().loadByWhere("where name = '"+unitname+"' or fullname = '"+unitname+"'");
                if(pu.length == 0)
                    throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("პროდუქტის ერთეული არასწორია: "+unitname));
                product.setInvnumber(code);
                product.setName(name);
                product.setProductgroupid(pg[0].getProductgroupid());
                product.setPunitid(pu[0].getPunitid());
                product = ProductManager.getInstance().save(product);
            }
            
            if(!oldinv.equals(num)){
                if(cname.length() == 0)
                    throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("მომწოდებლის დასახელება ცარიელია"));
                ContragentBean[] cgt = ContragentManager.getInstance().loadByWhere("where upper(name) = '"+cname.toUpperCase().replaceAll("'", "''") +"'");
                ContragentBean contragent = ContragentManager.getInstance().createContragentBean();
                if(cgt.length > 0){
                    contragent = ContragentManager.getInstance().loadByPrimaryKey(cgt[0].getContragentid());
                } else {
                    int ctypeid = 1;
                    if(cname.indexOf("ი/მ") >= 0)
                        ctypeid = 2;
                    else if(cname.indexOf("შ.პ.ს") >= 0 || cname.indexOf("შპს") >= 0)
                        ctypeid = 3;
                    else if(cname.indexOf("ს.პ.ს") >= 0 || cname.indexOf("სპს") >= 0)
                        ctypeid = 6;
                    else if(cname.indexOf("სს") == 0)
                        ctypeid = 4;
                    else if(cname.indexOf("სსიპ") >= 0)
                        ctypeid = 9;
                    else if(cname.indexOf("სეს") >= 0)
                        ctypeid = 11;
                    else if(cname.indexOf("DTRA") >= 0)
                        ctypeid = 11;
                    contragent.setAddress("");
                    contragent.setBankdata("");
                    contragent.setCompanyid(user.getCompanyid());
                    contragent.setContact("");
                    contragent.setContragenttypeid(ctypeid);
                    contragent.setDeleted(false);
                    contragent.setEmail("");
                    contragent.setFname("");
                    contragent.setLname("");
                    contragent.setIdn("");
                    contragent.setName(cname);
                    contragent.setNote("");
                    contragent.setType(2);
                    contragent.setVat(true);
                    contragent.setUrl("");
                    contragent.setPhone("");
                    contragent = ContragentManager.getInstance().save(contragent);
                }
                
                int itypeid = 0;
                if(sourcetype.length() == 0)
                    throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("პროექტის დასახელება ცარიელია"));
                //String sql = "where upper(name) like '%"+sourcetype.toUpperCase().replaceAll("'", "''") +"%' or '"+sourcetype.toUpperCase().replaceAll("'", "''")+"' like ";
                SourcetypeBean[] srctps = SourcetypeManager.getInstance().loadAll();
                for(int j=0;j<srctps.length;j++){
                    if(sourcetype.equalsIgnoreCase(srctps[j].getName())){
                        itypeid = srctps[j].getSourcetypeid();
                        break;
                    } else if(sourcetype.indexOf(srctps[j].getName()) >= 0){
                        itypeid = srctps[j].getSourcetypeid();
                        break;
                    } else if(srctps[j].getName().indexOf(sourcetype) >= 0){
                        itypeid = srctps[j].getSourcetypeid();
                        break;
                    }
                }
                if(itypeid == 0)
                    throw new Exception(trs.t("ხაზი")+" "+(row.getRowNum()+1)+": "+trs.t("პროექტის დასახელება ვერ მოინახა: "+sourcetype));
                
                InvoiceBean invoice = InvoiceManager.getInstance().createInvoiceBean();
                invoice.setContragentid(contragent.getContragentid());
                invoice.setInvoicedate(invdate);
                invoice.setInvoicesourcetypeid(itypeid);
                invoice.setNum(num);
                invoice.setOperid(2);
                invoice.setVat(0);
                invoice.setRegbyid(user.getPersonellid());
                invoice.setPrice(price);
                invoice = InvoiceManager.getInstance().save(invoice);
                invoiceid = invoice.getInvoiceid();
                oldinv = num;
            }
            
            StockmovementBean stmv = StockmovementManager.getInstance().createStockmovementBean();
            stmv.setCurquantity(amount);
            stmv.setInvoiceid(invoiceid);
            stmv.setNote(note);
            stmv.setOperdate(invdate.getTime());
            stmv.setOperid(2);
            stmv.setProductid(product.getProductid());
            stmv.setQuantity(amount);
            stmv.setRegbyid(user.getPersonellid());
            stmv.setStockid(30);
            stmv.setUnitprice(price);
            stmv = StockmovementManager.getInstance().save(stmv);
            nn++;
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

