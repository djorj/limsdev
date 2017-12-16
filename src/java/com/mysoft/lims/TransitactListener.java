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
 * Listener that is notified of transitact table changes.
 */
public interface TransitactListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a TransitactBean record into the database.
     *
     * @param pObject the TransitactBean that is about to be inserted
     */
    public void beforeInsert(TransitactBean pObject) throws SQLException;


    /**
     * Invoked just after a TransitactBean record is inserted in the database.
     *
     * @param pObject the TransitactBean that was just inserted
     */
    public void afterInsert(TransitactBean pObject) throws SQLException;


    /**
     * Invoked just before updating a TransitactBean record in the database.
     *
     * @param pObject the TransitactBean that is about to be updated
     */
    public void beforeUpdate(TransitactBean pObject) throws SQLException;


    /**
     * Invoked just after updating a TransitactBean record in the database.
     *
     * @param pObject the TransitactBean that was just updated
     */
    public void afterUpdate(TransitactBean pObject) throws SQLException;


// class+ 

// class- 
}
