function TMForward()
{
}
function ProjectServiceManager()
{
this.open=function(argument1,successHandler,exceptionHandler)
{
service.postJSON('projectService/open',{
'argument-1': argument1
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
this.createProject=function(argument1,argument2,successHandler,exceptionHandler)
{
service.postJSON('projectService/create',{
'argument-1': argument1,
'argument-2': argument2
},
function(result){
successHandler(result);
},function(exception){
exceptionHandler(exception);
});
}
}
var projectServiceManager=new ProjectServiceManager();
