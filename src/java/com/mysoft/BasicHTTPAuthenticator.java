/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft;

import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.logging.Logger;


/**
 *
 * @author djorj
 */
public class BasicHTTPAuthenticator extends Authenticator {

    private String userName;
    private String password;
    Logger log = Logger.getLogger(BasicHTTPAuthenticator.class.getName());
   
    public BasicHTTPAuthenticator(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        log.fine("getPasswordAuthenticator, protocol is " + this.getRequestingProtocol()
                + " userName is " + userName);
        // only return username / password if using https
        // because we don't want to show them in clear text
        if (this.getRequestingProtocol().equalsIgnoreCase("http")) {
            return new PasswordAuthentication(userName,password.toCharArray());
        } else {
            return null;
        }
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
} 