/*
 * CommandRunner.java
 *
 * Created on February 8, 2007, 11:22 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.mysoft;

import java.io.*;
import java.lang.Process;
import java.lang.Runtime;
/**
 *
 * @author djorj
 */
public class CommandRunner extends Thread{  

	public String err = "";
	private String[] stCommand;  
	private static int iRetVal;
	protected static Process p;
	private static StringBuffer sb = null;
	public void run(){
		int iRetVal = -1;
		try{
			int iOut = 0; 
			sb = new StringBuffer();
			Runtime t = Runtime.getRuntime();
			p = t.exec(stCommand);
			if(p.waitFor() != 0){}
			
			iRetVal = p.exitValue();
			InputStream pOut = p.getInputStream();

			while((iOut = pOut.read()) != -1){
				sb.append((char)iOut);
			}

		}
		catch(IOException ioe){
                        ioe.printStackTrace();
                        err = "IOException occurred when executing: " + ioe.getMessage(); 
		}
		catch(InterruptedException ie){
                        ie.printStackTrace();
			err = "InterruptedException occurred when executing: " + ie.getMessage();
		}
	}


	public String getGetOuputFromNonBackGroundProc(){
		return sb.toString();
	}

	public InputStream  executeProccessBackGround(String[] stCommandin){
		try{
			Runtime t = Runtime.getRuntime();
			p = t.exec(stCommandin);
			return p.getInputStream();
		}
		catch(Exception e){
                        e.printStackTrace();
			err = e.getMessage();
		}
		return null;
	}
	
	public Process getProcessObj(){
		return p;
	}

        public OutputStream getProccessOutputStream(){
		return p.getOutputStream(); 
	}

	public InputStream getProccessErrorStream(){
		return p.getErrorStream();
	}

	public int getExitValue(){
		try{
			int i = p.exitValue();
			return i;
		}
		catch(IllegalThreadStateException itse){
			return -1;
		}
		catch(Exception e){
			return -1;
		}
	}

	protected void destroyProcess(){
		p.destroy();
	}

	public int executeProgram(String[] stCommandin){

	
		CommandRunner crThrd = new CommandRunner();
		crThrd.stCommand = stCommandin;
		crThrd.start();
		try{
			int iwaitfor = 240;
			while(crThrd.isAlive() == true && iwaitfor > 0){
				iwaitfor--;
				
				sleep(500);
			}	
			if (crThrd.isAlive()){
				p.destroy();
				crThrd.stop();
				iRetVal = 16;
		
			}
			else{
				iRetVal = p.exitValue();
			}

		}
		catch (InterruptedException ie){
                        ie.printStackTrace();
                        err = ie.getMessage();
		}
		return iRetVal;
	}

	
	public int executeProgram(String[] stCommandin, int iTimeout){

		CommandRunner crThrd = new CommandRunner();
		crThrd.stCommand = stCommandin;
		crThrd.start();
		try{
			
			int iwaitfor = iTimeout * 2;
			while(crThrd.isAlive() == true && iwaitfor > 0){
				iwaitfor--;
				
				sleep(500);
			}	
			if (crThrd.isAlive()){
				p.destroy();
				crThrd.stop();
				iRetVal = 16;
		
			}
			else{
				iRetVal = p.exitValue();
			}
		}
		catch (InterruptedException ie){
                        err = ie.getMessage();
                        ie.printStackTrace();
		}
		
		return iRetVal;
	}
}
