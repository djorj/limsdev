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
 * Comparator class is used to sort the DocBean objects.
 */
public class DocComparator implements Comparator
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
     * Constructor class for DocComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DocComparator(DocManager.DOCID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DocManager.ID_DOCID
     *   <li>DocManager.ID_NAME
     *   <li>DocManager.ID_DESCRIPTION
     * </ul>
     */
    public DocComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for DocComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DocComparator(DocManager.DOCID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DocManager.ID_DOCID
     *   <li>DocManager.ID_NAME
     *   <li>DocManager.ID_DESCRIPTION
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public DocComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        DocBean b1 = (DocBean)pObj1;
        DocBean b2 = (DocBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case DocManager.ID_DOCID:
                if (b1.getDocid() == null && b2.getDocid() != null) {
                    iReturn = -1;
                } else if (b1.getDocid() == null && b2.getDocid() == null) {
                    iReturn = 0;
                } else if (b1.getDocid() != null && b2.getDocid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getDocid().compareTo(b2.getDocid());
                }
                break;
            case DocManager.ID_NAME:
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
            case DocManager.ID_DESCRIPTION:
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
            default: 
                throw new IllegalArgumentException("Type passed for the field is not supported");
        }

        return bReverse ? (-1 * iReturn) : iReturn;
    }
// class+ 

// class- 
}
