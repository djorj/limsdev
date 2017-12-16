// --------------------------------------------------------
// Generated by sql2java - http://sql2java.sourceforge.net/
// jdbc driver used at code generation time: org.postgresql.Driver
// 
// Please help us improve this tool by reporting:
//    problems,
//    suggestions,
//    feedbacks,
//    ideas,
//  to http://sourceforge.net/projects/sql2java/
// --------------------------------------------------------

package com.mysoft.lims;

import java.sql.*;
// imports+ 

// imports- 

/**
 * Handles database calls for the v_labtest_inst table.
 */
public class VLabtestInstManager
// extends+ 

// extends- 
{

    /**
     * Column labtestid of type Types.INTEGER mapped to Integer.
     */
    public static final int ID_LABTESTID = 0;
    public static final int TYPE_LABTESTID = Types.INTEGER;
    public static final String NAME_LABTESTID = "labtestid";

    /**
     * Column testname of type Types.VARCHAR mapped to String.
     */
    public static final int ID_TESTNAME = 1;
    public static final int TYPE_TESTNAME = Types.VARCHAR;
    public static final String NAME_TESTNAME = "testname";

    /**
     * Column institutionid of type Types.INTEGER mapped to Integer.
     */
    public static final int ID_INSTITUTIONID = 2;
    public static final int TYPE_INSTITUTIONID = Types.INTEGER;
    public static final String NAME_INSTITUTIONID = "institutionid";

    /**
     * Column lab of type Types.VARCHAR mapped to String.
     */
    public static final int ID_LAB = 3;
    public static final int TYPE_LAB = Types.VARCHAR;
    public static final String NAME_LAB = "lab";


    private static final String TABLE_NAME = "v_labtest_inst";

    /**
     * Create an array of type string containing all the fields of the v_labtest_inst table.
     */
    private static final String[] FIELD_NAMES = 
    {
        "v_labtest_inst.labtestid"
        ,"v_labtest_inst.testname"
        ,"v_labtest_inst.institutionid"
        ,"v_labtest_inst.lab"
    };

    /**
     * Field that contains the comma separated fields of the v_labtest_inst table.
     */
    private static final String ALL_FIELDS = "v_labtest_inst.labtestid"
                            + ",v_labtest_inst.testname"
                            + ",v_labtest_inst.institutionid"
                            + ",v_labtest_inst.lab";

    private static VLabtestInstManager singleton = new VLabtestInstManager();

    /**
     * Get the VLabtestInstManager singleton.
     *
     * @return VLabtestInstManager 
     */
    synchronized public static VLabtestInstManager getInstance()
    {
        return singleton;
    }

    /**
     * Sets your own VLabtestInstManager instance.
     <br>
     * This is optional, by default we provide it for you.
     */
    synchronized public static void setInstance(VLabtestInstManager instance)
    {
        singleton = instance;
    }


    /**
     * Creates a new VLabtestInstBean instance.
     *
     * @return the new VLabtestInstBean 
     */
    public VLabtestInstBean createVLabtestInstBean()
    {
        return new VLabtestInstBean();
    }



    //////////////////////////////////////
    // LOAD ALL
    //////////////////////////////////////

    /**
     * Loads all the rows from v_labtest_inst.
     *
     * @return an array of VLabtestInstManager pObject
     */
    //38
    public VLabtestInstBean[] loadAll() throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM v_labtest_inst",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            return loadByPreparedStatement(ps);
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }

    //////////////////////////////////////
    // SQL 'WHERE' METHOD
    //////////////////////////////////////
    /**
     * Retrieves an array of VLabtestInstBean given a sql 'where' clause.
     *
     * @param where the sql 'where' clause
     * @return the resulting VLabtestInstBean table 
     */
    //49
    public VLabtestInstBean[] loadByWhere(String where) throws SQLException
    {
        return loadByWhere(where, null);
    }

    /**
     * Retrieves an array of VLabtestInstBean given a sql where clause, and a list of fields.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the sql 'where' clause
     * @param fieldList table of the field's associated constants
     * @return the resulting VLabtestInstBean table 
     */
    //51
    public VLabtestInstBean[] loadByWhere(String where, int[] fieldList) throws SQLException
    {
        String sql = null;
        if(fieldList == null)
            sql = "select " + ALL_FIELDS + " from v_labtest_inst " + where;
        else
        {
            StringBuffer buff = new StringBuffer(128);
            buff.append("select ");
            for(int i = 0; i < fieldList.length; i++)
            {
                if(i != 0)
                    buff.append(",");
                buff.append(FIELD_NAMES[fieldList[i]]);
            }
            buff.append(" from v_labtest_inst ");
            buff.append(where);
            sql = buff.toString();
            buff = null;
        }
        Connection c = null;
        Statement pStatement = null;
        ResultSet rs =  null;
        java.util.ArrayList v = null;
        try 
        {
            c = getConnection();
            pStatement = c.createStatement();
            rs =  pStatement.executeQuery(sql);
            v = new java.util.ArrayList();
            while(rs.next())
            {
                if(fieldList == null)
                    v.add(decodeRow(rs));
                else
                    v.add(decodeRow(rs, fieldList));
            }

            return (VLabtestInstBean[])v.toArray(new VLabtestInstBean[0]);
        }
        finally
        {
            if (v != null) { v.clear(); }
            getManager().close(pStatement, rs);
            freeConnection(c);
        }
    }


    /**
     * Deletes all rows from v_labtest_inst table.
     * @return the number of deleted rows.
     */
    public int deleteAll() throws SQLException
    {
        return deleteByWhere("");
    }


    /**
     * Deletes rows from the v_labtest_inst table using a 'where' clause.
     * It is up to you to pass the 'WHERE' in your where clausis.
     * <br>Attention, if 'WHERE' is omitted it will delete all records. 
     *
     * @param where the sql 'where' clause
     * @return the number of deleted rows
     */
    public int deleteByWhere(String where) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;

        try
        {
            c = getConnection();
            String delByWhereSQL = "DELETE FROM v_labtest_inst " + where;
            ps = c.prepareStatement(delByWhereSQL);
            return ps.executeUpdate();
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }



    ///////////////////////////////////////////////////////////////////////
    // SAVE 
    ///////////////////////////////////////////////////////////////////////
    /**
     * Saves the VLabtestInstBean pObject into the database.
     *
     * @param pObject the VLabtestInstBean pObject to be saved
     */
    //100
    public VLabtestInstBean save(VLabtestInstBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer _sql = null;

        try
        {
            c = getConnection();
            if (pObject.isNew())
            { // SAVE 
                beforeInsert(pObject); // listener callback
                int _dirtyCount = 0;
                _sql = new StringBuffer("INSERT into v_labtest_inst (");
    
                if (pObject.isLabtestidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("labtestid");
                    _dirtyCount++;
                }

                if (pObject.isTestnameModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("testname");
                    _dirtyCount++;
                }

                if (pObject.isInstitutionidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("institutionid");
                    _dirtyCount++;
                }

                if (pObject.isLabModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("lab");
                    _dirtyCount++;
                }

                _sql.append(") values (");
                if(_dirtyCount > 0) {
                    _sql.append("?");
                    for(int i = 1; i < _dirtyCount; i++) {
                        _sql.append(",?");
                    }
                }
                _sql.append(")");

                ps = c.prepareStatement(_sql.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                _dirtyCount = 0;

                if (pObject.isLabtestidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
                }
    
                if (pObject.isTestnameModified()) {
                    ps.setString(++_dirtyCount, pObject.getTestname());
                }
    
                if (pObject.isInstitutionidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
                }
    
                if (pObject.isLabModified()) {
                    ps.setString(++_dirtyCount, pObject.getLab());
                }
    
                ps.executeUpdate();
    
                pObject.isNew(false);
                pObject.resetIsModified();
                afterInsert(pObject); // listener callback
            }
            else 
            { // UPDATE 
                beforeUpdate(pObject); // listener callback
                _sql = new StringBuffer("UPDATE v_labtest_inst SET ");
                boolean useComma=false;

                if (pObject.isLabtestidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("labtestid").append("=?");
                }

                if (pObject.isTestnameModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("testname").append("=?");
                }

                if (pObject.isInstitutionidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("institutionid").append("=?");
                }

                if (pObject.isLabModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("lab").append("=?");
                }
                _sql.append("");
                ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                int _dirtyCount = 0;

                if (pObject.isLabtestidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
                }

                if (pObject.isTestnameModified()) {
                      ps.setString(++_dirtyCount, pObject.getTestname());
                }

                if (pObject.isInstitutionidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
                }

                if (pObject.isLabModified()) {
                      ps.setString(++_dirtyCount, pObject.getLab());
                }
    
                if (_dirtyCount == 0) {
                     return pObject;
                }
    
                ps.executeUpdate();
                pObject.resetIsModified();
                afterUpdate(pObject); // listener callback
            }
    
            return pObject;
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }



    /**
     * Saves an array of VLabtestInstBean pObjects into the database.
     *
     * @param pObjects the VLabtestInstBean pObject table to be saved
     * @return the saved VLabtestInstBean array.
     */
    //65
    public VLabtestInstBean[] save(VLabtestInstBean[] pObjects) throws SQLException 
    {
        for (int iIndex = 0; iIndex < pObjects.length; iIndex ++){
            save(pObjects[iIndex]);
        }
        return pObjects;
    }



    ///////////////////////////////////////////////////////////////////////
    // USING TEMPLATE 
    ///////////////////////////////////////////////////////////////////////
    /**
     * Loads a unique VLabtestInstBean pObject from a template one giving a c
     *
     * @param pObject the VLabtestInstBean pObject to look for
     * @return the pObject matching the template
     */
    //85
    public VLabtestInstBean loadUniqueUsingTemplate(VLabtestInstBean pObject) throws SQLException
    {
         VLabtestInstBean[] pReturn = loadUsingTemplate(pObject);
         if (pReturn.length == 0)
             return null;
         if (pReturn.length > 1)
             throw new SQLException("More than one element !!");
         return pReturn[0];
     }

    /**
     * Loads an array of VLabtestInstBean from a template one.
     *
     * @param pObject the VLabtestInstBean template to look for
     * @return all the VLabtestInstBean matching the template
     */
    //88
    public VLabtestInstBean[] loadUsingTemplate(VLabtestInstBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer where = new StringBuffer("");
        StringBuffer _sql = new StringBuffer("SELECT " + ALL_FIELDS + " from v_labtest_inst WHERE ");
        StringBuffer _sqlWhere = new StringBuffer("");
        try
        {
            int _dirtyCount = 0;
    
             if (pObject.isLabtestidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("labtestid= ?");
             }
    
             if (pObject.isTestnameModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("testname= ?");
             }
    
             if (pObject.isInstitutionidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("institutionid= ?");
             }
    
             if (pObject.isLabModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("lab= ?");
             }
    
             if (_dirtyCount == 0) {
                 throw new SQLException ("The pObject to look for is invalid : not initialized !");
             }
             _sql.append(_sqlWhere);
             c = getConnection();
             ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
             _dirtyCount = 0;
    
             if (pObject.isLabtestidModified()) {
                 Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
             }
    
             if (pObject.isTestnameModified()) {
                 ps.setString(++_dirtyCount, pObject.getTestname());
             }
    
             if (pObject.isInstitutionidModified()) {
                 Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
             }
    
             if (pObject.isLabModified()) {
                 ps.setString(++_dirtyCount, pObject.getLab());
             }
    
             ps.executeQuery();
             return loadByPreparedStatement(ps);
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }
    /**
     * Deletes rows using a VLabtestInstBean template.
     *
     * @param pObject the VLabtestInstBean object(s) to be deleted
     * @return the number of deleted objects
     */
    //63
    public int deleteUsingTemplate(VLabtestInstBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer sql = null;
    
        try 
        {
            sql = new StringBuffer("DELETE FROM v_labtest_inst WHERE ");
            int _dirtyAnd = 0;
            if (pObject.isLabtestidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("labtestid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isTestnameInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("testname").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isInstitutionidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("institutionid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isLabInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("lab").append("=?");
                _dirtyAnd ++;
            }
    
            c = getConnection();
            ps = c.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            int _dirtyCount = 0;
    
            if (pObject.isLabtestidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
            }
    
            if (pObject.isTestnameInitialized()) {
                ps.setString(++_dirtyCount, pObject.getTestname());
            }
    
            if (pObject.isInstitutionidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
            }
    
            if (pObject.isLabInitialized()) {
                ps.setString(++_dirtyCount, pObject.getLab());
            }
    
            int _rows = ps.executeUpdate();
            return _rows;
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }



    ///////////////////////////////////////////////////////////////////////
    // COUNT 
    ///////////////////////////////////////////////////////////////////////

    /**
     * Retrieves the number of rows of the table v_labtest_inst.
     *
     * @return the number of rows returned
     */
    //78
    public int countAll() throws SQLException
    {
        return countWhere("");
    }



    /**
     * Retrieves the number of rows of the table v_labtest_inst with a 'where' clause.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the restriction clause
     * @return the number of rows returned
     */
    public int countWhere(String where) throws SQLException
    {
        String sql = "select count(*) as MCOUNT from v_labtest_inst " + where;
        Connection c = null;
        Statement pStatement = null;
        ResultSet rs =  null;
        try 
        {
            int iReturn = -1;    
            c = getConnection();
            pStatement = c.createStatement();
            rs =  pStatement.executeQuery(sql);
            if (rs.next())
            {
                iReturn = rs.getInt("MCOUNT");
            }
            if (iReturn != -1)
                return iReturn;
        }
        finally
        {
            getManager().close(pStatement, rs);
            freeConnection(c);
        }
       throw new SQLException("Error in countWhere");
    }

    /**
     * Retrieves the number of rows of the table v_labtest_inst with a prepared statement.
     *
     * @param ps the PreparedStatement to be used
     * @return the number of rows returned
     */
    //82
    int countByPreparedStatement(PreparedStatement ps) throws SQLException
    {
        ResultSet rs =  null;
        try 
        {
            int iReturn = -1;
            rs = ps.executeQuery();
            if (rs.next())
                iReturn = rs.getInt("MCOUNT");
            if (iReturn != -1)
                return iReturn;
        }
        finally
        {
            getManager().close(rs);
        }
       throw new SQLException("Error in countByPreparedStatement");
    }

    /**
     * Looks for the number of elements of a specific VLabtestInstBean pObject given a c
     *
     * @param pObject the VLabtestInstBean pObject to look for
     * @return the number of rows returned
     */
    //83
    public int countUsingTemplate(VLabtestInstBean pObject) throws SQLException
    {
        StringBuffer where = new StringBuffer("");
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer _sql = null;
        StringBuffer _sqlWhere = null;
    
        try
        {
                _sql = new StringBuffer("SELECT count(*) as MCOUNT  from v_labtest_inst WHERE ");
                _sqlWhere = new StringBuffer("");
                int _dirtyCount = 0;
    
                if (pObject.isLabtestidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("labtestid= ?");
                }
    
                if (pObject.isTestnameModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("testname= ?");
                }
    
                if (pObject.isInstitutionidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("institutionid= ?");
                }
    
                if (pObject.isLabModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("lab= ?");
                }
    
                if (_dirtyCount == 0)
                   throw new SQLException ("The pObject to look is unvalid : not initialized !");
    
                _sql.append(_sqlWhere);
                c = getConnection();
                ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    
                _dirtyCount = 0;
    
                if (pObject.isLabtestidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
                }
    
                if (pObject.isTestnameModified()) {
                    ps.setString(++_dirtyCount, pObject.getTestname());
                }
    
                if (pObject.isInstitutionidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
                }
    
                if (pObject.isLabModified()) {
                    ps.setString(++_dirtyCount, pObject.getLab());
                }
    
                return countByPreparedStatement(ps);
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }



    ///////////////////////////////////////////////////////////////////////
    // DECODE RESULT SET 
    ///////////////////////////////////////////////////////////////////////
    /**
     * Transforms a ResultSet iterating on the v_labtest_inst on a VLabtestInstBean pObject.
     *
     * @param rs the ResultSet to be transformed
     * @return pObject resulting VLabtestInstBean pObject
     */
    //72
    public VLabtestInstBean decodeRow(ResultSet rs) throws SQLException
    {
        VLabtestInstBean pObject = createVLabtestInstBean();
        pObject.setLabtestid(Manager.getInteger(rs, 1));
        pObject.setTestname(rs.getString(2));
        pObject.setInstitutionid(Manager.getInteger(rs, 3));
        pObject.setLab(rs.getString(4));

        pObject.isNew(false);
        pObject.resetIsModified();

        return pObject;
    }

    /**
     * Transforms a ResultSet iterating on the v_labtest_inst table on a VLabtestInstBean pObject according to a list of fields.
     *
     * @param rs the ResultSet to be transformed
     * @param fieldList table of the field's associated constants
     * @return pObject resulting VLabtestInstBean pObject
     */
    //73
    public VLabtestInstBean decodeRow(ResultSet rs, int[] fieldList) throws SQLException
    {
        VLabtestInstBean pObject = createVLabtestInstBean();
        int pos = 0;
        for(int i = 0; i < fieldList.length; i++)
        {
            switch(fieldList[i]) {
                case ID_LABTESTID:
                    ++pos;
                    pObject.setLabtestid(Manager.getInteger(rs, pos));
                    break;
                case ID_TESTNAME:
                    ++pos;
                    pObject.setTestname(rs.getString(pos));
                    break;
                case ID_INSTITUTIONID:
                    ++pos;
                    pObject.setInstitutionid(Manager.getInteger(rs, pos));
                    break;
                case ID_LAB:
                    ++pos;
                    pObject.setLab(rs.getString(pos));
                    break;
            }
        }
        pObject.isNew(false);
        pObject.resetIsModified();

        return pObject;
    }

    //////////////////////////////////////
    // PREPARED STATEMENT LOADER
    //////////////////////////////////////

    /**
     * Loads all the elements using a prepared statement.
     *
     * @param ps the PreparedStatement to be used
     * @return an array of VLabtestInstBean 
     */
    //41
    public VLabtestInstBean[] loadByPreparedStatement(PreparedStatement ps) throws SQLException
    {
        return loadByPreparedStatement(ps, null);
    }

    /**
     * Loads all the elements using a prepared statement specifying a list of fields to be retrieved.
     *
     * @param ps the PreparedStatement to be used
     * @param fieldList table of the field's associated constants
     * @return an array of VLabtestInstBean 
     */
    public VLabtestInstBean[] loadByPreparedStatement(PreparedStatement ps, int[] fieldList) throws SQLException
    {
        ResultSet rs =  null;
        java.util.ArrayList v =  null;
        try
        {
            rs =  ps.executeQuery();
            v = new java.util.ArrayList();
            while(rs.next())
            {
                if(fieldList == null)
                    v.add(decodeRow(rs));
                else 
                    v.add(decodeRow(rs, fieldList));
            }
            return (VLabtestInstBean[])v.toArray(new VLabtestInstBean[0]);
        }
        finally
        {
            if (v != null) { v.clear(); v = null;}
            getManager().close(rs);
        }
    }

    ///////////////////////////////////////////////////////////////////////
    // LISTENER 
    ///////////////////////////////////////////////////////////////////////
    private VLabtestInstListener listener = null;

    /**
     * Registers a unique VLabtestInstListener listener.
     */
    //66.5
    public void registerListener(VLabtestInstListener listener) {
        this.listener = listener;
    }

    /**
     * Before the save of the VLabtestInstBean pObject.
     *
     * @param pObject the VLabtestInstBean pObject to be saved
     */
    //67
    void beforeInsert(VLabtestInstBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeInsert(pObject);
    }

    /**
     * After the save of the VLabtestInstBean pObject.
     *
     * @param pObject the VLabtestInstBean pObject to be saved
     */
    //68
    void afterInsert(VLabtestInstBean pObject) throws SQLException {
        if (listener != null)
            listener.afterInsert(pObject);
    }

    /**
     * Before the update of the VLabtestInstBean pObject.
     *
     * @param pObject the VLabtestInstBean pObject to be updated
     */
    //69
    void beforeUpdate(VLabtestInstBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeUpdate(pObject);
    }

    /**
     * After the update of the VLabtestInstBean pObject.
     *
     * @param pObject the VLabtestInstBean pObject to be updated
     */
    //70
    void afterUpdate(VLabtestInstBean pObject) throws SQLException {
        if (listener != null)
            listener.afterUpdate(pObject);
    }

    ///////////////////////////////////////////////////////////////////////
    // UTILS  
    ///////////////////////////////////////////////////////////////////////

    /**
     * Retrieves the manager object used to get connections.
     *
     * @return the manager used
     */
    //2
    Manager getManager() {
        return Manager.getInstance();
    }

    /**
     * Frees the connection.
     *
     * @param c the connection to release
     */
    void freeConnection(Connection c) {
        getManager().releaseConnection(c); // back to pool
    }
    /**
     * Gets the connection.
     */
    Connection getConnection() throws SQLException {
        return getManager().getConnection();
    }

// class+ 

// class- 
}
