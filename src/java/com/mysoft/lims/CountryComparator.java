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
 * Comparator class is used to sort the CountryBean objects.
 */
public class CountryComparator implements Comparator
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
     * Constructor class for CountryComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new CountryComparator(CountryManager.COUNTRYID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>CountryManager.ID_COUNTRYID
     *   <li>CountryManager.ID_CODE
     *   <li>CountryManager.ID_NAMEEN
     *   <li>CountryManager.ID_NAMEGE
     * </ul>
     */
    public CountryComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for CountryComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new CountryComparator(CountryManager.COUNTRYID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>CountryManager.ID_COUNTRYID
     *   <li>CountryManager.ID_CODE
     *   <li>CountryManager.ID_NAMEEN
     *   <li>CountryManager.ID_NAMEGE
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public CountryComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        CountryBean b1 = (CountryBean)pObj1;
        CountryBean b2 = (CountryBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case CountryManager.ID_COUNTRYID:
                if (b1.getCountryid() == null && b2.getCountryid() != null) {
                    iReturn = -1;
                } else if (b1.getCountryid() == null && b2.getCountryid() == null) {
                    iReturn = 0;
                } else if (b1.getCountryid() != null && b2.getCountryid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getCountryid().compareTo(b2.getCountryid());
                }
                break;
            case CountryManager.ID_CODE:
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
            case CountryManager.ID_NAMEEN:
                if (b1.getNameen() == null && b2.getNameen() != null) {
                    iReturn = -1;
                } else if (b1.getNameen() == null && b2.getNameen() == null) {
                    iReturn = 0;
                } else if (b1.getNameen() != null && b2.getNameen() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getNameen().compareTo(b2.getNameen());
                }
                break;
            case CountryManager.ID_NAMEGE:
                if (b1.getNamege() == null && b2.getNamege() != null) {
                    iReturn = -1;
                } else if (b1.getNamege() == null && b2.getNamege() == null) {
                    iReturn = 0;
                } else if (b1.getNamege() != null && b2.getNamege() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getNamege().compareTo(b2.getNamege());
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
