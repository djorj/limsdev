/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author djorj
 */
public class DownloadServlet extends HttpServlet {


    protected void doGet( HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

         String fileName = request.getParameter("name");
System.out.println("name = "+fileName);
         File my_file = new File(fileName);
         Path path = FileSystems.getDefault().getPath(fileName);
         
         String fileType = Files.probeContentType(path);
         
         response.setContentType(fileType);

         response.setHeader("Content-disposition","attachment; filename="+my_file.getName());

         OutputStream out = response.getOutputStream();
         FileInputStream in = new FileInputStream(my_file);
         byte[] buffer = new byte[4096];
         int length;
         while ((length = in.read(buffer)) > 0){
            out.write(buffer, 0, length);
         }
         in.close();
         out.flush();
    }
}