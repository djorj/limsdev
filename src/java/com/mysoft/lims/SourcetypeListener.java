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
 * Listener that is notified of sourcetype table changes.
 */
public interface SourcetypeListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a SourcetypeBean record into the database.
     *
     * @param pObject the SourcetypeBean that is about to be inserted
     */
    public void beforeInsert(SourcetypeBean pObject) throws SQLException;


    /**
     * Invoked just after a SourcetypeBean record is inserted in the database.
     *
     * @param pObject the SourcetypeBean that was just inserted
     */
    public void afterInsert(SourcetypeBean pObject) throws SQLException;


    /**
     * Invoked just before updating a SourcetypeBean record in the database.
     *
     * @param pObject the SourcetypeBean that is about to be updated
     */
    public void beforeUpdate(SourcetypeBean pObject) throws SQLException;


    /**
     * Invoked just after updating a SourcetypeBean record in the database.
     *
     * @param pObject the SourcetypeBean that was just updated
     */
    public void afterUpdate(SourcetypeBean pObject) throws SQLException;


// class+ 

// class- 
}
