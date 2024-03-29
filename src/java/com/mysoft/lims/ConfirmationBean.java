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

public class ConfirmationBean
// extends+ 

// extends- 
{
    private Long confirmationid;
    private boolean confirmationid_is_modified = false;
    private boolean confirmationid_is_initialized = false;
    
    private Long contractsampleitemid;
    private boolean contractsampleitemid_is_modified = false;
    private boolean contractsampleitemid_is_initialized = false;
    
    private Boolean status;
    private boolean status_is_modified = false;
    private boolean status_is_initialized = false;
    
    private Integer regbyid;
    private boolean regbyid_is_modified = false;
    private boolean regbyid_is_initialized = false;
    
    private java.sql.Timestamp regdate;
    private boolean regdate_is_modified = false;
    private boolean regdate_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    ConfirmationBean()
    {
    }
    
    /**
     * Getter method for confirmationid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: confirmation.confirmationid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of confirmationid
     */
    public Long getConfirmationid()
    {
        return confirmationid; 
    }

    /**
     * Setter method for confirmationid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to confirmationid
     */
    public void setConfirmationid(Long newVal) {
        if ((newVal != null && this.confirmationid != null && (newVal.compareTo(this.confirmationid) == 0)) || 
            (newVal == null && this.confirmationid == null && confirmationid_is_initialized)) {
            return; 
        } 
        this.confirmationid = newVal; 
        confirmationid_is_modified = true; 
        confirmationid_is_initialized = true; 
    }

    /**
     * Setter method for confirmationid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to confirmationid
     */
    public void setConfirmationid(long newVal) {
        setConfirmationid(new Long(newVal));
    }

    /**
     * Determines if the confirmationid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isConfirmationidModified() {
        return confirmationid_is_modified; 
    }

    /**
     * Determines if the confirmationid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isConfirmationidInitialized() {
        return confirmationid_is_initialized; 
    }

    /**
     * Getter method for contractsampleitemid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: confirmation.contractsampleitemid
     * <li> foreign key: contractsampleitem.contractsampleitemid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of contractsampleitemid
     */
    public Long getContractsampleitemid()
    {
        return contractsampleitemid; 
    }

    /**
     * Setter method for contractsampleitemid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to contractsampleitemid
     */
    public void setContractsampleitemid(Long newVal) {
        if ((newVal != null && this.contractsampleitemid != null && (newVal.compareTo(this.contractsampleitemid) == 0)) || 
            (newVal == null && this.contractsampleitemid == null && contractsampleitemid_is_initialized)) {
            return; 
        } 
        this.contractsampleitemid = newVal; 
        contractsampleitemid_is_modified = true; 
        contractsampleitemid_is_initialized = true; 
    }

    /**
     * Setter method for contractsampleitemid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to contractsampleitemid
     */
    public void setContractsampleitemid(long newVal) {
        setContractsampleitemid(new Long(newVal));
    }

    /**
     * Determines if the contractsampleitemid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isContractsampleitemidModified() {
        return contractsampleitemid_is_modified; 
    }

    /**
     * Determines if the contractsampleitemid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isContractsampleitemidInitialized() {
        return contractsampleitemid_is_initialized; 
    }

    /**
     * Getter method for status.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: confirmation.status
     * <li>column size: 1
     * <li>jdbc type returned by the driver: Types.BIT
     * </ul>
     *
     * @return the value of status
     */
    public Boolean getStatus()
    {
        return status; 
    }

    /**
     * Setter method for status.
     * <br>
     * Attention, there will be no comparison with current value which
     * means calling this method will mark the field as 'modified' in all cases.
     *
     * @param newVal the new value to be assigned to status
     */
    public void setStatus(Boolean newVal) {
        if ((newVal != null && this.status != null && newVal.equals(this.status)) || 
            (newVal == null && this.status == null && status_is_initialized)) {
            return; 
        } 
        this.status = newVal; 
        status_is_modified = true; 
        status_is_initialized = true; 
    }

    /**
     * Setter method for status.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to status
     */
    public void setStatus(boolean newVal) {
        setStatus(new Boolean(newVal));
    }

    /**
     * Determines if the status has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isStatusModified() {
        return status_is_modified; 
    }

    /**
     * Determines if the status has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isStatusInitialized() {
        return status_is_initialized; 
    }

    /**
     * Getter method for regbyid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: confirmation.regbyid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of regbyid
     */
    public Integer getRegbyid()
    {
        return regbyid; 
    }

    /**
     * Setter method for regbyid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to regbyid
     */
    public void setRegbyid(Integer newVal) {
        if ((newVal != null && this.regbyid != null && (newVal.compareTo(this.regbyid) == 0)) || 
            (newVal == null && this.regbyid == null && regbyid_is_initialized)) {
            return; 
        } 
        this.regbyid = newVal; 
        regbyid_is_modified = true; 
        regbyid_is_initialized = true; 
    }

    /**
     * Setter method for regbyid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to regbyid
     */
    public void setRegbyid(int newVal) {
        setRegbyid(new Integer(newVal));
    }

    /**
     * Determines if the regbyid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isRegbyidModified() {
        return regbyid_is_modified; 
    }

    /**
     * Determines if the regbyid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isRegbyidInitialized() {
        return regbyid_is_initialized; 
    }

    /**
     * Getter method for regdate.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: confirmation.regdate
     * <li>default value: now()
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.TIMESTAMP
     * </ul>
     *
     * @return the value of regdate
     */
    public java.sql.Timestamp getRegdate()
    {
        return regdate; 
    }

    /**
     * Setter method for regdate.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to regdate
     */
    public void setRegdate(java.sql.Timestamp newVal) {
        if ((newVal != null && this.regdate != null && (newVal.compareTo(this.regdate) == 0)) || 
            (newVal == null && this.regdate == null && regdate_is_initialized)) {
            return; 
        } 
        this.regdate = newVal; 
        regdate_is_modified = true; 
        regdate_is_initialized = true; 
    }

    /**
     * Setter method for regdate.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to regdate
     */
    public void setRegdate(long newVal) {
        setRegdate(new java.sql.Timestamp(newVal));
    }

    /**
     * Determines if the regdate has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isRegdateModified() {
        return regdate_is_modified; 
    }

    /**
     * Determines if the regdate has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isRegdateInitialized() {
        return regdate_is_initialized; 
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
        return confirmationid_is_modified || 
		contractsampleitemid_is_modified || 
		status_is_modified || 
		regbyid_is_modified || 
		regdate_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        confirmationid_is_modified = false;
        contractsampleitemid_is_modified = false;
        status_is_modified = false;
        regbyid_is_modified = false;
        regdate_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(ConfirmationBean bean) {
        setConfirmationid(bean.getConfirmationid());
        setContractsampleitemid(bean.getContractsampleitemid());
        setStatus(bean.getStatus());
        setRegbyid(bean.getRegbyid());
        setRegdate(bean.getRegdate());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[confirmation] "
                 + "\n - confirmation.confirmationid = " + (confirmationid_is_initialized ? ("[" + (confirmationid == null ? null : confirmationid.toString()) + "]") : "not initialized") + ""
                 + "\n - confirmation.contractsampleitemid = " + (contractsampleitemid_is_initialized ? ("[" + (contractsampleitemid == null ? null : contractsampleitemid.toString()) + "]") : "not initialized") + ""
                 + "\n - confirmation.status = " + (status_is_initialized ? ("[" + (status == null ? null : status.toString()) + "]") : "not initialized") + ""
                 + "\n - confirmation.regbyid = " + (regbyid_is_initialized ? ("[" + (regbyid == null ? null : regbyid.toString()) + "]") : "not initialized") + ""
                 + "\n - confirmation.regdate = " + (regdate_is_initialized ? ("[" + (regdate == null ? null : regdate.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
