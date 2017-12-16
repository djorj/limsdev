package com.mysoft;

import com.mysoft.lims.ActBean;
import com.mysoft.lims.ActManager;
import com.mysoft.lims.AppealBean;
import com.mysoft.lims.ContractBean;
import com.mysoft.lims.ContragentBean;
import com.mysoft.lims.ContragentManager;
import com.mysoft.lims.ContragenttypeBean;
import com.mysoft.lims.DerivatetypeBean;
import com.mysoft.lims.LabtestBean;
import com.mysoft.lims.LabtestManager;
import com.mysoft.lims.PersonellBean;
import com.mysoft.lims.PersonellManager;
import com.mysoft.lims.SampletypeBean;
import com.mysoft.lims.TunitBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ObjOptions
{
  static int companyid = 2;
  
  public ObjOptions() {}
  
  public static void ObjOptions() {}
  
  public static String Contragent() { String ret = "";
    try {
      ContragentBean[] obj = ContragentManager.getInstance().loadByWhere("WHERE companyid=" + companyid + " ORDER BY contragentid DESC");
      for (int i = 0; i < obj.length; i++)
      {
        ret = ret + "<option value=\"" + obj[i].getIdn() + " " + obj[i].getName() + "\"></option>"; }
    } catch (Exception e) {
      e.printStackTrace(); }
    return ret;
  }
  
  public static String Labtest() { String ret = "";
    try {
      LabtestBean[] obj = LabtestManager.getInstance().loadByWhere("ORDER BY name");
      for (int i = 0; i < obj.length; i++)
      {
        ret = ret + "<option value=\"" + obj[i].getLabtestid() + "\">"+obj[i].getName()+"</option>"; }
    } catch (Exception e) {
      e.printStackTrace(); }
    return ret;
  }
  
  public static String Contragent(int n) { String ret = "";
    try {
      ContragentBean[] obj = ContragentManager.getInstance().loadByWhere("WHERE companyid=" + companyid + " ORDER BY contragentid DESC LIMIT " + n);
      for (int i = 0; i < obj.length; i++)
      {
        ret = ret + "<option value=\"" + obj[i].getIdn() + " " + obj[i].getName() + "\"></option>"; }
    } catch (Exception e) {
      e.printStackTrace(); }
    return ret;
  }
  
  public static String Contragenttype() {
    String ret = "";
    try {
      ContragenttypeBean[] obj = com.mysoft.lims.ContragenttypeManager.getInstance().loadByWhere("ORDER BY contragenttypeid");
      for (int i = 0; i < obj.length; i++)
        ret = ret + "<option value=\"" + obj[i].getContragenttypeid() + "\"> " + obj[i].getName() + "</option>";
    } catch (Exception e) { e.printStackTrace();
    }
    return ret;
  }
  
  public static String Sampletypes(int companyid) { String ret = "";
    try {
      SampletypeBean[] obj = com.mysoft.lims.SampletypeManager.getInstance().loadByWhere("where companyid = " + companyid + " order by name");
      for (int i = 0; i < obj.length; i++)
        ret = ret + "<option value=\"" + obj[i].getSampletypeid() + "\"> " + obj[i].getName() + "</option>";
      DerivatetypeBean[] obj0 = com.mysoft.lims.DerivatetypeManager.getInstance().loadByWhere("order by name");
      for (int i = 0; i < obj0.length; i++)
        ret = ret + "<option value=\"" + obj0[i].getDerivatetypeid() + "\"> " + obj0[i].getName() + "</option>";
    } catch (Exception e) { e.printStackTrace();
    }
    return ret;
  }
  
  public static String Labpers(int companyid) { String ret = "";
    try {
      PersonellBean[] obj = PersonellManager.getInstance().loadByWhere("where companyid = " + companyid + " order by lname, fname");
      for (int i = 0; i < obj.length; i++)
        ret = ret + "<option value=\"" + obj[i].getPersonellid() + "\"> " + obj[i].getLname() + " " + obj[i].getFname() + "</option>";
    } catch (Exception e) { e.printStackTrace();
    }
    return ret;
  }
  
  public static String Region() { String ret = "";
    try {
      TunitBean[] obj = com.mysoft.lims.TunitManager.getInstance().loadByWhere("where punitid is null");
      for (int i = 0; i < obj.length; i++)
        ret = ret + "<option value=\"" + obj[i].getTunitid() + "\"> " + obj[i].getName() + "</option>";
    } catch (Exception e) { e.printStackTrace();
    }
    return ret;
  }
  
  public static JSONObject GetContragent(String key, int n) {
    JSONObject res = new JSONObject();
    try {
      JSONArray opt = new JSONArray();
      ContragentBean[] obj = ContragentManager.getInstance().loadByWhere("WHERE idn like '%" + key + "%' OR name like '%" + key + "%' ORDER BY contragentid DESC LIMIT " + n);
      for (int i = 0; i < obj.length; i++)
        opt.add(obj[i].getIdn() + " " + obj[i].getName());
      res.put("status", "OK");
      res.put("data", opt);
      return res;
    }
    catch (Exception e) {
      e.printStackTrace();
      res.put("status", "ER");
      res.put("message", "Error Code 1"); }
    return res;
  }
  
  public static JSONObject GetContragentContract(String idn) {
    JSONObject res = new JSONObject();
    try {
      JSONArray opt = new JSONArray();
      ContractBean[] obj = com.mysoft.lims.ContractManager.getInstance().loadByWhere("WHERE contragentid=" + getContragentID(idn) + " AND companyid=" + companyid + " ORDER BY contractid DESC");
      for (int i = 0; i < obj.length; i++)
      {
        JSONObject tmp = new JSONObject();
        tmp.put("id", obj[i].getContractid());
        tmp.put("num", obj[i].getNum());
        opt.add(tmp);
      }
      res.put("status", "OK");
      res.put("data", opt);
      return res;
    }
    catch (Exception e) {
      e.printStackTrace();
      res.put("status", "ER");
      res.put("message", "Error Code 1"); }
    return res;
  }
  
  public static JSONObject GetContractAppeal(String contractid)
  {
    JSONObject res = new JSONObject();
    try {
      JSONArray opt = new JSONArray();
      AppealBean[] obj = com.mysoft.lims.AppealManager.getInstance().loadByWhere("WHERE contractid=" + contractid + " ORDER BY appealid DESC");
      for (int i = 0; i < obj.length; i++)
      {
        JSONObject tmp = new JSONObject();
        tmp.put("id", obj[i].getAppealid());
        tmp.put("num", obj[i].getNum());
        opt.add(tmp);
      }
      res.put("status", "OK");
      res.put("data", opt);
      return res;
    }
    catch (Exception e) {
      e.printStackTrace();
      res.put("status", "ER");
      res.put("message", "Error Code 1"); }
    return res;
  }
  
  public static JSONObject GetContractAct(String contractid)
  {
    JSONObject res = new JSONObject();
    try {
      JSONArray opt = new JSONArray();
      ActBean[] obj = ActManager.getInstance().loadByWhere("WHERE contractid=" + contractid + " ORDER BY actid DESC");
      for (int i = 0; i < obj.length; i++)
      {
        JSONObject tmp = new JSONObject();
        tmp.put("id", obj[i].getActid());
        tmp.put("num", obj[i].getNum());
        opt.add(tmp);
      }
      res.put("status", "OK");
      res.put("data", opt);
      return res;
    }
    catch (Exception e) {
      e.printStackTrace();
      res.put("status", "ER");
      res.put("message", "Error Code 1"); }
    return res;
  }
  
  public static long getContragentID(String idn)
  {
    try {
      ContragentBean[] obj = ContragentManager.getInstance().loadByWhere("WHERE idn='" + idn + "' AND companyid=" + companyid);
      return obj.length > 0 ? obj[0].getContragentid().longValue() : 0L;
    }
    catch (Exception e) {
      e.printStackTrace(); }
    return 0L;
  }
}
