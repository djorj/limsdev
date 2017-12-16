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
 * Handles database calls for the labtestprod table.
 */
public class LabtestprodManager
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
     * Column productid of type Types.BIGINT mapped to Long.
     */
    public static final int ID_PRODUCTID = 1;
    public static final int TYPE_PRODUCTID = Types.BIGINT;
    public static final String NAME_PRODUCTID = "productid";

    /**
     * Column qty of type Types.DOUBLE mapped to Double.
     */
    public static final int ID_QTY = 2;
    public static final int TYPE_QTY = Types.DOUBLE;
    public static final String NAME_QTY = "qty";


    private static final String TABLE_NAME = "labtestprod";

    /**
     * Create an array of type string containing all the fields of the labtestprod table.
     */
    private static final String[] FIELD_NAMES = 
    {
        "labtestprod.labtestid"
        ,"labtestprod.productid"
        ,"labtestprod.qty"
    };

    /**
     * Field that contains the comma separated fields of the labtestprod table.
     */
    private static final String ALL_FIELDS = "labtestprod.labtestid"
                            + ",labtestprod.productid"
                            + ",labtestprod.qty";

    private static LabtestprodManager singleton = new LabtestprodManager();

    /**
     * Get the LabtestprodManager singleton.
     *
     * @return LabtestprodManager 
     */
    synchronized public static LabtestprodManager getInstance()
    {
        return singleton;
    }

    /**
     * Sets your own LabtestprodManager instance.
     <br>
     * This is optional, by default we provide it for you.
     */
    synchronized public static void setInstance(LabtestprodManager instance)
    {
        singleton = instance;
    }


    /**
     * Creates a new LabtestprodBean instance.
     *
     * @return the new LabtestprodBean 
     */
    public LabtestprodBean createLabtestprodBean()
    {
        return new LabtestprodBean();
    }

    //////////////////////////////////////
    // PRIMARY KEY METHODS
    //////////////////////////////////////

    /**
     * Loads a LabtestprodBean from the labtestprod using its key fields.
     *
     * @return a unique LabtestprodBean 
     */
    //12
    public LabtestprodBean loadByPrimaryKey(Integer labtestid, Long productid) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM labtestprod WHERE labtestprod.labtestid=? and labtestprod.productid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setInteger(ps, 1, labtestid);
            Manager.setLong(ps, 2, productid);
            LabtestprodBean pReturn[] = loadByPreparedStatement(ps);
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
    public int deleteByPrimaryKey(Integer labtestid, Long productid) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        try
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE from labtestprod WHERE labtestprod.labtestid=? and labtestprod.productid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setInteger(ps, 1, labtestid);
            Manager.setLong(ps, 2, productid);
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
     * Loads LabtestprodBean array from the labtestprod table using its labtestid field.
     *
     * @return an array of LabtestprodBean 
     */
    // LOAD BY IMPORTED KEY
    public LabtestprodBean[] loadByLabtestid(Integer value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM labtestprod WHERE labtestid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
     * Deletes from the labtestprod table by labtestid field.
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
            ps = c.prepareStatement("DELETE FROM labtestprod WHERE labtestid=?");
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
     * Loads LabtestprodBean array from the labtestprod table using its productid field.
     *
     * @return an array of LabtestprodBean 
     */
    // LOAD BY IMPORTED KEY
    public LabtestprodBean[] loadByProductid(Long value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM labtestprod WHERE productid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setLong(ps, 1, value);
            return loadByPreparedStatement(ps);
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }


    /**
     * Deletes from the labtestprod table by productid field.
     *
     * @param value the key value to seek
     * @return the number of rows deleted
     */
    // DELETE BY IMPORTED KEY
    public int deleteByProductid(Long value) throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE FROM labtestprod WHERE productid=?");
            Manager.setLong(ps, 1, value);
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
     * Retrieves the LabtestBean object from the labtestprod.labtestid field.
     *
     * @param pObject the LabtestprodBean 
     * @return the associated LabtestBean pObject
     */
    // GET IMPORTED
    public LabtestBean getLabtestBean(LabtestprodBean pObject) throws SQLException
    {
        LabtestBean other = LabtestManager.getInstance().createLabtestBean();
        other.setLabtestid(pObject.getLabtestid());
        return LabtestManager.getInstance().loadUniqueUsingTemplate(other);
    }

    /**
     * Associates the LabtestprodBean object to the LabtestBean object.
     *
     * @param pObject the LabtestprodBean object to use
     * @param pObjectToBeSet the LabtestBean object to associate to the LabtestprodBean 
     * @return the associated LabtestBean pObject
     */
    // SET IMPORTED
    public LabtestprodBean setLabtestBean(LabtestprodBean pObject,LabtestBean pObjectToBeSet)
    {
        pObject.setLabtestid(pObjectToBeSet.getLabtestid());
        return pObject;
    }

    /**
     * Retrieves the ProductBean object from the labtestprod.productid field.
     *
     * @param pObject the LabtestprodBean 
     * @return the associated ProductBean pObject
     */
    // GET IMPORTED
    public ProductBean getProductBean(LabtestprodBean pObject) throws SQLException
    {
        ProductBean other = ProductManager.getInstance().createProductBean();
        other.setProductid(pObject.getProductid());
        return ProductManager.getInstance().loadUniqueUsingTemplate(other);
    }

    /**
     * Associates the LabtestprodBean object to the ProductBean object.
     *
     * @param pObject the LabtestprodBean object to use
     * @param pObjectToBeSet the ProductBean object to associate to the LabtestprodBean 
     * @return the associated ProductBean pObject
     */
    // SET IMPORTED
    public LabtestprodBean setProductBean(LabtestprodBean pObject,ProductBean pObjectToBeSet)
    {
        pObject.setProductid(pObjectToBeSet.getProductid());
        return pObject;
    }



    //////////////////////////////////////
    // LOAD ALL
    //////////////////////////////////////

    /**
     * Loads all the rows from labtestprod.
     *
     * @return an array of LabtestprodManager pObject
     */
    //38
    public LabtestprodBean[] loadAll() throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM labtestprod",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
     * Retrieves an array of LabtestprodBean given a sql 'where' clause.
     *
     * @param where the sql 'where' clause
     * @return the resulting LabtestprodBean table 
     */
    //49
    public LabtestprodBean[] loadByWhere(String where) throws SQLException
    {
        return loadByWhere(where, null);
    }

    /**
     * Retrieves an array of LabtestprodBean given a sql where clause, and a list of fields.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the sql 'where' clause
     * @param fieldList table of the field's associated constants
     * @return the resulting LabtestprodBean table 
     */
    //51
    public LabtestprodBean[] loadByWhere(String where, int[] fieldList) throws SQLException
    {
        String sql = null;
        if(fieldList == null)
            sql = "select " + ALL_FIELDS + " from labtestprod " + where;
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
            buff.append(" from labtestprod ");
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

            return (LabtestprodBean[])v.toArray(new LabtestprodBean[0]);
        }
        finally
        {
            if (v != null) { v.clear(); }
            getManager().close(pStatement, rs);
            freeConnection(c);
        }
    }


    /**
     * Deletes all rows from labtestprod table.
     * @return the number of deleted rows.
     */
    public int deleteAll() throws SQLException
    {
        return deleteByWhere("");
    }


    /**
     * Deletes rows from the labtestprod table using a 'where' clause.
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
            String delByWhereSQL = "DELETE FROM labtestprod " + where;
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
     * Saves the LabtestprodBean pObject into the database.
     *
     * @param pObject the LabtestprodBean pObject to be saved
     */
    //100
    public LabtestprodBean save(LabtestprodBean pObject) throws SQLException
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
                _sql = new StringBuffer("INSERT into labtestprod (");
    
                if (pObject.isLabtestidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("labtestid");
                    _dirtyCount++;
                }

                if (pObject.isProductidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("productid");
                    _dirtyCount++;
                }

                if (pObject.isQtyModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("qty");
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
    
                if (pObject.isProductidModified()) {
                    Manager.setLong(ps, ++_dirtyCount, pObject.getProductid());
                }
    
                if (pObject.isQtyModified()) {
                    Manager.setDouble(ps, ++_dirtyCount, pObject.getQty());
                }
    
                ps.executeUpdate();
    
                pObject.isNew(false);
                pObject.resetIsModified();
                afterInsert(pObject); // listener callback
            }
            else 
            { // UPDATE 
                beforeUpdate(pObject); // listener callback
                _sql = new StringBuffer("UPDATE labtestprod SET ");
                boolean useComma=false;

                if (pObject.isLabtestidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("labtestid").append("=?");
                }

                if (pObject.isProductidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("productid").append("=?");
                }

                if (pObject.isQtyModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("qty").append("=?");
                }
                _sql.append(" WHERE ");
                _sql.append("labtestprod.labtestid=? AND labtestprod.productid=?");
                ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                int _dirtyCount = 0;

                if (pObject.isLabtestidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
                }

                if (pObject.isProductidModified()) {
                      Manager.setLong(ps, ++_dirtyCount, pObject.getProductid());
                }

                if (pObject.isQtyModified()) {
                      Manager.setDouble(ps, ++_dirtyCount, pObject.getQty());
                }
    
                if (_dirtyCount == 0) {
                     return pObject;
                }
    
                Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
                Manager.setLong(ps, ++_dirtyCount, pObject.getProductid());
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
     * Saves an array of LabtestprodBean pObjects into the database.
     *
     * @param pObjects the LabtestprodBean pObject table to be saved
     * @return the saved LabtestprodBean array.
     */
    //65
    public LabtestprodBean[] save(LabtestprodBean[] pObjects) throws SQLException 
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
     * Loads a unique LabtestprodBean pObject from a template one giving a c
     *
     * @param pObject the LabtestprodBean pObject to look for
     * @return the pObject matching the template
     */
    //85
    public LabtestprodBean loadUniqueUsingTemplate(LabtestprodBean pObject) throws SQLException
    {
         LabtestprodBean[] pReturn = loadUsingTemplate(pObject);
         if (pReturn.length == 0)
             return null;
         if (pReturn.length > 1)
             throw new SQLException("More than one element !!");
         return pReturn[0];
     }

    /**
     * Loads an array of LabtestprodBean from a template one.
     *
     * @param pObject the LabtestprodBean template to look for
     * @return all the LabtestprodBean matching the template
     */
    //88
    public LabtestprodBean[] loadUsingTemplate(LabtestprodBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer where = new StringBuffer("");
        StringBuffer _sql = new StringBuffer("SELECT " + ALL_FIELDS + " from labtestprod WHERE ");
        StringBuffer _sqlWhere = new StringBuffer("");
        try
        {
            int _dirtyCount = 0;
    
             if (pObject.isLabtestidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("labtestid= ?");
             }
    
             if (pObject.isProductidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("productid= ?");
             }
    
             if (pObject.isQtyModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("qty= ?");
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
    
             if (pObject.isProductidModified()) {
                 Manager.setLong(ps, ++_dirtyCount, pObject.getProductid());
             }
    
             if (pObject.isQtyModified()) {
                 Manager.setDouble(ps, ++_dirtyCount, pObject.getQty());
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
     * Deletes rows using a LabtestprodBean template.
     *
     * @param pObject the LabtestprodBean object(s) to be deleted
     * @return the number of deleted objects
     */
    //63
    public int deleteUsingTemplate(LabtestprodBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer sql = null;
    
        try 
        {
            sql = new StringBuffer("DELETE FROM labtestprod WHERE ");
            int _dirtyAnd = 0;
            if (pObject.isLabtestidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("labtestid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isProductidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("productid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isQtyInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("qty").append("=?");
                _dirtyAnd ++;
            }
    
            c = getConnection();
            ps = c.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            int _dirtyCount = 0;
    
            if (pObject.isLabtestidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getLabtestid());
            }
    
            if (pObject.isProductidInitialized()) {
                Manager.setLong(ps, ++_dirtyCount, pObject.getProductid());
            }
    
            if (pObject.isQtyInitialized()) {
                Manager.setDouble(ps, ++_dirtyCount, pObject.getQty());
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
     * Retrieves the number of rows of the table labtestprod.
     *
     * @return the number of rows returned
     */
    //78
    public int countAll() throws SQLException
    {
        return countWhere("");
    }



    /**
     * Retrieves the number of rows of the table labtestprod with a 'where' clause.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the restriction clause
     * @return the number of rows returned
     */
    public int countWhere(String where) throws SQLException
    {
        String sql = "select count(*) as MCOUNT from labtestprod " + where;
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
     * Retrieves the number of rows of the table labtestprod with a prepared statement.
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
     * Looks for the number of elements of a specific LabtestprodBean pObject given a c
     *
     * @param pObject the LabtestprodBean pObject to look for
     * @return the number of rows returned
     */
    //83
    public int countUsingTemplate(LabtestprodBean pObject) throws SQLException
    {
        StringBuffer where = new StringBuffer("");
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer _sql = null;
        StringBuffer _sqlWhere = null;
    
        try
        {
                _sql = new StringBuffer("SELECT count(*) as MCOUNT  from labtestprod WHERE ");
                _sqlWhere = new StringBuffer("");
                int _dirtyCount = 0;
    
                if (pObject.isLabtestidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("labtestid= ?");
                }
    
                if (pObject.isProductidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("productid= ?");
                }
    
                if (pObject.isQtyModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("qty= ?");
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
    
                if (pObject.isProductidModified()) {
                    Manager.setLong(ps, ++_dirtyCount, pObject.getProductid());
                }
    
                if (pObject.isQtyModified()) {
                    Manager.setDouble(ps, ++_dirtyCount, pObject.getQty());
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
     * Transforms a ResultSet iterating on the labtestprod on a LabtestprodBean pObject.
     *
     * @param rs the ResultSet to be transformed
     * @return pObject resulting LabtestprodBean pObject
     */
    //72
    public LabtestprodBean decodeRow(ResultSet rs) throws SQLException
    {
        LabtestprodBean pObject = createLabtestprodBean();
        pObject.setLabtestid(Manager.getInteger(rs, 1));
        pObject.setProductid(Manager.getLong(rs, 2));
        pObject.setQty(Manager.getDouble(rs, 3));

        pObject.isNew(false);
        pObject.resetIsModified();

        return pObject;
    }

    /**
     * Transforms a ResultSet iterating on the labtestprod table on a LabtestprodBean pObject according to a list of fields.
     *
     * @param rs the ResultSet to be transformed
     * @param fieldList table of the field's associated constants
     * @return pObject resulting LabtestprodBean pObject
     */
    //73
    public LabtestprodBean decodeRow(ResultSet rs, int[] fieldList) throws SQLException
    {
        LabtestprodBean pObject = createLabtestprodBean();
        int pos = 0;
        for(int i = 0; i < fieldList.length; i++)
        {
            switch(fieldList[i]) {
                case ID_LABTESTID:
                    ++pos;
                    pObject.setLabtestid(Manager.getInteger(rs, pos));
                    break;
                case ID_PRODUCTID:
                    ++pos;
                    pObject.setProductid(Manager.getLong(rs, pos));
                    break;
                case ID_QTY:
                    ++pos;
                    pObject.setQty(Manager.getDouble(rs, pos));
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
     * @return an array of LabtestprodBean 
     */
    //41
    public LabtestprodBean[] loadByPreparedStatement(PreparedStatement ps) throws SQLException
    {
        return loadByPreparedStatement(ps, null);
    }

    /**
     * Loads all the elements using a prepared statement specifying a list of fields to be retrieved.
     *
     * @param ps the PreparedStatement to be used
     * @param fieldList table of the field's associated constants
     * @return an array of LabtestprodBean 
     */
    public LabtestprodBean[] loadByPreparedStatement(PreparedStatement ps, int[] fieldList) throws SQLException
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
            return (LabtestprodBean[])v.toArray(new LabtestprodBean[0]);
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
    private LabtestprodListener listener = null;

    /**
     * Registers a unique LabtestprodListener listener.
     */
    //66.5
    public void registerListener(LabtestprodListener listener) {
        this.listener = listener;
    }

    /**
     * Before the save of the LabtestprodBean pObject.
     *
     * @param pObject the LabtestprodBean pObject to be saved
     */
    //67
    void beforeInsert(LabtestprodBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeInsert(pObject);
    }

    /**
     * After the save of the LabtestprodBean pObject.
     *
     * @param pObject the LabtestprodBean pObject to be saved
     */
    //68
    void afterInsert(LabtestprodBean pObject) throws SQLException {
        if (listener != null)
            listener.afterInsert(pObject);
    }

    /**
     * Before the update of the LabtestprodBean pObject.
     *
     * @param pObject the LabtestprodBean pObject to be updated
     */
    //69
    void beforeUpdate(LabtestprodBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeUpdate(pObject);
    }

    /**
     * After the update of the LabtestprodBean pObject.
     *
     * @param pObject the LabtestprodBean pObject to be updated
     */
    //70
    void afterUpdate(LabtestprodBean pObject) throws SQLException {
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
