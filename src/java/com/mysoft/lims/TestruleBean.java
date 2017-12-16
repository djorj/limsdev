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

public class TestruleBean
// extends+ 

// extends- 
{
    private Integer testruleid;
    private boolean testruleid_is_modified = false;
    private boolean testruleid_is_initialized = false;
    
    private String json;
    private boolean json_is_modified = false;
    private boolean json_is_initialized = false;
    
    private Integer labtestid;
    private boolean labtestid_is_modified = false;
    private boolean labtestid_is_initialized = false;
    
    private boolean _isNew = true;
    
    /**
     * Do not use this constructor directly, please use the factory method
     * available in the associated manager.
     */
    TestruleBean()
    {
    }
    
    /**
     * Getter method for testruleid.
     * <br>
     * PRIMARY KEY.<br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: testrule.testruleid
     * <li>column size: 4
     * <li>jdbc type returned by the driver: Types.INTEGER
     * </ul>
     *
     * @return the value of testruleid
     */
    public Integer getTestruleid()
    {
        return testruleid; 
    }

    /**
     * Setter method for testruleid.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to testruleid
     */
    public void setTestruleid(Integer newVal) {
        if ((newVal != null && this.testruleid != null && (newVal.compareTo(this.testruleid) == 0)) || 
            (newVal == null && this.testruleid == null && testruleid_is_initialized)) {
            return; 
        } 
        this.testruleid = newVal; 
        testruleid_is_modified = true; 
        testruleid_is_initialized = true; 
    }

    /**
     * Setter method for testruleid.
     * <br>
     * Convenient for those who do not want to deal with Objects for primary types.
     *
     * @param newVal the new value to be assigned to testruleid
     */
    public void setTestruleid(int newVal) {
        setTestruleid(new Integer(newVal));
    }

    /**
     * Determines if the testruleid has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isTestruleidModified() {
        return testruleid_is_modified; 
    }

    /**
     * Determines if the testruleid has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isTestruleidInitialized() {
        return testruleid_is_initialized; 
    }

    /**
     * Getter method for json.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: testrule.json
     * <li>column size: -1
     * <li>jdbc type returned by the driver: Types.VARCHAR
     * </ul>
     *
     * @return the value of json
     */
    public String getJson()
    {
        return json; 
    }

    /**
     * Setter method for json.
     * <br>
     * The new value is set only if compareTo() says it is different,
     * or if one of either the new value or the current value is null.
     * In case the new value is different, it is set and the field is marked as 'modified'.
     *
     * @param newVal the new value to be assigned to json
     */
    public void setJson(String newVal) {
        if ((newVal != null && this.json != null && (newVal.compareTo(this.json) == 0)) || 
            (newVal == null && this.json == null && json_is_initialized)) {
            return; 
        } 
        this.json = newVal; 
        json_is_modified = true; 
        json_is_initialized = true; 
    }

    /**
     * Determines if the json has been modified.
     *
     * @return true if the field has been modified, false if the field has not been modified
     */
    public boolean isJsonModified() {
        return json_is_modified; 
    }

    /**
     * Determines if the json has been initialized.
     * <br>
     * It is useful to determine if a field is null on purpose or just because it has not been initialized.
     *
     * @return true if the field has been initialized, false otherwise
     */
    public boolean isJsonInitialized() {
        return json_is_initialized; 
    }

    /**
     * Getter method for labtestid.
     * <br>
     * Meta Data Information (in progress):
     * <ul>
     * <li>full name: testrule.labtestid
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
        return testruleid_is_modified || 
		json_is_modified || 
		labtestid_is_modified;
    }

    /**
     * Resets the object modification status to 'not modified'.
     */
    public void resetIsModified() {
        testruleid_is_modified = false;
        json_is_modified = false;
        labtestid_is_modified = false;
    }

    /**
     * Copies the passed bean into the current bean.
     *
     * @param bean the bean to copy into the current bean
     */
    public void copy(TestruleBean bean) {
        setTestruleid(bean.getTestruleid());
        setJson(bean.getJson());
        setLabtestid(bean.getLabtestid());
    }

    /**
     * Returns the object string representation.
     *
     * @return the object as a string
     */
    public String toString() {
        return   "\n[testrule] "
                 + "\n - testrule.testruleid = " + (testruleid_is_initialized ? ("[" + (testruleid == null ? null : testruleid.toString()) + "]") : "not initialized") + ""
                 + "\n - testrule.json = " + (json_is_initialized ? ("[" + (json == null ? null : json.toString()) + "]") : "not initialized") + ""
                 + "\n - testrule.labtestid = " + (labtestid_is_initialized ? ("[" + (labtestid == null ? null : labtestid.toString()) + "]") : "not initialized") + ""
            ;
    }

// class+ 

// class- 
}