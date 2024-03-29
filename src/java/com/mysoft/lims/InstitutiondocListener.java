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
 * Listener that is notified of institutiondoc table changes.
 */
public interface InstitutiondocListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a InstitutiondocBean record into the database.
     *
     * @param pObject the InstitutiondocBean that is about to be inserted
     */
    public void beforeInsert(InstitutiondocBean pObject) throws SQLException;


    /**
     * Invoked just after a InstitutiondocBean record is inserted in the database.
     *
     * @param pObject the InstitutiondocBean that was just inserted
     */
    public void afterInsert(InstitutiondocBean pObject) throws SQLException;


    /**
     * Invoked just before updating a InstitutiondocBean record in the database.
     *
     * @param pObject the InstitutiondocBean that is about to be updated
     */
    public void beforeUpdate(InstitutiondocBean pObject) throws SQLException;


    /**
     * Invoked just after updating a InstitutiondocBean record in the database.
     *
     * @param pObject the InstitutiondocBean that was just updated
     */
    public void afterUpdate(InstitutiondocBean pObject) throws SQLException;


// class+ 

// class- 
}
