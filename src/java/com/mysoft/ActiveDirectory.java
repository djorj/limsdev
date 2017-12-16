package com.mysoft;

import java.util.Properties;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

public class ActiveDirectory {
    private final Logger LOG = Logger.getLogger(ActiveDirectory.class.getName());
    private Properties properties;
    private DirContext dirContext;
    private SearchControls searchCtls;
    public String[] returnAttributes = { "cn","sn","l","title","givenName","department","company","sAMAccountName","userPrincipalName","mail" };
    private String domainBase;
    private String baseFilter = "(&(objectCategory=Person)";

    public ActiveDirectory(String username, String password, String domainController) {
        properties = new Properties();        

        properties.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        properties.put(Context.PROVIDER_URL, "LDAP://" + domainController);
        properties.put(Context.SECURITY_PRINCIPAL, username);
        properties.put(Context.SECURITY_CREDENTIALS, password);
        
        try {
            dirContext = new InitialDirContext(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        domainBase = getDomainBase(domainController);
        
        searchCtls = new SearchControls();
        searchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);
        searchCtls.setReturningAttributes(returnAttributes);
    }
    
    public NamingEnumeration<SearchResult> searchUser(String searchValue, String searchBy, String searchBase) throws NamingException {
    	String filter = getFilter(searchValue, searchBy);    	
    	String base = (null == searchBase) ? domainBase : getDomainBase(searchBase);
        return this.dirContext.search(base, filter, this.searchCtls);
    }

    public void closeLdapConnection(){
        try {
            if(dirContext != null)
                dirContext.close();
        }
        catch (NamingException e) {
        	LOG.severe(e.getMessage());            
        }
    }
    
    private String getFilter(String searchValue, String searchBy) {
    	String filter = this.baseFilter;
        
        filter += "("+searchBy+"="+searchValue+"))";
	return filter;
    }

    private String getDomainBase(String base) {
        char[] namePair = base.toUpperCase().toCharArray();
        String dn = "DC=";
        for (int i = 0; i < namePair.length; i++) {
                if (namePair[i] == '.') {
                        dn += ",DC=" + namePair[++i];
                } else {
                        dn += namePair[i];
                }
        }
        return dn;
    }
}
