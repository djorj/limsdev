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
 * Comparator class is used to sort the PlevelBean objects.
 */
public class PlevelComparator implements Comparator
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
     * Constructor class for PlevelComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new PlevelComparator(PlevelManager.PLEVELID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>PlevelManager.ID_PLEVELID
     *   <li>PlevelManager.ID_PERSONELLTYPEID
     *   <li>PlevelManager.ID_MENUID
     * </ul>
     */
    public PlevelComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for PlevelComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new PlevelComparator(PlevelManager.PLEVELID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>PlevelManager.ID_PLEVELID
     *   <li>PlevelManager.ID_PERSONELLTYPEID
     *   <li>PlevelManager.ID_MENUID
     *   <li>PlevelManager.ID_READ
     *   <li>PlevelManager.ID_WRITE
     *   <li>PlevelManager.ID_PRINT
     *   <li>PlevelManager.ID_EXPORT
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public PlevelComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        PlevelBean b1 = (PlevelBean)pObj1;
        PlevelBean b2 = (PlevelBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case PlevelManager.ID_PLEVELID:
                if (b1.getPlevelid() == null && b2.getPlevelid() != null) {
                    iReturn = -1;
                } else if (b1.getPlevelid() == null && b2.getPlevelid() == null) {
                    iReturn = 0;
                } else if (b1.getPlevelid() != null && b2.getPlevelid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPlevelid().compareTo(b2.getPlevelid());
                }
                break;
            case PlevelManager.ID_PERSONELLTYPEID:
                if (b1.getPersonelltypeid() == null && b2.getPersonelltypeid() != null) {
                    iReturn = -1;
                } else if (b1.getPersonelltypeid() == null && b2.getPersonelltypeid() == null) {
                    iReturn = 0;
                } else if (b1.getPersonelltypeid() != null && b2.getPersonelltypeid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPersonelltypeid().compareTo(b2.getPersonelltypeid());
                }
                break;
            case PlevelManager.ID_MENUID:
                if (b1.getMenuid() == null && b2.getMenuid() != null) {
                    iReturn = -1;
                } else if (b1.getMenuid() == null && b2.getMenuid() == null) {
                    iReturn = 0;
                } else if (b1.getMenuid() != null && b2.getMenuid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getMenuid().compareTo(b2.getMenuid());
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
