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

public class SampleitemreseachstatushistoryBean
// extends+ 

// extends- 
{
    private Long sampleitemreseachstatushistoryid;
    private boolean sampleitemreseachstatushistoryid_is_modified = false;
    private boolean sampleitemreseachstatushistoryid_is_initialized = false;
    
    private Long sampleitemreseachid;
    private boolean sampleitemreseachid_is_modified = false;
    private boolean sampleitemreseachid_is_initialized = false;
    
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
    SampleitemreseachstatushistoryBean()
    {
    }
    
    /**
     * Getter method for sampleitemreseachstatushistoryid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemreseachstatushistory.sampleitemreseachstatushistoryid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of sampleitemreseachstatushistoryid
     */
    public Long getSampleitemreseachstatushistoryid()
    {
        return sampleitemreseachstatushistoryid; 
    }

    /**
     * Setter method for sampleitemreseachstatushistoryid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to sampleitemreseachstatushistoryid
     */
    public void setSampleitemreseachstatushistoryid(Long newVal) {
        if ((newVal != null && this.sampleitemreseachstatushistoryid != null && (newVal.compareTo(this.sampleitemreseachstatushistoryid) == 0)) || 
            (newVal == null && this.sampleitemreseachstatushistoryid == null && sampleitemreseachstatushistoryid_is_initialized)) {
            return; 
        } 
        this.sampleitemreseachstatushistoryid = newVal; 
        sampleitemreseachstatushistoryid_is_modified = true; 
        sampleitemreseachstatushistoryid_is_initialized = true; 
    }

    /**
     * Setter method for sampleitemreseachstatushistoryid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to sampleitemreseachstatushistoryid
     */
    public void setSampleitemreseachstatushistoryid(long newVal) {
        setSampleitemreseachstatushistoryid(new Long(newVal));
    }

    /**
     * Determines if the sampleitemreseachstatushistoryid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isSampleitemreseachstatushistoryidModified() {
        return sampleitemreseachstatushistoryid_is_modified; 
    }

    /**
     * Determines if the sampleitemreseachstatushistoryid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isSampleitemreseachstatushistoryidInitialized() {
        return sampleitemreseachstatushistoryid_is_initialized; 
    }

    /**
     * Getter method for sampleitemreseachid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemreseachstatushistory.sampleitemreseachid
     * <li> foreign key: sampleitemreseach.sampleitemreseachid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of sampleitemreseachid
     */
    public Long getSampleitemreseachid()
    {
        return sampleitemreseachid; 
    }

    /**
     * Setter method for sampleitemreseachid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to sampleitemreseachid
     */
    public void setSampleitemreseachid(Long newVal) {
        if ((newVal != null && this.sampleitemreseachid != null && (newVal.compareTo(this.sampleitemreseachid) == 0)) || 
            (newVal == null && this.sampleitemreseachid == null && sampleitemreseachid_is_initialized)) {
            return; 
        } 
        this.sampleitemreseachid = newVal; 
        sampleitemreseachid_is_modified = true; 
        sampleitemreseachid_is_initialized = true; 
    }

    /**
     * Setter method for sampleitemreseachid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to sampleitemreseachid
     */
    public void setSampleitemreseachid(long newVal) {
        setSampleitemreseachid(new Long(newVal));
    }

    /**
     * Determines if the sampleitemreseachid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isSampleitemreseachidModified() {
        return sampleitemreseachid_is_modified; 
    }

    /**
     * Determines if the sampleitemreseachid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isSampleitemreseachidInitialized() {
        return sampleitemreseachid_is_initialized; 
    }

    /**
     * Getter method for status.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampleitemreseachstatushistory.status
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
     * <li>full name: sampleitemreseachstatushistory.reason
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
     * <li>full name: sampleitemreseachstatushistory.method
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
     * <li>full name: sampleitemreseachstatushistory.statusdate
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
     * <li>full name: sampleitemreseachstatushistory.regbyid
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
     * <li>full name: sampleitemreseachstatushistory.regdate
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
        return sampleitemreseachstatushistoryid_is_modified || 
		sampleitemreseachid_is_modified || 
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
        sampleitemreseachstatushistoryid_is_modified = false;
        sampleitemreseachid_is_modified = false;
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
    public void copy(SampleitemreseachstatushistoryBean bean) {
        setSampleitemreseachstatushistoryid(bean.getSampleitemreseachstatushistoryid());
        setSampleitemreseachid(bean.getSampleitemreseachid());
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
        return   "\n[sampleitemreseachstatushistory] "
                 + "\n - sampleitemreseachstatushistory.sampleitemreseachstatushistoryid = " + (sampleitemreseachstatushistoryid_is_initialized ? ("[" + (sampleitemreseachstatushistoryid == null ? null : sampleitemreseachstatushistoryid.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemreseachstatushistory.sampleitemreseachid = " + (sampleitemreseachid_is_initialized ? ("[" + (sampleitemreseachid == null ? null : sampleitemreseachid.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemreseachstatushistory.status = " + (status_is_initialized ? ("[" + (status == null ? null : status.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemreseachstatushistory.reason = " + (reason_is_initialized ? ("[" + (reason == null ? null : reason.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemreseachstatushistory.method = " + (method_is_initialized ? ("[" + (method == null ? null : method.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemreseachstatushistory.statusdate = " + (statusdate_is_initialized ? ("[" + (statusdate == null ? null : statusdate.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemreseachstatushistory.regbyid = " + (regbyid_is_initialized ? ("[" + (regbyid == null ? null : regbyid.toString()) + "]") : "not initialized") + ""
                 + "\n - sampleitemreseachstatushistory.regdate = " + (regdate_is_initialized ? ("[" + (regdate == null ? null : regdate.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
