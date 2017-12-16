/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.mysoft.lims.*;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author djorj
 */
public class ImageToPDF extends HttpServlet {
    
    protected void doGet( HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            String url = request.getProtocol().substring(0, request.getProtocol().indexOf("/")).toLowerCase()
                    +"://"+request.getServerName()+":"
                    +request.getServerPort()
                    +request.getContextPath()
                    +"/genbc"
                    + "?fmt=gif"
                    + "&mw=0.21mm"
                    + "&type=code128"
                    + "&wf=2&qz=4"
                    + "&hrp=none";
            String height = "8";
            if(request.getParameter("barheight") != null)
                height = request.getParameter("barheight");
            url += "&height="+height;
            String msg = request.getParameter("msg");
            String sleft = "";
            String sright = "";
            String scenter = "";
            if(request.getParameter("lmsg") != null)
                sleft = request.getParameter("lmsg");
            if(request.getParameter("rmsg") != null)
                sright = request.getParameter("rmsg");
            if(request.getParameter("cmsg") != null)
                scenter = request.getParameter("cmsg");
            url += "&msg="+msg;
            
            double w = 1.5;
            double h = 0.5;
            
            double koeff = 1;
            if(request.getParameter("mm") != null && request.getParameter("mm").equalsIgnoreCase("true"))
                koeff = 25.4;
            if(request.getParameter("width") != null)
                w = Double.parseDouble(request.getParameter("width"));
            if(request.getParameter("height") != null)
                h = Double.parseDouble(request.getParameter("height"));
            
            w /= koeff;
            h /= koeff;
            
            double mw = 0.0666666667*w;
            double mh = 0.0333333333*h;

	    if(request.getParameter("mw") != null)
                mw = Double.parseDouble(request.getParameter("mw"))*w;
            if(request.getParameter("mh") != null)
                mh = Double.parseDouble(request.getParameter("mh"))*h;


            Rectangle r = new Rectangle((int)(w*72), (int)(h*72));
            Rectangle r1 = new Rectangle((int)((w-mw)*72), (int)((h-mh)*72));
            
            Image img = Image.getInstance(new java.net.URL(url));
            img.scaleToFit(r1);
            img.setAlignment(Image.ALIGN_CENTER);
            Document document = new Document(r,0f,0f,2f,1f);
            
            
            response.setContentType("application/pdf");
            //response.setHeader("Content-disposition","attachment; filename="+fnm+".pdf");
            OutputStream oout = response.getOutputStream();
            PdfWriter writer = PdfWriter.getInstance(document, oout);
            writer.open();
            document.open();

            float fontsize = 7f;
            if(request.getParameter("fontsize") != null)
                fontsize = Float.parseFloat(request.getParameter("fontsize"));
            com.itextpdf.text.Font font = new com.itextpdf.text.Font(Font.FontFamily.HELVETICA, fontsize, com.itextpdf.text.Font.NORMAL);

            float[] wds = {33.33f,33.33f,33.33f};
            PdfPTable table = new PdfPTable(wds.length);
            table.setWidthPercentage(100);
            table.setWidths(wds);
            table.setSpacingBefore(0f);
            table.setSpacingAfter(0f);

            if(sleft.trim().length() > 0 || scenter.trim().length() > 0 || sright.trim().length() > 0){
                com.itextpdf.text.Phrase ph = new com.itextpdf.text.Phrase(new com.itextpdf.text.Chunk(sleft,font));
                PdfPCell cell = new PdfPCell(ph);
                cell.setBorderColor(new BaseColor(255, 255, 255));
                cell.setHorizontalAlignment(PdfPCell.ALIGN_LEFT);
                cell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
                cell.setPadding(0f);
                table.addCell(cell);

                ph = new com.itextpdf.text.Phrase(new com.itextpdf.text.Chunk(scenter,font));
                cell = new PdfPCell(ph);
                cell.setBorderColor(new BaseColor(255, 255, 255));
                cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
                cell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
                cell.setPadding(0f);
                table.addCell(cell);
                
                ph = new com.itextpdf.text.Phrase(new com.itextpdf.text.Chunk(sright,font));
                cell = new PdfPCell(ph);
                cell.setBorderColor(new BaseColor(255, 255, 255));
                cell.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
                cell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
                cell.setPadding(0f);
                table.addCell(cell);
            }
            
            PdfPCell cell = new PdfPCell(img);
            cell.setBorderColor(new BaseColor(255, 255, 255));
            cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
            cell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
            cell.setPaddingTop(2f);
            cell.setPaddingBottom(0f);
            cell.setColspan(3);
            table.addCell(cell);

            if(request.getParameter("notxt") == null || !request.getParameter("notxt").equalsIgnoreCase("true")){
                com.itextpdf.text.Phrase ph = new com.itextpdf.text.Phrase(new com.itextpdf.text.Chunk(msg,font));
                cell = new PdfPCell(ph);
                cell.setBorderColor(new BaseColor(255, 255, 255));
                cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
                cell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
                cell.setPadding(0f);
                cell.setColspan(3);
                table.addCell(cell);
            }
            document.add(table);

            document.close();
            writer.close();
            oout.flush();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
