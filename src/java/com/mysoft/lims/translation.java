/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mysoft.lims;

import java.io.FileInputStream;
import java.io.Serializable;
import java.util.Hashtable;

/**
 *
 * @author djorj
 */
public class translation implements Serializable {
    
    private int langid = 0;
    private int blangid = 0;
    private LangBean lang;
    private Hashtable h;
    public void translation(){}
    
    public void init(int langid){
        try{
            this.langid = langid;
            LangBean[] lng = LangManager.getInstance().loadByWhere("where basic = true");
            blangid = lng[0].getLangid().intValue();
            lang = LangManager.getInstance().loadByPrimaryKey(langid);
            h = new Hashtable();
            if(langid == blangid)                return;
            LangBean[] langs = LangManager.getInstance().loadByWhere("where basic = false order by langid");
            TrlibBean[] tr = TrlibManager.getInstance().loadByLangid(blangid);
            for(int i=0;i<tr.length;i++){
                TrlibBean[] trs = TrlibManager.getInstance().loadByWhere("where phraseid = "+tr[i].getTrlibid()+" and langid = "+langid);
                if(trs.length == 0){
                    TrlibBean trnew = TrlibManager.getInstance().createTrlibBean();
                    trnew.setLangid(langid);
                    trnew.setPhrase("");
                    trnew.setPhraseid(tr[i].getTrlibid());
                    trnew = TrlibManager.getInstance().save(trnew);
                } else {
                    h.put(tr[i].getPhrase(), trs[0].getPhrase());
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void init0(int langid){
        try{
            this.langid = langid;
            LangBean[] lng = LangManager.getInstance().loadByWhere("where basic = true");
            blangid = lng[0].getLangid().intValue();
            lang = LangManager.getInstance().loadByPrimaryKey(langid);
            h = new Hashtable();
            if(langid == blangid)                return;
            LangBean[] langs = LangManager.getInstance().loadByWhere("where basic = false order by langid");
            TrlibBean[] tr = TrlibManager.getInstance().loadByLangid(blangid);
            for(int i=0;i<tr.length;i++){
                TrlibBean[] trs = TrlibManager.getInstance().loadByWhere("where phraseid = "+tr[i].getTrlibid()+" and langid = "+langid);
                if(trs.length == 0){
                    TrlibBean trnew = TrlibManager.getInstance().createTrlibBean();
                    trnew.setLangid(langid);
                    trnew.setPhrase("");
                    trnew.setPhraseid(tr[i].getTrlibid());
                    trnew = TrlibManager.getInstance().save(trnew);
                } else {
                    h.put(tr[i].getPhrase(), trs[0].getPhrase());
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public boolean isinit(){
        boolean bret = false;
        if(langid > 0)  bret = true;
        return bret;
    }
    
    public String getName(){
        return lang.getName();
    }
    
    public String getFlag(){
        return lang.getFlag();
    }
    
    public String getCode(){
        return lang.getCode();
    }
    
    public int getLangid(){
        return langid;
    }

    public int getBlangid() {
        return blangid;
    }
    
    
    
    public String t(String phrase) throws Exception {
        if(h == null)   System.out.println("NULLL");
        String s = (String)h.get(phrase);
        if(s == null){
            TrlibBean[] trnews = TrlibManager.getInstance().loadByWhere("where phrase = '"+phrase.replaceAll("'", "''")+"' and langid = "+blangid);
            if(trnews.length == 0){
                TrlibBean trnew = TrlibManager.getInstance().createTrlibBean();
                trnew.setLangid(blangid);
                trnew.setPhrase(phrase);
                trnew = TrlibManager.getInstance().save(trnew);
            }
            s = phrase;
        } else if(s.trim().length() == 0)
            s = phrase;
        return s;
    }
    
    public String t(String phrase,String name) throws Exception {
        String s = (String)h.get(phrase);
        if(s == null){
            TrlibBean[] trnews = TrlibManager.getInstance().loadByWhere("where phrase = '"+phrase.replaceAll("'", "''")+"' and langid = "+blangid);
            if(trnews.length == 0){
                TrlibBean trnew = TrlibManager.getInstance().createTrlibBean();
                trnew.setLangid(blangid);
                trnew.setPhrase(phrase);
                trnew = TrlibManager.getInstance().save(trnew);
            }
            s = phrase;
        } else if(s.trim().length() == 0)
            s = phrase;
        s = s.replaceAll("~NAME~", name);
        return s;
    }
    
    public boolean setT(String phrase1,String phrase2, int lng) throws Exception {
        boolean bret = true;
        Manager.getInstance().beginTransaction();
        try{
            LangBean[] lng1 = LangManager.getInstance().loadByWhere("where basic = true");
            TrlibBean[] tr1 = TrlibManager.getInstance().loadByWhere("where langid = "+lng1[0]+" and phrase = '"+phrase1.trim().replaceAll("'", "''")+"'");
            TrlibBean tr = TrlibManager.getInstance().createTrlibBean();
            TrlibBean[] tr2 = TrlibManager.getInstance().loadByWhere("where langid = "+lng+" and phraseid = "+tr1[0].getTrlibid());
            if(tr2.length > 0)  tr = TrlibManager.getInstance().loadByPrimaryKey(tr2[0].getTrlibid());
            tr.setLangid(lng);
            tr.setPhraseid(tr1[0].getTrlibid());
            tr.setPhrase(phrase2);
            tr = TrlibManager.getInstance().save(tr);
            h.put(phrase1, phrase2);
            Manager.getInstance().endTransaction(true);
        }catch(Exception e){
            Manager.getInstance().endTransaction(false);
            e.printStackTrace();
            bret = false;
        }
        return bret;
    }
    
}
