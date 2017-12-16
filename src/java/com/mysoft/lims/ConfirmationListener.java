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
 * Listener that is notified of confirmation table changes.
 */
public interface ConfirmationListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a ConfirmationBean record into the database.
     *
     * @param pObject the ConfirmationBean that is about to be inserted
     */
    public void beforeInsert(ConfirmationBean pObject) throws SQLException;


    /**
     * Invoked just after a ConfirmationBean record is inserted in the database.
     *
     * @param pObject the ConfirmationBean that was just inserted
     */
    public void afterInsert(ConfirmationBean pObject) throws SQLException;


    /**
     * Invoked just before updating a ConfirmationBean record in the database.
     *
     * @param pObject the ConfirmationBean that is about to be updated
     */
    public void beforeUpdate(ConfirmationBean pObject) throws SQLException;


    /**
     * Invoked just after updating a ConfirmationBean record in the database.
     *
     * @param pObject the ConfirmationBean that was just updated
     */
    public void afterUpdate(ConfirmationBean pObject) throws SQLException;


// class+ 

// class- 
}
