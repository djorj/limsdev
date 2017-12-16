<%@page contentType="application/pdf; charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*"%>
<%@page import="com.mysoft.*"%>
<%@page import="com.mysoft.lims.*"%>
<%@page import="com.itextpdf.text.*" %>
<%@page import="com.itextpdf.text.pdf.*" %>
<%@page import="com.itextpdf.text.pdf.draw.*" %>
<%@page import="net.sf.json.*" %>
<jsp:useBean id="user" scope="session" class="com.mysoft.lims.PersonellBean"/>
<%!
class TableHeader extends PdfPageEventHelper {
        /** The header text. */
        String header;
        /** The template with the total number of pages. */
        PdfTemplate total;
 
        /**
         * Allows us to change the content of the header.
         * @param header The new header String
         */
        public void setHeader(String header) {
            this.header = header;
        }
 
        /**
         * Creates the PdfTemplate that will hold the total number of pages.
         * @see com.itextpdf.text.pdf.PdfPageEventHelper#onOpenDocument(
         *      com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
         */
        public void onOpenDocument(PdfWriter writer, Document document) {
            total = writer.getDirectContent().createTemplate(30, 16);
        }
 
        /**
         * Adds a header to every page
         * @see com.itextpdf.text.pdf.PdfPageEventHelper#onEndPage(
         *      com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
         */
        public void onEndPage(PdfWriter writer, Document document) {
            PdfPTable table = new PdfPTable(3);
            try {
                table.setWidths(new int[]{24, 24, 2});
                table.setTotalWidth(527);
                table.setLockedWidth(true);
                table.getDefaultCell().setFixedHeight(20);
                table.getDefaultCell().setBorder(com.itextpdf.text.Rectangle.BOTTOM);
                table.addCell(header);
                table.getDefaultCell().setHorizontalAlignment(com.itextpdf.text.Element.ALIGN_RIGHT);
                table.addCell(String.format("Page %d of", writer.getPageNumber()));
                PdfPCell cell = new PdfPCell(com.itextpdf.text.Image.getInstance(total));
                cell.setBorder(com.itextpdf.text.Rectangle.BOTTOM);
                table.addCell(cell);
                table.writeSelectedRows(0, -1, 34, 803, writer.getDirectContent());
            }
            catch(com.itextpdf.text.DocumentException de) {
                throw new com.itextpdf.text.ExceptionConverter(de);
            }
        }
 
        /**
         * Fills out the total number of pages before the document is closed.
         * @see com.itextpdf.text.pdf.PdfPageEventHelper#onCloseDocument(
         *      com.itextpdf.text.pdf.PdfWriter, com.itextpdf.text.Document)
         */
        public void onCloseDocument(PdfWriter writer, Document document) {
            ColumnText.showTextAligned(total, com.itextpdf.text.Element.ALIGN_LEFT,
                    new com.itextpdf.text.Phrase(String.valueOf(writer.getPageNumber() - 1)),
                    2, 2, 0);
        }
    }

public String Num2Text(double val)
   {
       if(val <= 0.0001)             return "ნული";
       if(val >= 1.0E33)    return "1.0E33";
       String[] smore = 
       {
           "ათასი", "მილიონი", "მილიარდი", "ტრილიონი", "კვადრილიონი", "კვინტილიონი", "სეკსტილიონი", "სეპტილიონი", "ოქტილიონი", "ნონილიონი", "დეცილიონი"
       };

       DecimalFormat nmf = new DecimalFormat("#,##0.00");

       String sval = nmf.format(val);

        String[] sv1 = sval.split("\\.");
        String[] sv2 = sv1[0].split(",");

        String ss = "";

        for(int i=0;i<sv2.length;i++)
        {
            double d = Double.parseDouble(sv2[i]);
            if(d == 0 && i == sv2.length-1 && ss.length() > 0) ss = ss.substring(0,ss.length()-1) + "ი";
            if(d == 0)  continue;
            ss += get1000(d);
            if(i < sv2.length-1)    ss += " " + smore[sv2.length-i-2].substring(0,smore[sv2.length-i-2].length()-1) + " ";
        }
        return ss;
   }
   
   public String get1000(double val)
   {
       DecimalFormat nmf = new DecimalFormat("#,##0.00");
       String[] s10 = 
       {
           "ერთი","ორი","სამი","ოთხი","ხუთი","ექვსი","შვიდი","რვა","ცხრა","ათი",
           "თერთმეტი","თორმეტი","ცამეტი","თოთხმეტი","თხუთმეტი","თექვსმეტი","ჩვიდმეტი","თვრამეტი","ცხრამეტი"
       };

       String[] s100 = 
       {
           "ოცი","ორმოცი","სამოცი","ოთხმოცი"
       };

       String[] s1000 = 
       {
           "ასი","ორასი","სამასი","ოთხასი","ხუთასი","ექვსასი","შვიდასი","რვაასი","ცხრაასი"
       };

       String sval = nmf.format(val);
   
       String[] sv1 = sval.split("\\.");
       String snum = sv1[0];

       String ss = "";
       int n = 0;
       int nn = 0;
       if(snum.length() == 3)
       {
           int m = Integer.parseInt(snum.substring(0,1));
           ss = s1000[m-1].substring(0,s1000[m-1].length()-1);
           if(Integer.parseInt(snum.substring(1))>0)   ss += " ";
           n = Integer.parseInt(snum.substring(1))/20-1;
           if(n >= 0)   ss += s100[n].substring(0,s100[n].length()-1);
           nn = Integer.parseInt(snum.substring(1)) - 20*(n+1);
           if(nn > 0 && n >=0) ss += "და";
           if(nn > 0)   ss += s10[nn-1];
           else          ss += "ი";
       }
       else if(snum.length() == 2)
       {
           n = Integer.parseInt(snum)/20-1;
           if(n >= 0)   ss += s100[n].substring(0,s100[n].length()-1);
           nn = Integer.parseInt(snum) - 20*(n+1);
           if(nn > 0 && n >=0) ss += "და";
           if(nn > 0)   ss += s10[nn-1];
           else          ss += "ი";
       }
       else if(snum.length() == 1)
       {
           if(Integer.parseInt(snum) > 0)   ss += s10[Integer.parseInt(snum)-1];
           else                                            ss = "ნული";
       }
       return ss;
   }
%>
<%
String strheader = "";
String basedir = session.getServletContext().getRealPath("/");
Manager.getInstance().setJdbcDriver(getServletContext().getInitParameter("driver"));
Manager.getInstance().setJdbcUrl(getServletContext().getInitParameter("url"));
Manager.getInstance().setJdbcUsername(getServletContext().getInitParameter("user"));
Manager.getInstance().setJdbcPassword(getServletContext().getInitParameter("pass"));



DecimalFormat dcf = new DecimalFormat("00000");
SimpleDateFormat dt = new SimpleDateFormat("dd.MM.yyyy");
SimpleDateFormat dtlong = new SimpleDateFormat("dd.MM.yyyy HH:mm");

float tinysize = 6;
float smallsize = 8;
float bigsize = 10;
float biggersize = 12;
float logosize = 16;

BaseFont utf = BaseFont.createFont(basedir+"/sylfaen.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
com.itextpdf.text.Font biggerboldfont = new com.itextpdf.text.Font(utf, biggersize,com.itextpdf.text.Font.BOLD);

com.itextpdf.text.Font tfont = new com.itextpdf.text.Font(utf, tinysize);
com.itextpdf.text.Font tbfont = new com.itextpdf.text.Font(utf, tinysize,com.itextpdf.text.Font.BOLD);
com.itextpdf.text.Font font = new com.itextpdf.text.Font(utf, smallsize, com.itextpdf.text.Font.NORMAL,BaseColor.BLACK);
com.itextpdf.text.Font redfont = new com.itextpdf.text.Font(utf, smallsize,com.itextpdf.text.Font.NORMAL,BaseColor.RED);
com.itextpdf.text.Font wfont = new com.itextpdf.text.Font(utf, smallsize,com.itextpdf.text.Font.NORMAL,BaseColor.WHITE);
com.itextpdf.text.Font ifont = new com.itextpdf.text.Font(utf, smallsize,com.itextpdf.text.Font.ITALIC);
com.itextpdf.text.Font bfont = new com.itextpdf.text.Font(utf, smallsize,com.itextpdf.text.Font.BOLD);
com.itextpdf.text.Font bigfont = new com.itextpdf.text.Font(utf, bigsize);
com.itextpdf.text.Font bigfontbold = new com.itextpdf.text.Font(utf, bigsize, com.itextpdf.text.Font.BOLD);
com.itextpdf.text.Font biggerfont = new com.itextpdf.text.Font(utf, biggersize);
com.itextpdf.text.Font logofont = new com.itextpdf.text.Font(utf, logosize, com.itextpdf.text.Font.BOLD);

com.itextpdf.text.Font boldulfont = new com.itextpdf.text.Font(utf, bigsize, com.itextpdf.text.Font.BOLD | com.itextpdf.text.Font.UNDERLINE);

com.itextpdf.text.Font certfont = new com.itextpdf.text.Font(utf, bigsize,com.itextpdf.text.Font.BOLD,BaseColor.BLUE);
com.itextpdf.text.Font isofont = new com.itextpdf.text.Font(utf, bigsize,com.itextpdf.text.Font.BOLD,BaseColor.RED);
com.itextpdf.text.Font titlefont = new com.itextpdf.text.Font(utf, bigsize,com.itextpdf.text.Font.BOLD,BaseColor.BLACK);
com.itextpdf.text.Font pfont = new com.itextpdf.text.Font(utf, bigsize,com.itextpdf.text.Font.NORMAL,BaseColor.BLACK);

com.itextpdf.text.Chunk tab1 = new com.itextpdf.text.Chunk(new VerticalPositionMark(), 8, false);
com.itextpdf.text.Chunk tab2 = new com.itextpdf.text.Chunk(new VerticalPositionMark(), 4, false);



PlateBean plate = PlateManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("plateid")));
PlatetemplateBean template = PlatetemplateManager.getInstance().loadByPrimaryKey(plate.getPlatetemplateid());
JSONObject sch = new JSONObject();
String positives = "";
String negatives = "";
String extras = "";
//LabtestBean[] test = LabtestManager.getInstance().loadByWhere("where labtestid in (select labtestid from devicelabtest where deviceid = "+plate.getDeviceid()+")");
//if(test.length > 0){
    LabtestcontrolBean[] lcb = LabtestcontrolManager.getInstance().loadByLabtestid(new Integer(request.getParameter("labtestid")));
    if(lcb.length > 0 && lcb[0].getSchedule().length() > 0){
        sch = JSONObject.fromObject(lcb[0].getSchedule());
        if(sch.containsKey("positive")) positives = sch.getString("positive");
        if(sch.containsKey("negative")) negatives = sch.getString("negative");
        if(sch.containsKey("extra")) extras = sch.getString("extra");
            
    }
//}

strheader = "ოპერატორი: "+user.getFname()+" "+user.getLname()+"\n";
strheader += "იმუნოთეფშის ნომერი: "+plate.getNum()+"\n\n\n";

String[][] s = new String[template.getH().intValue()+1][template.getW().intValue()+1];
float[] wds0 = new float[template.getW()+1];
for(int j=0;j<s[0].length;j++)
    wds0[j] = 100/template.getH();
s[0][0] = "სტრიპი";
for(int j=1;j<s[0].length;j++){
    s[0][j] = String.valueOf(j);
    
}
for(int i=1;i<s.length;i++){
    int nn = 64+i;
    String prefix = "";
    if(i>25)    {
        prefix = "A";
        nn = 65 + (i%26);
    }
    String name = prefix+((char)nn)+"";
    s[i][0] = name;
    for(int j=1;j<s[i].length;j++){
        String name1 = ((char)(64+i))+String.valueOf(j+1);
        String barcode = " \n ";
        PlatemapBean[] platemap = PlatemapManager.getInstance().loadByWhere("where plateid = "+plate.getPlateid()+" and wellno = '"+name1+"'");
        if(platemap.length > 0)
            barcode = "\n"+platemap[0].getBarcode()+"\n";
        else {
            if(positives.indexOf(name1) >= 0)   barcode = "PC";
            if(negatives.indexOf(name1) >= 0)   barcode = "NC";
            if(extras.indexOf(name1) >= 0)   barcode = "NC St.";
        }
        s[i][j] =barcode;
    }
}

response.reset();
response.setContentType("application/pdf");
response.addHeader("Content-Disposition","filename=PLATE_"+plate.getPlateid() +".pdf");

OutputStream oout = response.getOutputStream();

com.itextpdf.text.Document document = new com.itextpdf.text.Document(com.itextpdf.text.PageSize.A4, 20, 20, 0, 0);
com.itextpdf.text.pdf.PdfWriter writer = com.itextpdf.text.pdf.PdfWriter.getInstance(document, oout);

//TableHeader event = new TableHeader();
//writer.setPageEvent(event);

document.open();

PdfPTable table = new PdfPTable(1);
table.setWidthPercentage(100);
table.setSpacingAfter(5f);
PdfPCell cell = new PdfPCell(new com.itextpdf.text.Phrase(new com.itextpdf.text.Chunk(strheader,bigfontbold)));
cell.setBorderColor(new BaseColor(255, 255, 255));
cell.setHorizontalAlignment(com.itextpdf.text.Phrase.ALIGN_CENTER);
table.addCell(cell);
document.add(table);

table = new PdfPTable(wds0.length);
table.setWidths(wds0);
table.setWidthPercentage(100);
table.setSpacingAfter(5f);

for(int i=0;i<s.length;i++){
    for(int j=0;j<s[i].length;j++){
        cell = new PdfPCell(new com.itextpdf.text.Phrase(new com.itextpdf.text.Chunk(s[i][j],font)));
        cell.setBorderColor(new BaseColor(0, 0, 0));
        cell.setHorizontalAlignment(com.itextpdf.text.Phrase.ALIGN_CENTER);
        cell.setBorderColorBottom(new BaseColor(0, 0, 0));
        table.addCell(cell);
    }
}



document.add(table);

document.close();
out.flush();
oout.close();

%>
