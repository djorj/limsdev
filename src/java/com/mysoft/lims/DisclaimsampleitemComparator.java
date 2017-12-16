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
 * Comparator class is used to sort the DisclaimsampleitemBean objects.
 */
public class DisclaimsampleitemComparator implements Comparator
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
     * Constructor class for DisclaimsampleitemComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DisclaimsampleitemComparator(DisclaimsampleitemManager.DISCLAIMSAMPLEITEMID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DisclaimsampleitemManager.ID_DISCLAIMSAMPLEITEMID
     *   <li>DisclaimsampleitemManager.ID_CONTRACTSAMPLEITEMID
     *   <li>DisclaimsampleitemManager.ID_REASON
     *   <li>DisclaimsampleitemManager.ID_REGBYID
     *   <li>DisclaimsampleitemManager.ID_REGDATE
     * </ul>
     */
    public DisclaimsampleitemComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for DisclaimsampleitemComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DisclaimsampleitemComparator(DisclaimsampleitemManager.DISCLAIMSAMPLEITEMID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DisclaimsampleitemManager.ID_DISCLAIMSAMPLEITEMID
     *   <li>DisclaimsampleitemManager.ID_CONTRACTSAMPLEITEMID
     *   <li>DisclaimsampleitemManager.ID_REASON
     *   <li>DisclaimsampleitemManager.ID_REGBYID
     *   <li>DisclaimsampleitemManager.ID_REGDATE
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public DisclaimsampleitemComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        DisclaimsampleitemBean b1 = (DisclaimsampleitemBean)pObj1;
        DisclaimsampleitemBean b2 = (DisclaimsampleitemBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case DisclaimsampleitemManager.ID_DISCLAIMSAMPLEITEMID:
                if (b1.getDisclaimsampleitemid() == null && b2.getDisclaimsampleitemid() != null) {
                    iReturn = -1;
                } else if (b1.getDisclaimsampleitemid() == null && b2.getDisclaimsampleitemid() == null) {
                    iReturn = 0;
                } else if (b1.getDisclaimsampleitemid() != null && b2.getDisclaimsampleitemid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getDisclaimsampleitemid().compareTo(b2.getDisclaimsampleitemid());
                }
                break;
            case DisclaimsampleitemManager.ID_CONTRACTSAMPLEITEMID:
                if (b1.getContractsampleitemid() == null && b2.getContractsampleitemid() != null) {
                    iReturn = -1;
                } else if (b1.getContractsampleitemid() == null && b2.getContractsampleitemid() == null) {
                    iReturn = 0;
                } else if (b1.getContractsampleitemid() != null && b2.getContractsampleitemid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getContractsampleitemid().compareTo(b2.getContractsampleitemid());
                }
                break;
            case DisclaimsampleitemManager.ID_REASON:
                if (b1.getReason() == null && b2.getReason() != null) {
                    iReturn = -1;
                } else if (b1.getReason() == null && b2.getReason() == null) {
                    iReturn = 0;
                } else if (b1.getReason() != null && b2.getReason() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getReason().compareTo(b2.getReason());
                }
                break;
            case DisclaimsampleitemManager.ID_REGBYID:
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
            case DisclaimsampleitemManager.ID_REGDATE:
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
            default: 
                throw new IllegalArgumentException("Type passed for the field is not supported");
        }

        return bReverse ? (-1 * iReturn) : iReturn;
    }
// class+ 

// class- 
}
