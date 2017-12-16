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
 * Comparator class is used to sort the DoctypeBean objects.
 */
public class DoctypeComparator implements Comparator
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
     * Constructor class for DoctypeComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DoctypeComparator(DoctypeManager.DOCTYPEID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DoctypeManager.ID_DOCTYPEID
     *   <li>DoctypeManager.ID_NAME
     * </ul>
     */
    public DoctypeComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for DoctypeComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DoctypeComparator(DoctypeManager.DOCTYPEID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DoctypeManager.ID_DOCTYPEID
     *   <li>DoctypeManager.ID_NAME
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public DoctypeComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        DoctypeBean b1 = (DoctypeBean)pObj1;
        DoctypeBean b2 = (DoctypeBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case DoctypeManager.ID_DOCTYPEID:
                if (b1.getDoctypeid() == null && b2.getDoctypeid() != null) {
                    iReturn = -1;
                } else if (b1.getDoctypeid() == null && b2.getDoctypeid() == null) {
                    iReturn = 0;
                } else if (b1.getDoctypeid() != null && b2.getDoctypeid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getDoctypeid().compareTo(b2.getDoctypeid());
                }
                break;
            case DoctypeManager.ID_NAME:
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
            default: 
                throw new IllegalArgumentException("Type passed for the field is not supported");
        }

        return bReverse ? (-1 * iReturn) : iReturn;
    }
// class+ 

// class- 
}