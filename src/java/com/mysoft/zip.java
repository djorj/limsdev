/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.mysoft;

import java.io.*;
import java.util.zip.*;

/**
 *
 * @author djorj
 */
public class zip
    {
    static final int BUFFER = 2048;
    
    public static void zip() {}

    public static byte[] dozip(byte[] b)
        {
        byte[] bret = new byte[0];
        try {
            Deflater compressor = new Deflater();
            compressor.setLevel(Deflater.BEST_COMPRESSION);
            compressor.setInput(b);
            compressor.finish();

            ByteArrayOutputStream bos = new ByteArrayOutputStream(b.length);

            byte[] buf = new byte[BUFFER];
            while(!compressor.finished())
                {
                int count = compressor.deflate(buf);
                bos.write(buf, 0, count);
                }
            bos.close();
            bret = bos.toByteArray();
            } catch(Exception e) { e.printStackTrace(); }
        return bret;
        }

    public static byte[] dounzip(byte[] b)
        {
        byte[] bret = new byte[0];
        try {
            Inflater decompressor = new Inflater();
            decompressor.setInput(b);

            ByteArrayOutputStream bos = new ByteArrayOutputStream(b.length);

            byte[] buf = new byte[BUFFER];
            while (!decompressor.finished())
                {
                int count = decompressor.inflate(buf);
                bos.write(buf, 0, count);
                }
            bos.close();

            bret = bos.toByteArray();
            } catch(Exception e) { e.printStackTrace(); }
        return bret;
        }
    }

