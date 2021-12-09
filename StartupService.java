package com.thinking.machines.dbproject.services;
import com.thinking.machines.tmws.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.dmframework.exceptions.*;
import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.*;
import javax.servlet.*;
import com.thinking.machines.dbproject.services.pojo.*;
import com.thinking.machines.dbproject.util.*;
@Path("/startupService")
public class StartupService
{
private HttpServletRequest request;
private HttpSession session;
private ServletContext servletContext;
private File directory;
public void setDirectory(File directory)
{
this.directory=directory;
}
public void setServletContext(ServletContext servletContext)
{
this.servletContext=servletContext;
}
public void setHttpRequest(HttpServletRequest request){
this.request=request;
}
public void setHttpSession(HttpSession session){
this.session=session;
}
 
@InjectApplication
@InjectDirectory
@OnStart(1)
public void starter()
{
//list
int i=0;
int j=0;
List<DatabaseArchitecture> dbArchitectures=new LinkedList<>();
List<com.thinking.machines.dbproject.dl.DatabaseArchitecture> dbArcList;
 
try
{
DataManager dataManager=new DataManager();
dataManager.begin();
dbArcList=dataManager.select(com.thinking.machines.dbproject.dl.DatabaseArchitecture.class).query();
dataManager.end();
if(dbArcList.size()==0)
{
System.out.println("Nothing Found");
}
com.thinking.machines.dbproject.dl.DatabaseArchitecture dlArc=new com.thinking.machines.dbproject.dl.DatabaseArchitecture();
DatabaseArchitecture dbArc;
while(i<dbArcList.size())
{
dbArc= new DatabaseArchitecture(); 
dlArc=dbArcList.get(i);
dbArc.setCode(dlArc.getCode());
dbArc.setName(dlArc.getName());
dbArc.setMaxWidthOfColumnName(dlArc.getMaxWidthOfColumnName());
dbArc.setMaxWidthOfTableName(dlArc.getMaxWidthOfTableName());
dbArc.setMaxWidthOfRelationshipName(dlArc.getMaxWidthOfRelationshipName());
int code=dlArc.getCode();
List<com.thinking.machines.dbproject.dl.DatabaseArchitectureDataType> daDT;
 
dataManager.begin();
daDT=dataManager.select(com.thinking.machines.dbproject.dl.DatabaseArchitectureDataType.class).where("databaseArchitectureCode").eq(code).query();
dataManager.end();
System.out.println("DATABASE SE NIKLI LIST KI SIZE :"+daDT.size());
//System.out.println("Successssssssssssssssss");
com.thinking.machines.dbproject.dl.DatabaseArchitectureDataType dlArcDT=new com.thinking.machines.dbproject.dl.DatabaseArchitectureDataType();
List<DatabaseArchitectureDataType> dataTypeLists=new LinkedList<>();
DatabaseArchitectureDataType dbArcDT; //pojo wala
j=0;
while(j<daDT.size())
{
dbArcDT=new DatabaseArchitectureDataType();
dlArcDT=daDT.get(j);
dbArcDT.setCode(dlArcDT.getCode());
dbArcDT.setDataType(dlArcDT.getDataType());
dbArcDT.setMaxWidth(dlArcDT.getMaxWidth());
dbArcDT.setDefaultSize(dlArcDT.getDefaultSize());
dbArcDT.setMaxWidthOfPrecision(dlArcDT.getMaxWidthOfPrecision());
dbArcDT.setAllowAutoIncrement(dlArcDT.getAllowAutoIncrement());
dataTypeLists.add(dbArcDT);
//System.out.println("Database DT ki list Bn chuki");
//yaha pojo ka dbArcDT wale nikal k list me leke dbArc me set Karna;
 
//dbArc.setDbArchitectures(List Of Pojo dbAT);
System.out.println("\n\n\n\n\n LOOP"+j);
j++;
}
System.out.println("Number of data types :"+dataTypeLists.size());
 
/*for(int k=0;k<dataTypeLists.size();k++)
{
DatabaseArchitectureDataType iterator=new DatabaseArchitectureDataType(); //pojo wala
iterator=dataTypeLists.get(k);
System.out.println("Size of DT lists :"+dataTypeLists.size());
System.out.println(iterator.getDataType());
System.out.println("----------Separator------------");
}*/
 
 
dbArc.setDbArchitectures(dataTypeLists);
System.out.println("Data base me sb fields All Successss");
dbArchitectures.add(dbArc);
System.out.println("Final List D Architecture ki size"+dbArc.getDbArchitectures().size());
i++;
}
System.out.println("\n\n\n\n\n Bahar \n\n\n\n\n");
 
 
//System.out.println("Final List D Architecture ki size"+dbArc.getDbArchitectures().size());
 
 
servletContext.setAttribute("dbArchitectures",dbArchitectures);
System.out.println("Servlet Context set");
int k=1;
while(k<dbArchitectures.size())
{
servletContext.setAttribute("DbArchitecturesList",dbArchitectures.get(k).getName());
k++;
}

}catch(DMFrameworkException dme)
{
System.out.println(dme);
}
 
}
}