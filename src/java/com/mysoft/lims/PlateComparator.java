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
 * Comparator class is used to sort the PlateBean objects.
 */
public class PlateComparator implements Comparator
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
     * Constructor class for PlateComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new PlateComparator(PlateManager.PLATEID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>PlateManager.ID_PLATEID
     *   <li>PlateManager.ID_NUM
     *   <li>PlateManager.ID_PLATEDATE
     *   <li>PlateManager.ID_REGBYID
     *   <li>PlateManager.ID_REGDATE
     *   <li>PlateManager.ID_DEVICEID
     *   <li>PlateManager.ID_PLATETEMPLATEID
     * </ul>
     */
    public PlateComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for PlateComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new PlateComparator(PlateManager.PLATEID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>PlateManager.ID_PLATEID
     *   <li>PlateManager.ID_NUM
     *   <li>PlateManager.ID_PLATEDATE
     *   <li>PlateManager.ID_REGBYID
     *   <li>PlateManager.ID_REGDATE
     *   <li>PlateManager.ID_DEVICEID
     *   <li>PlateManager.ID_PLATETEMPLATEID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public PlateComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        PlateBean b1 = (PlateBean)pObj1;
        PlateBean b2 = (PlateBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case PlateManager.ID_PLATEID:
                if (b1.getPlateid() == null && b2.getPlateid() != null) {
                    iReturn = -1;
                } else if (b1.getPlateid() == null && b2.getPlateid() == null) {
                    iReturn = 0;
                } else if (b1.getPlateid() != null && b2.getPlateid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPlateid().compareTo(b2.getPlateid());
                }
                break;
            case PlateManager.ID_NUM:
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
            case PlateManager.ID_PLATEDATE:
                if (b1.getPlatedate() == null && b2.getPlatedate() != null) {
                    iReturn = -1;
                } else if (b1.getPlatedate() == null && b2.getPlatedate() == null) {
                    iReturn = 0;
                } else if (b1.getPlatedate() != null && b2.getPlatedate() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPlatedate().compareTo(b2.getPlatedate());
                }
                break;
            case PlateManager.ID_REGBYID:
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
            case PlateManager.ID_REGDATE:
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
            case PlateManager.ID_DEVICEID:
                if (b1.getDeviceid() == null && b2.getDeviceid() != null) {
                    iReturn = -1;
                } else if (b1.getDeviceid() == null && b2.getDeviceid() == null) {
                    iReturn = 0;
                } else if (b1.getDeviceid() != null && b2.getDeviceid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getDeviceid().compareTo(b2.getDeviceid());
                }
                break;
            case PlateManager.ID_PLATETEMPLATEID:
                if (b1.getPlatetemplateid() == null && b2.getPlatetemplateid() != null) {
                    iReturn = -1;
                } else if (b1.getPlatetemplateid() == null && b2.getPlatetemplateid() == null) {
                    iReturn = 0;
                } else if (b1.getPlatetemplateid() != null && b2.getPlatetemplateid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPlatetemplateid().compareTo(b2.getPlatetemplateid());
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
