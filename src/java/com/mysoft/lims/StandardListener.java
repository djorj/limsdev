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
 * Listener that is notified of standard table changes.
 */
public interface StandardListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a StandardBean record into the database.
     *
     * @param pObject the StandardBean that is about to be inserted
     */
    public void beforeInsert(StandardBean pObject) throws SQLException;


    /**
     * Invoked just after a StandardBean record is inserted in the database.
     *
     * @param pObject the StandardBean that was just inserted
     */
    public void afterInsert(StandardBean pObject) throws SQLException;


    /**
     * Invoked just before updating a StandardBean record in the database.
     *
     * @param pObject the StandardBean that is about to be updated
     */
    public void beforeUpdate(StandardBean pObject) throws SQLException;


    /**
     * Invoked just after updating a StandardBean record in the database.
     *
     * @param pObject the StandardBean that was just updated
     */
    public void afterUpdate(StandardBean pObject) throws SQLException;


// class+ 

// class- 
}
