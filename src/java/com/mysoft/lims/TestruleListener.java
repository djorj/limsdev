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
 * Listener that is notified of testrule table changes.
 */
public interface TestruleListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a TestruleBean record into the database.
     *
     * @param pObject the TestruleBean that is about to be inserted
     */
    public void beforeInsert(TestruleBean pObject) throws SQLException;


    /**
     * Invoked just after a TestruleBean record is inserted in the database.
     *
     * @param pObject the TestruleBean that was just inserted
     */
    public void afterInsert(TestruleBean pObject) throws SQLException;


    /**
     * Invoked just before updating a TestruleBean record in the database.
     *
     * @param pObject the TestruleBean that is about to be updated
     */
    public void beforeUpdate(TestruleBean pObject) throws SQLException;


    /**
     * Invoked just after updating a TestruleBean record in the database.
     *
     * @param pObject the TestruleBean that was just updated
     */
    public void afterUpdate(TestruleBean pObject) throws SQLException;


// class+ 

// class- 
}