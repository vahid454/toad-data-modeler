package com.thinking.machines.dbproject.services;
import com.thinking.machines.tmws.*;
import com.thinking.machines.dmframework.*;
import com.thinking.machines.tmws.annotations.*;
import com.thinking.machines.dmframework.exceptions.*;
import com.thinking.machines.dbproject.services.pojo.*;
import com.thinking.machines.dbproject.services.exception.*;
import com.thinking.machines.dbproject.util.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.*;
@Path("/projectService")
public class ProjectService
{
private HttpSession session;
private HttpServletRequest request;
public void setHttpSession(HttpSession session)
{
System.out.println("setHttpSession chali");
this.session=session;
}
public void setHttpRequest(HttpServletRequest request)
{
System.out.println("\n\n\n\n\n\n\nsetHttpRequest Chali\n\n\n\n\n\n\n\n");
this.request=request;
}
@InjectSession
@InjectRequest
@Post
@Path("create")
public Object createProject(String title,int DatabaseArchitetctureCode)
{
DataManager dataManager=new DataManager();
List<com.thinking.machines.dbproject.dl.Project>dlproject;
session=request.getSession(false);
String emailId=(String)session.getAttribute("emailId");
System.out.println(emailId);
System.out.println(session);
try
{
List<com.thinking.machines.dbproject.dl.Member> dlMembers;
dataManager.begin();
dlMembers=dataManager.select(com.thinking.machines.dbproject.dl.Member.class).where("emailId").eq(emailId).query()  ;
dataManager.end();
com.thinking.machines.dbproject.dl.Member member;
member=dlMembers.get(0);
int code=member.getCode();
System.out.println(code);
List<com.thinking.machines.dbproject.dl.Project> dlProjects;
dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dbproject.dl.Project.class).where("memberCode").eq(code).query();
dataManager.end();
if(dlProjects.size()>0)
{
for(com.thinking.machines.dbproject.dl.Project project:dlProjects)
{
if(title.equalsIgnoreCase(project.getTitle()))
{
ValidatorException validatorException=new ValidatorException();
validatorException.add("title","exist");
session.setAttribute("Title","exist");
return validatorException;
}
}
}
com.thinking.machines.dbproject.dl.Project project=new com.thinking.machines.dbproject.dl.Project();
project.setTitle(title);
project.setMemberCode(code);
project.setDatabaseArchitectureCode(DatabaseArchitetctureCode);
project.setDateOfCreation(new java.sql.Date(new java.util.Date().getTime()));
project.setTimeOfCreation(java.sql.Time.valueOf(java.time.LocalTime.now()));
project.setNumberOfTable(new Integer(0));
dataManager.begin();
dataManager.insert(project);
dataManager.end();
return project;
}catch(ValidatorException validatorException)
{
return new Exception(validatorException.getMessage());
}
catch(DMFrameworkException dmframeworkException)
{
return new Exception(dmframeworkException.getMessage());
}
}
@Post
@InjectSession
@Path("open")
public TMForward open(int projectCode)
{
DataManager dataManager=new DataManager();
TMForward tmf=new TMForward("/HomePage.jsp");
try
{
List<com.thinking.machines.dbproject.dl.Project> dlProjects;
dataManager.begin();
dlProjects=dataManager.select(com.thinking.machines.dbproject.dl.Project.class).where("code").eq(projectCode).query()  ;
dataManager.end();
if(dlProjects.size()==0)
{
return tmf;
}
com.thinking.machines.dbproject.dl.Project project=dlProjects.get(0);

String title=project.getTitle();
session.setAttribute("title",title);
session.setAttribute("projectCode",projectCode);
return new TMForward("/openProject.jsp");
}
catch(DMFrameworkException dmframeworkException)
{
return tmf;
}
} 
@InjectSession
@InjectRequest
@Post
@Path("populateDS")
public com.thinking.machines.dbproject.services.pojo.Project populateDataStructure()
{
System.out.println("Ajax req is arrived");
com.thinking.machines.dbproject.services.pojo.Project p= (com.thinking.machines.dbproject.services.pojo.Project)this.session.getAttribute("openProjectList");
System.out.println("Title"+p.getTitle()+","+"Code"+p.getCode());
return p;
}
@Post
@Path("save")
public Object save(TableComponents tableComponents)
{
System.out.println("save service chali");
System.out.println("******************");
System.out.println("save service chali");
System.out.println("******************");
System.out.println("save service chali");
System.out.println("******************");
System.out.println("Table Name : "+tableComponents.getTableName());
return "Saved";
}
@Post
@Path("generateScript")
public void generateScript(com.thinking.machines.dbproject.services.pojo.ClientProject clientProject)
{
List<com.thinking.machines.dbproject.services.pojo.ClientDatabaseTable> list=clientProject.getTables();
System.out.println("***********--------------*****************");
System.out.println(clientProject.getTables().get(0).getName());
System.out.println("***********--------------*****************");
System.out.println("***********--------------*****************");

System.out.println(list.size());
List<com.thinking.machines.dbproject.services.pojo.ClientField> clientFields;
String pk="";
String autoInc="";
String unq="";
String nn="";
try
{
System.out.println("try me aaya");
File file=new File("c:/tomcat8/webapps/dbproject/script/script.sql");
RandomAccessFile raf=new RandomAccessFile(file,"rw");
for(int i=0;i<list.size();i++)
{
System.out.println("Loop me aaya");
clientFields=new LinkedList<>();
clientFields=list.get(i).getFields();
raf.writeBytes("drop table IF EXISTS"+" "+list.get(i).getName()+";");
raf.writeBytes("\r\n");
raf.writeBytes("Create table"+" "+list.get(i).getName()+"(");
raf.writeBytes("\r\n");
for(int j=0;j<clientFields.size();j++)
{
if(clientFields.get(j).getIsPrimaryKey()==true) pk="PRIMARY KEY";
if(clientFields.get(j).getIsAutoIncrement()==true) autoInc="AUTO_INCREMENT";
if(clientFields.get(j).getIsUnique()==true) unq="UNIQUE";
if(clientFields.get(j).getIsNotNull()==true) nn="NOT NULL";

raf.writeBytes(clientFields.get(j).getName()+" "+clientFields.get(j).getDataType()+"( "+clientFields.get(j).getWidth()+")"+" "+pk+" "+nn+" "+unq+" "+autoInc+",");
raf.writeBytes("\r\n");
pk="";
autoInc="";
unq="";
nn="";
}
raf.writeBytes(")"+"Engine=InnoDB"+";");
raf.writeBytes("\r\n");
}
System.out.println("successfully generated");
raf.close();
}catch(IOException ioException)
{
System.out.println(ioException.getMessage());
}
}
@Post
@Path("generatePojo")
public void generatePojo(com.thinking.machines.dbproject.services.pojo.ClientProject clientProject)
{
List<com.thinking.machines.dbproject.services.pojo.ClientDatabaseTable> clientDatabaseTable=clientProject.getTables();
List<com.thinking.machines.dbproject.services.pojo.ClientField> clientFields=clientDatabaseTable.get(0).getFields();
System.out.println("**************generatePojo*************");
String tableName=clientDatabaseTable.get(0).getName();
String packageName=clientDatabaseTable.get(0).getPackageName();
int i,j,k;
String primaryKeyData="";
String defaultValue="";
try
{
k=0;
List<String> list=new LinkedList<>();
String path;
String kalu="";
String dot=Character.toString('.');
for(int l=0;l<clientFields.size();l++)
{
if(clientFields.get(l).getIsPrimaryKey()==true)
{
primaryKeyData=clientFields.get(l).getName();
defaultValue=clientFields.get(l).getDefaultValue();
break;
}
}
i=0;
while(i<packageName.length())
{
kalu=Character.toString(packageName.charAt(i));
if(kalu.equals(dot)) 
{
list.add(packageName.substring(k,i));
k=i+1;
}
i++;
if(i==packageName.length())
{
list.add(packageName.substring(k,i));
}
}
for(k=0;k<list.size();k++)
{
System.out.println(list.get(k));
}
String v=tableName+"."+"zip";
String subPath="c:/tomcat8/webapps/dbproject"+"/"+v;
path="";
for(j=0;j<list.size();j++)
{
path=path+"/"+list.get(j);
}
path=subPath+path;
File f=new File(path);
f.mkdirs();

File file=new File(path+"/"+tableName+"."+"java");
RandomAccessFile raf=new RandomAccessFile(file,"rw");
raf.writeBytes("package"+" "+packageName+";");
raf.writeBytes("\r\n");
raf.writeBytes("import"+" "+"java"+"."+"util"+"."+"*"+";");
raf.writeBytes("\r\n");
raf.writeBytes("import"+" "+"java"+"."+"io"+"."+"*"+";");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"class"+" "+tableName+" "+"implements"+" "+"Serializable"+","+"Comparable"+"<"+tableName+">");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
String dataType="";
String fieldName="";
for(k=0;k<clientFields.size();k++)
{
dataType=clientFields.get(k).getDataType();
fieldName=clientFields.get(k).getName();
if(dataType.equals("int")) raf.writeBytes("private"+" "+"Integer"+" "+fieldName+";");
if(dataType.equals("char") || dataType.equals("varchar")) raf.writeBytes("private"+" "+"String"+" "+fieldName+";");
if(dataType.equals("float") ) raf.writeBytes("private"+" "+"Float"+" "+fieldName+";");
if(dataType.equals("double") ) raf.writeBytes("private"+" "+"Double"+" "+fieldName+";");
if(dataType.equals("boolean") ) raf.writeBytes("private"+" "+"Boolean"+" "+fieldName+";");
if(dataType.equals("date") ) raf.writeBytes("private"+" "+"Date"+" "+fieldName+";");
dataType="";
fieldName="";
raf.writeBytes("\r\n");
}
raf.writeBytes("public"+" "+tableName+"("+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
for(k=0;k<clientFields.size();k++)
{
dataType=clientFields.get(k).getDataType();
fieldName=clientFields.get(k).getName();
if(dataType.equals("int")) raf.writeBytes("this"+"."+fieldName+"="+"0"+";");
if(dataType.equals("char") || dataType.equals("varchar")) raf.writeBytes("this"+"."+fieldName+"="+"null"+";");
if(dataType.equals("float") || dataType.equals("double")) raf.writeBytes("this"+"."+fieldName+"="+"0"+"."+"0"+";");
if(dataType.equals("boolean")) raf.writeBytes("this"+"."+fieldName+"="+"false"+";");
if(dataType.equals("date")) raf.writeBytes("this"+"."+fieldName+"="+"null"+";");
dataType="";
fieldName="";
raf.writeBytes("\r\n");
}
raf.writeBytes("}");
raf.writeBytes("\r\n");
String u="";
String l="";
String stringData="";
for(k=0;k<clientFields.size();k++)
{
dataType=clientFields.get(k).getDataType();
fieldName=clientFields.get(k).getName();
l=fieldName.toLowerCase();
u=Character.toString(l.charAt(0)).toUpperCase()+l.substring(1,l.length());
if(dataType.equals("int"))
{
raf.writeBytes("public"+" "+"void"+" "+"set"+u+"("+"Integer"+" "+fieldName+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("this"+"."+fieldName+"="+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"Integer"+" "+"get"+u+"("+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"this"+"."+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
}
if(dataType.equals("char") || dataType.equals("varchar"))
{
stringData=fieldName;
raf.writeBytes("public"+" "+"void"+" "+"set"+u+"("+"String"+" "+fieldName+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("this"+"."+fieldName+"="+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"String"+" "+"get"+u+"("+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"this"+"."+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
}
if(dataType.equals("float"))
{
raf.writeBytes("public"+" "+"void"+" "+"set"+u+"("+"Float"+" "+fieldName+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("this"+"."+fieldName+"="+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"Float"+" "+"get"+u+"("+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"this"+"."+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
}
if(dataType.equals("double"))
{
raf.writeBytes("public"+" "+"void"+" "+"set"+u+"("+"Double"+" "+fieldName+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("this"+"."+fieldName+"="+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"Double"+" "+"get"+u+"("+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"this"+"."+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
}
if(dataType.equals("boolean"))
{
raf.writeBytes("public"+" "+"void"+" "+"set"+u+"("+"Boolean"+" "+fieldName+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("this"+"."+fieldName+"="+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"Boolean"+" "+"get"+u+"("+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"this"+"."+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
}
if(dataType.equals("date"))
{
raf.writeBytes("public"+" "+"void"+" "+"set"+u+"("+"Date"+" "+fieldName+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("this"+"."+fieldName+"="+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"Date"+" "+"get"+u+"("+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"this"+"."+fieldName+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
}
l="";
u="";
dataType="";
fieldName="";
raf.writeBytes("\r\n");
}
raf.writeBytes("public"+" "+"boolean"+" "+"equals"+"("+"Object"+" "+"object"+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"object"+"="+"="+"null"+")"+" "+"return"+" "+"false"+";");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"!"+"("+"object"+" "+"instanceof"+" "+tableName+")"+")"+" "+"return"+" "+" false"+";");
raf.writeBytes("\r\n");
raf.writeBytes(tableName+" "+"another"+tableName+"="+"("+tableName+")"+"object"+";");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"this"+"."+primaryKeyData+"="+"="+defaultValue+" "+"&&"+" "+"another"+tableName+"."+primaryKeyData+"="+"="+defaultValue+")"+" "+"return"+" "+"true"+";");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"this"+"."+primaryKeyData+"="+"="+defaultValue+" "+"||"+" "+"another"+tableName+"."+primaryKeyData+"="+"="+defaultValue+")"+" "+"return"+" "+"false"+";");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"this"+"."+primaryKeyData+"."+"equals"+"("+"another"+tableName+"."+primaryKeyData+")"+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"int"+" "+"compareTo"+"("+tableName+" "+"another"+tableName+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"another"+tableName+"="+"="+"null"+")"+" "+"return"+" "+"1"+";");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"this"+"."+primaryKeyData+"="+"="+defaultValue+" "+"&&"+" "+"another"+tableName+"."+primaryKeyData+"="+"="+defaultValue+")"+" "+"return"+" "+"0"+";");
raf.writeBytes("\r\n");
raf.writeBytes("int"+" "+"difference"+";");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"this"+"."+primaryKeyData+"="+"="+defaultValue+" "+"&&"+" "+"another"+tableName+"."+primaryKeyData+"!"+"="+defaultValue+")"+" "+"return"+" "+"1"+";");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"this"+"."+primaryKeyData+"!"+"="+defaultValue+" "+"&&"+" "+"another"+tableName+"."+primaryKeyData+"="+"="+defaultValue+")"+" "+"return"+" "+"-1"+";");
raf.writeBytes("\r\n");
raf.writeBytes("difference"+"="+"this"+"."+primaryKeyData+"."+"compareTo"+"("+"another"+tableName+"."+primaryKeyData+")"+";");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"difference"+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("public"+" "+"int"+" "+"hashCode"+"("+")");
raf.writeBytes("\r\n");
raf.writeBytes("{");
raf.writeBytes("\r\n");
raf.writeBytes("if"+"("+"this"+"."+primaryKeyData+"="+"="+defaultValue+")"+" "+"return"+" "+"0"+";");
raf.writeBytes("\r\n");
raf.writeBytes("return"+" "+"this"+"."+primaryKeyData+"."+"hashCode"+"("+")"+";");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.writeBytes("\r\n");
raf.writeBytes("}");
raf.close();
}catch(Exception ioException)
{
System.out.println(ioException.getMessage());
}
System.out.println("Successfully generated");
}
}

