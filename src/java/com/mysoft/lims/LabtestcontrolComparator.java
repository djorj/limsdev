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
 * Comparator class is used to sort the LabtestcontrolBean objects.
 */
public class LabtestcontrolComparator implements Comparator
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
     * Constructor class for LabtestcontrolComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new LabtestcontrolComparator(LabtestcontrolManager.LABTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>LabtestcontrolManager.ID_LABTESTID
     *   <li>LabtestcontrolManager.ID_CONTROLID
     *   <li>LabtestcontrolManager.ID_SCHEDULE
     * </ul>
     */
    public LabtestcontrolComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for LabtestcontrolComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new LabtestcontrolComparator(LabtestcontrolManager.LABTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>LabtestcontrolManager.ID_LABTESTID
     *   <li>LabtestcontrolManager.ID_CONTROLID
     *   <li>LabtestcontrolManager.ID_SCHEDULE
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public LabtestcontrolComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        LabtestcontrolBean b1 = (LabtestcontrolBean)pObj1;
        LabtestcontrolBean b2 = (LabtestcontrolBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case LabtestcontrolManager.ID_LABTESTID:
                if (b1.getLabtestid() == null && b2.getLabtestid() != null) {
                    iReturn = -1;
                } else if (b1.getLabtestid() == null && b2.getLabtestid() == null) {
                    iReturn = 0;
                } else if (b1.getLabtestid() != null && b2.getLabtestid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getLabtestid().compareTo(b2.getLabtestid());
                }
                break;
            case LabtestcontrolManager.ID_CONTROLID:
                if (b1.getControlid() == null && b2.getControlid() != null) {
                    iReturn = -1;
                } else if (b1.getControlid() == null && b2.getControlid() == null) {
                    iReturn = 0;
                } else if (b1.getControlid() != null && b2.getControlid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getControlid().compareTo(b2.getControlid());
                }
                break;
            case LabtestcontrolManager.ID_SCHEDULE:
                if (b1.getSchedule() == null && b2.getSchedule() != null) {
                    iReturn = -1;
                } else if (b1.getSchedule() == null && b2.getSchedule() == null) {
                    iReturn = 0;
                } else if (b1.getSchedule() != null && b2.getSchedule() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSchedule().compareTo(b2.getSchedule());
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
