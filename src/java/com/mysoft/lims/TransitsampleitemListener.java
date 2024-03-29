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
 * Listener that is notified of transitsampleitem table changes.
 */
public interface TransitsampleitemListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a TransitsampleitemBean record into the database.
     *
     * @param pObject the TransitsampleitemBean that is about to be inserted
     */
    public void beforeInsert(TransitsampleitemBean pObject) throws SQLException;


    /**
     * Invoked just after a TransitsampleitemBean record is inserted in the database.
     *
     * @param pObject the TransitsampleitemBean that was just inserted
     */
    public void afterInsert(TransitsampleitemBean pObject) throws SQLException;


    /**
     * Invoked just before updating a TransitsampleitemBean record in the database.
     *
     * @param pObject the TransitsampleitemBean that is about to be updated
     */
    public void beforeUpdate(TransitsampleitemBean pObject) throws SQLException;


    /**
     * Invoked just after updating a TransitsampleitemBean record in the database.
     *
     * @param pObject the TransitsampleitemBean that was just updated
     */
    public void afterUpdate(TransitsampleitemBean pObject) throws SQLException;


// class+ 

// class- 
}
