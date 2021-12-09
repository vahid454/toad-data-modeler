<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Open Project</title>

<!-- Bootstrap core CSS-->
<link href="/dbproject/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="/dbproject/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link href="/dbproject/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/dbproject/css/sb-admin.css" rel="stylesheet">

<link href="/dbproject/JQuery/fontAwesome.css" rel="stylesheet">

<!--link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"-->


<!--link href="/dbproject/JQuery/bootstrap.min.css" rel="stylesheet" -->

    
<script src="/dbproject/JQuery/jquery-3.3.1.min.js"></script>
<script src="/dbproject/JQuery/bootstrap.min.js"></script>
<script src='/dbproject/JQuery/jquery.js'></script>



<script>
var canvasId=null;
var canvasDiv=null;
var e;
var selectedOption=0;
var tablesName=[];
var tableValues=[];
var tableComponents=[];
var selectedTable=null;
var clearBoundary=null;
var edit=false;
var del=false;
function initializeDS()
{
$.ajax('/dbproject/webservice/projectService/populateDS',{
type:"Post",
success:function(res){
alert(JSON.stringify(res.result));
setDS(res.result);
}
});
initialize();
}
function setDS(project)
{
alert("setDS Chala")
var tables=project.tables;
for(x=0;x<tables.length;x++)
{
alert("1st for setDS Chala")
var tableFields=tables[x].fields;
alert(tables[x].xLocation+","+tables[x].yLocation);
var tableComponent=new TableComponent(tables[x].xLocation,tables[x].yLocation,tables[x].name);
for(y=0;y<tableFields.length;y++)
{
alert("2nd for setDS Chala")
var databaseTableField=new DatabaseTableField();
databaseTableField.name=tableFields[y].name;
databaseTableField.width=tableFields[y].width;
databaseTableField.isPrimaryKey=tableFields[y].isPrimaryKey;
databaseTableField.dataType=tableFields[y].dataType;
alert(databaseTableField.dataType)
databaseTableField.isAutoIncrement=tableFields[y].isAutoIncrement;
databaseTableField.isUnique=tableFields[y].isUnique;
databaseTableField.isNotNull=tableFields[y].isNotNull;
databaseTableField.defaultValue=tableFields[y].defaultValue;
databaseTableField.checkConstraint=tableFields[y].checkConstraint;
databaseTableField.note=tableFields[y].note;
databaseTableField.numberOfDecimalPlaces=tableFields[y].numberOfDecimalPlaces;
tableComponent.databaseTable.fields.push(databaseTableField);
}//inner for ends
tableComponents.push(tableComponent);
}//outer for ends
Draw();
}//function setDS

function initialize()
{
canvasId=document.getElementById("canvas");
canvasId.addEventListener("click",DomouseDown,false);
canvasId.addEventListener("dblclick",doMouseDoubleClick); 
e=canvasId.getContext('2d');
}
//sending data to server

function saveProject()
{
var table=null;
var tables=[];
//var project=new Project();

for(i=0;i<tableComponents.length;i++)
{
table=new Table();
table.name=tableComponents[i].drawableTable.getDatabaseTable().tableName;
table.note=tableComponents[i].drawableTable.getDatabaseTable().note;
table.numberOfFields=tableComponents[i].databaseTable.fields.length;
var coordinates=tableComponents[i].drawableTable.getInfo()
table.xlocation=coordinates[0];
table.ylocation=coordinates[1];
table.engine=tableComponents[i].databaseTable.engineName;
alert(table.name+","+table.note+","+table.numberOfFields+","+table.xlocation+","+table.ylocation+","+table.engine);
for(j=0;j<tableComponents[i].databaseTable.fields.length;j++)
{
table.fields[j]=tableComponents[i].databaseTable.fields[j];
}
tables.push(table);
}

var details={
"argument-1":{
"tables":tables
}
};



var cap={
"argument-1":"Table ka naam"
};






$.ajax('/dbproject/webservice/projectService/saveProject',{
type:"POST",
contentType:"application/json",
data:JSON.stringify(details)
});
}//function ends here
/*
function Project()
{
this.tables=[];
}
*/

function PojoTable()
{
var name=null;
var packageName=null;
this.fields=[];
}
function Table()
{
var name=null;
var note=null;
var numberOfFields=0;
var xlocation=0;
var ylocation=0;
var engine=null;
var packageName=null;
this.fields=[];

}//Project function ends here
//===================new
function doMouseDoubleClick()
{
var bound = canvasId.getBoundingClientRect();
var x = parseInt(event.clientX - bound.left - canvasId.clientLeft);
var y = parseInt(event.clientY - bound.top - canvasId.clientTop);
//alert("mouseDoubleClicked  "+ x+","+ y)
selectedTable=isTableClicked(x,y)
if(selectedTable!=null)
{
var databaseTable=selectedTable.getDatabaseTable();
$('#tableName').val(databaseTable.tableName);
$('#table').modal('show');
}
}//dbclick ends
//top margin,left margin,width,height
function isTableClicked(x,y)
{
var drawableTable;
var a=[];
for(var j=0;j<tableComponents.length;j++)
{
drawableTable=tableComponents[j].drawableTable;
a=(drawableTable.getInfo());
if((x>=a[0] && x<=(a[0]+a[2])) && (y>=a[1] && y<=(a[1]+a[3])))
{
return drawableTable; 
}
}//for ends
return null;
}

function updateTableInformation()
{
/*var fields=[];
var databaseTableField=null;
var textValues=[];
for(var i=0;i<tableValues.length;i++)
{
databaseTableField=new DatabaseTableField();
textValues=tableValues[i];
databaseTableField.name=textValues["field"];
databaseTableField.isPrimaryKey=textValues["primaryKey"];
databaseTableField.defaultValue=textValues["default"];
databaseTableField.dataType=textValues["dataType"];
databaseTableField.isAutoIncrement=null;
databaseTableField.isUnique=null;
databaseTableField.isNotNull=null;
databaseTableField.checkConstraint=textValues["constraint"];
fields.push(databaseTableField);
}//outer for loop
selectedTable.getDatabaseTable().setFields(fields);
fields=selectedTable.getDatabaseTable().getFields();
//alert(fields.length);
//alert("value is"+fields[0].name);
//alert("value is"+fields[1].name);
*/
}//function ends here

function DatabaseTableField()
{
this.name=null;
this.width=null;
this.isPrimaryKey=false;
this.dataType=null;
this.isAutoIncrement=false;
this.isUnique=false;
this.isNotNull=false;
this.defaultValue=null;
this.checkConstraint=null;
this.note=null;
this.numberOfDecimalPlaces=0;
this.checkConstraint=" ";
}// DatabaseTableField function ends here





//================

function DrawableTable(vX,vY,vDatabaseTable)
{
var x=vX;
var y=vY;
var databaseTable=vDatabaseTable;
var width=150;
var height=150;
var largestWidth;

var databaseTableField;
var Fieldname;
var dataType;
var constraints='';
var defaultValue;
var rowValue;
this.draw=function()
{
e.beginPath();
e.moveTo(x,(y+50));
e.font="35px Arial";
var largestWidth=e.measureText(databaseTable.tableName).width+10;
if(width>largestWidth) largestWidth=width;

//logic to compute width
var z=x;
var pk="";
var nn="";
var autoInc="";
var unq="";
for(var j=0;j<databaseTable.fields.length;j++)
{
databaseTableField=databaseTable.fields[j];
e.font="25px Arial";
name=databaseTableField.name;
dataType=databaseTableField.dataType;
defaultValue=databaseTableField.defaultValue;
if(databaseTableField.isNotNull==true)
{
constraints=" NN ";
nn="not null";
}
if(databaseTableField.isPrimaryKey==true) 
{
constraints+=" PK ";
pk="primary key";
}
if(databaseTableField.isUnique==true) 
{
constraints+=" UNQ ";
unq="unique";
}
if(databaseTableField.isAutoIncrement==true) 
{
constraints+=" ++ ";
autoInc="auto_increment";
}
rowValue=name+" "+dataType+" "+defaultValue+" "+constraints+"  ";
if(e.measureText(rowValue).width>largestWidth) largestWidth=e.measureText(rowValue).width;
e.fillText(rowValue,x+5,z+30);
z+=30;
}
width=largestWidth;
e.fillText(databaseTable.tableName,(x+10),(y+35));
e.lineTo((x+width), (y+50));

e.rect(x,y,width,z);
height=z;
e.stroke();
selectedOption=0;
}

this.getInfo=function()
{
var a=[x,y,width,height];
return a;
}

this.getDatabaseTable=function()
{
return databaseTable;
}
}//drawable table function ends here
function DatabaseTable(vTableName)
{
this.tableName=vTableName;
this.engineName=null;
this.note=null;
this.fields=[];
this.setFields=function(databaseTableField)
{
this.fields.push(databaseTableField);
}
this.getFields=function()
{
return this.fields;
}
} //databaseTable function ends here

function TableComponent(vX,vY,tableName)
{
this.x=vX;
this.y=vY;
this.tableName=tableName;
this.databaseTable=new DatabaseTable(tableName);
this.drawableTable=new DrawableTable(this.x,this.y,this.databaseTable);
this.draw=function()
{
this.drawableTable.draw();
}


}//table component function ends here


function Draw()//componets ke array pe traverse krne wala
{
//alert("table component ki length"+tableComponents.length);
//canvas clear logic
e.clearRect(0,0,canvasId.width,canvasId.height);
for(i=0;i<tableComponents.length;i++)
{
tableComponents[i].draw();
}
}

//----------------------------
function tableNameGenerator()  //need to change the logic 
{
var prefix='table';
var tableName=prefix+" "+((tablesName.length)+1);
return tableName;
}

function DomouseDown()  //jab table per click ho
{
var bound = canvasId.getBoundingClientRect();
var x = parseInt(event.clientX - bound.left - canvasId.clientLeft);
var y = parseInt(event.clientY - bound.top - canvasId.clientTop);
if(selectedOption=='1')
{
var tableName=tableNameGenerator(); //update 
tablesName.push(tableName); //need to change
var tableComponent=new TableComponent(x,y,tableName); 
tableComponents.push(tableComponent); //inserted component array
Draw(); //componets ke array pe traverse krne wala
}//if ends here for selected option
}//mouse down function ends here

function createTableButton()
{
selectedOption=1;
}



//=============================================
var info=[];
info["field"]="code";
info["dataType"]="int";
info["constraint"]="no";
info["default"]=0;
info["primaryKey"]=true;
//tableValues.push(info);
var info1=[];

info1["field"]="name";
info1["dataType"]="int";
info1["constraint"]="no";
info1["default"]=0;
info1["primaryKey"]=true;
//tableValues.push(info1);
//testing
tableData=[];
function createRow(textValue)
{
var InnerTable=document.getElementById('outerTable');
var rows=InnerTable.getElementsByTagName("tr");
var columns=rows[0].getElementsByTagName("td");
//alert(rows.length);
var newRow = InnerTable.insertRow(rows.length);
var cell=newRow.insertCell(0);

//alert(textValue["field"]);
cell.innerHTML =textValue["field"];
if(textValue["primaryKey"])
{
var img = document.createElement('img');
img.src = '/dbproject/images/key.png';
cell.appendChild(img);
}

cell=newRow.insertCell(1);
cell.innerHTML=textValue["dataType"];

var constraints=" ";
cell=newRow.insertCell(2);
if(textValue["notNull"]) constraints="NN ";
if(textValue["uniqueKey"]) constraints+="  UNQ";
if(textValue["autoIncrement"]) constraints+=" ++ ";
cell.innerHTML=constraints;


cell=newRow.insertCell(3);
cell.innerHTML=textValue["default"];

cell=newRow.insertCell(4);
cell.innerHTML=textValue["note"];


cell=newRow.insertCell(5);
btnn = document.createElement("BUTTON");
img = document.createElement('img');
img.src = '/dbproject/images/edit.png';
btnn.setAttribute("data-toggle","tooltip");
btnn.setAttribute("title","Edit");
btnn.setAttribute("class","btn btn-default mr-1");
btnn.setAttribute("onclick","editRow()");
btnn.appendChild(img);
cell.appendChild(btnn);

btn = document.createElement("BUTTON");
img = document.createElement('img');
img.src = '/dbproject/images/delete.png';
btn.setAttribute("data-toggle","tooltip");
btn.setAttribute("title","Delete");
btn.setAttribute("class","btn btn-default");
btn.setAttribute("onclick","deleteRow()");
btn.appendChild(img);
cell.appendChild(btn);



cell.onclick = function () 
{
var node=this.parentNode;
selectedRow=node;
var a=selectedTable.getDatabaseTable().fields[node.rowIndex-2];
if(edit) 
{
alert("Edit wala if");
edit=false;
$("#outerTable").find("button").attr("disabled", "disabled");
document.getElementById("editFieldText").value=a.name;
document.getElementById("editDefaultText").value=a.defaultValue;
document.getElementById("editDataType").value=a.dataType;
document.getElementById("editnote").value=a.note;

if(a.isNotNull) document.getElementById("editNn").checked=true;
if(a.isPrimaryKey) document.getElementById("editPk").checked=true;
if(a.isUnique) document.getElementById("editUnq").checked=true;
if(a.isAutoIncrement) document.getElementById("editA+").checked=true;
}
else
{
if(del)
{
alert("delete wala if");
del=false;
$("#outerTable").find("button").attr("disabled", "disabled");
document.getElementById("deleteFieldText").innerHTML=a.name;
document.getElementById("deleteDefaultText").innerHTML=a.defaultValue;
document.getElementById("deleteDataType").innerHTML=a.dataType;
document.getElementById("deletenote").innerHTML=a.note;

if(a.isNotNull) document.getElementById("deleteNn").checked=true;
if(a.isPrimaryKey) document.getElementById("deletePk").checked=true;
if(a.isUnique) document.getElementById("deleteUnq").checked=true;
if(a.isAutoIncrement) document.getElementById("deleteA+").checked=true;

document.getElementById("deleteFieldText").disabled=true;
document.getElementById("deleteDefaultText").disabled=true;
document.getElementById("deleteDataType").disabled=true;
document.getElementById("deletenote").disabled=true;


document.getElementById("deleteA+").disabled= true;
document.getElementById("deletePk").disabled= true;
document.getElementById("deleteNn").disabled= true;
document.getElementById("deleteUnq").disabled= true;
//deleteRow(node.rowIndex);
//node.parentNode.removeChild(node);
}
}
}


$('#fieldText').val(" ");
//$("#typeText").val(" ");
$("#constraintText").val(" ");
$('#defaultText').val(" ");
$('#dataType').val("int");
$('#note').val(" ");
document.getElementById("nn").checked=false;
document.getElementById("pk").checked=false;
document.getElementById("a+").checked=false;
document.getElementById("unq").checked=false;
document.getElementById("a+").disabled=false; //enabling autoIncrement after Add new row
}
function addRow()
{
var fieldText=$('#fieldText');
var defaultText=$('#defaultText');
var dataType=$('#dataType').val();
if(dataType==1) dataType="int";
if(dataType==2) dataType="char";
if(dataType==3) dataType="varchar";
if(dataType==4) dataType="date";
if(dataType==5) dataType="time";

alert(dataType);
var notNull=document.getElementById("nn");
var primaryKey=document.getElementById("pk");
var uniqueKey=document.getElementById("unq");
var autoIncrement=document.getElementById("a+");
var dataTypeWidth=document.getElementById("width").value;
var note=$('#note');

var isFocus;
var isPrimaryKey=false;
var isNotNull=false;
var isUniqueKey=false;
var isAutoIncrement=false;
if(notNull.checked==true) isNotNull=true;
if(primaryKey.checked==true) isPrimaryKey=true;
if(uniqueKey.checked==true) isUniqueKey=true;
if(autoIncrement.checked==true) isAutoIncrement=true;
if(!fieldText.val().trim())
{
fieldText.addClass("is-invalid");
if(!isFocus) fieldText.focus();
isFocus=true;
}
else
{
fieldText.removeClass("is-invalid");
}

if(!defaultText.val().trim())
{
defaultText.addClass("is-invalid");
if(!isFocus)defaultText.focus();
isFocus=true;
}
else
{
defaultText.removeClass("is-invalid");
}

if(!note.val().trim())
{
note.addClass("is-invalid");
if(!isFocus) note.focus();
isFocus=true;
}
else
{
note.removeClass("is-invalid");
}

if (!isFocus)
{
var textValue=[];
textValue["field"]=fieldText.val().trim();
textValue["dataType"]=dataType;
textValue["default"]=defaultText.val().trim();
textValue["primaryKey"]=isPrimaryKey;
textValue["uniqueKey"]=isUniqueKey;
textValue["notNull"]=isNotNull;
textValue["autoIncrement"]=isAutoIncrement;
textValue["note"]=note.val().trim();
textValue["width"]=dataTypeWidth;
var databaseTableField=new DatabaseTableField();
databaseTableField.name=textValue["field"];
databaseTableField.isPrimaryKey=textValue["primaryKey"];
databaseTableField.defaultValue=textValue["default"];
databaseTableField.dataType=textValue["dataType"];
databaseTableField.isAutoIncrement=textValue["autoIncrement"];
databaseTableField.isUnique=textValue["uniqueKey"];
databaseTableField.isNotNull=textValue["notNull"];
databaseTableField.checkConstraint=textValue["constraint"];
databaseTableField.note=textValue["note"];
databaseTableField.width=textValue["width"];
selectedTable.getDatabaseTable().setFields(databaseTableField);
createRow(textValue);
}
}
function deleteRow()
{
alert('deleteRow');
alert(document.getElementById("delDivision"));
del=true;
document.getElementById("delDivision").style.display='block';
document.getElementById("addDivision").style.display='none';
}
function editRow()
{
edit=true;
document.getElementById("editDivision").style.display='block';
document.getElementById("addDivision").style.display='none';
}

function changeCheckbox(value)
{
if(value=="char" || value=="varchar" || value=="boolean") 
{
var d=document.getElementById("a+")
d.checked=false;
d.disabled= true;
}
else document.getElementById("a+").disabled= false;
}

function modalClose()
{

var tableName=$("#tableName").val().trim();
var tableNote=$("#tableNote").val();
var engine=$("#engine").val();
var databaseTable=selectedTable.getDatabaseTable();
databaseTable.tableName=tableName;
databaseTable.engineName=engine;
databaseTable.note=tableNote;
Draw();
alert(databaseTable.tableName);
$("#tableNote").val('');
$("#engine").val('');
}
function updateAttribute()
{
alert("update")
var a=selectedTable.getDatabaseTable().fields[selectedRow.rowIndex-2];
var fieldText=$('#editFieldText');
var defaultText=$('#editDefaultText');
var dataType=$('#editDataType').val();
var notNull=document.getElementById("editNn");
var primaryKey=document.getElementById("editPk");
var uniqueKey=document.getElementById("editUnq");
var autoIncrement=document.getElementById("editA+");
var note=$('#editnote');

var isFocus;
var isPrimaryKey=false;
var isNotNull=false;
var isUniqueKey=false;
var isAutoIncrement=false;
if(notNull.checked==true) isNotNull=true;
if(primaryKey.checked==true) isPrimaryKey=true;
if(uniqueKey.checked==true) isUniqueKey=true;
if(autoIncrement.checked==true) isAutoIncrement=true;
if(!fieldText.val().trim())
{
fieldText.addClass("is-invalid");
if(!isFocus) fieldText.focus();
isFocus=true;
}
else
{
fieldText.removeClass("is-invalid");
}

if(!defaultText.val().trim())
{
defaultText.addClass("is-invalid");
if(!isFocus)defaultText.focus();
isFocus=true;
}
else
{
defaultText.removeClass("is-invalid");
}

if(!note.val().trim())
{
note.addClass("is-invalid");
if(!isFocus) note.focus();
isFocus=true;
}
else
{
note.removeClass("is-invalid");
}

if (!isFocus)
{
var textValue=[];
textValue["field"]=fieldText.val().trim();
textValue["dataType"]=dataType;
textValue["default"]=defaultText.val().trim();
textValue["primaryKey"]=isPrimaryKey;
textValue["uniqueKey"]=isUniqueKey;
textValue["notNull"]=isNotNull;
textValue["autoIncrement"]=isAutoIncrement;
textValue["note"]=note.val().trim();
var databaseTableField=new DatabaseTableField();
databaseTableField.name=textValue["field"];
databaseTableField.isPrimaryKey=textValue["primaryKey"];
databaseTableField.defaultValue=textValue["default"];
databaseTableField.dataType=textValue["dataType"];
databaseTableField.isAutoIncrement=textValue["autoIncrement"];
databaseTableField.isUnique=textValue["uniqueKey"];
databaseTableField.isNotNull=textValue["notNull"];
databaseTableField.checkConstraint=textValue["constraint"];
databaseTableField.note=textValue["note"];
//alert(databaseTableField.name+","+databaseTableField.isPrimaryKey+","+databaseTableField.isAutoIncrement+","+databaseTableField.isNotNull);

$('#editFieldText').val(" ");
$('#editDefaultText').val(" ");
$('#editDataType').val("int");
$('#editnote').val(" ");
document.getElementById("editNn").checked=false;
document.getElementById("editPk").checked=false;
document.getElementById("editA+").checked=false;
document.getElementById("editUnq").checked=false;
document.getElementById("editA+").disabled=false; //enabling autoIncrement after Add new row
selectedTable.getDatabaseTable().fields.splice(selectedRow.rowIndex-2,1,databaseTableField);
document.getElementById("addDivision").style.display='block';
document.getElementById("editDivision").style.display='none';
$("#outerTable").find("button").attr("disabled", false);
var cells=selectedRow.childNodes;
var constraints="";
cells[0].innerHTML=textValue["field"];
if(textValue["primaryKey"])
{
var img = document.createElement('img');
img.src = '/dbproject/images/key.png';
cells[0].appendChild(img);
}
cells[1].innerHTML=textValue["dataType"];
if(textValue["notNull"]) constraints="NN ";
if(textValue["uniqueKey"]) constraints+="  UNQ";
if(textValue["autoIncrement"]) constraints+=" ++ ";
cells[2].innerHTML=constraints;
cells[3].innerHTML=textValue["default"];
cells[4].innerHTML=textValue["note"];




}//if(!isFocus)
}//updateEdit

function deleteAttribute()
{
selectedTable.getDatabaseTable().fields.splice(selectedRow.rowIndex-2,1);
selectedRow.parentNode.removeChild(selectedRow); //selected row global
document.getElementById("addDivision").style.display='block';
document.getElementById("delDivision").style.display='none';
$("#outerTable").find("button").attr("disabled", false);
}
var checkBox;
var textNode;
function generateScript()
{
var generateScriptModalBody=document.getElementById("generateScriptModalBody");
if(tableComponents.length==0)
{
return;
}
generateScriptModalBody.innerHTML="";
for(var i=0;i<tableComponents.length;i++)
{
checkBox=document.createElement("input");
checkBox.type="checkbox";
checkBox.name="name"+i;
checkBox.id="id"+i;
textNode=document.createTextNode(tableComponents[i].databaseTable.tableName);
generateScriptModalBody.appendChild(textNode);
generateScriptModalBody.appendChild(checkBox);
generateScriptModalBody.appendChild(document.createElement("br"));
}
$('#generateScriptModal').modal('show');
}
function generate()
{
var table=null;
var tables=[];
var a;
var array=[];
var aa;
for(var k=0;k<tableComponents.length;k++)
{
a="id"+k;
if(document.getElementById(a).checked==true)
{
array.push(k);
}
}
if(array.length==0) return;
for(var i=0;i<array.length;i++)
{
table=new Table();
aa=parseInt(array[i]);
table.name=tableComponents[aa].drawableTable.getDatabaseTable().tableName;
table.note=tableComponents[aa].drawableTable.getDatabaseTable().note;
table.numberOfFields=parseInt(tableComponents[aa].databaseTable.fields.length);
var coordinates=tableComponents[aa].drawableTable.getInfo()
table.xlocation=parseInt(coordinates[0]);
table.ylocation=parseInt(coordinates[1]);
table.engine=tableComponents[aa].databaseTable.engineName;
for(var j=0;j<tableComponents[aa].databaseTable.fields.length;j++)
{
table.fields[j]=tableComponents[aa].databaseTable.fields[j];
}
tables.push(table);
}

var details={
"argument-1":{
"tables":tables
}
};

$.ajax('/dbproject/webservice/projectService/generateScript',{
type:"POST",
contentType:"application/json",
data:JSON.stringify(details)
});
}
function generatePojoModal()
{
if(tableComponents.length==0) return;
$('#generatePojoModal').modal('show');
}
function generatePojo()
{
var tables=[];
var i;
var pojoTable;
var pTable=document.getElementById("pTable").value;
var pojoPackageName=document.getElementById("pojoPackage").value;
if(pojoPackageName=="" || pTable=="") return;
var c=-1;
for(i=0;i<tableComponents.length;i++)
{
if(pTable==tableComponents[i].drawableTable.getDatabaseTable().tableName) 
{
c=i;
}
}
if(c==-1) return;
pojoTable=new Table();
pojoTable.name=tableComponents[c].drawableTable.getDatabaseTable().tableName;
pojoTable.packageName=pojoPackageName;
for(var j=0;j<tableComponents[c].databaseTable.fields.length;j++)
{
pojoTable.fields[j]=tableComponents[c].databaseTable.fields[j];
}
tables.push(pojoTable);
var details={
"argument-1":{
"tables":tables
}
};
$.ajax('/dbproject/webservice/projectService/generatePojo',{
type:"POST",
contentType:"application/json",
data:JSON.stringify(details)
});

}
</script>
<style>
.modal-lg 
{
max-width:80%;
}
</style>

</head>

<body onLoad=initializeDS()>
<!-- Modal -->

<div class="modal fade" id="table" role="dialog" data-backdrop='static' >
<div  class="modal-dialog modal-lg">
<div class="modal-content">

<div class="modal-header">
<h4 class="modal-title">Table</h4>
<button type="button" class="close" data-dismiss="modal" onclick='modalClose()'>&times;</button>
</div>

<div class="modal-body">

<div class="form-group">
              
<div class="form-label-group">
                
<input type="tableName" id="tableName" name="tableName"  class="form-control" placeholder="Table Name" required="required" autofocus="autofocus" style="width:400px;">

<label for="tableName">Table Name</label>
              
</div>
            
</div>
            

<!-- Nav Tabs-->

<nav class="navbar" bg-light navbar-light">
<ul class="nav nav-tabs">
<li class="nav-item">
<a class="nav-link active" data-toggle="tab" href="#tables">Table</a>
</li>
  
<li class="nav-item">
<a class="nav-link" data-toggle="tab" href="#attributes">Attributes</a>
</li>
</ul>
</nav>

<!-- Nav Tabs Closed-->

<!----Toggle Modal-------------->
<div class="modal fade" id="generateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop='static'>
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title">TOAD DATA MODELER SAYS</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body" id="generateModalBody"></div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal" >Ok</button>
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>

</div>
</div>
</div>
</div>

<!---------Toggle Modal Close-------->

<!-- Tab Panes -->
<div class="tab-content">
<div class="tab-pane container fade show active" id="tables">
<table style="width:100%" border='2 solid black'>
<tr>
<th>
<table >
<tr>
<th style="padding:30px">
<div class='form-group'>
<label for="engine"><h4>Database Engine :</h4></label>
<select class="from-control" id='engine' >
<option value="1">InnoDB</option>
</select>
</div>
</th>

<th style="padding:30px">
<label for="Note"><h4>Note <h4></label>
<textarea class='form-control' rows="4" cols="60" id="tableNote"></textarea>
</th></tr>
</table>
</table>
</th></tr>
</div>

<div class="tab-pane container" id="attributes">

<div  style="overflow-y:scroll;max-height: 300px; width: 100%;" id="attributeTable">
<table  id="outerTable" class="table table-striped table-bordered" cellspacing="2" width="100%">
<tr>
<thead class='thead-light'>
<th style="padding:20px;"><h4>Fields</h4></th>
<th style="padding:20px;"><h4>Type</h4></th>
<th style="padding:20px;"><h4>Constraints</h4></th>
<th style="padding:20px;"><h4>Default</h4></th>
<th style="padding:20px;"><h4>Note</h4></th>
<th style="padding:20px;"><h4>Edit/Delete</h4></th>
</tr>
</thead>
</table>
</div>

<div id="addDivision" >
<table style="width:80%" border='2 solid black'>
<tr><h4>Add</h4>
<th>
<table>
<tr><th style="padding:10px">
<div class="form-label-group">
                
<input type="text" id="fieldText" name="fieldName" class="form-control" placeholder="Enter Field Name" style="width:200px;">

<label for="fieldText">Enter Field Name</label>
              
</div>
            
</th>

<th style="padding:10px">
<div class="form-label-group">
                
<input type="text" id="width" name="width" class="form-control" placeholder="Enter Width" style="width:200px;">

<label for="width">Enter Width</label>
              
</div>
            
</th>


<th style="padding:20px">

<div class='form-group'>
DataType <select class="from-control" id='dataType'>
<option >int</option>
<option >char</option>
<option >varchar</option>
<option >boolean</option>
<option >date</option>
<option >time</option>
<option >float</option>
<option >double</option>
</select>
</div>


<th style="padding:5px">
<div class="form-label-group">
                
<input type="text" id="defaultText" name="defaultValue" class="form-control" placeholder="Enter Field Name" required="required" autofocus="autofocus" style="width:200px;">

<label for="defaultText">Default Value</label>
              
</div>
            
</th></tr>

<tr><th style="padding:20px">
Constraints<h5>
NN  <input type="checkbox" id="nn" name="nn" value="nn" style="text-align:center;vertical-align:middle;zoom:1.5">
AUTO++<input type="checkbox" id="a+" name="a+" value="a+" style="text-align:center;vertical-align:middle;zoom:1.5;">
PK <input type="checkbox" id="pk" name="pk" value="pk" style="text-align:center;vertical-align:middle;zoom:1.5;">
UNQ <input type="checkbox" id="unq" name="unq" value="unq" style="text-align:center;vertical-align:middle;zoom:1.5;">
</h5>
</th>

<th style="padding:30px">
<label for="note"><h4>Field Note <h4></label>
<textarea class='form-control' rows="2" cols="30" id="note"></textarea>
</th>
<th style="padding:50px">
<button type="button" id="addNewField" style="padding:10px 10px" class="btn btn-default" data-toggle="tooltip" title="Add" id="addField" onclick='addRow()'><img src='/dbproject/images/add.png'></img></button>

</th></tr>

</table>
</tr></th>
</table>
</div>
<!-- add division closed-->


<div id="editDivision" style="display: none;" >
<table style="width:80%" border='2 solid black'>
<tr><h4>Edit</h4>
<th>
<table>
<tr><th style="padding:10px">
<div class="form-label-group">
                
<input type="text" id="editFieldText" name="fieldName" class="form-control" placeholder="Enter Field Name" style="width:200px;">

<label for="editFieldText">Enter Field Name</label>
              
</div>
            
</th>
<th style="padding:20px">

<div class='form-group'>
DataType <select class="from-control" id='editDataType' onchange="changeCheckbox(this.value)">
<option >int</option>
<option >char</option>
<option >varchar</option>
<option >boolean</option>
<option >date</option>
<option >time</option>
<option >float</option>
<option >double</option>
</select>
</div>



<th style="padding:5px">
<div class="form-label-group">
                
<input type="text" id="widthText" name="widthText" class="form-control" placeholder="Enter Width" required="required" autofocus="autofocus" style="width:200px;">

<label for="widthText">Enter Width</label>
              
</div>
            
</th></tr>


<tr><th style="padding:20px">
Constraints<h5>
NN  <input type="checkbox" id="editNn" name="nn" value="nn" style="text-align:center;vertical-align:middle;zoom:1.5">
AUTO++<input type="checkbox" id="editA+" name="a+" value="a+" style="text-align:center;vertical-align:middle;zoom:1.5;">
PK <input type="checkbox" id="editPk" name="pk" value="pk" style="text-align:center;vertical-align:middle;zoom:1.5;">
UNQ <input type="checkbox" id="editUnq" name="unq" value="unq" style="text-align:center;vertical-align:middle;zoom:1.5;">
</h5>
</th>

<th style="padding:30px">
<label for="note"><h4>Field Note <h4></label>
<textarea class='form-control' rows="2" cols="30" id="editnote"></textarea>
</th>
<th style="padding:50px">
<button type="button" id="updateAttribute" style="padding:10px 10px" class="btn btn-default" data-toggle="tooltip" title="Update"  onclick='updateAttribute()'><img src='/dbproject/images/edit.png'></img></button>

</th></tr>

</table>
</tr></th>
</table>
</div>
<!--edit division closed-->

<div id="delDivision" style="display: none;" >
<table style="width:80%" border='2 solid black'>
<tr><h4>Delete</h4>
<th>
<table>
<tr><th style="padding:10px">
Field Name : <span id="deleteFieldText">
</span>
</th>
<th style="padding:20px">
Datatype : <span id="deleteDataType">
</span>

<th style="padding:5px">
Default Text : <span id="deleteDefaultText">
</span>

</th></tr>

<tr><th style="padding:20px">
Constraints : <h5>
NN  <input type="checkbox" id="deleteNn" name="nn" value="nn" style="text-align:center;vertical-align:middle;zoom:1.5">
AUTO++<input type="checkbox" id="deleteA+" name="a+" value="a+" style="text-align:center;vertical-align:middle;zoom:1.5;">
PK <input type="checkbox" id="deletePk" name="pk" value="pk" style="text-align:center;vertical-align:middle;zoom:1.5;">
UNQ <input type="checkbox" id="deleteUnq" name="unq" value="unq" style="text-align:center;vertical-align:middle;zoom:1.5;">
</h5>
</th>

<th style="padding:30px">
Note : <span id="deletenote">
</span>

</th>
<th style="padding:50px">

<button type="button" id="deleteAttribute" style="padding:10px 10px" class="btn btn-default" data-toggle="tooltip" title="delete"  onclick='deleteAttribute()'><img src='/dbproject/images/delete.png'></img></button>

</th></tr>

</table>
</tr></th>
</table>
</div>
<!--delete division closed-->








<!-- Tab Panes Closed -->

</div></div></div></div></div>


<!--modal-body-->
</div>
</div>
</div>


<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
<h1 class="navbar-brand mr-0">Menu</h1>
<button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
<i class="fas fa-bars"></i>
</button>


<!-- Navbar -->
<ul class="navbar-nav ml-auto mr-md-3">
<h1 class="navbar-brand mr-0 text-white" aria-haspopup="true" aria-expanded="false">    
<i class="fas fa-user-circle fa-fw">
</i>
${emailId}
</h1>
</ul>
</nav>

<div id="wrapper">
<!-- Sidebar -->
<ul class="sidebar navbar-nav">
<li class="nav-item active">
<a class="nav-link" href="#" data-toggle="modal" data-target="#closeProjectModal">
<!-- i class="fas fa-fw fa-tachometer-alt"></i-->
<span>Close</span>
</a>
</li>




<!--table close Modal-->
<div class="modal fade" id="tableCloseModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop='static'>
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title">Do you want to save changes ?</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">Click on save to save changes.</div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
<button class="btn btn-secondary" type="button" data-dismiss="modal" onclick='updateTableInformation()'>Save</button>

</div>
</div>
</div>
</div>


<!----Generate Script Modal---->
<div class="modal fade" id="generateScriptModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop='static'>
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title">Generate Scripts for</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body" id="generateScriptModalBody">No tables Found</div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal" onclick='generate()'>generate</button>
<button class="btn btn-secondary" type="button" data-dismiss="modal">No</button>

</div>
</div>
</div>
</div>

<!--------Generate ScriptModal close---->

<!----------Generate Pojo Modal-------------->
<div class="modal fade" id="generatePojoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop='static'>
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title">Generate Pojo for</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body" id="generateScriptModalBody">
<b>Package Name: </b><input type="text" id="pojoPackage" name="pojoPackage" class="form-control" placeholder="com.demo" style="width:200px;">

<br>
<br>
<b>Table Name: </b><input type="text" id="pTable" name="pTable" class="form-control" placeholder="Enter tableName.." style="width:200px;">


</div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal" onclick='generatePojo()'>GeneratePojo</button>
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>

</div>
</div>
</div>
</div>


<!-----------Generate Pojo Modal close>


<!-- project close modal-->

<div class="modal fade" id="closeProjectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop='static'>
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Do you want to save changes ?</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">Click on save to save changes.</div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
<a class="btn btn-primary" href="/dbproject/homepage.jsp">Save</a>
</div>
</div>
</div>
</div>

<!--project close Modal khatam -->




<li class="nav-item active">
<a class="nav-link" href="#" data-toggle="modal" data-target="#logoutModal">
<!-- i class="fas fa-fw fa-tachometer-alt"></i-->
<span>Logout</span>
</a>
</li>


<li class="nav-item active">
<a class="nav-link" href="#" data-toggle="modal" data-target="">
<!-- i class="fas fa-fw fa-tachometer-alt"></i-->
<button type="button" class="btn btn-primary bg-dark" style="border:none;" onclick="generateScript()">GenerateScript</button>
</a>
</li>

<li class="nav-item active">
<a class="nav-link" href="#" data-toggle="modal" data-target="">
<!-- i class="fas fa-fw fa-tachometer-alt"></i-->
<button type="button" class="btn btn-primary bg-dark" style="border:none;" onclick="generatePojoModal()">GeneratePojo</button>
</a>
</li>


</ul>

<div id="content-wrapper">
<div class="container-fluid">


<!-- Area Chart Example-->
 <div class="card mb-3">
  <div class="card-header">
<i class="fas fa-chart-area"></i>

 ${sessionScope.title}
</div>

<div class="card-header">
<div class="container-fluid">
<div class="btn-toolbar" role="toolbar">

<div class="btn-group mr-1" role="group">
<button type="button" class="btn btn-primary bg-dark" data-toggle="tooltip" title="Create Table" onclick='createTableButton()'><i class="fas fa-table"></i></button>

</div>

<div class="btn-group text-white" role="group">
<button type="button" class="btn btn-primary bg-dark" onclick='saveProject()' data-toggle="tooltip" title="Save"><i class="fas fa-save"></i></button>
</div>



</div>
</div>
</div>


<div class="card-body" id="canvasDiv" style="max-height: 600px;overflow: scroll;">
<canvas id="canvas" width="1380" height="1000" style="border:1px solid"></canvas>
</div>
</div>
<!-- Area Chart Ends -->



<!-- /.container-fluid -->

<!-- Sticky Footer -->
<footer class="sticky-footer">
<div class="container my-auto">
<div class="copyright text-center my-auto">
<span>Copyright ©Thinking Machines 2019</span>
</div>
</div>
</footer>

</div>
<!-- /.content-wrapper -->
</div>
<!-- /#wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
<i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modals-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop='static'>
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
<a class="btn btn-primary" href="/dbproject/webservice/memberService/logout">Logout</a>
</div>
</div>
</div>
</div>




<!-- Modal -->
<div class="modal fade" id="createProjectModal" role="dialog" data-backdrop='static'>
<div class="modal-dialog modal-lg">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title">Create Project</h4>          
<button type="button" class="close" data-dismiss="modal">&times;</button>
          
</div>
<div class="modal-body">
<form method='Post' id='modalCreateProject' action='/dbproject/webservice/projectService/create' novalidate>

<div class="form-group">
              
<div class="form-label-group">
                
<input type="text" id="projectTitle" name="argument-1" class="form-control" placeholder="Project Title "   required="required"   autofocus="autofocus">
                
<label for="projectTitle">Project Title</label>
              
</div>
            
</div>

<h6>
<b>Select Database Architecture</b>
<select name='argument-2' id='projectArchitecture'>
<option value='-1'>&lt;Select&gt;</option>
<option value='1'>MySql</option>
<option value='3'>Apache Derby</option>
<option value='2'>Oracle</option>
</select>
</h6>

</div>
<div class="modal-footer">
<input type="submit" class="btn btn-default" value='Create' >
<button type="button" class="btn btn-default"  data-dismiss="modal">Close</button>
</div>
</div>
</form>

</div>
</div>


<!-- Bootstrap core JavaScript-->
<script src="/dbproject/vendor/jquery/jquery.min.js"></script>
<script src="/dbproject/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/dbproject/vendor/jquery-easing/jquery.easing.min.js"></script>

    
<!-- Custom scripts for all pages-->
<script src="/dbproject/js/sb-admin.min.js"></script>

<!-- Demo scripts for this page-->
  
</body>
</html>
