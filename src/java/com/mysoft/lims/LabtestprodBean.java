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

// imports+ 

// imports- 

public class LabtestprodBean
// extends+ 

// extends- 
{
    private Integer labtestid;
    private boolean labtestid_is_modified = false;
    private boolean labtestid_is_initialized = false;
    
    private Long productid;
    private boolean productid_is_modified = false;
    private boolean productid_is_initialized = false;
    
    private Double qty;
    private boolean qty_is_modified = false;
    private boolean qty_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    LabtestprodBean()
    {
    }
    
    /**
     * Getter method for labtestid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: labtestprod.labtestid
     * <li> foreign key: labtest.labtestid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of labtestid
     */
    public Integer getLabtestid()
    {
        return labtestid; 
    }

    /**
     * Setter method for labtestid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to labtestid
     */
    public void setLabtestid(Integer newVal) {
        if ((newVal != null && this.labtestid != null && (newVal.compareTo(this.labtestid) == 0)) || 
            (newVal == null && this.labtestid == null && labtestid_is_initialized)) {
            return; 
        } 
        this.labtestid = newVal; 
        labtestid_is_modified = true; 
        labtestid_is_initialized = true; 
    }

    /**
     * Setter method for labtestid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to labtestid
     */
    public void setLabtestid(int newVal) {
        setLabtestid(new Integer(newVal));
    }

    /**
     * Determines if the labtestid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isLabtestidModified() {
        return labtestid_is_modified; 
    }

    /**
     * Determines if the labtestid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isLabtestidInitialized() {
        return labtestid_is_initialized; 
    }

    /**
     * Getter method for productid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: labtestprod.productid
     * <li> foreign key: product.productid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of productid
     */
    public Long getProductid()
    {
        return productid; 
    }

    /**
     * Setter method for productid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to productid
     */
    public void setProductid(Long newVal) {
        if ((newVal != null && this.productid != null && (newVal.compareTo(this.productid) == 0)) || 
            (newVal == null && this.productid == null && productid_is_initialized)) {
            return; 
        } 
        this.productid = newVal; 
        productid_is_modified = true; 
        productid_is_initialized = true; 
    }

    /**
     * Setter method for productid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to productid
     */
    public void setProductid(long newVal) {
        setProductid(new Long(newVal));
    }

    /**
     * Determines if the productid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isProductidModified() {
        return productid_is_modified; 
    }

    /**
     * Determines if the productid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isProductidInitialized() {
        return productid_is_initialized; 
    }

    /**
     * Getter method for qty.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: labtestprod.qty
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.DOUBLE
     * </ul>
     *
     * @return the value of qty
     */
    public Double getQty()
    {
        return qty; 
    }

    /**
     * Setter method for qty.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to qty
     */
    public void setQty(Double newVal) {
        if ((newVal != null && this.qty != null && (newVal.compareTo(this.qty) == 0)) || 
            (newVal == null && this.qty == null && qty_is_initialized)) {
            return; 
        } 
        this.qty = newVal; 
        qty_is_modified = true; 
        qty_is_initialized = true; 
    }

    /**
     * Setter method for qty.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to qty
     */
    public void setQty(double newVal) {
        setQty(new Double(newVal));
    }

    /**
     * Determines if the qty has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isQtyModified() {
        return qty_is_modified; 
    }

    /**
     * Determines if the qty has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isQtyInitialized() {
        return qty_is_initialized; 
    }

    /**
     * Determines if the current object is new.
     *
     * @return true if the current object is new, false if the object is not new
     */
    public boolean isNew() {
        return _isNew;
    }

    /**
     * Specifies to the object if it has been set as new.
     *
     * @param isNew the boolean value to be assigned to the isNew field
     */
    public void isNew(boolean isNew) {
        this._isNew = isNew;
    }

    /**
     * Determines if the object has been modified since the last time this method was called.
     * <br>
     * We can also determine if this object has ever been modified since its creation.
     *
     * @return true if the object has been modified, false if the object has not been modified
     */
    public boolean isModified() {
        return labtestid_is_modified || 
		productid_is_modified || 
		qty_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        labtestid_is_modified = false;
        productid_is_modified = false;
        qty_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(LabtestprodBean bean) {
        setLabtestid(bean.getLabtestid());
        setProductid(bean.getProductid());
        setQty(bean.getQty());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[labtestprod] "
                 + "\n - labtestprod.labtestid = " + (labtestid_is_initialized ? ("[" + (labtestid == null ? null : labtestid.toString()) + "]") : "not initialized") + ""
                 + "\n - labtestprod.productid = " + (productid_is_initialized ? ("[" + (productid == null ? null : productid.toString()) + "]") : "not initialized") + ""
                 + "\n - labtestprod.qty = " + (qty_is_initialized ? ("[" + (qty == null ? null : qty.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
