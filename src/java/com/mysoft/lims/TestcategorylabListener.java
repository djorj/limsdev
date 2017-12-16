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

import java.sql.SQLException;
// imports+ 

// imports- 


/**
 * Listener that is notified of testcategorylab table changes.
 */
public interface TestcategorylabListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a TestcategorylabBean record into the database.
     *
     * @param pObject the TestcategorylabBean that is about to be inserted
     */
    public void beforeInsert(TestcategorylabBean pObject) throws SQLException;


    /**
     * Invoked just after a TestcategorylabBean record is inserted in the database.
     *
     * @param pObject the TestcategorylabBean that was just inserted
     */
    public void afterInsert(TestcategorylabBean pObject) throws SQLException;


    /**
     * Invoked just before updating a TestcategorylabBean record in the database.
     *
     * @param pObject the TestcategorylabBean that is about to be updated
     */
    public void beforeUpdate(TestcategorylabBean pObject) throws SQLException;


    /**
     * Invoked just after updating a TestcategorylabBean record in the database.
     *
     * @param pObject the TestcategorylabBean that was just updated
     */
    public void afterUpdate(TestcategorylabBean pObject) throws SQLException;


// class+ 

// class- 
}
