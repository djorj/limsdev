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
 * Comparator class is used to sort the SampleitemtestBean objects.
 */
public class SampleitemtestComparator implements Comparator
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
     * Constructor class for SampleitemtestComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new SampleitemtestComparator(SampleitemtestManager.SAMPLEITEMTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>SampleitemtestManager.ID_SAMPLEITEMTESTID
     *   <li>SampleitemtestManager.ID_CONTRACTSAMPLEITEMID
     *   <li>SampleitemtestManager.ID_CONTRACTID
     *   <li>SampleitemtestManager.ID_LABTESTID
     *   <li>SampleitemtestManager.ID_INSTITUTIONID
     *   <li>SampleitemtestManager.ID_PRICE
     *   <li>SampleitemtestManager.ID_ENDDAYS
     *   <li>SampleitemtestManager.ID_REGBYID
     *   <li>SampleitemtestManager.ID_REGDATE
     * </ul>
     */
    public SampleitemtestComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for SampleitemtestComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new SampleitemtestComparator(SampleitemtestManager.SAMPLEITEMTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>SampleitemtestManager.ID_SAMPLEITEMTESTID
     *   <li>SampleitemtestManager.ID_CONTRACTSAMPLEITEMID
     *   <li>SampleitemtestManager.ID_CONTRACTID
     *   <li>SampleitemtestManager.ID_LABTESTID
     *   <li>SampleitemtestManager.ID_INSTITUTIONID
     *   <li>SampleitemtestManager.ID_PRICE
     *   <li>SampleitemtestManager.ID_ENDDAYS
     *   <li>SampleitemtestManager.ID_REGBYID
     *   <li>SampleitemtestManager.ID_REGDATE
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public SampleitemtestComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        SampleitemtestBean b1 = (SampleitemtestBean)pObj1;
        SampleitemtestBean b2 = (SampleitemtestBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case SampleitemtestManager.ID_SAMPLEITEMTESTID:
                if (b1.getSampleitemtestid() == null && b2.getSampleitemtestid() != null) {
                    iReturn = -1;
                } else if (b1.getSampleitemtestid() == null && b2.getSampleitemtestid() == null) {
                    iReturn = 0;
                } else if (b1.getSampleitemtestid() != null && b2.getSampleitemtestid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSampleitemtestid().compareTo(b2.getSampleitemtestid());
                }
                break;
            case SampleitemtestManager.ID_CONTRACTSAMPLEITEMID:
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
            case SampleitemtestManager.ID_CONTRACTID:
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
            case SampleitemtestManager.ID_LABTESTID:
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
            case SampleitemtestManager.ID_INSTITUTIONID:
                if (b1.getInstitutionid() == null && b2.getInstitutionid() != null) {
                    iReturn = -1;
                } else if (b1.getInstitutionid() == null && b2.getInstitutionid() == null) {
                    iReturn = 0;
                } else if (b1.getInstitutionid() != null && b2.getInstitutionid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getInstitutionid().compareTo(b2.getInstitutionid());
                }
                break;
            case SampleitemtestManager.ID_PRICE:
                if (b1.getPrice() == null && b2.getPrice() != null) {
                    iReturn = -1;
                } else if (b1.getPrice() == null && b2.getPrice() == null) {
                    iReturn = 0;
                } else if (b1.getPrice() != null && b2.getPrice() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPrice().compareTo(b2.getPrice());
                }
                break;
            case SampleitemtestManager.ID_ENDDAYS:
                if (b1.getEnddays() == null && b2.getEnddays() != null) {
                    iReturn = -1;
                } else if (b1.getEnddays() == null && b2.getEnddays() == null) {
                    iReturn = 0;
                } else if (b1.getEnddays() != null && b2.getEnddays() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getEnddays().compareTo(b2.getEnddays());
                }
                break;
            case SampleitemtestManager.ID_REGBYID:
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
            case SampleitemtestManager.ID_REGDATE:
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
