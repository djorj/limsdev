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

import java.util.Comparator;
// imports+ 

// imports- 

/**
 * Comparator class is used to sort the TransitactBean objects.
 */
public class TransitactComparator implements Comparator
// extends+ 

// extends- 
{
    /**
     * Holds the field on which the comparison is performed.
     */
    private int iType;
    /**
     * Value that will contain the information about the order of the sort: normal or reversal.
     */
    private boolean bReverse;

    /**
     * Constructor class for TransitactComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new TransitactComparator(TransitactManager.TRANSITACTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>TransitactManager.ID_TRANSITACTID
     *   <li>TransitactManager.ID_FROMLOCATIONID
     *   <li>TransitactManager.ID_TOLOCATIONID
     *   <li>TransitactManager.ID_SENDDATE
     *   <li>TransitactManager.ID_RESPONSIBLE
     *   <li>TransitactManager.ID_SENDREASON
     *   <li>TransitactManager.ID_AMOUNT
     *   <li>TransitactManager.ID_VOLUME
     *   <li>TransitactManager.ID_SENDCONDITION
     *   <li>TransitactManager.ID_REGBYID
     *   <li>TransitactManager.ID_REGDATE
     *   <li>TransitactManager.ID_GETBYID
     *   <li>TransitactManager.ID_GETDATE
     *   <li>TransitactManager.ID_CONTRACTID
     *   <li>TransitactManager.ID_APPEALID
     *   <li>TransitactManager.ID_ACTID
     * </ul>
     */
    public TransitactComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for TransitactComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new TransitactComparator(TransitactManager.TRANSITACTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>TransitactManager.ID_TRANSITACTID
     *   <li>TransitactManager.ID_FROMLOCATIONID
     *   <li>TransitactManager.ID_TOLOCATIONID
     *   <li>TransitactManager.ID_SENDDATE
     *   <li>TransitactManager.ID_RESPONSIBLE
     *   <li>TransitactManager.ID_SENDREASON
     *   <li>TransitactManager.ID_AMOUNT
     *   <li>TransitactManager.ID_VOLUME
     *   <li>TransitactManager.ID_SENDCONDITION
     *   <li>TransitactManager.ID_REGBYID
     *   <li>TransitactManager.ID_REGDATE
     *   <li>TransitactManager.ID_GETBYID
     *   <li>TransitactManager.ID_GETDATE
     *   <li>TransitactManager.ID_CONTRACTID
     *   <li>TransitactManager.ID_APPEALID
     *   <li>TransitactManager.ID_ACTID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public TransitactComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        TransitactBean b1 = (TransitactBean)pObj1;
        TransitactBean b2 = (TransitactBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case TransitactManager.ID_TRANSITACTID:
                if (b1.getTransitactid() == null && b2.getTransitactid() != null) {
                    iReturn = -1;
                } else if (b1.getTransitactid() == null && b2.getTransitactid() == null) {
                    iReturn = 0;
                } else if (b1.getTransitactid() != null && b2.getTransitactid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getTransitactid().compareTo(b2.getTransitactid());
                }
                break;
            case TransitactManager.ID_FROMLOCATIONID:
                if (b1.getFromlocationid() == null && b2.getFromlocationid() != null) {
                    iReturn = -1;
                } else if (b1.getFromlocationid() == null && b2.getFromlocationid() == null) {
                    iReturn = 0;
                } else if (b1.getFromlocationid() != null && b2.getFromlocationid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getFromlocationid().compareTo(b2.getFromlocationid());
                }
                break;
            case TransitactManager.ID_TOLOCATIONID:
                if (b1.getTolocationid() == null && b2.getTolocationid() != null) {
                    iReturn = -1;
                } else if (b1.getTolocationid() == null && b2.getTolocationid() == null) {
                    iReturn = 0;
                } else if (b1.getTolocationid() != null && b2.getTolocationid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getTolocationid().compareTo(b2.getTolocationid());
                }
                break;
            case TransitactManager.ID_SENDDATE:
                if (b1.getSenddate() == null && b2.getSenddate() != null) {
                    iReturn = -1;
                } else if (b1.getSenddate() == null && b2.getSenddate() == null) {
                    iReturn = 0;
                } else if (b1.getSenddate() != null && b2.getSenddate() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSenddate().compareTo(b2.getSenddate());
                }
                break;
            case TransitactManager.ID_RESPONSIBLE:
                if (b1.getResponsible() == null && b2.getResponsible() != null) {
                    iReturn = -1;
                } else if (b1.getResponsible() == null && b2.getResponsible() == null) {
                    iReturn = 0;
                } else if (b1.getResponsible() != null && b2.getResponsible() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getResponsible().compareTo(b2.getResponsible());
                }
                break;
            case TransitactManager.ID_SENDREASON:
                if (b1.getSendreason() == null && b2.getSendreason() != null) {
                    iReturn = -1;
                } else if (b1.getSendreason() == null && b2.getSendreason() == null) {
                    iReturn = 0;
                } else if (b1.getSendreason() != null && b2.getSendreason() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSendreason().compareTo(b2.getSendreason());
                }
                break;
            case TransitactManager.ID_AMOUNT:
                if (b1.getAmount() == null && b2.getAmount() != null) {
                    iReturn = -1;
                } else if (b1.getAmount() == null && b2.getAmount() == null) {
                    iReturn = 0;
                } else if (b1.getAmount() != null && b2.getAmount() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getAmount().compareTo(b2.getAmount());
                }
                break;
            case TransitactManager.ID_VOLUME:
                if (b1.getVolume() == null && b2.getVolume() != null) {
                    iReturn = -1;
                } else if (b1.getVolume() == null && b2.getVolume() == null) {
                    iReturn = 0;
                } else if (b1.getVolume() != null && b2.getVolume() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getVolume().compareTo(b2.getVolume());
                }
                break;
            case TransitactManager.ID_SENDCONDITION:
                if (b1.getSendcondition() == null && b2.getSendcondition() != null) {
                    iReturn = -1;
                } else if (b1.getSendcondition() == null && b2.getSendcondition() == null) {
                    iReturn = 0;
                } else if (b1.getSendcondition() != null && b2.getSendcondition() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSendcondition().compareTo(b2.getSendcondition());
                }
                break;
            case TransitactManager.ID_REGBYID:
                if (b1.getRegbyid() == null && b2.getRegbyid() != null) {
                    iReturn = -1;
                } else if (b1.getRegbyid() == null && b2.getRegbyid() == null) {
                    iReturn = 0;
                } else if (b1.getRegbyid() != null && b2.getRegbyid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getRegbyid().compareTo(b2.getRegbyid());
                }
                break;
            case TransitactManager.ID_REGDATE:
                if (b1.getRegdate() == null && b2.getRegdate() != null) {
                    iReturn = -1;
                } else if (b1.getRegdate() == null && b2.getRegdate() == null) {
                    iReturn = 0;
                } else if (b1.getRegdate() != null && b2.getRegdate() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getRegdate().compareTo(b2.getRegdate());
                }
                break;
            case TransitactManager.ID_GETBYID:
                if (b1.getGetbyid() == null && b2.getGetbyid() != null) {
                    iReturn = -1;
                } else if (b1.getGetbyid() == null && b2.getGetbyid() == null) {
                    iReturn = 0;
                } else if (b1.getGetbyid() != null && b2.getGetbyid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getGetbyid().compareTo(b2.getGetbyid());
                }
                break;
            case TransitactManager.ID_GETDATE:
                if (b1.getGetdate() == null && b2.getGetdate() != null) {
                    iReturn = -1;
                } else if (b1.getGetdate() == null && b2.getGetdate() == null) {
                    iReturn = 0;
                } else if (b1.getGetdate() != null && b2.getGetdate() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getGetdate().compareTo(b2.getGetdate());
                }
                break;
            case TransitactManager.ID_CONTRACTID:
                if (b1.getContractid() == null && b2.getContractid() != null) {
                    iReturn = -1;
                } else if (b1.getContractid() == null && b2.getContractid() == null) {
                    iReturn = 0;
                } else if (b1.getContractid() != null && b2.getContractid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getContractid().compareTo(b2.getContractid());
                }
                break;
            case TransitactManager.ID_APPEALID:
                if (b1.getAppealid() == null && b2.getAppealid() != null) {
                    iReturn = -1;
                } else if (b1.getAppealid() == null && b2.getAppealid() == null) {
                    iReturn = 0;
                } else if (b1.getAppealid() != null && b2.getAppealid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getAppealid().compareTo(b2.getAppealid());
                }
                break;
            case TransitactManager.ID_ACTID:
                if (b1.getActid() == null && b2.getActid() != null) {
                    iReturn = -1;
                } else if (b1.getActid() == null && b2.getActid() == null) {
                    iReturn = 0;
                } else if (b1.getActid() != null && b2.getActid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getActid().compareTo(b2.getActid());
                }
                break;
            default: 
                throw new IllegalArgumentException("Type passed for the field is not supported");
        }

        return bReverse ? (-1 * iReturn) : iReturn;
    }
// class+ 

// class- 
}
