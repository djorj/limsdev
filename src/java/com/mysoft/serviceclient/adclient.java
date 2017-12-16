/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft.serviceclient;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *
 * @author djorj
 */
public class adclient {

    private String baseurl;
    private String logintoken;
    private String limsid;
    
    public adclient(){}
    public void adclient(String url, String limsid){
        this.limsid = limsid;
        this.baseurl = url;
    }
    //public void adclient(String url){ baseurl = url; }

    public void setLimsid(String limsid) {
        this.limsid = limsid;
    }

    public void setBaseurl(String baseurl) {
        this.baseurl = baseurl;
    }

    public String getLogintoken() {
        return logintoken;
    }
    
    
    
    public JSONObject getResponce(String url) throws Exception {
        URI apicall=URI.create(url);
        InputStreamReader reader=new InputStreamReader(apicall.toURL().openStream());
        BufferedReader br=new BufferedReader(reader);
        StringBuilder buffer=new StringBuilder();
        String line;
        while((line=br.readLine()) != null)   buffer.append(line);
        JSONObject json=JSONObject.fromObject(buffer.toString());
        return json;
    }
    
    public boolean login(String uname, String pass) throws Exception {
        String url = baseurl+"/Login?loginName="+uname+"&password="+pass;
        JSONObject ob = getResponce(url);
        if(!ob.containsKey("d"))    throw new Exception("Wrong answer from AD");
        boolean loggedin = false;
        logintoken = ob.getString("d");
        if(logintoken != null)
            loggedin = true;
        return loggedin;
    }
    
    public boolean isactive() throws Exception {
        if(logintoken == null)  return false;
        
        String url = baseurl+"/IsTokenActual?token="+logintoken;
        JSONObject ob = getResponce(url);
        if(!ob.containsKey("d"))    throw new Exception("Wrong answer from AD");
        return ob.getBoolean("d");
    }
    
    public JSONArray getprojects() throws Exception {
        String url = baseurl+"/GetProjects";
        JSONObject ob = getResponce(url);
        if(!ob.containsKey("d"))    throw new Exception("Wrong answer from AD");
        return ob.getJSONArray("d");
    }
    
    public JSONObject addresource(String name) throws Exception {
        String url = baseurl+"/GetResourcePermission?token="+logintoken+"&resourcePath="+limsid+name;
        JSONObject ob = getResponce(url);
        if(!ob.containsKey("d"))    throw new Exception("Wrong answer from AD");
        return ob.getJSONObject("d");
    }
    
    public JSONObject getuserdata() throws Exception {
        String url = baseurl+"/GetCurrentUser?token="+logintoken;
        JSONObject ob = getResponce(url);
        if(!ob.containsKey("d"))    throw new Exception("Wrong answer from AD");
        return ob.getJSONObject("d");
    }
    
    public boolean logout() throws Exception {
        String url = baseurl+"/Logout?token="+logintoken;
        JSONObject ob = getResponce(url);
        if(!ob.containsKey("d"))    throw new Exception("Wrong answer from AD");
        //boolean loggedin = false;
        //logintoken = ob.getString("d");
        //if(logintoken != null)
        //    loggedin = true;
        return true;
    }
    
}
