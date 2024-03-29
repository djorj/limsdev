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
 * Listener that is notified of contractclosing table changes.
 */
public interface ContractclosingListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a ContractclosingBean record into the database.
     *
     * @param pObject the ContractclosingBean that is about to be inserted
     */
    public void beforeInsert(ContractclosingBean pObject) throws SQLException;


    /**
     * Invoked just after a ContractclosingBean record is inserted in the database.
     *
     * @param pObject the ContractclosingBean that was just inserted
     */
    public void afterInsert(ContractclosingBean pObject) throws SQLException;


    /**
     * Invoked just before updating a ContractclosingBean record in the database.
     *
     * @param pObject the ContractclosingBean that is about to be updated
     */
    public void beforeUpdate(ContractclosingBean pObject) throws SQLException;


    /**
     * Invoked just after updating a ContractclosingBean record in the database.
     *
     * @param pObject the ContractclosingBean that was just updated
     */
    public void afterUpdate(ContractclosingBean pObject) throws SQLException;


// class+ 

// class- 
}
