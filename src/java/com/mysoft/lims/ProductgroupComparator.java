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
 * Comparator class is used to sort the ProductgroupBean objects.
 */
public class ProductgroupComparator implements Comparator
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
     * Constructor class for ProductgroupComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new ProductgroupComparator(ProductgroupManager.PRODUCTGROUPID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>ProductgroupManager.ID_PRODUCTGROUPID
     *   <li>ProductgroupManager.ID_PARENTID
     *   <li>ProductgroupManager.ID_NAME
     *   <li>ProductgroupManager.ID_CODE
     *   <li>ProductgroupManager.ID_COMPANYID
     * </ul>
     */
    public ProductgroupComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for ProductgroupComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new ProductgroupComparator(ProductgroupManager.PRODUCTGROUPID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>ProductgroupManager.ID_PRODUCTGROUPID
     *   <li>ProductgroupManager.ID_PARENTID
     *   <li>ProductgroupManager.ID_NAME
     *   <li>ProductgroupManager.ID_CODE
     *   <li>ProductgroupManager.ID_COMPANYID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public ProductgroupComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        ProductgroupBean b1 = (ProductgroupBean)pObj1;
        ProductgroupBean b2 = (ProductgroupBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case ProductgroupManager.ID_PRODUCTGROUPID:
                if (b1.getProductgroupid() == null && b2.getProductgroupid() != null) {
                    iReturn = -1;
                } else if (b1.getProductgroupid() == null && b2.getProductgroupid() == null) {
                    iReturn = 0;
                } else if (b1.getProductgroupid() != null && b2.getProductgroupid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getProductgroupid().compareTo(b2.getProductgroupid());
                }
                break;
            case ProductgroupManager.ID_PARENTID:
                if (b1.getParentid() == null && b2.getParentid() != null) {
                    iReturn = -1;
                } else if (b1.getParentid() == null && b2.getParentid() == null) {
                    iReturn = 0;
                } else if (b1.getParentid() != null && b2.getParentid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getParentid().compareTo(b2.getParentid());
                }
                break;
            case ProductgroupManager.ID_NAME:
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
            case ProductgroupManager.ID_CODE:
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
            case ProductgroupManager.ID_COMPANYID:
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
