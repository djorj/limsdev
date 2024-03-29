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
 * Listener that is notified of certificate table changes.
 */
public interface CertificateListener
// extends+ 

// extends- 
{
    /**
     * Invoked just before inserting a CertificateBean record into the database.
     *
     * @param pObject the CertificateBean that is about to be inserted
     */
    public void beforeInsert(CertificateBean pObject) throws SQLException;


    /**
     * Invoked just after a CertificateBean record is inserted in the database.
     *
     * @param pObject the CertificateBean that was just inserted
     */
    public void afterInsert(CertificateBean pObject) throws SQLException;


    /**
     * Invoked just before updating a CertificateBean record in the database.
     *
     * @param pObject the CertificateBean that is about to be updated
     */
    public void beforeUpdate(CertificateBean pObject) throws SQLException;


    /**
     * Invoked just after updating a CertificateBean record in the database.
     *
     * @param pObject the CertificateBean that was just updated
     */
    public void afterUpdate(CertificateBean pObject) throws SQLException;


// class+ 

// class- 
}
