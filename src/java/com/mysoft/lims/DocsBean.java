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

public class DocsBean
// extends+ 

// extends- 
{
    private Long docsid;
    private boolean docsid_is_modified = false;
    private boolean docsid_is_initialized = false;
    
    private Integer doctypeid;
    private boolean doctypeid_is_modified = false;
    private boolean doctypeid_is_initialized = false;
    
    private Long contractid;
    private boolean contractid_is_modified = false;
    private boolean contractid_is_initialized = false;
    
    private String path;
    private boolean path_is_modified = false;
    private boolean path_is_initialized = false;
    
    private java.sql.Timestamp regdate;
    private boolean regdate_is_modified = false;
    private boolean regdate_is_initialized = false;
    
    private Integer regbyid;
    private boolean regbyid_is_modified = false;
    private boolean regbyid_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    DocsBean()
    {
    }
    
    /**
     * Getter method for docsid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: docs.docsid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of docsid
     */
    public Long getDocsid()
    {
        return docsid; 
    }

    /**
     * Setter method for docsid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to docsid
     */
    public void setDocsid(Long newVal) {
        if ((newVal != null && this.docsid != null && (newVal.compareTo(this.docsid) == 0)) || 
            (newVal == null && this.docsid == null && docsid_is_initialized)) {
            return; 
        } 
        this.docsid = newVal; 
        docsid_is_modified = true; 
        docsid_is_initialized = true; 
    }

    /**
     * Setter method for docsid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to docsid
     */
    public void setDocsid(long newVal) {
        setDocsid(new Long(newVal));
    }

    /**
     * Determines if the docsid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isDocsidModified() {
        return docsid_is_modified; 
    }

    /**
     * Determines if the docsid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isDocsidInitialized() {
        return docsid_is_initialized; 
    }

    /**
     * Getter method for doctypeid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: docs.doctypeid
     * <li> foreign key: doctype.doctypeid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of doctypeid
     */
    public Integer getDoctypeid()
    {
        return doctypeid; 
    }

    /**
     * Setter method for doctypeid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to doctypeid
     */
    public void setDoctypeid(Integer newVal) {
        if ((newVal != null && this.doctypeid != null && (newVal.compareTo(this.doctypeid) == 0)) || 
            (newVal == null && this.doctypeid == null && doctypeid_is_initialized)) {
            return; 
        } 
        this.doctypeid = newVal; 
        doctypeid_is_modified = true; 
        doctypeid_is_initialized = true; 
    }

    /**
     * Setter method for doctypeid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to doctypeid
     */
    public void setDoctypeid(int newVal) {
        setDoctypeid(new Integer(newVal));
    }

    /**
     * Determines if the doctypeid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isDoctypeidModified() {
        return doctypeid_is_modified; 
    }

    /**
     * Determines if the doctypeid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isDoctypeidInitialized() {
        return doctypeid_is_initialized; 
    }

    /**
     * Getter method for contractid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: docs.contractid
     * <li> foreign key: contract.contractid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of contractid
     */
    public Long getContractid()
    {
        return contractid; 
    }

    /**
     * Setter method for contractid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to contractid
     */
    public void setContractid(Long newVal) {
        if ((newVal != null && this.contractid != null && (newVal.compareTo(this.contractid) == 0)) || 
            (newVal == null && this.contractid == null && contractid_is_initialized)) {
            return; 
        } 
        this.contractid = newVal; 
        contractid_is_modified = true; 
        contractid_is_initialized = true; 
    }

    /**
     * Setter method for contractid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to contractid
     */
    public void setContractid(long newVal) {
        setContractid(new Long(newVal));
    }

    /**
     * Determines if the contractid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isContractidModified() {
        return contractid_is_modified; 
    }

    /**
     * Determines if the contractid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isContractidInitialized() {
        return contractid_is_initialized; 
    }

    /**
     * Getter method for path.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: docs.path
     * <li>column size: 255
     * <li>jdbc type returned by the driver: Types.VARCHAR
     * </ul>
     *
     * @return the value of path
     */
    public String getPath()
    {
        return path; 
    }

    /**
     * Setter method for path.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to path
     */
    public void setPath(String newVal) {
        if ((newVal != null && this.path != null && (newVal.compareTo(this.path) == 0)) || 
            (newVal == null && this.path == null && path_is_initialized)) {
            return; 
        } 
        this.path = newVal; 
        path_is_modified = true; 
        path_is_initialized = true; 
    }

    /**
     * Determines if the path has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isPathModified() {
        return path_is_modified; 
    }

    /**
     * Determines if the path has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isPathInitialized() {
        return path_is_initialized; 
    }

    /**
     * Getter method for regdate.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: docs.regdate
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
     * Getter method for regbyid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: docs.regbyid
     * <li> foreign key: personell.personellid
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
        return docsid_is_modified || 
		doctypeid_is_modified || 
		contractid_is_modified || 
		path_is_modified || 
		regdate_is_modified || 
		regbyid_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        docsid_is_modified = false;
        doctypeid_is_modified = false;
        contractid_is_modified = false;
        path_is_modified = false;
        regdate_is_modified = false;
        regbyid_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(DocsBean bean) {
        setDocsid(bean.getDocsid());
        setDoctypeid(bean.getDoctypeid());
        setContractid(bean.getContractid());
        setPath(bean.getPath());
        setRegdate(bean.getRegdate());
        setRegbyid(bean.getRegbyid());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[docs] "
                 + "\n - docs.docsid = " + (docsid_is_initialized ? ("[" + (docsid == null ? null : docsid.toString()) + "]") : "not initialized") + ""
                 + "\n - docs.doctypeid = " + (doctypeid_is_initialized ? ("[" + (doctypeid == null ? null : doctypeid.toString()) + "]") : "not initialized") + ""
                 + "\n - docs.contractid = " + (contractid_is_initialized ? ("[" + (contractid == null ? null : contractid.toString()) + "]") : "not initialized") + ""
                 + "\n - docs.path = " + (path_is_initialized ? ("[" + (path == null ? null : path.toString()) + "]") : "not initialized") + ""
                 + "\n - docs.regdate = " + (regdate_is_initialized ? ("[" + (regdate == null ? null : regdate.toString()) + "]") : "not initialized") + ""
                 + "\n - docs.regbyid = " + (regbyid_is_initialized ? ("[" + (regbyid == null ? null : regbyid.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
