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
 * Handles database calls for the doc table.
 */
public class DocManager
// extends+ 

// extends- 
{

    /**
     * Column docid of type Types.INTEGER mapped to Integer.
     */
    public static final int ID_DOCID = 0;
    public static final int TYPE_DOCID = Types.INTEGER;
    public static final String NAME_DOCID = "docid";

    /**
     * Column name of type Types.VARCHAR mapped to String.
     */
    public static final int ID_NAME = 1;
    public static final int TYPE_NAME = Types.VARCHAR;
    public static final String NAME_NAME = "name";

    /**
     * Column description of type Types.VARCHAR mapped to String.
     */
    public static final int ID_DESCRIPTION = 2;
    public static final int TYPE_DESCRIPTION = Types.VARCHAR;
    public static final String NAME_DESCRIPTION = "description";


    private static final String TABLE_NAME = "doc";

    /**
     * Create an array of type string containing all the fields of the doc table.
     */
    private static final String[] FIELD_NAMES = 
    {
        "doc.docid"
        ,"doc.name"
        ,"doc.description"
    };

    /**
     * Field that contains the comma separated fields of the doc table.
     */
    private static final String ALL_FIELDS = "doc.docid"
                            + ",doc.name"
                            + ",doc.description";

    private static DocManager singleton = new DocManager();

    /**
     * Get the DocManager singleton.
     *
     * @return DocManager 
     */
    synchronized public static DocManager getInstance()
    {
        return singleton;
    }

    /**
     * Sets your own DocManager instance.
     <br>
     * This is optional, by default we provide it for you.
     */
    synchronized public static void setInstance(DocManager instance)
    {
        singleton = instance;
    }


    /**
     * Creates a new DocBean instance.
     *
     * @return the new DocBean 
     */
    public DocBean createDocBean()
    {
        return new DocBean();
    }

    //////////////////////////////////////
    // PRIMARY KEY METHODS
    //////////////////////////////////////

    /**
     * Loads a DocBean from the doc using its key fields.
     *
     * @return a unique DocBean 
     */
    //12
    public DocBean loadByPrimaryKey(Integer docid) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM doc WHERE doc.docid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setInteger(ps, 1, docid);
            DocBean pReturn[] = loadByPreparedStatement(ps);
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
    public int deleteByPrimaryKey(Integer docid) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        try
        {
            c = getConnection();
            ps = c.prepareStatement("DELETE from doc WHERE doc.docid=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            Manager.setInteger(ps, 1, docid);
            return ps.executeUpdate();
        }
        finally
        {
            getManager().close(ps);
            freeConnection(c);
        }
    }



    //////////////////////////////////////
    // LOAD ALL
    //////////////////////////////////////

    /**
     * Loads all the rows from doc.
     *
     * @return an array of DocManager pObject
     */
    //38
    public DocBean[] loadAll() throws SQLException 
    {
        Connection c = null;
        PreparedStatement ps = null;
        try 
        {
            c = getConnection();
            ps = c.prepareStatement("SELECT " + ALL_FIELDS + " FROM doc",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
     * Retrieves an array of DocBean given a sql 'where' clause.
     *
     * @param where the sql 'where' clause
     * @return the resulting DocBean table 
     */
    //49
    public DocBean[] loadByWhere(String where) throws SQLException
    {
        return loadByWhere(where, null);
    }

    /**
     * Retrieves an array of DocBean given a sql where clause, and a list of fields.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the sql 'where' clause
     * @param fieldList table of the field's associated constants
     * @return the resulting DocBean table 
     */
    //51
    public DocBean[] loadByWhere(String where, int[] fieldList) throws SQLException
    {
        String sql = null;
        if(fieldList == null)
            sql = "select " + ALL_FIELDS + " from doc " + where;
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
            buff.append(" from doc ");
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

            return (DocBean[])v.toArray(new DocBean[0]);
        }
        finally
        {
            if (v != null) { v.clear(); }
            getManager().close(pStatement, rs);
            freeConnection(c);
        }
    }


    /**
     * Deletes all rows from doc table.
     * @return the number of deleted rows.
     */
    public int deleteAll() throws SQLException
    {
        return deleteByWhere("");
    }


    /**
     * Deletes rows from the doc table using a 'where' clause.
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
            String delByWhereSQL = "DELETE FROM doc " + where;
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
     * Saves the DocBean pObject into the database.
     *
     * @param pObject the DocBean pObject to be saved
     */
    //100
    public DocBean save(DocBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer _sql = null;

        try
        {
            c = getConnection();
            if (pObject.isNew())
            { // SAVE 
                if (!pObject.isDocidModified())
                {
                    ps = c.prepareStatement("SELECT nextval('docid_seq')");
                    ResultSet rs = null;
                    try
                    {
                        rs = ps.executeQuery();
                        if(rs.next())
                            pObject.setDocid(Manager.getInteger(rs, 1));
                        else
                            getManager().log("ATTENTION: Could not retrieve generated key!");
                    }
                    finally
                    {
                        getManager().close(ps, rs);
                        ps=null;
                    }
                }
                beforeInsert(pObject); // listener callback
                int _dirtyCount = 0;
                _sql = new StringBuffer("INSERT into doc (");
    
                if (pObject.isDocidModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("docid");
                    _dirtyCount++;
                }

                if (pObject.isNameModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("name");
                    _dirtyCount++;
                }

                if (pObject.isDescriptionModified()) {
                    if (_dirtyCount>0) {
                        _sql.append(",");
                    }
                    _sql.append("description");
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

                if (pObject.isDocidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
                }
    
                if (pObject.isNameModified()) {
                    ps.setString(++_dirtyCount, pObject.getName());
                }
    
                if (pObject.isDescriptionModified()) {
                    ps.setString(++_dirtyCount, pObject.getDescription());
                }
    
                ps.executeUpdate();
    
                pObject.isNew(false);
                pObject.resetIsModified();
                afterInsert(pObject); // listener callback
            }
            else 
            { // UPDATE 
                beforeUpdate(pObject); // listener callback
                _sql = new StringBuffer("UPDATE doc SET ");
                boolean useComma=false;

                if (pObject.isDocidModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("docid").append("=?");
                }

                if (pObject.isNameModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("name").append("=?");
                }

                if (pObject.isDescriptionModified()) {
                    if (useComma) {
                        _sql.append(",");
                    } else {
                        useComma=true;
                    }
                    _sql.append("description").append("=?");
                }
                _sql.append(" WHERE ");
                _sql.append("doc.docid=?");
                ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                int _dirtyCount = 0;

                if (pObject.isDocidModified()) {
                      Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
                }

                if (pObject.isNameModified()) {
                      ps.setString(++_dirtyCount, pObject.getName());
                }

                if (pObject.isDescriptionModified()) {
                      ps.setString(++_dirtyCount, pObject.getDescription());
                }
    
                if (_dirtyCount == 0) {
                     return pObject;
                }
    
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
     * Saves an array of DocBean pObjects into the database.
     *
     * @param pObjects the DocBean pObject table to be saved
     * @return the saved DocBean array.
     */
    //65
    public DocBean[] save(DocBean[] pObjects) throws SQLException 
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
     * Loads a unique DocBean pObject from a template one giving a c
     *
     * @param pObject the DocBean pObject to look for
     * @return the pObject matching the template
     */
    //85
    public DocBean loadUniqueUsingTemplate(DocBean pObject) throws SQLException
    {
         DocBean[] pReturn = loadUsingTemplate(pObject);
         if (pReturn.length == 0)
             return null;
         if (pReturn.length > 1)
             throw new SQLException("More than one element !!");
         return pReturn[0];
     }

    /**
     * Loads an array of DocBean from a template one.
     *
     * @param pObject the DocBean template to look for
     * @return all the DocBean matching the template
     */
    //88
    public DocBean[] loadUsingTemplate(DocBean pObject) throws SQLException
    {
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer where = new StringBuffer("");
        StringBuffer _sql = new StringBuffer("SELECT " + ALL_FIELDS + " from doc WHERE ");
        StringBuffer _sqlWhere = new StringBuffer("");
        try
        {
            int _dirtyCount = 0;
    
             if (pObject.isDocidModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("docid= ?");
             }
    
             if (pObject.isNameModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("name= ?");
             }
    
             if (pObject.isDescriptionModified()) {
                 _dirtyCount ++; 
                 _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("description= ?");
             }
    
             if (_dirtyCount == 0) {
                 throw new SQLException ("The pObject to look for is invalid : not initialized !");
             }
             _sql.append(_sqlWhere);
             c = getConnection();
             ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
             _dirtyCount = 0;
    
             if (pObject.isDocidModified()) {
                 Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
             }
    
             if (pObject.isNameModified()) {
                 ps.setString(++_dirtyCount, pObject.getName());
             }
    
             if (pObject.isDescriptionModified()) {
                 ps.setString(++_dirtyCount, pObject.getDescription());
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
     * Deletes rows using a DocBean template.
     *
     * @param pObject the DocBean object(s) to be deleted
     * @return the number of deleted objects
     */
    //63
    public int deleteUsingTemplate(DocBean pObject) throws SQLException
    {
        if (pObject.isDocidInitialized())
            return deleteByPrimaryKey(pObject.getDocid());
    
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer sql = null;
    
        try 
        {
            sql = new StringBuffer("DELETE FROM doc WHERE ");
            int _dirtyAnd = 0;
            if (pObject.isDocidInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("docid").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isNameInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("name").append("=?");
                _dirtyAnd ++;
            }
    
            if (pObject.isDescriptionInitialized()) {
                if (_dirtyAnd > 0)
                    sql.append(" AND ");
                sql.append("description").append("=?");
                _dirtyAnd ++;
            }
    
            c = getConnection();
            ps = c.prepareStatement(sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            int _dirtyCount = 0;
    
            if (pObject.isDocidInitialized()) {
                Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
            }
    
            if (pObject.isNameInitialized()) {
                ps.setString(++_dirtyCount, pObject.getName());
            }
    
            if (pObject.isDescriptionInitialized()) {
                ps.setString(++_dirtyCount, pObject.getDescription());
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
    // MANY TO MANY: LOAD OTHER BEAN VIA JUNCTION TABLE 
    ///////////////////////////////////////////////////////////////////////
    /**
     * Retrieves an array of InstitutionBean using the relation table Institutiondoc given a DocBean object.
     *
     * @param pObject the DocBean pObject to be used
     * @return an array of InstitutionBean 
     */
    // MANY TO MANY
    public InstitutionBean[] loadInstitutionViaInstitutiondoc(DocBean pObject) throws SQLException
    {
         Connection c = null;
         PreparedStatement ps = null;
         String strSQL =      " SELECT "
                         + "        *"
                         + " FROM  "
                         + "        institution,institutiondoc"
                         + " WHERE "    
                         + "     institutiondoc.docid = ?"
                         + " AND institutiondoc.institutionid = institution.institutionid";
         try
         {
             c = getConnection();
             ps = c.prepareStatement(strSQL,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
             Manager.setInteger(ps, 1, pObject.getDocid());
             return InstitutionManager.getInstance().loadByPreparedStatement(ps);
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
     * Retrieves the number of rows of the table doc.
     *
     * @return the number of rows returned
     */
    //78
    public int countAll() throws SQLException
    {
        return countWhere("");
    }



    /**
     * Retrieves the number of rows of the table doc with a 'where' clause.
     * It is up to you to pass the 'WHERE' in your where clausis.
     *
     * @param where the restriction clause
     * @return the number of rows returned
     */
    public int countWhere(String where) throws SQLException
    {
        String sql = "select count(*) as MCOUNT from doc " + where;
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
     * Retrieves the number of rows of the table doc with a prepared statement.
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
     * Looks for the number of elements of a specific DocBean pObject given a c
     *
     * @param pObject the DocBean pObject to look for
     * @return the number of rows returned
     */
    //83
    public int countUsingTemplate(DocBean pObject) throws SQLException
    {
        StringBuffer where = new StringBuffer("");
        Connection c = null;
        PreparedStatement ps = null;
        StringBuffer _sql = null;
        StringBuffer _sqlWhere = null;
    
        try
        {
                _sql = new StringBuffer("SELECT count(*) as MCOUNT  from doc WHERE ");
                _sqlWhere = new StringBuffer("");
                int _dirtyCount = 0;
    
                if (pObject.isDocidModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("docid= ?");
                }
    
                if (pObject.isNameModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("name= ?");
                }
    
                if (pObject.isDescriptionModified()) {
                    _dirtyCount++; 
                    _sqlWhere.append((_sqlWhere.length() == 0) ? " " : " AND ").append("description= ?");
                }
    
                if (_dirtyCount == 0)
                   throw new SQLException ("The pObject to look is unvalid : not initialized !");
    
                _sql.append(_sqlWhere);
                c = getConnection();
                ps = c.prepareStatement(_sql.toString(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    
                _dirtyCount = 0;
    
                if (pObject.isDocidModified()) {
                    Manager.setInteger(ps, ++_dirtyCount, pObject.getDocid());
                }
    
                if (pObject.isNameModified()) {
                    ps.setString(++_dirtyCount, pObject.getName());
                }
    
                if (pObject.isDescriptionModified()) {
                    ps.setString(++_dirtyCount, pObject.getDescription());
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
     * Transforms a ResultSet iterating on the doc on a DocBean pObject.
     *
     * @param rs the ResultSet to be transformed
     * @return pObject resulting DocBean pObject
     */
    //72
    public DocBean decodeRow(ResultSet rs) throws SQLException
    {
        DocBean pObject = createDocBean();
        pObject.setDocid(Manager.getInteger(rs, 1));
        pObject.setName(rs.getString(2));
        pObject.setDescription(rs.getString(3));

        pObject.isNew(false);
        pObject.resetIsModified();

        return pObject;
    }

    /**
     * Transforms a ResultSet iterating on the doc table on a DocBean pObject according to a list of fields.
     *
     * @param rs the ResultSet to be transformed
     * @param fieldList table of the field's associated constants
     * @return pObject resulting DocBean pObject
     */
    //73
    public DocBean decodeRow(ResultSet rs, int[] fieldList) throws SQLException
    {
        DocBean pObject = createDocBean();
        int pos = 0;
        for(int i = 0; i < fieldList.length; i++)
        {
            switch(fieldList[i]) {
                case ID_DOCID:
                    ++pos;
                    pObject.setDocid(Manager.getInteger(rs, pos));
                    break;
                case ID_NAME:
                    ++pos;
                    pObject.setName(rs.getString(pos));
                    break;
                case ID_DESCRIPTION:
                    ++pos;
                    pObject.setDescription(rs.getString(pos));
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
     * @return an array of DocBean 
     */
    //41
    public DocBean[] loadByPreparedStatement(PreparedStatement ps) throws SQLException
    {
        return loadByPreparedStatement(ps, null);
    }

    /**
     * Loads all the elements using a prepared statement specifying a list of fields to be retrieved.
     *
     * @param ps the PreparedStatement to be used
     * @param fieldList table of the field's associated constants
     * @return an array of DocBean 
     */
    public DocBean[] loadByPreparedStatement(PreparedStatement ps, int[] fieldList) throws SQLException
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
            return (DocBean[])v.toArray(new DocBean[0]);
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
    private DocListener listener = null;

    /**
     * Registers a unique DocListener listener.
     */
    //66.5
    public void registerListener(DocListener listener) {
        this.listener = listener;
    }

    /**
     * Before the save of the DocBean pObject.
     *
     * @param pObject the DocBean pObject to be saved
     */
    //67
    void beforeInsert(DocBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeInsert(pObject);
    }

    /**
     * After the save of the DocBean pObject.
     *
     * @param pObject the DocBean pObject to be saved
     */
    //68
    void afterInsert(DocBean pObject) throws SQLException {
        if (listener != null)
            listener.afterInsert(pObject);
    }

    /**
     * Before the update of the DocBean pObject.
     *
     * @param pObject the DocBean pObject to be updated
     */
    //69
    void beforeUpdate(DocBean pObject) throws SQLException {
        if (listener != null)
            listener.beforeUpdate(pObject);
    }

    /**
     * After the update of the DocBean pObject.
     *
     * @param pObject the DocBean pObject to be updated
     */
    //70
    void afterUpdate(DocBean pObject) throws SQLException {
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
