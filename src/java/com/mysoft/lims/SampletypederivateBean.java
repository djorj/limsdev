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

public class SampletypederivateBean
// extends+ 

// extends- 
{
    private Integer sampletypeid;
    private boolean sampletypeid_is_modified = false;
    private boolean sampletypeid_is_initialized = false;
    
    private Integer derivatetypeid;
    private boolean derivatetypeid_is_modified = false;
    private boolean derivatetypeid_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    SampletypederivateBean()
    {
    }
    
    /**
     * Getter method for sampletypeid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampletypederivate.sampletypeid
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
     * Getter method for derivatetypeid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: sampletypederivate.derivatetypeid
     * <li> foreign key: derivatetype.derivatetypeid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of derivatetypeid
     */
    public Integer getDerivatetypeid()
    {
        return derivatetypeid; 
    }

    /**
     * Setter method for derivatetypeid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to derivatetypeid
     */
    public void setDerivatetypeid(Integer newVal) {
        if ((newVal != null && this.derivatetypeid != null && (newVal.compareTo(this.derivatetypeid) == 0)) || 
            (newVal == null && this.derivatetypeid == null && derivatetypeid_is_initialized)) {
            return; 
        } 
        this.derivatetypeid = newVal; 
        derivatetypeid_is_modified = true; 
        derivatetypeid_is_initialized = true; 
    }

    /**
     * Setter method for derivatetypeid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to derivatetypeid
     */
    public void setDerivatetypeid(int newVal) {
        setDerivatetypeid(new Integer(newVal));
    }

    /**
     * Determines if the derivatetypeid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isDerivatetypeidModified() {
        return derivatetypeid_is_modified; 
    }

    /**
     * Determines if the derivatetypeid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isDerivatetypeidInitialized() {
        return derivatetypeid_is_initialized; 
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
        return sampletypeid_is_modified || 
		derivatetypeid_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        sampletypeid_is_modified = false;
        derivatetypeid_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(SampletypederivateBean bean) {
        setSampletypeid(bean.getSampletypeid());
        setDerivatetypeid(bean.getDerivatetypeid());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[sampletypederivate] "
                 + "\n - sampletypederivate.sampletypeid = " + (sampletypeid_is_initialized ? ("[" + (sampletypeid == null ? null : sampletypeid.toString()) + "]") : "not initialized") + ""
                 + "\n - sampletypederivate.derivatetypeid = " + (derivatetypeid_is_initialized ? ("[" + (derivatetypeid == null ? null : derivatetypeid.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
