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
 * Listener that is notified of tunit table changes.
 */
public interface TunitListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a TunitBean record into the database.
     *
     * @param pObject the TunitBean that is about to be inserted
     */
    public void beforeInsert(TunitBean pObject) throws SQLException;


    /**
     * Invoked just after a TunitBean record is inserted in the database.
     *
     * @param pObject the TunitBean that was just inserted
     */
    public void afterInsert(TunitBean pObject) throws SQLException;


    /**
     * Invoked just before updating a TunitBean record in the database.
     *
     * @param pObject the TunitBean that is about to be updated
     */
    public void beforeUpdate(TunitBean pObject) throws SQLException;


    /**
     * Invoked just after updating a TunitBean record in the database.
     *
     * @param pObject the TunitBean that was just updated
     */
    public void afterUpdate(TunitBean pObject) throws SQLException;


// class+ 

// class- 
}
