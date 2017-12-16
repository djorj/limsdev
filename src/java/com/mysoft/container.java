package com.mysoft;

import java.io.*;
import java.util.*;

public class container implements Serializable
{ 
	private Hashtable values = new Hashtable(); 
	
	public container(){}
	
	public Object getValue(Object key){return values.get(key);}
	public void setValue(Object key,Object val){values.put(key,val);}
        public void delValue(Object key){values.remove(key);}
	public void clear(){values.clear();}
}

