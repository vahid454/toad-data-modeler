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
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import java.util.*;
@Path("/memberService")
public class MemberService implements RequestAware
{
private HttpServletRequest request;
private HttpSession session;
public void setHttpRequest(HttpServletRequest request){
this.request=request;
}
public void setHttpSession(HttpSession session){
this.session=session;
}
 

@Post
@Path("create")
public Object create(Member m)
{
int i=0;
String emailId=m.getEmailId();
String password=m.getPassword();
String firstName=m.getFirstName();
String lastName=m.getLastName();
String mobileNumber=m.getMobileNumber();
String regex = "^[A-Za-z0-9+_.-]+@(.+)$";
String regexM = "^\\+(?:[0-9] ?){6,14}[0-9]$"; 
  
ValidatorException ve=new ValidatorException();
boolean b=false;
if(firstName.length()==0 || firstName.length()>25){
b=true;
ve.add("FirstName",firstName);
}
 
if(lastName.length()==0 || lastName.length()>25){
b=true;
ve.add("LastName",lastName);
}
 
if(emailId.length()==0 || emailId.length()>100){
b=true;
ve.add("EmailId",emailId);
}
if(password.length()==0 || password.length()>100){
b=true;
ve.add("Password",password);
}

System.out.println("Length : "+mobileNumber.length());
if(mobileNumber.length()>15 || mobileNumber.length()<10)
{
b=true;
ve.add("MobileNumber",mobileNumber);
}

/*

if(((int)mobileNumber.charAt(i))==43){
i++;
}
while(i<mobileNumber.length())
{
if(!(((int)mobileNumber.charAt(i))>=48 && ((int)mobileNumber.charAt(i))<=57))
{
b=true;
ve.add("MobileNumberReg",mobileNumber);
break;
}
i++;
}*/


 
 
Pattern pattern = Pattern.compile(regex);
Matcher matcher = pattern.matcher(emailId);
if(!(matcher.matches()))
{
b=true;
ve.add("EmailIdReg",emailId);
}
Pattern patternM = Pattern.compile(regexM);
Matcher matcherM = patternM.matcher(mobileNumber);
if(!(matcherM.matches()))
{
b=true;
ve.add("MobileNumberReg",mobileNumber);
}
 

System.out.println("Going to return");
 
if(b==true){
return ve;
}

System.out.println("Validation Complete");

//------------------validation completed---------------------------------------
   
com.thinking.machines.dbproject.dl.Member member=new com.thinking.machines.dbproject.dl.Member();
member.setEmailId(m.getEmailId());
String Key=UUID.randomUUID().toString();
String  encypt=Utility.encrypt(m.getPassword(),Key);
member.setPassword(encypt);
member.setPasswordKey(Key);
member.setFirstName(m.getFirstName());
member.setLastName(m.getLastName());
member.setMobileNumber(m.getMobileNumber());
member.setStatus("Y");
member.setNumberOfProjects(0);
try
{
DataManager dataManager=new DataManager();
dataManager.begin();
List<com.thinking.machines.dbproject.dl.Member> dlMembers;
dlMembers=dataManager.select(com.thinking.machines.dbproject.dl.Member.class).where("emailId").eq(m.getEmailId()).query();
dataManager.end();
dataManager.begin();
dlMembers=dataManager.select(com.thinking.machines.dbproject.dl.Member.class).where("mobileNumber").eq(m.getMobileNumber()).query();
dataManager.end();
if(dlMembers.size()>0)
{
ValidatorException vee=new ValidatorException();
vee.add("There is another member againts this"," Email / Password");
return vee;
}
dataManager.begin();
dataManager.insert(member);
dataManager.end();

}catch(ValidatorException validatorException)
{
System.out.println("VahidV Validator");
return validatorException;
}
catch(DMFrameworkException dmFrameworkException)
{
System.out.println("Vahid");
return new Exception(dmFrameworkException.getMessage());
}
return true;
}
//----------------- create ends --------------

@InjectSession
@InjectRequest
@Post
@Path("login")
public TMForward login(String emailId,String password)
{
TMForward tmf=new TMForward("/index.jsp");
 
boolean valid=true;
if(emailId.length()==0){
valid=false;
System.out.println("Pappu");
request.setAttribute("emailIdError","Email can't be empty");
return new TMForward("/index.jsp"); 
}
if(password.length()==0){
valid=false;
 
request.setAttribute("emailId",emailId);
request.setAttribute("passwordError","Password can't be empty");
return new TMForward("/index.jsp"); 

}
if(valid==false){

return tmf;
}
try
{
List<com.thinking.machines.dbproject.dl.Member> members;
DataManager dataManager=new DataManager();
dataManager.begin();
members=dataManager.select(com.thinking.machines.dbproject.dl.Member.class).where("emailId").eq(emailId).query();
dataManager.end();
if(members.size()==0){
request.setAttribute("authenticationError","Invalid Email Id or password");
return new TMForward("/index.jsp"); 
}
request.setAttribute("emailId",emailId);

com.thinking.machines.dbproject.dl.Member member=members.get(0);
System.out.println("passy"+"("+member.getPassword()+")");
System.out.println("passKey"+"("+member.getPasswordKey()+")");
System.out.println(member.getEmailId());

String dpassword=Utility.decrypt(member.getPassword().trim(),member.getPasswordKey().trim());

System.out.println(dpassword);

if(!(password.equals(dpassword)))
{
request.setAttribute("authenticationError","Invalid Email Id or password");
return new TMForward("/index.jsp"); 
}
System.out.println("login successfully");

session.setAttribute("emailId",emailId);
session.setAttribute("firstName",member.getFirstName());
session.setAttribute("lastName",member.getLastName());
session.setAttribute("mobileNumber",member.getMobileNumber());


}catch(DMFrameworkException dmframeworkException)
{
System.out.println(dmframeworkException);
}

return new TMForward("/Homepage.jsp");
}//------------------ ends of login

@InjectSession
@InjectRequest
@Path("logout")
public TMForward logout()
{
session.invalidate();
TMForward tmf=new TMForward("/index.jsp");
return tmf;
}

//-----------


@InjectSession
@InjectRequest
@Post
@Path("changePassword")
public TMForward changePassword(String emailId,String oldPassword,String newPassword)
{
TMForward tmf=new TMForward("/ChangePassword.jsp"); 
if(emailId==null){
return tmf;
}
try
{
List<com.thinking.machines.dbproject.dl.Member> members;
 
DataManager dataManager=new DataManager();

dataManager.begin();
members=dataManager.select(com.thinking.machines.dbproject.dl.Member.class).where("emailId").eq(emailId).query();
dataManager.end();

if(members.size()==0){
request.setAttribute("authenticationError","Invalid Email Id");
return tmf;
}
com.thinking.machines.dbproject.dl.Member member=members.get(0);

String dpassword=Utility.decrypt(member.getPassword().trim(),member.getPasswordKey().trim());

System.out.println("old password : "+dpassword);
if(!(oldPassword.equals(dpassword)))
{
request.setAttribute("authenticationError","Invalid Password");
return new TMForward("ChangePassword.jsp");
}

String passwordKey=UUID.randomUUID().toString();
String encrpyt=Utility.encrypt(newPassword,passwordKey);
 com.thinking.machines.dbproject.dl.Member  mm=new com.thinking.machines.dbproject.dl.Member();
mm.setCode(member.getCode());
mm.setFirstName(member.getFirstName());
mm.setLastName(member.getLastName());
mm.setEmailId(emailId);
mm.setPassword(encrpyt);
mm.setPasswordKey(passwordKey);
mm.setMobileNumber(member.getMobileNumber());
mm.setStatus("Y");
mm.setNumberOfProjects(0);

try
{

dataManager.begin();
dataManager.update(mm);
dataManager.end();

}catch(Exception ve)
{
System.out.println(ve);
return new TMForward("/ChangePassword.jsp");
}

}catch(DMFrameworkException dmframeworkException)
{
System.out.println(dmframeworkException);
return new TMForward("/ChangePassword.jsp");
}
session.invalidate();
return new TMForward("/index.jsp");
}
//-----------------------------------------
 
@InjectSession
@InjectRequest
@Post
@Path("changeProfile")
public TMForward changeProfile(Member member)
{
TMForward tmf=new TMForward("/ChangeProfile.jsp");

String emailId=member.getEmailId();
String password=member.getPassword();
String firstName=member.getFirstName();
String lastName=member.getLastName();
String mobileNumber=member.getMobileNumber();
  
ValidatorException ve=new ValidatorException();
boolean b=false;
if(firstName.length()==0 || firstName.length()>25){
b=true;
ve.add("FirstName",firstName);
}
 
if(lastName.length()==0 || lastName.length()>25){
b=true;
ve.add("LastName",lastName);
}
 
if(emailId.length()==0 || emailId.length()>100){
b=true;
ve.add("EmailId",emailId);
}
if(password.length()==0 || password.length()>100){
b=true;
ve.add("Password",password);
}

System.out.println("Length : "+mobileNumber.length());
if(mobileNumber.length()>15 || mobileNumber.length()<10)
{
b=true;
ve.add("MobileNumber",mobileNumber);
}
 
System.out.println("Going to return");
 
if(b==true){
return new TMForward("/ChangeProfile.jsp");
}

if(member.getEmailId()==null)
{
System.out.println("Enter Emails................");
return tmf;
}
if(member.getMobileNumber()==null)
{
return tmf;
}
System.out.println("------------Validation Complete------------");

session.setAttribute("firstName",member.getFirstName());
session.setAttribute("lastName",member.getLastName());
session.setAttribute("emailId",member.getEmailId());
session.setAttribute("mobileNumber",member.getMobileNumber());

try
{
List<com.thinking.machines.dbproject.dl.Member> members;
 
DataManager dataManager=new DataManager();

dataManager.begin();
members=dataManager.select(com.thinking.machines.dbproject.dl.Member.class).where("emailId").eq(member.getEmailId()).query();
dataManager.end();

if(members.size()==0){
request.setAttribute("authenticationError","Invalid Email Id");
return tmf;
}
com.thinking.machines.dbproject.dl.Member dlmember=members.get(0);
String passwordKey=UUID.randomUUID().toString();
String encrpyt=Utility.encrypt(member.getPassword(),passwordKey);
 
com.thinking.machines.dbproject.dl.Member  mm=new com.thinking.machines.dbproject.dl.Member();

mm.setCode(dlmember.getCode());
mm.setEmailId(dlmember.getEmailId());
mm.setPassword(encrpyt);
mm.setPasswordKey(passwordKey);
mm.setFirstName(member.getFirstName());
mm.setLastName(member.getLastName());
mm.setMobileNumber(dlmember.getMobileNumber());
mm.setStatus("Y");
mm.setNumberOfProjects(member.getNumberOfProjects());

try
{
dataManager.begin();
dataManager.update(mm);
dataManager.end();

}catch(Exception vee)
{
return new TMForward("/ChangeProfile.jsp");
}

}catch(DMFrameworkException dmframeworkException)
{
System.out.println(dmframeworkException);
return new TMForward("/ChangeProfile.jsp");
}
System.out.println("You have successfully update your profile");
return new TMForward("/Homepage.jsp");
}

}