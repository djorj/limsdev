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
 * Comparator class is used to sort the LabtestsampletypeBean objects.
 */
public class LabtestsampletypeComparator implements Comparator
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
     * Constructor class for LabtestsampletypeComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new LabtestsampletypeComparator(LabtestsampletypeManager.LABTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort
     * <br>
     * Possible values are:
     * <ul>
     *   <li>LabtestsampletypeManager.ID_LABTESTID
     *   <li>LabtestsampletypeManager.ID_SAMPLETYPEID
     * </ul>
     */
    public LabtestsampletypeComparator(int iType)
    {
        this(iType, false);
    }

    /**
     * Constructor class for LabtestsampletypeComparator.
     * <br>
     * Example:
     * <br>
     * <code>Arrays.sort(pArray, new LabtestsampletypeComparator(LabtestsampletypeManager.LABTESTID, bReverse));<code>
     *
     * @param iType the field from which you want to sort.
     * <br>
     * Possible values are:
     * <ul>
     *   <li>LabtestsampletypeManager.ID_LABTESTID
     *   <li>LabtestsampletypeManager.ID_SAMPLETYPEID
     * </ul>
     *
     * @param bReverse set this value to true, if you want to reverse the sorting results
     */
    public LabtestsampletypeComparator(int iType, boolean bReverse)
    {
        this.iType = iType;
        this.bReverse = bReverse;
    }

    /**
     * Implementation of the compare method.
     */
    public int compare(Object pObj1, Object pObj2)
    {
        LabtestsampletypeBean b1 = (LabtestsampletypeBean)pObj1;
        LabtestsampletypeBean b2 = (LabtestsampletypeBean)pObj2;
        int iReturn = 0;
        switch(iType)
        {
            case LabtestsampletypeManager.ID_LABTESTID:
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
            case LabtestsampletypeManager.ID_SAMPLETYPEID:
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
            default: 
                throw new IllegalArgumentException("Type passed for the field is not supported");
        }

        return bReverse ? (-1 * iReturn) : iReturn;
    }
// class+ 

// class- 
}