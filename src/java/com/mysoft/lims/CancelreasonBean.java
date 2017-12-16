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

public class CancelreasonBean
// extends+ 

// extends- 
{
    private Integer cancelreasonid;
    private boolean cancelreasonid_is_modified = false;
    private boolean cancelreasonid_is_initialized = false;
    
    private String name;
    private boolean name_is_modified = false;
    private boolean name_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    CancelreasonBean()
    {
    }
    
    /**
     * Getter method for cancelreasonid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: cancelreason.cancelreasonid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of cancelreasonid
     */
    public Integer getCancelreasonid()
    {
        return cancelreasonid; 
    }

    /**
     * Setter method for cancelreasonid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to cancelreasonid
     */
    public void setCancelreasonid(Integer newVal) {
        if ((newVal != null && this.cancelreasonid != null && (newVal.compareTo(this.cancelreasonid) == 0)) || 
            (newVal == null && this.cancelreasonid == null && cancelreasonid_is_initialized)) {
            return; 
        } 
        this.cancelreasonid = newVal; 
        cancelreasonid_is_modified = true; 
        cancelreasonid_is_initialized = true; 
    }

    /**
     * Setter method for cancelreasonid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to cancelreasonid
     */
    public void setCancelreasonid(int newVal) {
        setCancelreasonid(new Integer(newVal));
    }

    /**
     * Determines if the cancelreasonid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isCancelreasonidModified() {
        return cancelreasonid_is_modified; 
    }

    /**
     * Determines if the cancelreasonid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isCancelreasonidInitialized() {
        return cancelreasonid_is_initialized; 
    }

    /**
     * Getter method for name.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: cancelreason.name
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
        return cancelreasonid_is_modified || 
		name_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        cancelreasonid_is_modified = false;
        name_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(CancelreasonBean bean) {
        setCancelreasonid(bean.getCancelreasonid());
        setName(bean.getName());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[cancelreason] "
                 + "\n - cancelreason.cancelreasonid = " + (cancelreasonid_is_initialized ? ("[" + (cancelreasonid == null ? null : cancelreasonid.toString()) + "]") : "not initialized") + ""
                 + "\n - cancelreason.name = " + (name_is_initialized ? ("[" + (name == null ? null : name.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}
