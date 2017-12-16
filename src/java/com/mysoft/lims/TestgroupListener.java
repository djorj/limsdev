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
 * Listener that is notified of testgroup table changes.
 */
public interface TestgroupListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a TestgroupBean record into the database.
     *
     * @param pObject the TestgroupBean that is about to be inserted
     */
    public void beforeInsert(TestgroupBean pObject) throws SQLException;


    /**
     * Invoked just after a TestgroupBean record is inserted in the database.
     *
     * @param pObject the TestgroupBean that was just inserted
     */
    public void afterInsert(TestgroupBean pObject) throws SQLException;


    /**
     * Invoked just before updating a TestgroupBean record in the database.
     *
     * @param pObject the TestgroupBean that is about to be updated
     */
    public void beforeUpdate(TestgroupBean pObject) throws SQLException;


    /**
     * Invoked just after updating a TestgroupBean record in the database.
     *
     * @param pObject the TestgroupBean that was just updated
     */
    public void afterUpdate(TestgroupBean pObject) throws SQLException;


// class+ 

// class- 
}
