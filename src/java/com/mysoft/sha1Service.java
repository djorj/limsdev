/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author djorj
 */
public class sha1Service {

            private static String convToHex(byte[] data) {
                StringBuilder buf = new StringBuilder();
                for (int i = 0; i < data.length; i++) {
                    int halfbyte = (data[i] >>> 4) & 0x0F;
                    int two_halfs = 0;
                    do {
                        if ((0 <= halfbyte) && (halfbyte <= 9))
                            buf.append((char) ('0' + halfbyte));
                        else
                                buf.append((char) ('a' + (halfbyte - 10)));
                        halfbyte = data[i] & 0x0F;
                    } while(two_halfs++ < 1);
                }
                return buf.toString();
            }
            
            private static final String HEXES = "0123456789abcdef";
            
            private static String asHex( byte [] raw ) {
                if ( raw == null ) {
                return null;
                }
                final StringBuilder hex = new StringBuilder( 2 * raw.length );
                for ( final byte b : raw ) {
                hex.append(HEXES.charAt((b & 0xF0) >> 4))
                    .append(HEXES.charAt((b & 0x0F)));
                }
                return hex.toString();
            }

            public static String SHA1(String text) throws NoSuchAlgorithmException, UnsupportedEncodingException  {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] sha1hash = new byte[329];
            md.update(text.getBytes("iso-8859-1"), 0, text.length());
            sha1hash = md.digest();
            return convToHex(sha1hash);
            }
            
            public static String sha1(String password) throws Exception {
                String result = new sun.misc.BASE64Encoder().encode(java.security.MessageDigest.getInstance("SHA1").digest(password.getBytes())); 
                return result;

            }
            
            public static String md5(String password) throws Exception {
                return asHex(java.security.MessageDigest.getInstance("MD5").digest(password.getBytes()));
            }
        }
