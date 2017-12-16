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
 * Listener that is notified of labtestcontroldocument table changes.
 */
public interface LabtestcontroldocumentListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a LabtestcontroldocumentBean record into the database.
     *
     * @param pObject the LabtestcontroldocumentBean that is about to be inserted
     */
    public void beforeInsert(LabtestcontroldocumentBean pObject) throws SQLException;


    /**
     * Invoked just after a LabtestcontroldocumentBean record is inserted in the database.
     *
     * @param pObject the LabtestcontroldocumentBean that was just inserted
     */
    public void afterInsert(LabtestcontroldocumentBean pObject) throws SQLException;


    /**
     * Invoked just before updating a LabtestcontroldocumentBean record in the database.
     *
     * @param pObject the LabtestcontroldocumentBean that is about to be updated
     */
    public void beforeUpdate(LabtestcontroldocumentBean pObject) throws SQLException;


    /**
     * Invoked just after updating a LabtestcontroldocumentBean record in the database.
     *
     * @param pObject the LabtestcontroldocumentBean that was just updated
     */
    public void afterUpdate(LabtestcontroldocumentBean pObject) throws SQLException;


// class+ 

// class- 
}
