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
 * Comparator class is used to sort the SampleboxreseachBean objects.
 */
public class SampleboxreseachComparator implements Comparator
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
     * Constructor class for SampleboxreseachComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new SampleboxreseachComparator(SampleboxreseachManager.SAMPLEBOXRESEACHID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>SampleboxreseachManager.ID_SAMPLEBOXRESEACHID
     *   <li>SampleboxreseachManager.ID_CONTRACTSAMPLETYPEID
     *   <li>SampleboxreseachManager.ID_LABTESTID
     *   <li>SampleboxreseachManager.ID_REGBYID
     *   <li>SampleboxreseachManager.ID_REGDATE
     *   <li>SampleboxreseachManager.ID_TOTALSUBTEST
     *   <li>SampleboxreseachManager.ID_PARENTTEST
     *   <li>SampleboxreseachManager.ID_INSTITUTIONID
     *   <li>SampleboxreseachManager.ID_PRICE
     *   <li>SampleboxreseachManager.ID_DAYNUM
     * </ul>
     */
    public SampleboxreseachComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for SampleboxreseachComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new SampleboxreseachComparator(SampleboxreseachManager.SAMPLEBOXRESEACHID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>SampleboxreseachManager.ID_SAMPLEBOXRESEACHID
     *   <li>SampleboxreseachManager.ID_CONTRACTSAMPLETYPEID
     *   <li>SampleboxreseachManager.ID_LABTESTID
     *   <li>SampleboxreseachManager.ID_REGBYID
     *   <li>SampleboxreseachManager.ID_REGDATE
     *   <li>SampleboxreseachManager.ID_DELETED
     *   <li>SampleboxreseachManager.ID_TOTALSUBTEST
     *   <li>SampleboxreseachManager.ID_PARENTTEST
     *   <li>SampleboxreseachManager.ID_INSTITUTIONID
     *   <li>SampleboxreseachManager.ID_PRICE
     *   <li>SampleboxreseachManager.ID_DAYNUM
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public SampleboxreseachComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        SampleboxreseachBean b1 = (SampleboxreseachBean)pObj1;
        SampleboxreseachBean b2 = (SampleboxreseachBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case SampleboxreseachManager.ID_SAMPLEBOXRESEACHID:
                if (b1.getSampleboxreseachid() == null && b2.getSampleboxreseachid() != null) {
                    iReturn = -1;
                } else if (b1.getSampleboxreseachid() == null && b2.getSampleboxreseachid() == null) {
                    iReturn = 0;
                } else if (b1.getSampleboxreseachid() != null && b2.getSampleboxreseachid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSampleboxreseachid().compareTo(b2.getSampleboxreseachid());
                }
                break;
            case SampleboxreseachManager.ID_CONTRACTSAMPLETYPEID:
                if (b1.getContractsampletypeid() == null && b2.getContractsampletypeid() != null) {
                    iReturn = -1;
                } else if (b1.getContractsampletypeid() == null && b2.getContractsampletypeid() == null) {
                    iReturn = 0;
                } else if (b1.getContractsampletypeid() != null && b2.getContractsampletypeid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getContractsampletypeid().compareTo(b2.getContractsampletypeid());
                }
                break;
            case SampleboxreseachManager.ID_LABTESTID:
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
            case SampleboxreseachManager.ID_REGBYID:
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
            case SampleboxreseachManager.ID_REGDATE:
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
            case SampleboxreseachManager.ID_TOTALSUBTEST:
                if (b1.getTotalsubtest() == null && b2.getTotalsubtest() != null) {
                    iReturn = -1;
                } else if (b1.getTotalsubtest() == null && b2.getTotalsubtest() == null) {
                    iReturn = 0;
                } else if (b1.getTotalsubtest() != null && b2.getTotalsubtest() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getTotalsubtest().compareTo(b2.getTotalsubtest());
                }
                break;
            case SampleboxreseachManager.ID_PARENTTEST:
                if (b1.getParenttest() == null && b2.getParenttest() != null) {
                    iReturn = -1;
                } else if (b1.getParenttest() == null && b2.getParenttest() == null) {
                    iReturn = 0;
                } else if (b1.getParenttest() != null && b2.getParenttest() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getParenttest().compareTo(b2.getParenttest());
                }
                break;
            case SampleboxreseachManager.ID_INSTITUTIONID:
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
            case SampleboxreseachManager.ID_PRICE:
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
            case SampleboxreseachManager.ID_DAYNUM:
                if (b1.getDaynum() == null && b2.getDaynum() != null) {
                    iReturn = -1;
                } else if (b1.getDaynum() == null && b2.getDaynum() == null) {
                    iReturn = 0;
                } else if (b1.getDaynum() != null && b2.getDaynum() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getDaynum().compareTo(b2.getDaynum());
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
