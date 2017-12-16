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
 * Listener that is notified of plevel table changes.
 */
public interface PlevelListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a PlevelBean record into the database.
     *
     * @param pObject the PlevelBean that is about to be inserted
     */
    public void beforeInsert(PlevelBean pObject) throws SQLException;


    /**
     * Invoked just after a PlevelBean record is inserted in the database.
     *
     * @param pObject the PlevelBean that was just inserted
     */
    public void afterInsert(PlevelBean pObject) throws SQLException;


    /**
     * Invoked just before updating a PlevelBean record in the database.
     *
     * @param pObject the PlevelBean that is about to be updated
     */
    public void beforeUpdate(PlevelBean pObject) throws SQLException;


    /**
     * Invoked just after updating a PlevelBean record in the database.
     *
     * @param pObject the PlevelBean that was just updated
     */
    public void afterUpdate(PlevelBean pObject) throws SQLException;


// class+ 

// class- 
}
