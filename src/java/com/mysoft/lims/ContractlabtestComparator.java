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
 * Comparator class is used to sort the ContractlabtestBean objects.
 */
public class ContractlabtestComparator implements Comparator
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
     * Constructor class for ContractlabtestComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new ContractlabtestComparator(ContractlabtestManager.CONTRACTLABTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>ContractlabtestManager.ID_CONTRACTLABTESTID
     *   <li>ContractlabtestManager.ID_CONTRACTID
     *   <li>ContractlabtestManager.ID_LABTESTID
     *   <li>ContractlabtestManager.ID_MAXPRICE
     *   <li>ContractlabtestManager.ID_MAXCNT
     *   <li>ContractlabtestManager.ID_REGBYID
     *   <li>ContractlabtestManager.ID_REGDATE
     *   <li>ContractlabtestManager.ID_MINDAY
     *   <li>ContractlabtestManager.ID_MAXDAY
     *   <li>ContractlabtestManager.ID_INFO
     *   <li>ContractlabtestManager.ID_SAMPLETYPEID
     * </ul>
     */
    public ContractlabtestComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for ContractlabtestComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new ContractlabtestComparator(ContractlabtestManager.CONTRACTLABTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>ContractlabtestManager.ID_CONTRACTLABTESTID
     *   <li>ContractlabtestManager.ID_CONTRACTID
     *   <li>ContractlabtestManager.ID_LABTESTID
     *   <li>ContractlabtestManager.ID_MAXPRICE
     *   <li>ContractlabtestManager.ID_MAXCNT
     *   <li>ContractlabtestManager.ID_REGBYID
     *   <li>ContractlabtestManager.ID_REGDATE
     *   <li>ContractlabtestManager.ID_MINDAY
     *   <li>ContractlabtestManager.ID_MAXDAY
     *   <li>ContractlabtestManager.ID_INFO
     *   <li>ContractlabtestManager.ID_SAMPLETYPEID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public ContractlabtestComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        ContractlabtestBean b1 = (ContractlabtestBean)pObj1;
        ContractlabtestBean b2 = (ContractlabtestBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case ContractlabtestManager.ID_CONTRACTLABTESTID:
                if (b1.getContractlabtestid() == null && b2.getContractlabtestid() != null) {
                    iReturn = -1;
                } else if (b1.getContractlabtestid() == null && b2.getContractlabtestid() == null) {
                    iReturn = 0;
                } else if (b1.getContractlabtestid() != null && b2.getContractlabtestid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getContractlabtestid().compareTo(b2.getContractlabtestid());
                }
                break;
            case ContractlabtestManager.ID_CONTRACTID:
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
            case ContractlabtestManager.ID_LABTESTID:
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
            case ContractlabtestManager.ID_MAXPRICE:
                if (b1.getMaxprice() == null && b2.getMaxprice() != null) {
                    iReturn = -1;
                } else if (b1.getMaxprice() == null && b2.getMaxprice() == null) {
                    iReturn = 0;
                } else if (b1.getMaxprice() != null && b2.getMaxprice() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getMaxprice().compareTo(b2.getMaxprice());
                }
                break;
            case ContractlabtestManager.ID_MAXCNT:
                if (b1.getMaxcnt() == null && b2.getMaxcnt() != null) {
                    iReturn = -1;
                } else if (b1.getMaxcnt() == null && b2.getMaxcnt() == null) {
                    iReturn = 0;
                } else if (b1.getMaxcnt() != null && b2.getMaxcnt() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getMaxcnt().compareTo(b2.getMaxcnt());
                }
                break;
            case ContractlabtestManager.ID_REGBYID:
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
            case ContractlabtestManager.ID_REGDATE:
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
            case ContractlabtestManager.ID_MINDAY:
                if (b1.getMinday() == null && b2.getMinday() != null) {
                    iReturn = -1;
                } else if (b1.getMinday() == null && b2.getMinday() == null) {
                    iReturn = 0;
                } else if (b1.getMinday() != null && b2.getMinday() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getMinday().compareTo(b2.getMinday());
                }
                break;
            case ContractlabtestManager.ID_MAXDAY:
                if (b1.getMaxday() == null && b2.getMaxday() != null) {
                    iReturn = -1;
                } else if (b1.getMaxday() == null && b2.getMaxday() == null) {
                    iReturn = 0;
                } else if (b1.getMaxday() != null && b2.getMaxday() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getMaxday().compareTo(b2.getMaxday());
                }
                break;
            case ContractlabtestManager.ID_INFO:
                if (b1.getInfo() == null && b2.getInfo() != null) {
                    iReturn = -1;
                } else if (b1.getInfo() == null && b2.getInfo() == null) {
                    iReturn = 0;
                } else if (b1.getInfo() != null && b2.getInfo() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getInfo().compareTo(b2.getInfo());
                }
                break;
            case ContractlabtestManager.ID_SAMPLETYPEID:
                if (b1.getSampletypeid() == null && b2.getSampletypeid() != null) {
                    iReturn = -1;
                } else if (b1.getSampletypeid() == null && b2.getSampletypeid() == null) {
                    iReturn = 0;
                } else if (b1.getSampletypeid() != null && b2.getSampletypeid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSampletypeid().compareTo(b2.getSampletypeid());
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