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

public class StockBean
// extends+ 

// extends- 
{
    private Integer stockid;
    private boolean stockid_is_modified = false;
    private boolean stockid_is_initialized = false;
    
    private Integer parentid;
    private boolean parentid_is_modified = false;
    private boolean parentid_is_initialized = false;
    
    private String name;
    private boolean name_is_modified = false;
    private boolean name_is_initialized = false;
    
    private Integer companyid;
    private boolean companyid_is_modified = false;
    private boolean companyid_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    StockBean()
    {
    }
    
    /**
     * Getter method for stockid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: stock.stockid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of stockid
     */
    public Integer getStockid()
    {
        return stockid; 
    }

    /**
     * Setter method for stockid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to stockid
     */
    public void setStockid(Integer newVal) {
        if ((newVal != null && this.stockid != null && (newVal.compareTo(this.stockid) == 0)) || 
            (newVal == null && this.stockid == null && stockid_is_initialized)) {
            return; 
        } 
        this.stockid = newVal; 
        stockid_is_modified = true; 
        stockid_is_initialized = true; 
    }

    /**
     * Setter method for stockid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to stockid
     */
    public void setStockid(int newVal) {
        setStockid(new Integer(newVal));
    }

    /**
     * Determines if the stockid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isStockidModified() {
        return stockid_is_modified; 
    }

    /**
     * Determines if the stockid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isStockidInitialized() {
        return stockid_is_initialized; 
    }

    /**
     * Getter method for parentid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: stock.parentid
     * <li> foreign key: stock.stockid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of parentid
     */
    public Integer getParentid()
    {
        return parentid; 
    }

    /**
     * Setter method for parentid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to parentid
     */
    public void setParentid(Integer newVal) {
        if ((newVal != null && this.parentid != null && (newVal.compareTo(this.parentid) == 0)) || 
            (newVal == null && this.parentid == null && parentid_is_initialized)) {
            return; 
        } 
        this.parentid = newVal; 
        parentid_is_modified = true; 
        parentid_is_initialized = true; 
    }

    /**
     * Setter method for parentid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to parentid
     */
    public void setParentid(int newVal) {
        setParentid(new Integer(newVal));
    }

    /**
     * Determines if the parentid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isParentidModified() {
        return parentid_is_modified; 
    }

    /**
     * Determines if the parentid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isParentidInitialized() {
        return parentid_is_initialized; 
    }

    /**
     * Getter method for name.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: stock.name
     * <li>column size: -1
     * <li>jdbc type returned by the driver: Types.VARCHAR
     * </ul>
     *
     * @return the value of name
     */
    public String getName()
    {
        return name; 
    }

    /**
     * Setter method for name.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to name
     */
    public void setName(String newVal) {
        if ((newVal != null && this.name != null && (newVal.compareTo(this.name) == 0)) || 
            (newVal == null && this.name == null && name_is_initialized)) {
            return; 
        } 
        this.name = newVal; 
        name_is_modified = true; 
        name_is_initialized = true; 
    }

    /**
     * Determines if the name has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isNameModified() {
        return name_is_modified; 
    }

    /**
     * Determines if the name has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isNameInitialized() {
        return name_is_initialized; 
    }

    /**
     * Getter method for companyid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: stock.companyid
     * <li> foreign key: company.companyid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of companyid
     */
    public Integer getCompanyid()
    {
        return companyid; 
    }

    /**
     * Setter method for companyid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to companyid
     */
    public void setCompanyid(Integer newVal) {
        if ((newVal != null && this.companyid != null && (newVal.compareTo(this.companyid) == 0)) || 
            (newVal == null && this.companyid == null && companyid_is_initialized)) {
            return; 
        } 
        this.companyid = newVal; 
        companyid_is_modified = true; 
        companyid_is_initialized = true; 
    }

    /**
     * Setter method for companyid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to companyid
     */
    public void setCompanyid(int newVal) {
        setCompanyid(new Integer(newVal));
    }

    /**
     * Determines if the companyid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isCompanyidModified() {
        return companyid_is_modified; 
    }

    /**
     * Determines if the companyid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isCompanyidInitialized() {
        return companyid_is_initialized; 
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
        return stockid_is_modified || 
		parentid_is_modified || 
		name_is_modified || 
		companyid_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        stockid_is_modified = false;
        parentid_is_modified = false;
        name_is_modified = false;
        companyid_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(StockBean bean) {
        setStockid(bean.getStockid());
        setParentid(bean.getParentid());
        setName(bean.getName());
        setCompanyid(bean.getCompanyid());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[stock] "
                 + "\n - stock.stockid = " + (stockid_is_initialized ? ("[" + (stockid == null ? null : stockid.toString()) + "]") : "not initialized") + ""
                 + "\n - stock.parentid = " + (parentid_is_initialized ? ("[" + (parentid == null ? null : parentid.toString()) + "]") : "not initialized") + ""
                 + "\n - stock.name = " + (name_is_initialized ? ("[" + (name == null ? null : name.toString()) + "]") : "not initialized") + ""
                 + "\n - stock.companyid = " + (companyid_is_initialized ? ("[" + (companyid == null ? null : companyid.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
