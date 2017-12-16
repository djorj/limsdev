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
 * Handles database calls for the labtestparams table.
 */
public class LabtestparamsManager
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
     * Column sampletypeid of type Types.INTEGER mapped to Integer.
     */
    public static final int ID_SAMPLETYPEID = 1;
    public static final int TYPE_SAMPLETYPEID = Types.INTEGER;
    public static final String NAME_SAMPLETYPEID = "sampletypeid";

    /**
     * Column standardid of type Types.INTEGER mapped to Integer.
     */
    public static final int ID_STANDARDID = 2;
    public static final int TYPE_STANDARDID = Types.INTEGER;
    public static final String NAME_STANDARDID = "standardid";


    private static final String TABLE_NAME = "labtestparams";

    /**
     * Create an array of type string containing all the fields of the labtestparams table.
     */
    private static final String[] FIELD_NAMES = 
    {
        "labtestparams.labtestid"
        ,"labtestparams.sampletypeid"
        ,"labtestparams.standardid"
    };

    /**
     * Field that contains the comma separated fields of the labtestparams table.
     */
    private static final String ALL_FIELDS = "labtestparams.labtestid"
                            + ",labtestparams.sampletypeid"
                            + ",labtestparams.standardid";

    private static LabtestparamsManager singleton = new LabtestparamsManager();

    /**
     * Get the LabtestparamsManager singleton.
     *
     * @return LabtestparamsManager 
     */
    synchronized public static LabtestparamsManager getInstance()
    {
        return singleton;
    }

    /**
     * Sets your own LabtestparamsManager instance.
     <br>
     * This is optional, by default we provide it for you.
     */
    synchronized public static void setInstance(LabtestparamsManager instance)
    {
        singleton = instance;
    }


    /**
     * Creates a new LabtestparamsBean instance.
     *
     * @return the new LabtestparamsBean 
     */
    public LabtestparamsBean createLabtestparamsBean()
    {
        return new LabtestparamsBean();
    }

    
    
    //////////////////////////////////////
    // FOREIGN KEY METHODS 
    //////////////////////////////////////

    /**
     * Loads LabtestparamsBean array from the labtestparams table using its labtestid field.
     *
     * @return an array of LabtestparamsBean 
     */
    // LOAD BY IMPORTED KEY
    public LabtestparamsBean[] loadByLabtestid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM labtestparams WHERE labtestid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
     * Deletes from the labtestparams table by labtestid field.
     *
     * @param value the key value to seek
     * @return the number of rows deleted
     */
    // DELETE BY IMPORTED KEY
    public int deleteByLabtestid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE FROM labtestparams WHERE labtestid=?");
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
     * Loads LabtestparamsBean array from the labtestparams table using its sampletypeid field.
     *
     * @return an array of LabtestparamsBean 
     */
    // LOAD BY IMPORTED KEY
    public LabtestparamsBean[] loadBySampletypeid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM labtestparams WHERE sampletypeid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
     * Deletes from the labtestparams table by sampletypeid field.
     *
     * @param value the key value to seek
     * @return the number of rows deleted
     */
    // DELETE BY IMPORTED KEY
    public int deleteBySampletypeid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE FROM labtestparams WHERE sampletypeid=?");
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
     * Loads LabtestparamsBean array from the labtestparams table using its standardid field.
     *
     * @return an array of LabtestparamsBean 
     */
    // LOAD BY IMPORTED KEY
    public LabtestparamsBean[] loadByStandardid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM labtestparams WHERE standardid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
     * Deletes from the labtestparams table by standardid field.
     *
     * @param value the key value to seek
     * @return the number of rows deleted
     */
    // DELETE BY IMPORTED KEY
    public int deleteByStandardid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE FROM labtestparams WHERE standardid=?");
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
     * Retrieves the LabtestBean object from the labtestparams.labtestid field.
     *
     * @param pObject the LabtestparamsBean 
     * @return the associated LabtestBean pObject
     */
    // GET IMPORTED
    public LabtestBean getLabtestBean(LabtestparamsBean pObject) throws SQLException
    {
        LabtestBean other = LabtestManager.getInstance().createLabtestBean();
        other.setLabtestid(pObject.getLabtestid());
        return LabtestManager.getInstance().loadUniqueUsingTemplate(other);
    }

    /**
     * Associates the LabtestparamsBean object to the LabtestBean object.
     *
     * @param pObject the LabtestparamsBean object to use
     * @param pObjectToBeSet the LabtestBean object to associate to the LabtestparamsBean 
     * @return the associated LabtestBean pObject
     */
    // SET IMPORTED
    public LabtestparamsBean setLabtestBean(LabtestparamsBean pObject,LabtestBean pObjectToBeSet)
    {
        pObject.setLabtestid(pObjectToBeSet.getLabtestid());
        return pObject;
    }

    /**
     * Retrieves the SampletypeBean object from the labtestparams.sampletypeid field.
     *
     * @param pObject the LabtestparamsBean 
     * @return the associated SampletypeBean pObject
     */
    // GET IMPORTED
    public SampletypeBean getSampletypeBean(LabtestparamsBean pObject) throws SQLException
    {
        SampletypeBean other = SampletypeManager.getInstance().createSampletypeBean();
        other.setSampletypeid(pObject.getSampletypeid());
        return SampletypeManager.getInstance().loadUniqueUsingTemplate(other);
    }

    /**
     * Associates the LabtestparamsBean object to the SampletypeBean object.
     *
     * @param pObject the LabtestparamsBean object to use
     * @param pObjectToBeSet the SampletypeBean object to associate to the LabtestparamsBean 
     * @return the associated SampletypeBean pObject
     */
    // SET IMPORTED
    public LabtestparamsBean setSampletypeBean(LabtestparamsBean pObject,SampletypeBean pObjectToBeSet)
    {
        pObject.setSampletypeid(pObjectToBeSet.getSampletypeid());
        return pObject;
    }

    /**
     * Retrieves the StandardBean object from the labtestparams.standardid field.
     *
     * @param pObject the LabtestparamsBean 
     * @return the associated StandardBean pObject
     */
    // GET IMPORTED
    public StandardBean getStandardBean(LabtestparamsBean pObject) throws SQLException
    {
        StandardBean other = StandardManager.getInstance().createStandardBean();
        other.setStandardid(pObject.getStandardid());
        return StandardManager.getInstance().loadUniqueUsingTemplate(other);
    }

    /**
     * Associates the LabtestparamsBean object to the StandardBean object.
     *
     * @param pObject the LabtestparamsBean object to use
     * @param pObjectToBeSet the StandardBean object to associate to the LabtestparamsBean 
     * @return the associated StandardBean pObject
     */
    // SET IMPORTED
    public LabtestparamsBean setStandardBean(LabtestparamsBean pObject,StandardBean pObjectToBeSet)
    {
        pObject.setStandardid(pObjectToBeSet.getStandardid());
        return pObject;
    }



    //////////////////////////////////////
    // LOAD ALL
    //////////////////////////////////////

    /**
     * Loads all the rows from labtestparams.
     *
     * @return an array of LabtestparamsManager pObject
     */
    //38
    public LabtestparamsBean[] loadAll() throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM labtestparams",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
     * Retrieves an array of LabtestparamsBean given a sql 'where' clause.
     *
     * @param where the sql 'where' clause
     * @return the resulting LabtestparamsBean table 
     */
    //49
    public LabtestparamsBean[] loadByWhere(String where) throws SQLException
    {
        return loadByWhere(where, null);
    }

    /**
     * Retrieves an array of LabtestparamsBean given a sql where clause, and a list of fields.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the sql 'where' clause
     * @param fieldList table of the field's associated constants
     * @return the resulting LabtestparamsBean table 
     */
    //51
    public LabtestparamsBean[] loadByWhere(String where, int[] fieldList) throws SQLException
    {
        String sql = null;
        if(fieldList == null)
            sql = "select " + ALL_FIELDS + " from labtestparams " + where;
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
            buff.append(" from labtestparams ");
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

            return (LabtestparamsBean[])v.toArray(new LabtestparamsBean[0]);
        }
        finally
        {
            if (v != null) { v.clear(); }
            getManager().close(pStatement, rs);
            freeConnection(c);
        }
    }


    /**
     * Deletes all rows from labtestparams table.
     * @return the number of deleted rows.
     */
    public int deleteAll() throws SQLException
    {
        return deleteByWhere("");
    }


    /**
     * Deletes rows from the labtestparams table using a 'where' clause.
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
            String delByWhereSQL = "DELETE FROM labtestparams " + where;
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
     * Saves the LabtestparamsBean pObject into the database.
     *
     * @param pObject the LabtestparamsBean pObject to be saved
     */
    //100
    public LabtestparamsBean save(LabtestparamsBean pObject) throws SQLException
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
                _sql = new StringBuffer("INSERT into labtestparams (");
    
                if (pObject.isLabtestidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("labtestid");
                    _dirtyCount++;
                }

                if (pObject.isSampletypeidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("sampletypeid");
                    _dirtyCount++;
                }

                if (pObject.isStandardidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("standardid");
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
    
                if (pObject.isSampletypeidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getSampletypeid());
                }
    
                if (pObject.isStandardidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getStandardid());
                }
    
                ps.executeUpdate();
    
                pObject.isNew(false);
                pObject.resetIsModified();
                afterInsert(pObject); // listener callback
            }
            else 
            { // UPDATE 
                beforeUpdate(pObject); // listener callback
                _sql = new StringBuffer("UPDATE labtestparams SET ");
                boolean useComma=false;

                if (pObject.isLabtestidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("labtestid").append("=?");
                }

                if (pObject.isSampletypeidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("sampletypeid").append("=?");
                }

                if (pObject.isStandardidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("standardid").append("=?");
                }
                _sql.append("");
                ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                int _dirtyCount = 0;

                if (pObject.isLabtestidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
                }

                if (pObject.isSampletypeidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getSampletypeid());
                }

                if (pObject.isStandardidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getStandardid());
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
     * Saves an array of LabtestparamsBean pObjects into the database.
     *
     * @param pObjects the LabtestparamsBean pObject table to be saved
     * @return the saved LabtestparamsBean array.
     */
    //65
    public LabtestparamsBean[] save(LabtestparamsBean[] pObjects) throws SQLException 
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
     * Loads a unique LabtestparamsBean pObject from a template one giving a c
     *
     * @param pObject the LabtestparamsBean pObject to look for
     * @return the pObject matching the template
     */
    //85
    public LabtestparamsBean loadUniqueUsingTemplate(LabtestparamsBean pObject) throws SQLException
    {
         LabtestparamsBean[] pReturn = loadUsingTemplate(pObject);
         if (pReturn.length == 0)
             return null;
         if (pReturn.length > 1)
             throw new SQLException("More than one element !!");
         return pReturn[0];
     }

    /**
     * Loads an array of LabtestparamsBean from a template one.
     *
     * @param pObject the LabtestparamsBean template to look for
     * @return all the LabtestparamsBean matching the template
     */
    //88
    public LabtestparamsBean[] loadUsingTemplate(LabtestparamsBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer where = new StringBuffer("");
        StringBuffer _sql = new StringBuffer("SELECT " + ALL_FIELDS + " from labtestparams WHERE ");
        StringBuffer _sqlWhere = new StringBuffer("");
        try
        {
            int _dirtyCount = 0;
    
             if (pObject.isLabtestidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("labtestid= ?");
             }
    
             if (pObject.isSampletypeidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("sampletypeid= ?");
             }
    
             if (pObject.isStandardidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("standardid= ?");
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
    
             if (pObject.isSampletypeidModified()) {
                 Manager.setInteger(ps, ++_dirtyCount, pObject.getSampletypeid());
             }
    
             if (pObject.isStandardidModified()) {
                 Manager.setInteger(ps, ++_dirtyCount, pObject.getStandardid());
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
     * Deletes rows using a LabtestparamsBean template.
     *
     * @param pObject the LabtestparamsBean object(s) to be deleted
     * @return the number of deleted objects
     */
    //63
    public int deleteUsingTemplate(LabtestparamsBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer sql = null;
    
        try 
        {
            sql = new StringBuffer("DELETE FROM labtestparams WHERE ");
            int _dirtyAnd = 0;
            if (pObject.isLabtestidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("labtestid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isSampletypeidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("sampletypeid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isStandardidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("standardid").append("=?");
                _dirtyAnd ++;
            }
    
            c = getConnection();
            ps = c.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            int _dirtyCount = 0;
    
            if (pObject.isLabtestidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
            }
    
            if (pObject.isSampletypeidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getSampletypeid());
            }
    
            if (pObject.isStandardidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getStandardid());
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
     * Retrieves the number of rows of the table labtestparams.
     *
     * @return the number of rows returned
     */
    //78
    public int countAll() throws SQLException
    {
        return countWhere("");
    }



    /**
     * Retrieves the number of rows of the table labtestparams with a 'where' clause.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the restriction clause
     * @return the number of rows returned
     */
    public int countWhere(String where) throws SQLException
    {
        String sql = "select count(*) as MCOUNT from labtestparams " + where;
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
     * Retrieves the number of rows of the table labtestparams with a prepared statement.
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
     * Looks for the number of elements of a specific LabtestparamsBean pObject given a c
     *
     * @param pObject the LabtestparamsBean pObject to look for
     * @return the number of rows returned
     */
    //83
    public int countUsingTemplate(LabtestparamsBean pObject) throws SQLException
    {
        StringBuffer where = new StringBuffer("");
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer _sql = null;
        StringBuffer _sqlWhere = null;
    
        try
        {
                _sql = new StringBuffer("SELECT count(*) as MCOUNT  from labtestparams WHERE ");
                _sqlWhere = new StringBuffer("");
                int _dirtyCount = 0;
    
                if (pObject.isLabtestidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("labtestid= ?");
                }
    
                if (pObject.isSampletypeidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("sampletypeid= ?");
                }
    
                if (pObject.isStandardidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("standardid= ?");
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
    
                if (pObject.isSampletypeidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getSampletypeid());
                }
    
                if (pObject.isStandardidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getStandardid());
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
     * Transforms a ResultSet iterating on the labtestparams on a LabtestparamsBean pObject.
     *
     * @param rs the ResultSet to be transformed
     * @return pObject resulting LabtestparamsBean pObject
     */
    //72
    public LabtestparamsBean decodeRow(ResultSet rs) throws SQLException
    {
        LabtestparamsBean pObject = createLabtestparamsBean();
        pObject.setLabtestid(Manager.getInteger(rs, 1));
        pObject.setSampletypeid(Manager.getInteger(rs, 2));
        pObject.setStandardid(Manager.getInteger(rs, 3));

        pObject.isNew(false);
        pObject.resetIsModified();

        return pObject;
    }

    /**
     * Transforms a ResultSet iterating on the labtestparams table on a LabtestparamsBean pObject according to a list of fields.
     *
     * @param rs the ResultSet to be transformed
     * @param fieldList table of the field's associated constants
     * @return pObject resulting LabtestparamsBean pObject
     */
    //73
    public LabtestparamsBean decodeRow(ResultSet rs, int[] fieldList) throws SQLException
    {
        LabtestparamsBean pObject = createLabtestparamsBean();
        int pos = 0;
        for(int i = 0; i < fieldList.length; i++)
        {
            switch(fieldList[i]) {
                case ID_LABTESTID:
                    ++pos;
                    pObject.setLabtestid(Manager.getInteger(rs, pos));
                    break;
                case ID_SAMPLETYPEID:
                    ++pos;
                    pObject.setSampletypeid(Manager.getInteger(rs, pos));
                    break;
                case ID_STANDARDID:
                    ++pos;
                    pObject.setStandardid(Manager.getInteger(rs, pos));
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
     * @return an array of LabtestparamsBean 
     */
    //41
    public LabtestparamsBean[] loadByPreparedStatement(PreparedStatement ps) throws SQLException
    {
        return loadByPreparedStatement(ps, null);
    }

    /**
     * Loads all the elements using a prepared statement specifying a list of fields to be retrieved.
     *
     * @param ps the PreparedStatement to be used
     * @param fieldList table of the field's associated constants
     * @return an array of LabtestparamsBean 
     */
    public LabtestparamsBean[] loadByPreparedStatement(PreparedStatement ps, int[] fieldList) throws SQLException
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
            return (LabtestparamsBean[])v.toArray(new LabtestparamsBean[0]);
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
    private LabtestparamsListener listener = null;

    /**
     * Registers a unique LabtestparamsListener listener.
     */
    //66.5
    public void registerListener(LabtestparamsListener listener) {
        this.listener = listener;
    }

    /**
     * Before the save of the LabtestparamsBean pObject.
     *
     * @param pObject the LabtestparamsBean pObject to be saved
     */
    //67
    void beforeInsert(LabtestparamsBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeInsert(pObject);
    }

    /**
     * After the save of the LabtestparamsBean pObject.
     *
     * @param pObject the LabtestparamsBean pObject to be saved
     */
    //68
    void afterInsert(LabtestparamsBean pObject) throws SQLException {
        if (listener != null)
            listener.afterInsert(pObject);
    }

    /**
     * Before the update of the LabtestparamsBean pObject.
     *
     * @param pObject the LabtestparamsBean pObject to be updated
     */
    //69
    void beforeUpdate(LabtestparamsBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeUpdate(pObject);
    }

    /**
     * After the update of the LabtestparamsBean pObject.
     *
     * @param pObject the LabtestparamsBean pObject to be updated
     */
    //70
    void afterUpdate(LabtestparamsBean pObject) throws SQLException {
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
