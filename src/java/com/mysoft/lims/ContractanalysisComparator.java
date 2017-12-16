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
 * Comparator class is used to sort the ContractanalysisBean objects.
 */
public class ContractanalysisComparator implements Comparator
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
     * Constructor class for ContractanalysisComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new ContractanalysisComparator(ContractanalysisManager.CONTRACTANALYSISID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>ContractanalysisManager.ID_CONTRACTANALYSISID
     *   <li>ContractanalysisManager.ID_CONTRACTID
     *   <li>ContractanalysisManager.ID_SAMPLETYPEID
     *   <li>ContractanalysisManager.ID_LABTESTID
     *   <li>ContractanalysisManager.ID_INSTITUTIONID
     *   <li>ContractanalysisManager.ID_PRICE
     *   <li>ContractanalysisManager.ID_ENDDAYS
     *   <li>ContractanalysisManager.ID_REGBYID
     *   <li>ContractanalysisManager.ID_REGDATE
     *   <li>ContractanalysisManager.ID_STATUS
     * </ul>
     */
    public ContractanalysisComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for ContractanalysisComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new ContractanalysisComparator(ContractanalysisManager.CONTRACTANALYSISID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>ContractanalysisManager.ID_CONTRACTANALYSISID
     *   <li>ContractanalysisManager.ID_CONTRACTID
     *   <li>ContractanalysisManager.ID_SAMPLETYPEID
     *   <li>ContractanalysisManager.ID_LABTESTID
     *   <li>ContractanalysisManager.ID_INSTITUTIONID
     *   <li>ContractanalysisManager.ID_PRICE
     *   <li>ContractanalysisManager.ID_ENDDAYS
     *   <li>ContractanalysisManager.ID_REGBYID
     *   <li>ContractanalysisManager.ID_REGDATE
     *   <li>ContractanalysisManager.ID_DELETED
     *   <li>ContractanalysisManager.ID_STATUS
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public ContractanalysisComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        ContractanalysisBean b1 = (ContractanalysisBean)pObj1;
        ContractanalysisBean b2 = (ContractanalysisBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case ContractanalysisManager.ID_CONTRACTANALYSISID:
                if (b1.getContractanalysisid() == null && b2.getContractanalysisid() != null) {
                    iReturn = -1;
                } else if (b1.getContractanalysisid() == null && b2.getContractanalysisid() == null) {
                    iReturn = 0;
                } else if (b1.getContractanalysisid() != null && b2.getContractanalysisid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getContractanalysisid().compareTo(b2.getContractanalysisid());
                }
                break;
            case ContractanalysisManager.ID_CONTRACTID:
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
            case ContractanalysisManager.ID_SAMPLETYPEID:
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
            case ContractanalysisManager.ID_LABTESTID:
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
            case ContractanalysisManager.ID_INSTITUTIONID:
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
            case ContractanalysisManager.ID_PRICE:
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
            case ContractanalysisManager.ID_ENDDAYS:
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
            case ContractanalysisManager.ID_REGBYID:
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
            case ContractanalysisManager.ID_REGDATE:
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
            case ContractanalysisManager.ID_STATUS:
                if (b1.getStatus() == null && b2.getStatus() != null) {
                    iReturn = -1;
                } else if (b1.getStatus() == null && b2.getStatus() == null) {
                    iReturn = 0;
                } else if (b1.getStatus() != null && b2.getStatus() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getStatus().compareTo(b2.getStatus());
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
