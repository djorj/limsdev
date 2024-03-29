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
 * Comparator class is used to sort the ContragentBean objects.
 */
public class ContragentComparator implements Comparator
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
     * Constructor class for ContragentComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new ContragentComparator(ContragentManager.CONTRAGENTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>ContragentManager.ID_CONTRAGENTID
     *   <li>ContragentManager.ID_NAME
     *   <li>ContragentManager.ID_IDN
     *   <li>ContragentManager.ID_ADDRESS
     *   <li>ContragentManager.ID_PHONE
     *   <li>ContragentManager.ID_CONTACT
     *   <li>ContragentManager.ID_BANKDATA
     *   <li>ContragentManager.ID_NOTE
     *   <li>ContragentManager.ID_CONTRAGENTTYPEID
     *   <li>ContragentManager.ID_EMAIL
     *   <li>ContragentManager.ID_URL
     *   <li>ContragentManager.ID_COMPANYID
     *   <li>ContragentManager.ID_TYPE
     *   <li>ContragentManager.ID_REGBYID
     *   <li>ContragentManager.ID_REGDATE
     *   <li>ContragentManager.ID_REGIONID
     *   <li>ContragentManager.ID_RAIONID
     *   <li>ContragentManager.ID_VILLAGEID
     *   <li>ContragentManager.ID_FNAME
     *   <li>ContragentManager.ID_LNAME
     * </ul>
     */
    public ContragentComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for ContragentComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new ContragentComparator(ContragentManager.CONTRAGENTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>ContragentManager.ID_CONTRAGENTID
     *   <li>ContragentManager.ID_NAME
     *   <li>ContragentManager.ID_IDN
     *   <li>ContragentManager.ID_ADDRESS
     *   <li>ContragentManager.ID_PHONE
     *   <li>ContragentManager.ID_CONTACT
     *   <li>ContragentManager.ID_BANKDATA
     *   <li>ContragentManager.ID_NOTE
     *   <li>ContragentManager.ID_CONTRAGENTTYPEID
     *   <li>ContragentManager.ID_EMAIL
     *   <li>ContragentManager.ID_URL
     *   <li>ContragentManager.ID_COMPANYID
     *   <li>ContragentManager.ID_TYPE
     *   <li>ContragentManager.ID_REGBYID
     *   <li>ContragentManager.ID_REGDATE
     *   <li>ContragentManager.ID_REGIONID
     *   <li>ContragentManager.ID_RAIONID
     *   <li>ContragentManager.ID_VILLAGEID
     *   <li>ContragentManager.ID_DELETED
     *   <li>ContragentManager.ID_FNAME
     *   <li>ContragentManager.ID_LNAME
     *   <li>ContragentManager.ID_VAT
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public ContragentComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        ContragentBean b1 = (ContragentBean)pObj1;
        ContragentBean b2 = (ContragentBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case ContragentManager.ID_CONTRAGENTID:
                if (b1.getContragentid() == null && b2.getContragentid() != null) {
                    iReturn = -1;
                } else if (b1.getContragentid() == null && b2.getContragentid() == null) {
                    iReturn = 0;
                } else if (b1.getContragentid() != null && b2.getContragentid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getContragentid().compareTo(b2.getContragentid());
                }
                break;
            case ContragentManager.ID_NAME:
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
            case ContragentManager.ID_IDN:
                if (b1.getIdn() == null && b2.getIdn() != null) {
                    iReturn = -1;
                } else if (b1.getIdn() == null && b2.getIdn() == null) {
                    iReturn = 0;
                } else if (b1.getIdn() != null && b2.getIdn() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getIdn().compareTo(b2.getIdn());
                }
                break;
            case ContragentManager.ID_ADDRESS:
                if (b1.getAddress() == null && b2.getAddress() != null) {
                    iReturn = -1;
                } else if (b1.getAddress() == null && b2.getAddress() == null) {
                    iReturn = 0;
                } else if (b1.getAddress() != null && b2.getAddress() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getAddress().compareTo(b2.getAddress());
                }
                break;
            case ContragentManager.ID_PHONE:
                if (b1.getPhone() == null && b2.getPhone() != null) {
                    iReturn = -1;
                } else if (b1.getPhone() == null && b2.getPhone() == null) {
                    iReturn = 0;
                } else if (b1.getPhone() != null && b2.getPhone() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getPhone().compareTo(b2.getPhone());
                }
                break;
            case ContragentManager.ID_CONTACT:
                if (b1.getContact() == null && b2.getContact() != null) {
                    iReturn = -1;
                } else if (b1.getContact() == null && b2.getContact() == null) {
                    iReturn = 0;
                } else if (b1.getContact() != null && b2.getContact() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getContact().compareTo(b2.getContact());
                }
                break;
            case ContragentManager.ID_BANKDATA:
                if (b1.getBankdata() == null && b2.getBankdata() != null) {
                    iReturn = -1;
                } else if (b1.getBankdata() == null && b2.getBankdata() == null) {
                    iReturn = 0;
                } else if (b1.getBankdata() != null && b2.getBankdata() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getBankdata().compareTo(b2.getBankdata());
                }
                break;
            case ContragentManager.ID_NOTE:
                if (b1.getNote() == null && b2.getNote() != null) {
                    iReturn = -1;
                } else if (b1.getNote() == null && b2.getNote() == null) {
                    iReturn = 0;
                } else if (b1.getNote() != null && b2.getNote() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getNote().compareTo(b2.getNote());
                }
                break;
            case ContragentManager.ID_CONTRAGENTTYPEID:
                if (b1.getContragenttypeid() == null && b2.getContragenttypeid() != null) {
                    iReturn = -1;
                } else if (b1.getContragenttypeid() == null && b2.getContragenttypeid() == null) {
                    iReturn = 0;
                } else if (b1.getContragenttypeid() != null && b2.getContragenttypeid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getContragenttypeid().compareTo(b2.getContragenttypeid());
                }
                break;
            case ContragentManager.ID_EMAIL:
                if (b1.getEmail() == null && b2.getEmail() != null) {
                    iReturn = -1;
                } else if (b1.getEmail() == null && b2.getEmail() == null) {
                    iReturn = 0;
                } else if (b1.getEmail() != null && b2.getEmail() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getEmail().compareTo(b2.getEmail());
                }
                break;
            case ContragentManager.ID_URL:
                if (b1.getUrl() == null && b2.getUrl() != null) {
                    iReturn = -1;
                } else if (b1.getUrl() == null && b2.getUrl() == null) {
                    iReturn = 0;
                } else if (b1.getUrl() != null && b2.getUrl() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getUrl().compareTo(b2.getUrl());
                }
                break;
            case ContragentManager.ID_COMPANYID:
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
            case ContragentManager.ID_TYPE:
                if (b1.getType() == null && b2.getType() != null) {
                    iReturn = -1;
                } else if (b1.getType() == null && b2.getType() == null) {
                    iReturn = 0;
                } else if (b1.getType() != null && b2.getType() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getType().compareTo(b2.getType());
                }
                break;
            case ContragentManager.ID_REGBYID:
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
            case ContragentManager.ID_REGDATE:
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
            case ContragentManager.ID_REGIONID:
                if (b1.getRegionid() == null && b2.getRegionid() != null) {
                    iReturn = -1;
                } else if (b1.getRegionid() == null && b2.getRegionid() == null) {
                    iReturn = 0;
                } else if (b1.getRegionid() != null && b2.getRegionid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getRegionid().compareTo(b2.getRegionid());
                }
                break;
            case ContragentManager.ID_RAIONID:
                if (b1.getRaionid() == null && b2.getRaionid() != null) {
                    iReturn = -1;
                } else if (b1.getRaionid() == null && b2.getRaionid() == null) {
                    iReturn = 0;
                } else if (b1.getRaionid() != null && b2.getRaionid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getRaionid().compareTo(b2.getRaionid());
                }
                break;
            case ContragentManager.ID_VILLAGEID:
                if (b1.getVillageid() == null && b2.getVillageid() != null) {
                    iReturn = -1;
                } else if (b1.getVillageid() == null && b2.getVillageid() == null) {
                    iReturn = 0;
                } else if (b1.getVillageid() != null && b2.getVillageid() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getVillageid().compareTo(b2.getVillageid());
                }
                break;
            case ContragentManager.ID_FNAME:
                if (b1.getFname() == null && b2.getFname() != null) {
                    iReturn = -1;
                } else if (b1.getFname() == null && b2.getFname() == null) {
                    iReturn = 0;
                } else if (b1.getFname() != null && b2.getFname() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getFname().compareTo(b2.getFname());
                }
                break;
            case ContragentManager.ID_LNAME:
                if (b1.getLname() == null && b2.getLname() != null) {
                    iReturn = -1;
                } else if (b1.getLname() == null && b2.getLname() == null) {
                    iReturn = 0;
                } else if (b1.getLname() != null && b2.getLname() == null) {
                    iReturn = 1;
                } else { 
                    iReturn = b1.getLname().compareTo(b2.getLname());
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
