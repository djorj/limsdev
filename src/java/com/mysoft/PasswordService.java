/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.mysoft;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import sun.misc.BASE64Encoder;
import sun.misc.CharacterEncoder;
/**
 *
 * @author djorj
 */
public final class PasswordService
{
  private static PasswordService instance;
  private PasswordService()
  {
  }
  
  public synchronized String encrypt(String plaintext) throws Exception
  {
    MessageDigest md = null;
    try
    {
      md = MessageDigest.getInstance("MD5"); //step 2
    }
    catch(NoSuchAlgorithmException e)
    {
      throw new Exception(e.getMessage());
    }
    try
    {
      md.update(plaintext.getBytes("UTF-8")); //step 3
    }
    catch(UnsupportedEncodingException e)
    {
      throw new Exception(e.getMessage());
    }
    byte raw[] = md.digest(); //step 4
    String hash = (new BASE64Encoder()).encode(raw); //step 5
    return hash; //step 6
  }
  public static synchronized PasswordService getInstance() //step 1
  {
    if(instance == null)
    {
      return new PasswordService();
    }
    else
    {
      return instance;
    }
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
    
    public static String md5(String password) throws Exception {
        return asHex(java.security.MessageDigest.getInstance("MD5").digest(password.getBytes()));
    }
}