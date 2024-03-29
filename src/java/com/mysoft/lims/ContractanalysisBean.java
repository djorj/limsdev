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

public class ContractanalysisBean
// extends+ 

// extends- 
{
    private Long contractanalysisid;
    private boolean contractanalysisid_is_modified = false;
    private boolean contractanalysisid_is_initialized = false;
    
    private Long contractid;
    private boolean contractid_is_modified = false;
    private boolean contractid_is_initialized = false;
    
    private Integer sampletypeid;
    private boolean sampletypeid_is_modified = false;
    private boolean sampletypeid_is_initialized = false;
    
    private Integer labtestid;
    private boolean labtestid_is_modified = false;
    private boolean labtestid_is_initialized = false;
    
    private Integer institutionid;
    private boolean institutionid_is_modified = false;
    private boolean institutionid_is_initialized = false;
    
    private Double price;
    private boolean price_is_modified = false;
    private boolean price_is_initialized = false;
    
    private Integer enddays;
    private boolean enddays_is_modified = false;
    private boolean enddays_is_initialized = false;
    
    private Integer regbyid;
    private boolean regbyid_is_modified = false;
    private boolean regbyid_is_initialized = false;
    
    private java.sql.Timestamp regdate;
    private boolean regdate_is_modified = false;
    private boolean regdate_is_initialized = false;
    
    private Boolean deleted;
    private boolean deleted_is_modified = false;
    private boolean deleted_is_initialized = false;
    
    private Integer status;
    private boolean status_is_modified = false;
    private boolean status_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    ContractanalysisBean()
    {
    }
    
    /**
     * Getter method for contractanalysisid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.contractanalysisid
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.BIGINT
     * </ul>
     *
     * @return the value of contractanalysisid
     */
    public Long getContractanalysisid()
    {
        return contractanalysisid; 
    }

    /**
     * Setter method for contractanalysisid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to contractanalysisid
     */
    public void setContractanalysisid(Long newVal) {
        if ((newVal != null && this.contractanalysisid != null && (newVal.compareTo(this.contractanalysisid) == 0)) || 
            (newVal == null && this.contractanalysisid == null && contractanalysisid_is_initialized)) {
            return; 
        } 
        this.contractanalysisid = newVal; 
        contractanalysisid_is_modified = true; 
        contractanalysisid_is_initialized = true; 
    }

    /**
     * Setter method for contractanalysisid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to contractanalysisid
     */
    public void setContractanalysisid(long newVal) {
        setContractanalysisid(new Long(newVal));
    }

    /**
     * Determines if the contractanalysisid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isContractanalysisidModified() {
        return contractanalysisid_is_modified; 
    }

    /**
     * Determines if the contractanalysisid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isContractanalysisidInitialized() {
        return contractanalysisid_is_initialized; 
    }

    /**
     * Getter method for contractid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.contractid
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
     * Getter method for sampletypeid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.sampletypeid
     * <li> foreign key: sampletype.sampletypeid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of sampletypeid
     */
    public Integer getSampletypeid()
    {
        return sampletypeid; 
    }

    /**
     * Setter method for sampletypeid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to sampletypeid
     */
    public void setSampletypeid(Integer newVal) {
        if ((newVal != null && this.sampletypeid != null && (newVal.compareTo(this.sampletypeid) == 0)) || 
            (newVal == null && this.sampletypeid == null && sampletypeid_is_initialized)) {
            return; 
        } 
        this.sampletypeid = newVal; 
        sampletypeid_is_modified = true; 
        sampletypeid_is_initialized = true; 
    }

    /**
     * Setter method for sampletypeid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to sampletypeid
     */
    public void setSampletypeid(int newVal) {
        setSampletypeid(new Integer(newVal));
    }

    /**
     * Determines if the sampletypeid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isSampletypeidModified() {
        return sampletypeid_is_modified; 
    }

    /**
     * Determines if the sampletypeid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isSampletypeidInitialized() {
        return sampletypeid_is_initialized; 
    }

    /**
     * Getter method for labtestid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.labtestid
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
     * Getter method for institutionid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.institutionid
     * <li> foreign key: institution.institutionid
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
     * Getter method for price.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.price
     * <li>column size: 8
     * <li>jdbc type returned by the driver: Types.DOUBLE
     * </ul>
     *
     * @return the value of price
     */
    public Double getPrice()
    {
        return price; 
    }

    /**
     * Setter method for price.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to price
     */
    public void setPrice(Double newVal) {
        if ((newVal != null && this.price != null && (newVal.compareTo(this.price) == 0)) || 
            (newVal == null && this.price == null && price_is_initialized)) {
            return; 
        } 
        this.price = newVal; 
        price_is_modified = true; 
        price_is_initialized = true; 
    }

    /**
     * Setter method for price.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to price
     */
    public void setPrice(double newVal) {
        setPrice(new Double(newVal));
    }

    /**
     * Determines if the price has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isPriceModified() {
        return price_is_modified; 
    }

    /**
     * Determines if the price has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isPriceInitialized() {
        return price_is_initialized; 
    }

    /**
     * Getter method for enddays.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.enddays
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of enddays
     */
    public Integer getEnddays()
    {
        return enddays; 
    }

    /**
     * Setter method for enddays.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to enddays
     */
    public void setEnddays(Integer newVal) {
        if ((newVal != null && this.enddays != null && (newVal.compareTo(this.enddays) == 0)) || 
            (newVal == null && this.enddays == null && enddays_is_initialized)) {
            return; 
        } 
        this.enddays = newVal; 
        enddays_is_modified = true; 
        enddays_is_initialized = true; 
    }

    /**
     * Setter method for enddays.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to enddays
     */
    public void setEnddays(int newVal) {
        setEnddays(new Integer(newVal));
    }

    /**
     * Determines if the enddays has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isEnddaysModified() {
        return enddays_is_modified; 
    }

    /**
     * Determines if the enddays has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isEnddaysInitialized() {
        return enddays_is_initialized; 
    }

    /**
     * Getter method for regbyid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.regbyid
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
     * <li>full name: contractanalysis.regdate
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
     * <li>full name: contractanalysis.deleted
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
     * Getter method for status.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: contractanalysis.status
     * <li>default value: 1
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
        return contractanalysisid_is_modified || 
		contractid_is_modified || 
		sampletypeid_is_modified || 
		labtestid_is_modified || 
		institutionid_is_modified || 
		price_is_modified || 
		enddays_is_modified || 
		regbyid_is_modified || 
		regdate_is_modified || 
		deleted_is_modified || 
		status_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        contractanalysisid_is_modified = false;
        contractid_is_modified = false;
        sampletypeid_is_modified = false;
        labtestid_is_modified = false;
        institutionid_is_modified = false;
        price_is_modified = false;
        enddays_is_modified = false;
        regbyid_is_modified = false;
        regdate_is_modified = false;
        deleted_is_modified = false;
        status_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(ContractanalysisBean bean) {
        setContractanalysisid(bean.getContractanalysisid());
        setContractid(bean.getContractid());
        setSampletypeid(bean.getSampletypeid());
        setLabtestid(bean.getLabtestid());
        setInstitutionid(bean.getInstitutionid());
        setPrice(bean.getPrice());
        setEnddays(bean.getEnddays());
        setRegbyid(bean.getRegbyid());
        setRegdate(bean.getRegdate());
        setDeleted(bean.getDeleted());
        setStatus(bean.getStatus());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[contractanalysis] "
                 + "\n - contractanalysis.contractanalysisid = " + (contractanalysisid_is_initialized ? ("[" + (contractanalysisid == null ? null : contractanalysisid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.contractid = " + (contractid_is_initialized ? ("[" + (contractid == null ? null : contractid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.sampletypeid = " + (sampletypeid_is_initialized ? ("[" + (sampletypeid == null ? null : sampletypeid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.labtestid = " + (labtestid_is_initialized ? ("[" + (labtestid == null ? null : labtestid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.institutionid = " + (institutionid_is_initialized ? ("[" + (institutionid == null ? null : institutionid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.price = " + (price_is_initialized ? ("[" + (price == null ? null : price.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.enddays = " + (enddays_is_initialized ? ("[" + (enddays == null ? null : enddays.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.regbyid = " + (regbyid_is_initialized ? ("[" + (regbyid == null ? null : regbyid.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.regdate = " + (regdate_is_initialized ? ("[" + (regdate == null ? null : regdate.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.deleted = " + (deleted_is_initialized ? ("[" + (deleted == null ? null : deleted.toString()) + "]") : "not initialized") + ""
                 + "\n - contractanalysis.status = " + (status_is_initialized ? ("[" + (status == null ? null : status.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
