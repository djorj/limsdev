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
 * Comparator class is used to sort the DocsBean objects.
 */
public class DocsComparator implements Comparator
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
     * Constructor class for DocsComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DocsComparator(DocsManager.DOCSID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DocsManager.ID_DOCSID
     *   <li>DocsManager.ID_DOCTYPEID
     *   <li>DocsManager.ID_CONTRACTID
     *   <li>DocsManager.ID_PATH
     *   <li>DocsManager.ID_REGDATE
     *   <li>DocsManager.ID_REGBYID
     * </ul>
     */
    public DocsComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for DocsComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DocsComparator(DocsManager.DOCSID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DocsManager.ID_DOCSID
     *   <li>DocsManager.ID_DOCTYPEID
     *   <li>DocsManager.ID_CONTRACTID
     *   <li>DocsManager.ID_PATH
     *   <li>DocsManager.ID_REGDATE
     *   <li>DocsManager.ID_REGBYID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public DocsComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        DocsBean b1 = (DocsBean)pObj1;
        DocsBean b2 = (DocsBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case DocsManager.ID_DOCSID:
                if (b1.getDocsid() == null && b2.getDocsid() != null) {
                    iReturn = -1;
                } else if (b1.getDocsid() == null && b2.getDocsid() == null) {
                    iReturn = 0;
                } else if (b1.getDocsid() != null && b2.getDocsid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getDocsid().compareTo(b2.getDocsid());
                }
                break;
            case DocsManager.ID_DOCTYPEID:
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
            case DocsManager.ID_CONTRACTID:
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
            case DocsManager.ID_PATH:
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
            case DocsManager.ID_REGDATE:
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
            case DocsManager.ID_REGBYID:
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
