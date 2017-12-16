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
 * Comparator class is used to sort the DeviceresultBean objects.
 */
public class DeviceresultComparator implements Comparator
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
     * Constructor class for DeviceresultComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DeviceresultComparator(DeviceresultManager.DEVICERESULTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DeviceresultManager.ID_DEVICERESULTID
     *   <li>DeviceresultManager.ID_DEVICEID
     *   <li>DeviceresultManager.ID_RESULTDATE
     *   <li>DeviceresultManager.ID_RESULT
     *   <li>DeviceresultManager.ID_REGBYID
     *   <li>DeviceresultManager.ID_REGDATE
     *   <li>DeviceresultManager.ID_SAMPLEITEMRESEACHID
     * </ul>
     */
    public DeviceresultComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for DeviceresultComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new DeviceresultComparator(DeviceresultManager.DEVICERESULTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>DeviceresultManager.ID_DEVICERESULTID
     *   <li>DeviceresultManager.ID_DEVICEID
     *   <li>DeviceresultManager.ID_RESULTDATE
     *   <li>DeviceresultManager.ID_RESULT
     *   <li>DeviceresultManager.ID_REGBYID
     *   <li>DeviceresultManager.ID_REGDATE
     *   <li>DeviceresultManager.ID_SAMPLEITEMRESEACHID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public DeviceresultComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        DeviceresultBean b1 = (DeviceresultBean)pObj1;
        DeviceresultBean b2 = (DeviceresultBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case DeviceresultManager.ID_DEVICERESULTID:
                if (b1.getDeviceresultid() == null && b2.getDeviceresultid() != null) {
                    iReturn = -1;
                } else if (b1.getDeviceresultid() == null && b2.getDeviceresultid() == null) {
                    iReturn = 0;
                } else if (b1.getDeviceresultid() != null && b2.getDeviceresultid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getDeviceresultid().compareTo(b2.getDeviceresultid());
                }
                break;
            case DeviceresultManager.ID_DEVICEID:
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
            case DeviceresultManager.ID_RESULTDATE:
                if (b1.getResultdate() == null && b2.getResultdate() != null) {
                    iReturn = -1;
                } else if (b1.getResultdate() == null && b2.getResultdate() == null) {
                    iReturn = 0;
                } else if (b1.getResultdate() != null && b2.getResultdate() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getResultdate().compareTo(b2.getResultdate());
                }
                break;
            case DeviceresultManager.ID_RESULT:
                if (b1.getResult() == null && b2.getResult() != null) {
                    iReturn = -1;
                } else if (b1.getResult() == null && b2.getResult() == null) {
                    iReturn = 0;
                } else if (b1.getResult() != null && b2.getResult() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getResult().compareTo(b2.getResult());
                }
                break;
            case DeviceresultManager.ID_REGBYID:
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
            case DeviceresultManager.ID_REGDATE:
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
            case DeviceresultManager.ID_SAMPLEITEMRESEACHID:
                if (b1.getSampleitemreseachid() == null && b2.getSampleitemreseachid() != null) {
                    iReturn = -1;
                } else if (b1.getSampleitemreseachid() == null && b2.getSampleitemreseachid() == null) {
                    iReturn = 0;
                } else if (b1.getSampleitemreseachid() != null && b2.getSampleitemreseachid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getSampleitemreseachid().compareTo(b2.getSampleitemreseachid());
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
