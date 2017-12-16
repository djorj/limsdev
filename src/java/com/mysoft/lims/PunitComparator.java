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
 * Comparator class is used to sort the PunitBean objects.
 */
public class PunitComparator implements Comparator
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
     * Constructor class for PunitComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new PunitComparator(PunitManager.PUNITID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>PunitManager.ID_PUNITID
     *   <li>PunitManager.ID_NAME
     *   <li>PunitManager.ID_FULLNAME
     * </ul>
     */
    public PunitComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for PunitComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new PunitComparator(PunitManager.PUNITID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>PunitManager.ID_PUNITID
     *   <li>PunitManager.ID_NAME
     *   <li>PunitManager.ID_FULLNAME
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public PunitComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        PunitBean b1 = (PunitBean)pObj1;
        PunitBean b2 = (PunitBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case PunitManager.ID_PUNITID:
                if (b1.getPunitid() == null && b2.getPunitid() != null) {
                    iReturn = -1;
                } else if (b1.getPunitid() == null && b2.getPunitid() == null) {
                    iReturn = 0;
                } else if (b1.getPunitid() != null && b2.getPunitid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPunitid().compareTo(b2.getPunitid());
                }
                break;
            case PunitManager.ID_NAME:
                if (b1.getName() == null && b2.getName() != null) {
                    iReturn = -1;
                } else if (b1.getName() == null && b2.getName() == null) {
                    iReturn = 0;
                } else if (b1.getName() != null && b2.getName() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getName().compareTo(b2.getName());
                }
                break;
            case PunitManager.ID_FULLNAME:
                if (b1.getFullname() == null && b2.getFullname() != null) {
                    iReturn = -1;
                } else if (b1.getFullname() == null && b2.getFullname() == null) {
                    iReturn = 0;
                } else if (b1.getFullname() != null && b2.getFullname() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getFullname().compareTo(b2.getFullname());
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
