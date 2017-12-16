<%@page contentType="text/html; charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
String where = "where analizedate is not null ";
JSONObject pdfdata = new JSONObject();
pdfdata.put("reportname", "journal0");
JSONArray ar = new JSONArray();
JSONObject o = new JSONObject();



if(orgids.length() > 0){
    where += " and institutionid in ("+orgids+")";
    o.put("name", "orgs");
    o.put("value", orgids);
    o.put("type",3);
    ar.add(o);
    InstitutionBean[] insts = InstitutionManager.getInstance().loadByWhere("where institutionid in ("+orgids+") order by name");
    for(int i=0;i<insts.length;i++){
        if(i > 0)   headertext2 += "; ";
        headertext2 += insts[i].getName();
    }
} else {
    headertext2 = "ყველა ორგანიზაცია. ";
    o.put("name", "orgs");
    o.put("value", "");
    o.put("type",3);
    ar.add(o);
}

if(orgids1.length() > 0){
    where += " and orgid in ("+orgids1+")";
    o.put("name", "orgs1");
    o.put("value", orgids1);
    o.put("type",3);
    ar.add(o);
    InstitutionBean[] insts = InstitutionManager.getInstance().loadByWhere("where institutionid in ("+orgids1+") order by name");
    for(int i=0;i<insts.length;i++){
        if(i > 0)   headertext3 += "; ";
        headertext3 += insts[i].getName();
    }
} else {
    headertext3 = "ყველა ორგანიზაცია. ";
    o.put("name", "orgs1");
    o.put("value", "");
    o.put("type",3);
    ar.add(o);
}

if(rdate.length() > 0){
    String[] search_rdate = rdate.split("-");
    if(search_rdate.length == 1){
        where += " and analizedate = to_date('"+search_rdate[0]+"','DD/MM/YYYY')";
        o.put("name", "dt1");
        o.put("value", search_rdate[0]);
        o.put("type",3);
        ar.add(o);
        o.put("name", "dt2");
        o.put("value", search_rdate[0]);
        o.put("type",3);
        ar.add(o);
        headertext1 = search_rdate[0];
    } else if(search_rdate.length == 2){
        where += " and analizedate >= to_date('"+search_rdate[0].trim()+"','DD/MM/YYYY')";
        where += " and analizedate <= to_date('"+search_rdate[1].trim()+"','DD/MM/YYYY')";
        o.put("name", "dt1");
        o.put("value", search_rdate[0].trim());
        o.put("type",3);
        ar.add(o);
        o.put("name", "dt2");
        o.put("value", search_rdate[1].trim());
        o.put("type",3);
        ar.add(o);
        headertext1 = search_rdate[0].trim() + " - " + search_rdate[1].trim();
    }
} else {
    headertext1 = "სრული პერიოდი. ";
    o.put("name", "dt1");
    o.put("value", "");
    o.put("type",3);
    ar.add(o);
    o.put("name", "dt2");
    o.put("value", "");
    o.put("type",3);
    ar.add(o);
}

o.put("name", "headertxt");
o.put("value", headertext1+" "+headertext2.replaceAll("-სს \"სამედიცინო კორპორაცია ევექსი\"", "").replaceAll("-სს „სამედიცინო კორპორაცია ევექსი“", "").replaceAll("სს „სამედიცინო კორპორაცია ევექსი“", "")+" "+headertext3.replaceAll("-სს \"სამედიცინო კორპორაცია ევექსი\"", "").replaceAll("-სს „სამედიცინო კორპორაცია ევექსი“", "").replaceAll("სს „სამედიცინო კორპორაცია ევექსი“", ""));
o.put("type",3);
ar.add(o);

pdfdata.put("data",ar);
session.setAttribute("REPORT_JSON", pdfdata);


%>