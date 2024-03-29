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
 * Comparator class is used to sort the LabtestBean objects.
 */
public class LabtestComparator implements Comparator
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
     * Constructor class for LabtestComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new LabtestComparator(LabtestManager.LABTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>LabtestManager.ID_LABTESTID
     *   <li>LabtestManager.ID_CODE
     *   <li>LabtestManager.ID_NAME
     *   <li>LabtestManager.ID_ABBREVIATION
     *   <li>LabtestManager.ID_RESTYPEID
     *   <li>LabtestManager.ID_UNITSID
     *   <li>LabtestManager.ID_TESTCATEGORYID
     *   <li>LabtestManager.ID_DESCRIPTION
     *   <li>LabtestManager.ID_COMPANYID
     *   <li>LabtestManager.ID_NORMMIN
     *   <li>LabtestManager.ID_NORMMAX
     *   <li>LabtestManager.ID_TNORM
     *   <li>LabtestManager.ID_BNORMVAL1
     *   <li>LabtestManager.ID_BNORMVAL2
     *   <li>LabtestManager.ID_CONTROLPROCEDURE
     *   <li>LabtestManager.ID_POS
     *   <li>LabtestManager.ID_NEG
     *   <li>LabtestManager.ID_ANSLIST
     * </ul>
     */
    public LabtestComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for LabtestComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new LabtestComparator(LabtestManager.LABTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>LabtestManager.ID_LABTESTID
     *   <li>LabtestManager.ID_CODE
     *   <li>LabtestManager.ID_NAME
     *   <li>LabtestManager.ID_ABBREVIATION
     *   <li>LabtestManager.ID_GRP
     *   <li>LabtestManager.ID_CTR
     *   <li>LabtestManager.ID_RESTYPEID
     *   <li>LabtestManager.ID_UNITSID
     *   <li>LabtestManager.ID_TESTCATEGORYID
     *   <li>LabtestManager.ID_DESCRIPTION
     *   <li>LabtestManager.ID_COMPANYID
     *   <li>LabtestManager.ID_NORMMIN
     *   <li>LabtestManager.ID_NORMMAX
     *   <li>LabtestManager.ID_TNORM
     *   <li>LabtestManager.ID_BNORMVAL1
     *   <li>LabtestManager.ID_BNORMVAL2
     *   <li>LabtestManager.ID_CONTROLPROCEDURE
     *   <li>LabtestManager.ID_POS
     *   <li>LabtestManager.ID_NEG
     *   <li>LabtestManager.ID_ANSLIST
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public LabtestComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        LabtestBean b1 = (LabtestBean)pObj1;
        LabtestBean b2 = (LabtestBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case LabtestManager.ID_LABTESTID:
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
            case LabtestManager.ID_CODE:
                if (b1.getCode() == null && b2.getCode() != null) {
                    iReturn = -1;
                } else if (b1.getCode() == null && b2.getCode() == null) {
                    iReturn = 0;
                } else if (b1.getCode() != null && b2.getCode() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getCode().compareTo(b2.getCode());
                }
                break;
            case LabtestManager.ID_NAME:
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
            case LabtestManager.ID_ABBREVIATION:
                if (b1.getAbbreviation() == null && b2.getAbbreviation() != null) {
                    iReturn = -1;
                } else if (b1.getAbbreviation() == null && b2.getAbbreviation() == null) {
                    iReturn = 0;
                } else if (b1.getAbbreviation() != null && b2.getAbbreviation() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getAbbreviation().compareTo(b2.getAbbreviation());
                }
                break;
            case LabtestManager.ID_RESTYPEID:
                if (b1.getRestypeid() == null && b2.getRestypeid() != null) {
                    iReturn = -1;
                } else if (b1.getRestypeid() == null && b2.getRestypeid() == null) {
                    iReturn = 0;
                } else if (b1.getRestypeid() != null && b2.getRestypeid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getRestypeid().compareTo(b2.getRestypeid());
                }
                break;
            case LabtestManager.ID_UNITSID:
                if (b1.getUnitsid() == null && b2.getUnitsid() != null) {
                    iReturn = -1;
                } else if (b1.getUnitsid() == null && b2.getUnitsid() == null) {
                    iReturn = 0;
                } else if (b1.getUnitsid() != null && b2.getUnitsid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getUnitsid().compareTo(b2.getUnitsid());
                }
                break;
            case LabtestManager.ID_TESTCATEGORYID:
                if (b1.getTestcategoryid() == null && b2.getTestcategoryid() != null) {
                    iReturn = -1;
                } else if (b1.getTestcategoryid() == null && b2.getTestcategoryid() == null) {
                    iReturn = 0;
                } else if (b1.getTestcategoryid() != null && b2.getTestcategoryid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getTestcategoryid().compareTo(b2.getTestcategoryid());
                }
                break;
            case LabtestManager.ID_DESCRIPTION:
                if (b1.getDescription() == null && b2.getDescription() != null) {
                    iReturn = -1;
                } else if (b1.getDescription() == null && b2.getDescription() == null) {
                    iReturn = 0;
                } else if (b1.getDescription() != null && b2.getDescription() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getDescription().compareTo(b2.getDescription());
                }
                break;
            case LabtestManager.ID_COMPANYID:
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
            case LabtestManager.ID_NORMMIN:
                if (b1.getNormmin() == null && b2.getNormmin() != null) {
                    iReturn = -1;
                } else if (b1.getNormmin() == null && b2.getNormmin() == null) {
                    iReturn = 0;
                } else if (b1.getNormmin() != null && b2.getNormmin() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getNormmin().compareTo(b2.getNormmin());
                }
                break;
            case LabtestManager.ID_NORMMAX:
                if (b1.getNormmax() == null && b2.getNormmax() != null) {
                    iReturn = -1;
                } else if (b1.getNormmax() == null && b2.getNormmax() == null) {
                    iReturn = 0;
                } else if (b1.getNormmax() != null && b2.getNormmax() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getNormmax().compareTo(b2.getNormmax());
                }
                break;
            case LabtestManager.ID_TNORM:
                if (b1.getTnorm() == null && b2.getTnorm() != null) {
                    iReturn = -1;
                } else if (b1.getTnorm() == null && b2.getTnorm() == null) {
                    iReturn = 0;
                } else if (b1.getTnorm() != null && b2.getTnorm() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getTnorm().compareTo(b2.getTnorm());
                }
                break;
            case LabtestManager.ID_BNORMVAL1:
                if (b1.getBnormval1() == null && b2.getBnormval1() != null) {
                    iReturn = -1;
                } else if (b1.getBnormval1() == null && b2.getBnormval1() == null) {
                    iReturn = 0;
                } else if (b1.getBnormval1() != null && b2.getBnormval1() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getBnormval1().compareTo(b2.getBnormval1());
                }
                break;
            case LabtestManager.ID_BNORMVAL2:
                if (b1.getBnormval2() == null && b2.getBnormval2() != null) {
                    iReturn = -1;
                } else if (b1.getBnormval2() == null && b2.getBnormval2() == null) {
                    iReturn = 0;
                } else if (b1.getBnormval2() != null && b2.getBnormval2() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getBnormval2().compareTo(b2.getBnormval2());
                }
                break;
            case LabtestManager.ID_CONTROLPROCEDURE:
                if (b1.getControlprocedure() == null && b2.getControlprocedure() != null) {
                    iReturn = -1;
                } else if (b1.getControlprocedure() == null && b2.getControlprocedure() == null) {
                    iReturn = 0;
                } else if (b1.getControlprocedure() != null && b2.getControlprocedure() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getControlprocedure().compareTo(b2.getControlprocedure());
                }
                break;
            case LabtestManager.ID_POS:
                if (b1.getPos() == null && b2.getPos() != null) {
                    iReturn = -1;
                } else if (b1.getPos() == null && b2.getPos() == null) {
                    iReturn = 0;
                } else if (b1.getPos() != null && b2.getPos() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPos().compareTo(b2.getPos());
                }
                break;
            case LabtestManager.ID_NEG:
                if (b1.getNeg() == null && b2.getNeg() != null) {
                    iReturn = -1;
                } else if (b1.getNeg() == null && b2.getNeg() == null) {
                    iReturn = 0;
                } else if (b1.getNeg() != null && b2.getNeg() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getNeg().compareTo(b2.getNeg());
                }
                break;
            case LabtestManager.ID_ANSLIST:
                if (b1.getAnslist() == null && b2.getAnslist() != null) {
                    iReturn = -1;
                } else if (b1.getAnslist() == null && b2.getAnslist() == null) {
                    iReturn = 0;
                } else if (b1.getAnslist() != null && b2.getAnslist() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getAnslist().compareTo(b2.getAnslist());
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
