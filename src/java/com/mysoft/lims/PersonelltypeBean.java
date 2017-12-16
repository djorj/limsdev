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

public class PersonelltypeBean
// extends+ 

// extends- 
{
    private Integer personelltypeid;
    private boolean personelltypeid_is_modified = false;
    private boolean personelltypeid_is_initialized = false;
    
    private String name;
    private boolean name_is_modified = false;
    private boolean name_is_initialized = false;
    
    private String description;
    private boolean description_is_modified = false;
    private boolean description_is_initialized = false;
    
    private String code;
    private boolean code_is_modified = false;
    private boolean code_is_initialized = false;
    
    private Integer companyid;
    private boolean companyid_is_modified = false;
    private boolean companyid_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    PersonelltypeBean()
    {
    }
    
    /**
     * Getter method for personelltypeid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: personelltype.personelltypeid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of personelltypeid
     */
    public Integer getPersonelltypeid()
    {
        return personelltypeid; 
    }

    /**
     * Setter method for personelltypeid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to personelltypeid
     */
    public void setPersonelltypeid(Integer newVal) {
        if ((newVal != null && this.personelltypeid != null && (newVal.compareTo(this.personelltypeid) == 0)) || 
            (newVal == null && this.personelltypeid == null && personelltypeid_is_initialized)) {
            return; 
        } 
        this.personelltypeid = newVal; 
        personelltypeid_is_modified = true; 
        personelltypeid_is_initialized = true; 
    }

    /**
     * Setter method for personelltypeid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to personelltypeid
     */
    public void setPersonelltypeid(int newVal) {
        setPersonelltypeid(new Integer(newVal));
    }

    /**
     * Determines if the personelltypeid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isPersonelltypeidModified() {
        return personelltypeid_is_modified; 
    }

    /**
     * Determines if the personelltypeid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isPersonelltypeidInitialized() {
        return personelltypeid_is_initialized; 
    }

    /**
     * Getter method for name.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: personelltype.name
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
     * Getter method for description.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: personelltype.description
     * <li>column size: -1
     * <li>jdbc type returned by the driver: Types.VARCHAR
     * </ul>
     *
     * @return the value of description
     */
    public String getDescription()
    {
        return description; 
    }

    /**
     * Setter method for description.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to description
     */
    public void setDescription(String newVal) {
        if ((newVal != null && this.description != null && (newVal.compareTo(this.description) == 0)) || 
            (newVal == null && this.description == null && description_is_initialized)) {
            return; 
        } 
        this.description = newVal; 
        description_is_modified = true; 
        description_is_initialized = true; 
    }

    /**
     * Determines if the description has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isDescriptionModified() {
        return description_is_modified; 
    }

    /**
     * Determines if the description has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isDescriptionInitialized() {
        return description_is_initialized; 
    }

    /**
     * Getter method for code.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: personelltype.code
     * <li>column size: 2
     * <li>jdbc type returned by the driver: Types.VARCHAR
     * </ul>
     *
     * @return the value of code
     */
    public String getCode()
    {
        return code; 
    }

    /**
     * Setter method for code.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to code
     */
    public void setCode(String newVal) {
        if ((newVal != null && this.code != null && (newVal.compareTo(this.code) == 0)) || 
            (newVal == null && this.code == null && code_is_initialized)) {
            return; 
        } 
        this.code = newVal; 
        code_is_modified = true; 
        code_is_initialized = true; 
    }

    /**
     * Determines if the code has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isCodeModified() {
        return code_is_modified; 
    }

    /**
     * Determines if the code has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isCodeInitialized() {
        return code_is_initialized; 
    }

    /**
     * Getter method for companyid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: personelltype.companyid
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
        return personelltypeid_is_modified || 
		name_is_modified || 
		description_is_modified || 
		code_is_modified || 
		companyid_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        personelltypeid_is_modified = false;
        name_is_modified = false;
        description_is_modified = false;
        code_is_modified = false;
        companyid_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(PersonelltypeBean bean) {
        setPersonelltypeid(bean.getPersonelltypeid());
        setName(bean.getName());
        setDescription(bean.getDescription());
        setCode(bean.getCode());
        setCompanyid(bean.getCompanyid());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[personelltype] "
                 + "\n - personelltype.personelltypeid = " + (personelltypeid_is_initialized ? ("[" + (personelltypeid == null ? null : personelltypeid.toString()) + "]") : "not initialized") + ""
                 + "\n - personelltype.name = " + (name_is_initialized ? ("[" + (name == null ? null : name.toString()) + "]") : "not initialized") + ""
                 + "\n - personelltype.description = " + (description_is_initialized ? ("[" + (description == null ? null : description.toString()) + "]") : "not initialized") + ""
                 + "\n - personelltype.code = " + (code_is_initialized ? ("[" + (code == null ? null : code.toString()) + "]") : "not initialized") + ""
                 + "\n - personelltype.companyid = " + (companyid_is_initialized ? ("[" + (companyid == null ? null : companyid.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
