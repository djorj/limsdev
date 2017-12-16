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
 * Handles database calls for the institutiondoc table.
 */
public class InstitutiondocManager
// extends+ 

// extends- 
{

    /**
     * Column institutionid of type Types.INTEGER mapped to Integer.
     */
    public static final int ID_INSTITUTIONID = 0;
    public static final int TYPE_INSTITUTIONID = Types.INTEGER;
    public static final String NAME_INSTITUTIONID = "institutionid";

    /**
     * Column docid of type Types.INTEGER mapped to Integer.
     */
    public static final int ID_DOCID = 1;
    public static final int TYPE_DOCID = Types.INTEGER;
    public static final String NAME_DOCID = "docid";

    /**
     * Column filename of type Types.VARCHAR mapped to String.
     */
    public static final int ID_FILENAME = 2;
    public static final int TYPE_FILENAME = Types.VARCHAR;
    public static final String NAME_FILENAME = "filename";


    private static final String TABLE_NAME = "institutiondoc";

    /**
     * Create an array of type string containing all the fields of the institutiondoc table.
     */
    private static final String[] FIELD_NAMES = 
    {
        "institutiondoc.institutionid"
        ,"institutiondoc.docid"
        ,"institutiondoc.filename"
    };

    /**
     * Field that contains the comma separated fields of the institutiondoc table.
     */
    private static final String ALL_FIELDS = "institutiondoc.institutionid"
                            + ",institutiondoc.docid"
                            + ",institutiondoc.filename";

    private static InstitutiondocManager singleton = new InstitutiondocManager();

    /**
     * Get the InstitutiondocManager singleton.
     *
     * @return InstitutiondocManager 
     */
    synchronized public static InstitutiondocManager getInstance()
    {
        return singleton;
    }

    /**
     * Sets your own InstitutiondocManager instance.
     <br>
     * This is optional, by default we provide it for you.
     */
    synchronized public static void setInstance(InstitutiondocManager instance)
    {
        singleton = instance;
    }


    /**
     * Creates a new InstitutiondocBean instance.
     *
     * @return the new InstitutiondocBean 
     */
    public InstitutiondocBean createInstitutiondocBean()
    {
        return new InstitutiondocBean();
    }

    //////////////////////////////////////
    // PRIMARY KEY METHODS
    //////////////////////////////////////

    /**
     * Loads a InstitutiondocBean from the institutiondoc using its key fields.
     *
     * @return a unique InstitutiondocBean 
     */
    //12
    public InstitutiondocBean loadByPrimaryKey(Integer institutionid, Integer docid) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM institutiondoc WHERE institutiondoc.institutionid=? and institutiondoc.docid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setInteger(ps, 1, institutionid);
            Manager.setInteger(ps, 2, docid);
            InstitutiondocBean pReturn[] = loadByPreparedStatement(ps);
            if (pReturn.length < 1)
                return null;
            else
                return pReturn[0];
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }

    /**
     * Deletes rows according to its keys.
     *
     * @return the number of deleted rows
     */
    //60
    public int deleteByPrimaryKey(Integer institutionid, Integer docid) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        try
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE from institutiondoc WHERE institutiondoc.institutionid=? and institutiondoc.docid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setInteger(ps, 1, institutionid);
            Manager.setInteger(ps, 2, docid);
            return ps.executeUpdate();
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }

    
    
    //////////////////////////////////////
    // FOREIGN KEY METHODS 
    //////////////////////////////////////

    /**
     * Loads InstitutiondocBean array from the institutiondoc table using its docid field.
     *
     * @return an array of InstitutiondocBean 
     */
    // LOAD BY IMPORTED KEY
    public InstitutiondocBean[] loadByDocid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM institutiondoc WHERE docid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setInteger(ps, 1, value);
            return loadByPreparedStatement(ps);
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }


    /**
     * Deletes from the institutiondoc table by docid field.
     *
     * @param value the key value to seek
     * @return the number of rows deleted
     */
    // DELETE BY IMPORTED KEY
    public int deleteByDocid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE FROM institutiondoc WHERE docid=?");
            Manager.setInteger(ps, 1, value);
            return ps.executeUpdate();
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }


    /**
     * Loads InstitutiondocBean array from the institutiondoc table using its institutionid field.
     *
     * @return an array of InstitutiondocBean 
     */
    // LOAD BY IMPORTED KEY
    public InstitutiondocBean[] loadByInstitutionid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM institutiondoc WHERE institutionid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setInteger(ps, 1, value);
            return loadByPreparedStatement(ps);
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }


    /**
     * Deletes from the institutiondoc table by institutionid field.
     *
     * @param value the key value to seek
     * @return the number of rows deleted
     */
    // DELETE BY IMPORTED KEY
    public int deleteByInstitutionid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE FROM institutiondoc WHERE institutionid=?");
            Manager.setInteger(ps, 1, value);
            return ps.executeUpdate();
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }



    //////////////////////////////////////
    // GET/SET FOREIGN KEY BEAN METHOD
    //////////////////////////////////////
    /**
     * Retrieves the DocBean object from the institutiondoc.docid field.
     *
     * @param pObject the InstitutiondocBean 
     * @return the associated DocBean pObject
     */
    // GET IMPORTED
    public DocBean getDocBean(InstitutiondocBean pObject) throws SQLException
    {
        DocBean other = DocManager.getInstance().createDocBean();
        other.setDocid(pObject.getDocid());
        return DocManager.getInstance().loadUniqueUsingTemplate(other);
    }

    /**
     * Associates the InstitutiondocBean object to the DocBean object.
     *
     * @param pObject the InstitutiondocBean object to use
     * @param pObjectToBeSet the DocBean object to associate to the InstitutiondocBean 
     * @return the associated DocBean pObject
     */
    // SET IMPORTED
    public InstitutiondocBean setDocBean(InstitutiondocBean pObject,DocBean pObjectToBeSet)
    {
        pObject.setDocid(pObjectToBeSet.getDocid());
        return pObject;
    }

    /**
     * Retrieves the InstitutionBean object from the institutiondoc.institutionid field.
     *
     * @param pObject the InstitutiondocBean 
     * @return the associated InstitutionBean pObject
     */
    // GET IMPORTED
    public InstitutionBean getInstitutionBean(InstitutiondocBean pObject) throws SQLException
    {
        InstitutionBean other = InstitutionManager.getInstance().createInstitutionBean();
        other.setInstitutionid(pObject.getInstitutionid());
        return InstitutionManager.getInstance().loadUniqueUsingTemplate(other);
    }

    /**
     * Associates the InstitutiondocBean object to the InstitutionBean object.
     *
     * @param pObject the InstitutiondocBean object to use
     * @param pObjectToBeSet the InstitutionBean object to associate to the InstitutiondocBean 
     * @return the associated InstitutionBean pObject
     */
    // SET IMPORTED
    public InstitutiondocBean setInstitutionBean(InstitutiondocBean pObject,InstitutionBean pObjectToBeSet)
    {
        pObject.setInstitutionid(pObjectToBeSet.getInstitutionid());
        return pObject;
    }



    //////////////////////////////////////
    // LOAD ALL
    //////////////////////////////////////

    /**
     * Loads all the rows from institutiondoc.
     *
     * @return an array of InstitutiondocManager pObject
     */
    //38
    public InstitutiondocBean[] loadAll() throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM institutiondoc",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
     * Retrieves an array of InstitutiondocBean given a sql 'where' clause.
     *
     * @param where the sql 'where' clause
     * @return the resulting InstitutiondocBean table 
     */
    //49
    public InstitutiondocBean[] loadByWhere(String where) throws SQLException
    {
        return loadByWhere(where, null);
    }

    /**
     * Retrieves an array of InstitutiondocBean given a sql where clause, and a list of fields.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the sql 'where' clause
     * @param fieldList table of the field's associated constants
     * @return the resulting InstitutiondocBean table 
     */
    //51
    public InstitutiondocBean[] loadByWhere(String where, int[] fieldList) throws SQLException
    {
        String sql = null;
        if(fieldList == null)
            sql = "select " + ALL_FIELDS + " from institutiondoc " + where;
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
            buff.append(" from institutiondoc ");
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

            return (InstitutiondocBean[])v.toArray(new InstitutiondocBean[0]);
        }
        finally
        {
            if (v != null) { v.clear(); }
            getManager().close(pStatement, rs);
            freeConnection(c);
        }
    }


    /**
     * Deletes all rows from institutiondoc table.
     * @return the number of deleted rows.
     */
    public int deleteAll() throws SQLException
    {
        return deleteByWhere("");
    }


    /**
     * Deletes rows from the institutiondoc table using a 'where' clause.
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
            String delByWhereSQL = "DELETE FROM institutiondoc " + where;
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
     * Saves the InstitutiondocBean pObject into the database.
     *
     * @param pObject the InstitutiondocBean pObject to be saved
     */
    //100
    public InstitutiondocBean save(InstitutiondocBean pObject) throws SQLException
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
                _sql = new StringBuffer("INSERT into institutiondoc (");
    
                if (pObject.isInstitutionidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("institutionid");
                    _dirtyCount++;
                }

                if (pObject.isDocidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("docid");
                    _dirtyCount++;
                }

                if (pObject.isFilenameModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("filename");
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

                if (pObject.isInstitutionidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
                }
    
                if (pObject.isDocidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
                }
    
                if (pObject.isFilenameModified()) {
                    ps.setString(++_dirtyCount, pObject.getFilename());
                }
    
                ps.executeUpdate();
    
                pObject.isNew(false);
                pObject.resetIsModified();
                afterInsert(pObject); // listener callback
            }
            else 
            { // UPDATE 
                beforeUpdate(pObject); // listener callback
                _sql = new StringBuffer("UPDATE institutiondoc SET ");
                boolean useComma=false;

                if (pObject.isInstitutionidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("institutionid").append("=?");
                }

                if (pObject.isDocidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("docid").append("=?");
                }

                if (pObject.isFilenameModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("filename").append("=?");
                }
                _sql.append(" WHERE ");
                _sql.append("institutiondoc.institutionid=? AND institutiondoc.docid=?");
                ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                int _dirtyCount = 0;

                if (pObject.isInstitutionidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
                }

                if (pObject.isDocidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
                }

                if (pObject.isFilenameModified()) {
                      ps.setString(++_dirtyCount, pObject.getFilename());
                }
    
                if (_dirtyCount == 0) {
                     return pObject;
                }
    
                Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
                Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
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
     * Saves an array of InstitutiondocBean pObjects into the database.
     *
     * @param pObjects the InstitutiondocBean pObject table to be saved
     * @return the saved InstitutiondocBean array.
     */
    //65
    public InstitutiondocBean[] save(InstitutiondocBean[] pObjects) throws SQLException 
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
     * Loads a unique InstitutiondocBean pObject from a template one giving a c
     *
     * @param pObject the InstitutiondocBean pObject to look for
     * @return the pObject matching the template
     */
    //85
    public InstitutiondocBean loadUniqueUsingTemplate(InstitutiondocBean pObject) throws SQLException
    {
         InstitutiondocBean[] pReturn = loadUsingTemplate(pObject);
         if (pReturn.length == 0)
             return null;
         if (pReturn.length > 1)
             throw new SQLException("More than one element !!");
         return pReturn[0];
     }

    /**
     * Loads an array of InstitutiondocBean from a template one.
     *
     * @param pObject the InstitutiondocBean template to look for
     * @return all the InstitutiondocBean matching the template
     */
    //88
    public InstitutiondocBean[] loadUsingTemplate(InstitutiondocBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer where = new StringBuffer("");
        StringBuffer _sql = new StringBuffer("SELECT " + ALL_FIELDS + " from institutiondoc WHERE ");
        StringBuffer _sqlWhere = new StringBuffer("");
        try
        {
            int _dirtyCount = 0;
    
             if (pObject.isInstitutionidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("institutionid= ?");
             }
    
             if (pObject.isDocidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("docid= ?");
             }
    
             if (pObject.isFilenameModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("filename= ?");
             }
    
             if (_dirtyCount == 0) {
                 throw new SQLException ("The pObject to look for is invalid : not initialized !");
             }
             _sql.append(_sqlWhere);
             c = getConnection();
             ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
             _dirtyCount = 0;
    
             if (pObject.isInstitutionidModified()) {
                 Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
             }
    
             if (pObject.isDocidModified()) {
                 Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
             }
    
             if (pObject.isFilenameModified()) {
                 ps.setString(++_dirtyCount, pObject.getFilename());
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
     * Deletes rows using a InstitutiondocBean template.
     *
     * @param pObject the InstitutiondocBean object(s) to be deleted
     * @return the number of deleted objects
     */
    //63
    public int deleteUsingTemplate(InstitutiondocBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer sql = null;
    
        try 
        {
            sql = new StringBuffer("DELETE FROM institutiondoc WHERE ");
            int _dirtyAnd = 0;
            if (pObject.isInstitutionidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("institutionid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isDocidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("docid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isFilenameInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("filename").append("=?");
                _dirtyAnd ++;
            }
    
            c = getConnection();
            ps = c.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            int _dirtyCount = 0;
    
            if (pObject.isInstitutionidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
            }
    
            if (pObject.isDocidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
            }
    
            if (pObject.isFilenameInitialized()) {
                ps.setString(++_dirtyCount, pObject.getFilename());
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
     * Retrieves the number of rows of the table institutiondoc.
     *
     * @return the number of rows returned
     */
    //78
    public int countAll() throws SQLException
    {
        return countWhere("");
    }



    /**
     * Retrieves the number of rows of the table institutiondoc with a 'where' clause.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the restriction clause
     * @return the number of rows returned
     */
    public int countWhere(String where) throws SQLException
    {
        String sql = "select count(*) as MCOUNT from institutiondoc " + where;
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
     * Retrieves the number of rows of the table institutiondoc with a prepared statement.
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
     * Looks for the number of elements of a specific InstitutiondocBean pObject given a c
     *
     * @param pObject the InstitutiondocBean pObject to look for
     * @return the number of rows returned
     */
    //83
    public int countUsingTemplate(InstitutiondocBean pObject) throws SQLException
    {
        StringBuffer where = new StringBuffer("");
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer _sql = null;
        StringBuffer _sqlWhere = null;
    
        try
        {
                _sql = new StringBuffer("SELECT count(*) as MCOUNT  from institutiondoc WHERE ");
                _sqlWhere = new StringBuffer("");
                int _dirtyCount = 0;
    
                if (pObject.isInstitutionidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("institutionid= ?");
                }
    
                if (pObject.isDocidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("docid= ?");
                }
    
                if (pObject.isFilenameModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("filename= ?");
                }
    
                if (_dirtyCount == 0)
                   throw new SQLException ("The pObject to look is unvalid : not initialized !");
    
                _sql.append(_sqlWhere);
                c = getConnection();
                ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    
                _dirtyCount = 0;
    
                if (pObject.isInstitutionidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getInstitutionid());
                }
    
                if (pObject.isDocidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
                }
    
                if (pObject.isFilenameModified()) {
                    ps.setString(++_dirtyCount, pObject.getFilename());
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
     * Transforms a ResultSet iterating on the institutiondoc on a InstitutiondocBean pObject.
     *
     * @param rs the ResultSet to be transformed
     * @return pObject resulting InstitutiondocBean pObject
     */
    //72
    public InstitutiondocBean decodeRow(ResultSet rs) throws SQLException
    {
        InstitutiondocBean pObject = createInstitutiondocBean();
        pObject.setInstitutionid(Manager.getInteger(rs, 1));
        pObject.setDocid(Manager.getInteger(rs, 2));
        pObject.setFilename(rs.getString(3));

        pObject.isNew(false);
        pObject.resetIsModified();

        return pObject;
    }

    /**
     * Transforms a ResultSet iterating on the institutiondoc table on a InstitutiondocBean pObject according to a list of fields.
     *
     * @param rs the ResultSet to be transformed
     * @param fieldList table of the field's associated constants
     * @return pObject resulting InstitutiondocBean pObject
     */
    //73
    public InstitutiondocBean decodeRow(ResultSet rs, int[] fieldList) throws SQLException
    {
        InstitutiondocBean pObject = createInstitutiondocBean();
        int pos = 0;
        for(int i = 0; i < fieldList.length; i++)
        {
            switch(fieldList[i]) {
                case ID_INSTITUTIONID:
                    ++pos;
                    pObject.setInstitutionid(Manager.getInteger(rs, pos));
                    break;
                case ID_DOCID:
                    ++pos;
                    pObject.setDocid(Manager.getInteger(rs, pos));
                    break;
                case ID_FILENAME:
                    ++pos;
                    pObject.setFilename(rs.getString(pos));
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
     * @return an array of InstitutiondocBean 
     */
    //41
    public InstitutiondocBean[] loadByPreparedStatement(PreparedStatement ps) throws SQLException
    {
        return loadByPreparedStatement(ps, null);
    }

    /**
     * Loads all the elements using a prepared statement specifying a list of fields to be retrieved.
     *
     * @param ps the PreparedStatement to be used
     * @param fieldList table of the field's associated constants
     * @return an array of InstitutiondocBean 
     */
    public InstitutiondocBean[] loadByPreparedStatement(PreparedStatement ps, int[] fieldList) throws SQLException
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
            return (InstitutiondocBean[])v.toArray(new InstitutiondocBean[0]);
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
    private InstitutiondocListener listener = null;

    /**
     * Registers a unique InstitutiondocListener listener.
     */
    //66.5
    public void registerListener(InstitutiondocListener listener) {
        this.listener = listener;
    }

    /**
     * Before the save of the InstitutiondocBean pObject.
     *
     * @param pObject the InstitutiondocBean pObject to be saved
     */
    //67
    void beforeInsert(InstitutiondocBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeInsert(pObject);
    }

    /**
     * After the save of the InstitutiondocBean pObject.
     *
     * @param pObject the InstitutiondocBean pObject to be saved
     */
    //68
    void afterInsert(InstitutiondocBean pObject) throws SQLException {
        if (listener != null)
            listener.afterInsert(pObject);
    }

    /**
     * Before the update of the InstitutiondocBean pObject.
     *
     * @param pObject the InstitutiondocBean pObject to be updated
     */
    //69
    void beforeUpdate(InstitutiondocBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeUpdate(pObject);
    }

    /**
     * After the update of the InstitutiondocBean pObject.
     *
     * @param pObject the InstitutiondocBean pObject to be updated
     */
    //70
    void afterUpdate(InstitutiondocBean pObject) throws SQLException {
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
