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

public class SampleitemstatushistoryBean
// extends+ 

// extends- 
{
    private Long sampleitemstatushistoryid;
    private boolean sampleitemstatushistoryid_is_modified = false;
    private boolean sampleitemstatushistoryid_is_initialized = false;
    
    private Long contractsampleitemid;
    private boolean contractsampleitemid_is_modified = false;
    private boolean contractsampleitemid_is_initialized = false;
    
    private Integer status;
    private boolean status_is_modified = false;
    private boolean status_is_initialized = false;
    
    private String reason;
    private boolean reason_is_modified = false;
    private boolean reason_is_initialized = false;
    
    private String method;
    private boolean method_is_modified = false;
    private boolean method_is_initialized = false;
    
    private java.sql.Timestamp statusdate;
    private boolean statusdate_is_modified = false;
    private boolean statusdate_is_initialized = false;
    
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
    SampleitemstatushistoryBean()
    {
    }
    
    /**
     * Getter method for sampleitemstatushistoryid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemstatushistory.sampleitemstatushistoryid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of sampleitemstatushistoryid
     */
    public Long getSampleitemstatushistoryid()
    {
        return sampleitemstatushistoryid; 
    }

    /**
     * Setter method for sampleitemstatushistoryid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to sampleitemstatushistoryid
     */
    public void setSampleitemstatushistoryid(Long newVal) {
        if ((newVal != null && this.sampleitemstatushistoryid != null && (newVal.compareTo(this.sampleitemstatushistoryid) == 0)) || 
            (newVal == null && this.sampleitemstatushistoryid == null && sampleitemstatushistoryid_is_initialized)) {
            return; 
        } 
        this.sampleitemstatushistoryid = newVal; 
        sampleitemstatushistoryid_is_modified = true; 
        sampleitemstatushistoryid_is_initialized = true; 
    }

    /**
     * Setter method for sampleitemstatushistoryid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to sampleitemstatushistoryid
     */
    public void setSampleitemstatushistoryid(long newVal) {
        setSampleitemstatushistoryid(new Long(newVal));
    }

    /**
     * Determines if the sampleitemstatushistoryid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isSampleitemstatushistoryidModified() {
        return sampleitemstatushistoryid_is_modified; 
    }

    /**
     * Determines if the sampleitemstatushistoryid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isSampleitemstatushistoryidInitialized() {
        return sampleitemstatushistoryid_is_initialized; 
    }

    /**
     * Getter method for contractsampleitemid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemstatushistory.contractsampleitemid
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
     * <li>full name: sampleitemstatushistory.status
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of status
     */
    public Integer getStatus()
    {
        return status; 
    }

    /**
     * Setter method for status.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to status
     */
    public void setStatus(Integer newVal) {
        if ((newVal != null && this.status != null && (newVal.compareTo(this.status) == 0)) || 
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
    public void setStatus(int newVal) {
        setStatus(new Integer(newVal));
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
     * Getter method for reason.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemstatushistory.reason
     * <li>column size: -1
     * <li>jdbc type returned by the driver: Types.VARCHAR
     * </ul>
     *
     * @return the value of reason
     */
    public String getReason()
    {
        return reason; 
    }

    /**
     * Setter method for reason.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to reason
     */
    public void setReason(String newVal) {
        if ((newVal != null && this.reason != null && (newVal.compareTo(this.reason) == 0)) || 
            (newVal == null && this.reason == null && reason_is_initialized)) {
            return; 
        } 
        this.reason = newVal; 
        reason_is_modified = true; 
        reason_is_initialized = true; 
    }

    /**
     * Determines if the reason has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isReasonModified() {
        return reason_is_modified; 
    }

    /**
     * Determines if the reason has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isReasonInitialized() {
        return reason_is_initialized; 
    }

    /**
     * Getter method for method.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemstatushistory.method
     * <li>column size: -1
     * <li>jdbc type returned by the driver: Types.VARCHAR
     * </ul>
     *
     * @return the value of method
     */
    public String getMethod()
    {
        return method; 
    }

    /**
     * Setter method for method.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to method
     */
    public void setMethod(String newVal) {
        if ((newVal != null && this.method != null && (newVal.compareTo(this.method) == 0)) || 
            (newVal == null && this.method == null && method_is_initialized)) {
            return; 
        } 
        this.method = newVal; 
        method_is_modified = true; 
        method_is_initialized = true; 
    }

    /**
     * Determines if the method has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isMethodModified() {
        return method_is_modified; 
    }

    /**
     * Determines if the method has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isMethodInitialized() {
        return method_is_initialized; 
    }

    /**
     * Getter method for statusdate.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemstatushistory.statusdate
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.TIMESTAMP
     * </ul>
     *
     * @return the value of statusdate
     */
    public java.sql.Timestamp getStatusdate()
    {
        return statusdate; 
    }

    /**
     * Setter method for statusdate.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to statusdate
     */
    public void setStatusdate(java.sql.Timestamp newVal) {
        if ((newVal != null && this.statusdate != null && (newVal.compareTo(this.statusdate) == 0)) || 
            (newVal == null && this.statusdate == null && statusdate_is_initialized)) {
            return; 
        } 
        this.statusdate = newVal; 
        statusdate_is_modified = true; 
        statusdate_is_initialized = true; 
    }

    /**
     * Setter method for statusdate.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to statusdate
     */
    public void setStatusdate(long newVal) {
        setStatusdate(new java.sql.Timestamp(newVal));
    }

    /**
     * Determines if the statusdate has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isStatusdateModified() {
        return statusdate_is_modified; 
    }

    /**
     * Determines if the statusdate has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isStatusdateInitialized() {
        return statusdate_is_initialized; 
    }

    /**
     * Getter method for regbyid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemstatushistory.regbyid
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
     * <li>full name: sampleitemstatushistory.regdate
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
        return sampleitemstatushistoryid_is_modified || 
		contractsampleitemid_is_modified || 
		status_is_modified || 
		reason_is_modified || 
		method_is_modified || 
		statusdate_is_modified || 
		regbyid_is_modified || 
		regdate_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        sampleitemstatushistoryid_is_modified = false;
        contractsampleitemid_is_modified = false;
        status_is_modified = false;
        reason_is_modified = false;
        method_is_modified = false;
        statusdate_is_modified = false;
        regbyid_is_modified = false;
        regdate_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(SampleitemstatushistoryBean bean) {
        setSampleitemstatushistoryid(bean.getSampleitemstatushistoryid());
        setContractsampleitemid(bean.getContractsampleitemid());
        setStatus(bean.getStatus());
        setReason(bean.getReason());
        setMethod(bean.getMethod());
        setStatusdate(bean.getStatusdate());
        setRegbyid(bean.getRegbyid());
        setRegdate(bean.getRegdate());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[sampleitemstatushistory] "
                 + "\n - sampleitemstatushistory.sampleitemstatushistoryid = " + (sampleitemstatushistoryid_is_initialized ? ("[" + (sampleitemstatushistoryid == null ? null : sampleitemstatushistoryid.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemstatushistory.contractsampleitemid = " + (contractsampleitemid_is_initialized ? ("[" + (contractsampleitemid == null ? null : contractsampleitemid.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemstatushistory.status = " + (status_is_initialized ? ("[" + (status == null ? null : status.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemstatushistory.reason = " + (reason_is_initialized ? ("[" + (reason == null ? null : reason.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemstatushistory.method = " + (method_is_initialized ? ("[" + (method == null ? null : method.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemstatushistory.statusdate = " + (statusdate_is_initialized ? ("[" + (statusdate == null ? null : statusdate.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemstatushistory.regbyid = " + (regbyid_is_initialized ? ("[" + (regbyid == null ? null : regbyid.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemstatushistory.regdate = " + (regdate_is_initialized ? ("[" + (regdate == null ? null : regdate.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
