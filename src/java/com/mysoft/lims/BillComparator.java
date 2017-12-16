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
 * Comparator class is used to sort the BillBean objects.
 */
public class BillComparator implements Comparator
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
     * Constructor class for BillComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new BillComparator(BillManager.BILLID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>BillManager.ID_BILLID
     *   <li>BillManager.ID_NUM
     *   <li>BillManager.ID_CONTRACTID
     *   <li>BillManager.ID_PATH
     *   <li>BillManager.ID_REGDATE
     *   <li>BillManager.ID_REGBYID
     * </ul>
     */
    public BillComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for BillComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new BillComparator(BillManager.BILLID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>BillManager.ID_BILLID
     *   <li>BillManager.ID_NUM
     *   <li>BillManager.ID_CONTRACTID
     *   <li>BillManager.ID_PATH
     *   <li>BillManager.ID_REGDATE
     *   <li>BillManager.ID_REGBYID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public BillComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        BillBean b1 = (BillBean)pObj1;
        BillBean b2 = (BillBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case BillManager.ID_BILLID:
                if (b1.getBillid() == null && b2.getBillid() != null) {
                    iReturn = -1;
                } else if (b1.getBillid() == null && b2.getBillid() == null) {
                    iReturn = 0;
                } else if (b1.getBillid() != null && b2.getBillid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getBillid().compareTo(b2.getBillid());
                }
                break;
            case BillManager.ID_NUM:
                if (b1.getNum() == null && b2.getNum() != null) {
                    iReturn = -1;
                } else if (b1.getNum() == null && b2.getNum() == null) {
                    iReturn = 0;
                } else if (b1.getNum() != null && b2.getNum() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getNum().compareTo(b2.getNum());
                }
                break;
            case BillManager.ID_CONTRACTID:
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
            case BillManager.ID_PATH:
                if (b1.getPath() == null && b2.getPath() != null) {
                    iReturn = -1;
                } else if (b1.getPath() == null && b2.getPath() == null) {
                    iReturn = 0;
                } else if (b1.getPath() != null && b2.getPath() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPath().compareTo(b2.getPath());
                }
                break;
            case BillManager.ID_REGDATE:
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
            case BillManager.ID_REGBYID:
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
            default: 
                throw new IllegalArgumentException("Type passed for the field is not supported");
        }

        return bReverse ? (-1 * iReturn) : iReturn;
    }
// class+ 

// class- 
}
