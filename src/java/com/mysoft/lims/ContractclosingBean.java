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

public class ContractclosingBean
// extends+ 

// extends- 
{
    private Long contractclosingid;
    private boolean contractclosingid_is_modified = false;
    private boolean contractclosingid_is_initialized = false;
    
    private Long contractid;
    private boolean contractid_is_modified = false;
    private boolean contractid_is_initialized = false;
    
    private Integer institutionid;
    private boolean institutionid_is_modified = false;
    private boolean institutionid_is_initialized = false;
    
    private Boolean isinfo;
    private boolean isinfo_is_modified = false;
    private boolean isinfo_is_initialized = false;
    
    private java.sql.Timestamp reminddate;
    private boolean reminddate_is_modified = false;
    private boolean reminddate_is_initialized = false;
    
    private java.sql.Timestamp takedate;
    private boolean takedate_is_modified = false;
    private boolean takedate_is_initialized = false;
    
    private String personels;
    private boolean personels_is_modified = false;
    private boolean personels_is_initialized = false;
    
    private Integer regbyid;
    private boolean regbyid_is_modified = false;
    private boolean regbyid_is_initialized = false;
    
    private java.sql.Timestamp regdate;
    private boolean regdate_is_modified = false;
    private boolean regdate_is_initialized = false;
    
    private Boolean deleted;
    private boolean deleted_is_modified = false;
    private boolean deleted_is_initialized = false;
    
    private Long appealid;
    private boolean appealid_is_modified = false;
    private boolean appealid_is_initialized = false;
    
    private Long actid;
    private boolean actid_is_modified = false;
    private boolean actid_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    ContractclosingBean()
    {
    }
    
    /**
     * Getter method for contractclosingid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.contractclosingid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of contractclosingid
     */
    public Long getContractclosingid()
    {
        return contractclosingid; 
    }

    /**
     * Setter method for contractclosingid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to contractclosingid
     */
    public void setContractclosingid(Long newVal) {
        if ((newVal != null && this.contractclosingid != null && (newVal.compareTo(this.contractclosingid) == 0)) || 
            (newVal == null && this.contractclosingid == null && contractclosingid_is_initialized)) {
            return; 
        } 
        this.contractclosingid = newVal; 
        contractclosingid_is_modified = true; 
        contractclosingid_is_initialized = true; 
    }

    /**
     * Setter method for contractclosingid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to contractclosingid
     */
    public void setContractclosingid(long newVal) {
        setContractclosingid(new Long(newVal));
    }

    /**
     * Determines if the contractclosingid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isContractclosingidModified() {
        return contractclosingid_is_modified; 
    }

    /**
     * Determines if the contractclosingid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isContractclosingidInitialized() {
        return contractclosingid_is_initialized; 
    }

    /**
     * Getter method for contractid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.contractid
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
     * Getter method for institutionid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.institutionid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of institutionid
     */
    public Integer getInstitutionid()
    {
        return institutionid; 
    }

    /**
     * Setter method for institutionid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to institutionid
     */
    public void setInstitutionid(Integer newVal) {
        if ((newVal != null && this.institutionid != null && (newVal.compareTo(this.institutionid) == 0)) || 
            (newVal == null && this.institutionid == null && institutionid_is_initialized)) {
            return; 
        } 
        this.institutionid = newVal; 
        institutionid_is_modified = true; 
        institutionid_is_initialized = true; 
    }

    /**
     * Setter method for institutionid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to institutionid
     */
    public void setInstitutionid(int newVal) {
        setInstitutionid(new Integer(newVal));
    }

    /**
     * Determines if the institutionid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isInstitutionidModified() {
        return institutionid_is_modified; 
    }

    /**
     * Determines if the institutionid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isInstitutionidInitialized() {
        return institutionid_is_initialized; 
    }

    /**
     * Getter method for isinfo.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.isinfo
     * <li>default value: false
     * <li>column size: 1
     * <li>jdbc type returned by the driver: Types.BIT
     * </ul>
     *
     * @return the value of isinfo
     */
    public Boolean getIsinfo()
    {
        return isinfo; 
    }

    /**
     * Setter method for isinfo.
     * <br>
     * Attention, there will be no comparison with current value which
     * means calling this method will mark the field as 'modified' in all cases.
     *
     * @param newVal the new value to be assigned to isinfo
     */
    public void setIsinfo(Boolean newVal) {
        if ((newVal != null && this.isinfo != null && newVal.equals(this.isinfo)) || 
            (newVal == null && this.isinfo == null && isinfo_is_initialized)) {
            return; 
        } 
        this.isinfo = newVal; 
        isinfo_is_modified = true; 
        isinfo_is_initialized = true; 
    }

    /**
     * Setter method for isinfo.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to isinfo
     */
    public void setIsinfo(boolean newVal) {
        setIsinfo(new Boolean(newVal));
    }

    /**
     * Determines if the isinfo has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isIsinfoModified() {
        return isinfo_is_modified; 
    }

    /**
     * Determines if the isinfo has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isIsinfoInitialized() {
        return isinfo_is_initialized; 
    }

    /**
     * Getter method for reminddate.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.reminddate
     * <li>default value: now()
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.TIMESTAMP
     * </ul>
     *
     * @return the value of reminddate
     */
    public java.sql.Timestamp getReminddate()
    {
        return reminddate; 
    }

    /**
     * Setter method for reminddate.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to reminddate
     */
    public void setReminddate(java.sql.Timestamp newVal) {
        if ((newVal != null && this.reminddate != null && (newVal.compareTo(this.reminddate) == 0)) || 
            (newVal == null && this.reminddate == null && reminddate_is_initialized)) {
            return; 
        } 
        this.reminddate = newVal; 
        reminddate_is_modified = true; 
        reminddate_is_initialized = true; 
    }

    /**
     * Setter method for reminddate.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to reminddate
     */
    public void setReminddate(long newVal) {
        setReminddate(new java.sql.Timestamp(newVal));
    }

    /**
     * Determines if the reminddate has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isReminddateModified() {
        return reminddate_is_modified; 
    }

    /**
     * Determines if the reminddate has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isReminddateInitialized() {
        return reminddate_is_initialized; 
    }

    /**
     * Getter method for takedate.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.takedate
     * <li>default value: now()
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.TIMESTAMP
     * </ul>
     *
     * @return the value of takedate
     */
    public java.sql.Timestamp getTakedate()
    {
        return takedate; 
    }

    /**
     * Setter method for takedate.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to takedate
     */
    public void setTakedate(java.sql.Timestamp newVal) {
        if ((newVal != null && this.takedate != null && (newVal.compareTo(this.takedate) == 0)) || 
            (newVal == null && this.takedate == null && takedate_is_initialized)) {
            return; 
        } 
        this.takedate = newVal; 
        takedate_is_modified = true; 
        takedate_is_initialized = true; 
    }

    /**
     * Setter method for takedate.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to takedate
     */
    public void setTakedate(long newVal) {
        setTakedate(new java.sql.Timestamp(newVal));
    }

    /**
     * Determines if the takedate has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isTakedateModified() {
        return takedate_is_modified; 
    }

    /**
     * Determines if the takedate has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isTakedateInitialized() {
        return takedate_is_initialized; 
    }

    /**
     * Getter method for personels.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.personels
     * <li>column size: -1
     * <li>jdbc type returned by the driver: Types.VARCHAR
     * </ul>
     *
     * @return the value of personels
     */
    public String getPersonels()
    {
        return personels; 
    }

    /**
     * Setter method for personels.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to personels
     */
    public void setPersonels(String newVal) {
        if ((newVal != null && this.personels != null && (newVal.compareTo(this.personels) == 0)) || 
            (newVal == null && this.personels == null && personels_is_initialized)) {
            return; 
        } 
        this.personels = newVal; 
        personels_is_modified = true; 
        personels_is_initialized = true; 
    }

    /**
     * Determines if the personels has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isPersonelsModified() {
        return personels_is_modified; 
    }

    /**
     * Determines if the personels has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isPersonelsInitialized() {
        return personels_is_initialized; 
    }

    /**
     * Getter method for regbyid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.regbyid
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
     * <li>full name: contractclosing.regdate
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
     * Getter method for deleted.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.deleted
     * <li>default value: false
     * <li>column size: 1
     * <li>jdbc type returned by the driver: Types.BIT
     * </ul>
     *
     * @return the value of deleted
     */
    public Boolean getDeleted()
    {
        return deleted; 
    }

    /**
     * Setter method for deleted.
     * <br>
     * Attention, there will be no comparison with current value which
     * means calling this method will mark the field as 'modified' in all cases.
     *
     * @param newVal the new value to be assigned to deleted
     */
    public void setDeleted(Boolean newVal) {
        if ((newVal != null && this.deleted != null && newVal.equals(this.deleted)) || 
            (newVal == null && this.deleted == null && deleted_is_initialized)) {
            return; 
        } 
        this.deleted = newVal; 
        deleted_is_modified = true; 
        deleted_is_initialized = true; 
    }

    /**
     * Setter method for deleted.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to deleted
     */
    public void setDeleted(boolean newVal) {
        setDeleted(new Boolean(newVal));
    }

    /**
     * Determines if the deleted has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isDeletedModified() {
        return deleted_is_modified; 
    }

    /**
     * Determines if the deleted has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isDeletedInitialized() {
        return deleted_is_initialized; 
    }

    /**
     * Getter method for appealid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.appealid
     * <li> foreign key: appeal.appealid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of appealid
     */
    public Long getAppealid()
    {
        return appealid; 
    }

    /**
     * Setter method for appealid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to appealid
     */
    public void setAppealid(Long newVal) {
        if ((newVal != null && this.appealid != null && (newVal.compareTo(this.appealid) == 0)) || 
            (newVal == null && this.appealid == null && appealid_is_initialized)) {
            return; 
        } 
        this.appealid = newVal; 
        appealid_is_modified = true; 
        appealid_is_initialized = true; 
    }

    /**
     * Setter method for appealid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to appealid
     */
    public void setAppealid(long newVal) {
        setAppealid(new Long(newVal));
    }

    /**
     * Determines if the appealid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isAppealidModified() {
        return appealid_is_modified; 
    }

    /**
     * Determines if the appealid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isAppealidInitialized() {
        return appealid_is_initialized; 
    }

    /**
     * Getter method for actid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractclosing.actid
     * <li> foreign key: act.actid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of actid
     */
    public Long getActid()
    {
        return actid; 
    }

    /**
     * Setter method for actid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to actid
     */
    public void setActid(Long newVal) {
        if ((newVal != null && this.actid != null && (newVal.compareTo(this.actid) == 0)) || 
            (newVal == null && this.actid == null && actid_is_initialized)) {
            return; 
        } 
        this.actid = newVal; 
        actid_is_modified = true; 
        actid_is_initialized = true; 
    }

    /**
     * Setter method for actid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to actid
     */
    public void setActid(long newVal) {
        setActid(new Long(newVal));
    }

    /**
     * Determines if the actid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isActidModified() {
        return actid_is_modified; 
    }

    /**
     * Determines if the actid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isActidInitialized() {
        return actid_is_initialized; 
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
        return contractclosingid_is_modified || 
		contractid_is_modified || 
		institutionid_is_modified || 
		isinfo_is_modified || 
		reminddate_is_modified || 
		takedate_is_modified || 
		personels_is_modified || 
		regbyid_is_modified || 
		regdate_is_modified || 
		deleted_is_modified || 
		appealid_is_modified || 
		actid_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        contractclosingid_is_modified = false;
        contractid_is_modified = false;
        institutionid_is_modified = false;
        isinfo_is_modified = false;
        reminddate_is_modified = false;
        takedate_is_modified = false;
        personels_is_modified = false;
        regbyid_is_modified = false;
        regdate_is_modified = false;
        deleted_is_modified = false;
        appealid_is_modified = false;
        actid_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(ContractclosingBean bean) {
        setContractclosingid(bean.getContractclosingid());
        setContractid(bean.getContractid());
        setInstitutionid(bean.getInstitutionid());
        setIsinfo(bean.getIsinfo());
        setReminddate(bean.getReminddate());
        setTakedate(bean.getTakedate());
        setPersonels(bean.getPersonels());
        setRegbyid(bean.getRegbyid());
        setRegdate(bean.getRegdate());
        setDeleted(bean.getDeleted());
        setAppealid(bean.getAppealid());
        setActid(bean.getActid());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[contractclosing] "
                 + "\n - contractclosing.contractclosingid = " + (contractclosingid_is_initialized ? ("[" + (contractclosingid == null ? null : contractclosingid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.contractid = " + (contractid_is_initialized ? ("[" + (contractid == null ? null : contractid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.institutionid = " + (institutionid_is_initialized ? ("[" + (institutionid == null ? null : institutionid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.isinfo = " + (isinfo_is_initialized ? ("[" + (isinfo == null ? null : isinfo.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.reminddate = " + (reminddate_is_initialized ? ("[" + (reminddate == null ? null : reminddate.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.takedate = " + (takedate_is_initialized ? ("[" + (takedate == null ? null : takedate.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.personels = " + (personels_is_initialized ? ("[" + (personels == null ? null : personels.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.regbyid = " + (regbyid_is_initialized ? ("[" + (regbyid == null ? null : regbyid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.regdate = " + (regdate_is_initialized ? ("[" + (regdate == null ? null : regdate.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.deleted = " + (deleted_is_initialized ? ("[" + (deleted == null ? null : deleted.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.appealid = " + (appealid_is_initialized ? ("[" + (appealid == null ? null : appealid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractclosing.actid = " + (actid_is_initialized ? ("[" + (actid == null ? null : actid.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}