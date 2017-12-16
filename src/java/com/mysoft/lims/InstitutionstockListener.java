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
 * Listener that is notified of institutionstock table changes.
 */
public interface InstitutionstockListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a InstitutionstockBean record into the database.
     *
     * @param pObject the InstitutionstockBean that is about to be inserted
     */
    public void beforeInsert(InstitutionstockBean pObject) throws SQLException;


    /**
     * Invoked just after a InstitutionstockBean record is inserted in the database.
     *
     * @param pObject the InstitutionstockBean that was just inserted
     */
    public void afterInsert(InstitutionstockBean pObject) throws SQLException;


    /**
     * Invoked just before updating a InstitutionstockBean record in the database.
     *
     * @param pObject the InstitutionstockBean that is about to be updated
     */
    public void beforeUpdate(InstitutionstockBean pObject) throws SQLException;


    /**
     * Invoked just after updating a InstitutionstockBean record in the database.
     *
     * @param pObject the InstitutionstockBean that was just updated
     */
    public void afterUpdate(InstitutionstockBean pObject) throws SQLException;


// class+ 

// class- 
}
