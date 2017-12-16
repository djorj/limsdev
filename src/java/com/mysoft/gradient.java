/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.LinearGradientPaint;
import java.awt.font.FontRenderContext;
import java.awt.font.TextLayout;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.text.DecimalFormat;
import javax.imageio.ImageIO;
import javax.imageio.stream.ImageOutputStream;

/**
 *
 * @author djorj
 */
public class gradient {

    public gradient(){
        
    }
    
    public static byte[] getgradient(double min, double max, double val, String color1, String color2, String color3, String fontname) throws Exception {
        
        
        File fll = new File(fontname);
        java.awt.Font fnt = java.awt.Font.createFont(java.awt.Font.TRUETYPE_FONT,fll);
        java.awt.Font geofont = fnt.deriveFont((float)12);
        
        DecimalFormat dcc = new DecimalFormat("0.0#");
        
        int width = 200;
        int height = 30;
        float xtmin = width/5;
        float xtmax = width-width/5;
        float yt = 12;
        Color gradient1 = Color.decode("#"+color1);
        Color gradient2 = Color.decode("#"+color2);
        Color gradient3 = Color.decode("#"+color3);
        float[] frs = {0f, 0.7f, 1f};
        Color[] cls = {gradient1, gradient2, gradient3};
        Color[] cls1 = {gradient3, gradient3, gradient3};
        
        BufferedImage gradientImage = new BufferedImage(width,height, BufferedImage.TYPE_INT_RGB); 
        Graphics2D g2 = (Graphics2D) gradientImage.getGraphics();
        g2.fillRect(0, 0, width, height);
        LinearGradientPaint gr = new LinearGradientPaint(0, 0, width/5, 0, frs, cls);
        //GradientPaint gradient = new GradientPaint(0, 0, gradient1, width/5, 0, gradient2, false);
        //if(min == 0) gradient = new GradientPaint(0, 0, gradient2, width, 0, gradient2, false);
        if(min == 0)    gr = new LinearGradientPaint(0, 0, width, 0, frs, cls1);
        g2.setPaint(gr);
        g2.fillRect(0, height/2, width/2, height);
        //gradient = new GradientPaint(width, 0, gradient1, width-width/5, 0, gradient2, false);
        gr = new LinearGradientPaint(width, 0, width-width/5, 0, frs, cls);
        g2.setPaint(gr);
        g2.fillRect(width/2, height/2, width, height);

        FontRenderContext frc = g2.getFontRenderContext();
        g2.setColor(new Color(0,0,0));
        g2.setFont(geofont);
        TextLayout layout = new TextLayout(dcc.format(min), geofont, frc);
        Rectangle2D bounds = layout.getBounds();
        if(min > 0)    g2.drawString(dcc.format(min),xtmin-(int)bounds.getWidth(),yt);
        g2.drawString(dcc.format(max),xtmax,yt);
        double coeff = (xtmax-xtmin)/(max-min);
        float xtval = (float)((val-min)*coeff)+xtmin;
        if(xtval > width)   xtval = (float)(width-1);
        if(xtval < xtmin-5)   xtval = 1;
        g2.drawOval((int)(xtval-5), 2+height/2, 10, 10);
        g2.fillOval((int)(xtval-5), 2+height/2, 10, 10);
        g2.dispose();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageOutputStream  ios =  ImageIO.createImageOutputStream(baos);
        ImageIO.write(gradientImage, "jpg", ios);
        byte[] b = baos.toByteArray();
        return b;
    }
    
    
    
}
