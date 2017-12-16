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
 * Comparator class is used to sort the SamplestatusBean objects.
 */
public class SamplestatusComparator implements Comparator
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
     * Constructor class for SamplestatusComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new SamplestatusComparator(SamplestatusManager.SAMPLESTATUSID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>SamplestatusManager.ID_SAMPLESTATUSID
     *   <li>SamplestatusManager.ID_NAME
     *   <li>SamplestatusManager.ID_COMPANYID
     * </ul>
     */
    public SamplestatusComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for SamplestatusComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new SamplestatusComparator(SamplestatusManager.SAMPLESTATUSID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>SamplestatusManager.ID_SAMPLESTATUSID
     *   <li>SamplestatusManager.ID_NAME
     *   <li>SamplestatusManager.ID_COMPANYID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public SamplestatusComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        SamplestatusBean b1 = (SamplestatusBean)pObj1;
        SamplestatusBean b2 = (SamplestatusBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case SamplestatusManager.ID_SAMPLESTATUSID:
                if (b1.getSamplestatusid() == null && b2.getSamplestatusid() != null) {
                    iReturn = -1;
                } else if (b1.getSamplestatusid() == null && b2.getSamplestatusid() == null) {
                    iReturn = 0;
                } else if (b1.getSamplestatusid() != null && b2.getSamplestatusid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSamplestatusid().compareTo(b2.getSamplestatusid());
                }
                break;
            case SamplestatusManager.ID_NAME:
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
            case SamplestatusManager.ID_COMPANYID:
                if (b1.getCompanyid() == null && b2.getCompanyid() != null) {
                    iReturn = -1;
                } else if (b1.getCompanyid() == null && b2.getCompanyid() == null) {
                    iReturn = 0;
                } else if (b1.getCompanyid() != null && b2.getCompanyid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getCompanyid().compareTo(b2.getCompanyid());
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
