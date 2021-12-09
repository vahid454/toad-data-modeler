function TMForward()
{
}
function Member()
{
this.code=0;
this.emailId="";
this.password="";
this.passwordKey="";
this.firstName="";
this.lastName="";
this.mobileNumber="";
this.status="";
this.numberOfProjects=0;
}
function MemberServiceManager()
{
this.create=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('memberService/create',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.logout=function(successHandler,exceptionHandler)
{
service.getJSON('memberService/logout',null,function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.login=function(argument1,argument2,successHandler,exceptionHandler)
{
service.postJSON('memberService/login',{
'argument-1': argument1,
'argument-2': argument2
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.changeProfile=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('memberService/changeProfile',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.changePassword=function(argument1,argument2,argument3,successHandler,exceptionHandler)
{
service.postJSON('memberService/changePassword',{
'argument-1': argument1,
'argument-2': argument2,
'argument-3': argument3
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
}
var memberServiceManager=new MemberServiceManager();
