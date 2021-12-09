<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

     <title>SB Admin Create Project- Dashboard</title>

    <!-- Bootstrap core CSS-->
    <link href="/dbproject/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="/dbproject/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="/dbproject/vendor/fontawesome-free/css/fontawesome.min.css" rel="stylesheet" type="text/css">
    <link href="/dbproject/vendor/fontawesome-free/css/fontawesome.css" rel="stylesheet" type="text/css">
    <link href="/dbproject/vendor/fontawesome-free/css/all.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/dbproject/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/dbproject/css/sb-admin.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/dbproject/vendor2/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/dbproject/fonts2/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/dbproject/vendor2/animate/animate.css">
<link rel="stylesheet" type="text/css" href="/dbproject/vendor2/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="/dbproject/vendor2/perfect-scrollbar/perfect-scrollbar.css">
<script src='/dbproject/JQuery/jquery.js'></script>
<script src='webservice/js/TMService.js'></script>
<script src='webservice/js/projectService.js'></script>
<script>
var valid=false;
var lastTableIndex=0;
var tableComponents=[];
var projectCode=${projectCode};
function TableAttribute()
{
this.code=0;
this.name=null;
this.dataType=null;
this.databaseArchitectureDataTypeCode=0;
this.width=0;
this.numberOfDecimalPlaces=0;
this.isPrimaryKey=false;
this.isAutoIncrement=false;
this.isUnique=false;
this.isNotNull=false;
this.defaultValue=null;
this.checkConstraint=null;
this.note=null;
}
function DatabaseTable(x,y,name)
{
this.code=0;
this.x=x;
this.y=y;
this.name=name;
this.databaseEngineCode=0;
this.note=null;
this.fields=[];
}
function DrawableTable(vDatabaseTable)
{
this.databaseTable=vDatabaseTable;
this.draw=function()
{

alert("drawable table ki draw");
alert(this.databaseTable.x);
//find max width of font and adjust the table acco. to it
var canvas=document.getElementById("myCanvas");
var ctx=canvas.getContext("2d");
var width=160;
var height=210;
j=0;
alert((tableComponents[0].databaseTable.x+width)+","+tableComponents[0].databaseTable.y);
while(j<tableComponents.length)
{
alert("Loop me");
alert(JSON.stringify(tableComponents));
if(((this.databaseTable.x >= (tableComponents[j].databaseTable.x+width))&& (this.databaseTable.x<=(tableComponents[j].databaseTable.x)))&&((this.databaseTable.y>= (tableComponents[j].databaseTable.y+height))&& (this.databaseTable.y<=(tableComponents[j].databaseTable.y))))
{
valid=false;
alert("if me gaya");


}

j++;
}
alert(valid);



if(valid==true)
{
ctx.beginPath();
ctx.fillStyle="#D3D3D3";
ctx.fillRect(this.databaseTable.x,this.databaseTable.y,width,50);

ctx.moveTo(this.databaseTable.x, this.databaseTable.y+50);
ctx.lineTo(this.databaseTable.x+width,this.databaseTable.y+50);
ctx.fillStyle="#000000";

ctx.font = "30px Arial";
ctx.fillText("Table "+(i+1),this.databaseTable.x+18,this.databaseTable.y+35);

ctx.rect(this.databaseTable.x,this.databaseTable.y,width,height);
ctx.stroke();




valid=false;
document.getElementById("addTable").style.borderColor="white";
i++;
return;
}
else
{
document.getElementById("addTable").style.borderColor="white";
}
}
}
function TableComponent(x,y,name)
{
this.databaseTable=new DatabaseTable(x,y,name);
this.drawableTable=new DrawableTable(this.databaseTable);
this.draw=function()
{
this.drawableTable.draw();
}
}
function add()
{
valid=true;
document.getElementById("addTable").style.borderColor="red";
}
function kalu()
{
this.x1=0;
this.y1=0;
this.x2=0;
this.y2=0;
}
var i=0;
var j=0;
var count=0;
function draw(event)
{
if(valid==false)
{
return;
}
alert("draw chali");
var canvas=document.getElementById("myCanvas");
var ctx=canvas.getContext("2d");
var kp=0;
var width=160;
var height=210;
var x=event.clientX;
var y=event.clientY-132;
var name="table"+(count+1);
if(tableComponents.length!=0)
{
ctx.clearRect(0,132,1341,700);
while(kp<tableComponents.length)
{
ctx.beginPath();
ctx.fillStyle="#D3D3D3";
ctx.fillRect(tableComponents[kp].databaseTable.x,tableComponents[kp].databaseTable.y,width,50);
ctx.moveTo(tableComponents[kp].databaseTable.x, tableComponents[kp].databaseTable.y+50);
ctx.lineTo(tableComponents[kp].databaseTable.x+width,tableComponents[kp].databaseTable.y+50);
ctx.fillStyle="#000000";
ctx.font = "30px Arial";
ctx.fillText("Table "+(kp+1),tableComponents[kp].databaseTable.x+18,tableComponents[kp].databaseTable.y+35);
ctx.rect(tableComponents[kp].databaseTable.x,tableComponents[kp].databaseTable.y,width,height);
ctx.stroke();
kp++;
}
}
var kk=false;
alert("ClientX :"+x+","+"ClientY: "+y);
while(i<tableComponents.length)
{
alert(tableComponents[i].databaseTable.x+","+tableComponents[i].databaseTable.x+width+","+tableComponents[i].databaseTable.y+","+tableComponents[i].databaseTable.y+height);
if(((x>=(tableComponents[i].databaseTable.x))&& (x<=(tableComponents[i].databaseTable.x+width)))&&((y>= (tableComponents[i].databaseTable.y))&& (y<=(tableComponents[i].databaseTable.y+height))))
{
alert("draw k if me aaya");
alert("i :"+i);
break;
kk=true;
}
i++;
}
if(kk==true)
{
alert("KK true hai");
return;
}
else
{
alert("KK false hai");
var databaseTable=new DatabaseTable(x,y,name);
var tableComponent=new TableComponent(x,y,name);
var i=0;
var ghoda=false;
tableComponents.push(tableComponent);
tableComponent.draw();
count++;
}
}
var ramu=0;
function OpenModal(event)
{
var width=160;
var height=210;
alert("Open Modal chali");
var x=event.clientX;
var y=event.clientY-132;
var name="table"+(count+1);
var tableComponent=new TableComponent(x,y,name);
var ghoda=false;
alert("Table Components Length :"+tableComponents.length);
while(ramu<tableComponents.length)
{
if(((x>=(tableComponents[ramu].databaseTable.x))&& (x<=(tableComponents[ramu].databaseTable.x+width)))&&((y>= (tableComponents[ramu].databaseTable.y))&& (y<=(tableComponents[ramu].databaseTable.y+height))))
{
alert("OpenModal ke if me aaya");
ghoda=true;
break;
}
ramu++;
}
alert("Ghoda:" +ghoda);
if(ghoda==true)
{
alert("openModal k if me aaya");
document.getElementById("tableCode").value=ramu;
document.getElementById("tableName").value="table"+(ramu+1);
$('#largeModal').modal('show');
}
else
{
return;
}
}
function note()
{
$('#fieldModal').modal('hide');
document.getElementById("noteDivision").style.visibility="visible";
}
function clearText()
{
document.getElementById("noteDivision").style.visibility="hidden";
$('#largeModal').modal('hide');
$('#fieldModal').modal('show');
tableBharo();
}
function tableBharo()
{
var tC=parseInt(document.getElementById("tableCode").value);
var p=tableComponents[tC].databaseTable.fields.length;
var h;
var tr;
var td;
var r=0;
var c;
var textNode;
var deleteImage;
var keyImage;
var editImage;
var autoIncrementImage;
var caretUpImage;
var caretDownImage;
var headRow=document.getElementById("headRow");
var fieldTable=document.getElementById("fieldTable");
var fieldTableBody=document.createElement("tbody");
var fieldTableHeader=document.getElementById("fieldTableHeader");
fieldTable.innerHTML="";
fieldTableHeader.appendChild(headRow);
fieldTable.appendChild(fieldTableHeader);
while(r<p)
{
tr=document.createElement("tr");
tr.id="row"+r;
tr.rowNumber=r;
function cellContentClickHandlerCreator(rowNumber,cellNumber)
{
return function(){
raiseCellContentClickedEvent(rowNumber,cellNumber,tC);
};
}
function rowSelectionClickHandlerCreator(rowNumber,cellNumber,tC)
{
return function(){
raiseRowSelectedEvent(rowNumber,cellNumber);
};
}
c=0;
while(c<=10)
{
td=document.createElement("td");
if(c==0)
{
textNode=document.createTextNode(r+1);
td.appendChild(textNode);
}
if(c==1)
{
if(tableComponents[tC].databaseTable.fields[r].isPrimaryKey==true)
{
textNode=document.createTextNode(tableComponents[tC].databaseTable.fields[r].name);
keyImage=document.createElement("i");
keyImage.setAttribute("class","fa fa-key");
var str="decimal"+"("+tableComponents[tC].databaseTable.fields[r].width+","+tableComponents[tC].databaseTable.fields[r].numberOfDecimalPlaces+")";
var tn=document.createTextNode(str);
td.appendChild(textNode);
td.appendChild(document.createTextNode(" "));
td.appendChild(tn);
td.appendChild(keyImage);
}
else
{
var str2="decimal"+"("+tableComponents[tC].databaseTable.fields[r].width+","+tableComponents[tC].databaseTable.fields[r].numberOfDecimalPlaces+")";
textNode=document.createTextNode(tableComponents[tC].databaseTable.fields[r].name);
var tn2=document.createTextNode(str2);
td.appendChild(textNode);
td.appendChild(document.createTextNode(" "));
td.appendChild(tn2);
}
}
if(c==2) 
{
textNode=document.createTextNode(tableComponents[tC].databaseTable.fields[r].dataType);
td.appendChild(textNode);
}
if(c==3)
{
if(tableComponents[tC].databaseTable.fields[r].isAutoIncrement==true)
{
var aiI=document.createElement("i");
aiI.setAttribute("class","fa fa-plus");
autoIncrementImage=document.createElement("i");
autoIncrementImage.setAttribute("class","fa fa-plus");
td.appendChild(autoIncrementImage);
td.appendChild(aiI);
}
else
{
td.appendChild(document.createTextNode(" "));
}
}
if(c==4) 
{
textNode=document.createTextNode(tableComponents[tC].databaseTable.fields[r].isUnique);
td.appendChild(textNode);
}
if(c==5)
{
textNode=document.createTextNode(tableComponents[tC].databaseTable.fields[r].isNull);
td.appendChild(textNode);
}
if(c==6)
{
textNode=document.createTextNode(tableComponents[tC].databaseTable.fields[r].defaultValue);
td.appendChild(textNode);
}
if(c==7)
{
deleteImage=document.createElement("i");
deleteImage.setAttribute("class","fa fa-trash");
td.appendChild(deleteImage);
}
if(c==8)
{
editImage=document.createElement("i");
editImage.setAttribute("class","fa fa-edit");
td.appendChild(editImage);
}
if(c==9)
{
caretUpImage=document.createElement("i");
caretUpImage.setAttribute("class","fa fa-caret-up");
td.appendChild(caretUpImage);
}
if(c==10)
{
caretDownImage=document.createElement("i");
caretDownImage.setAttribute("class","fa fa-caret-down");
td.appendChild(caretDownImage);
}
td.onclick=cellContentClickHandlerCreator(r,c);
tr.appendChild(td);
c++;
}
tr.style.cursor='pointer';
tr.onclick=rowSelectionClickHandlerCreator(r,c);
fieldTableBody.appendChild(tr);
r++;
}
fieldTable.appendChild(fieldTableBody);
return;
}
function raiseRowSelectedEvent(rowNumber,cellNumber,tC)
{
//alert("Row Number :"+rowNumber);
}
function raiseCellContentClickedEvent(rowNumber,cellNumber,tC)
{
var deleteButton=document.getElementById("deleteButton");
if(cellNumber==0) return;
if(cellNumber==1) return;
if(cellNumber==2) return;
if(cellNumber==3) return;
if(cellNumber==4) return;
if(cellNumber==5) return;
if(cellNumber==6) return;
if(cellNumber==7) 
{
document.getElementById("addRowDivision").visibility="hidden";
document.getElementById("deleteRowDivision").visibility="visible";
document.getElementById("delAttrName").value=tableComponents[tC].databaseTable.fields[rowNumber].name;
document.getElementById("delDataType").value=tableComponents[tC].databaseTable.fields[rowNumber].dataType;
document.getElementById("delPrimaryKey").checked=tableComponents[tC].databaseTable.fields[rowNumber].isPrimaryKey;
document.getElementById("delAutoInc").checked=tableComponents[tC].databaseTable.fields[rowNumber].isAutoIncrement;
document.getElementById("delUnique").checked=tableComponents[tC].databaseTable.fields[rowNumber].isUnique;
document.getElementById("delNotNull").checked=tableComponents[tC].databaseTable.fields[rowNumber].isNull;
document.getElementById("deleteButton").disabled=false;
document.getElementById("editAttrName").disabled=true;
document.getElementById("editDataType").disabled=true;
document.getElementById("editPrimaryKey").disabled=true;
document.getElementById("editAutoInc").disabled=true;
document.getElementById("editUnique").disabled=true;
document.getElementById("editNotNull").disabled=true;
document.getElementById("editButton").disabled=true;
document.getElementById("attrName").disabled=true;
document.getElementById("dataType").disabled=true;
document.getElementById("primKey").disabled=true;
document.getElementById("autoInc").disabled=true;
document.getElementById("unique").disabled=true;
document.getElementById("isNotNull").disabled=true;
document.getElementById("addButton").disabled=true;
document.getElementById("editAttrName").value="";
document.getElementById("editDataType").value="";
document.getElementById("editPrimaryKey").checked=false;
document.getElementById("editAutoInc").checked=false;
document.getElementById("editUnique").checked=false;
document.getElementById("editNotNull").checked=false;
}
if(cellNumber==8)
{
document.getElementById("editAttrName").disabled=false;
document.getElementById("editDataType").disabled=false;
document.getElementById("editPrimaryKey").disabled=false;
document.getElementById("editAutoInc").disabled=false;
document.getElementById("editUnique").disabled=false;
document.getElementById("editNotNull").disabled=false;
document.getElementById("editButton").disabled=false;
document.getElementById("attrName").disabled=true;
document.getElementById("dataType").disabled=true;
document.getElementById("primKey").disabled=true;
document.getElementById("autoInc").disabled=true;
document.getElementById("unique").disabled=true;
document.getElementById("isNotNull").disabled=true;
document.getElementById("addButton").disabled=true;
document.getElementById("delAttrName").disabled=true;
document.getElementById("delDataType").disabled=true;
document.getElementById("delPrimaryKey").disabled=true;
document.getElementById("delAutoInc").disabled=true;
document.getElementById("delUnique").disabled=true;
document.getElementById("delNotNull").disabled=true;
document.getElementById("deleteButton").disabled=true;
document.getElementById("delAttrName").value="";
document.getElementById("delDataType").value="";
document.getElementById("delPrimaryKey").checked=false;
document.getElementById("delAutoInc").checked=false;
document.getElementById("delUnique").checked=false;
document.getElementById("delNotNull").checked=false;
document.getElementById("editHiddenField").value=rowNumber;
}
if(cellNumber==9)
{
if(rowNumber==0)return;
var swap=tableComponents[tC].databaseTable.fields[rowNumber];
tableComponents[tC].databaseTable.fields[rowNumber]=tableComponents[tC].databaseTable.fields[rowNumber-1];
tableComponents[tC].databaseTable.fields[rowNumber-1]=swap;
tableBharo();
}
if(cellNumber==10)
{
if(rowNumber==tableComponents[tC].databaseTable.fields.length-1) return;
var swp=tableComponents[tC].databaseTable.fields[rowNumber];
tableComponents[tC].databaseTable.fields[rowNumber]=tableComponents[tC].databaseTable.fields[rowNumber+1];
tableComponents[tC].databaseTable.fields[rowNumber+1]=swp;
tableBharo();
}
}
function RemoveModal()
{
alert("Remove Modal");
var tC=parseInt(document.getElementById("tableCode").value);
var tableName=document.getElementById("tableName").value;
tableComponents[tC].databaseTable.name=tableName;
alert(tableComponents[tC].databaseTable.name);
}
function AddAttribute()
{
var tC=document.getElementById("tableCode").value;
document.getElementById("editDataType").disabled=true;
var p=tableComponents[tC].databaseTable.fields.length;
var attrName=document.getElementById("attrName").value;
var dataType=document.getElementById("dataType").value;
var primKey=document.getElementById("primKey").checked;
var autoInc=document.getElementById("autoInc").checked;
var unique=document.getElementById("unique").checked;
var isNotNull=document.getElementById("isNotNull").checked;
var t=tableComponents[tC].databaseTable.fields;
var f=new TableAttribute();
f.code=0;
f.name=attrName;
f.dataType=dataType;
f.width=15;
f.numberOfDecimalPlaces=4;
f.isPrimaryKey=primKey;
f.isAutoIncrement=autoInc;
f.isUnique=unique;
f.isNull=isNotNull;
f.defaultValue=null;
f.checkConstraint=null;
f.note=document.getElementById("noteField").value;
t.push(f);
document.getElementById("attrName").value="";
document.getElementById("dataType").value="";
document.getElementById("primKey").checked=false;
document.getElementById("autoInc").checked=false;
document.getElementById("unique").checked=false;
document.getElementById("isNotNull").checked=false;
alert(JSON.stringify(tableComponents[tC].databaseTable.fields[p].name));
var headRow=document.getElementById("headRow");
var fieldTable=document.getElementById("fieldTable");
var fieldTableBody=document.createElement("tbody");
var fieldTableHeader=document.getElementById("fieldTableHeader");
fieldTable.innerHTML="";
fieldTableHeader.appendChild(headRow);
fieldTable.appendChild(fieldTableHeader);
tableBharo();
}
function DeleteAttribute()
{
var tC=document.getElementById("tableCode").value;
var delAttrName=document.getElementById("delAttrName").value;
document.getElementById("editAttrName").disabled=true;
document.getElementById("editDataType").disabled=true;
document.getElementById("editPrimaryKey").disabled=true;
document.getElementById("editAutoInc").disabled=true;
document.getElementById("editUnique").disabled=true;
document.getElementById("editNotNull").disabled=true;
document.getElementById("editButton").disabled=true;

for(var d=0;d<tableComponents[tC].databaseTable.fields.length;d++)
{
if(delAttrName==tableComponents[tC].databaseTable.fields[d].name)
{
tableComponents[tC].databaseTable.fields.splice(d,1);
break;
}
}
document.getElementById("delAttrName").value="";
document.getElementById("delDataType").value="";
document.getElementById("delPrimaryKey").checked=false;
document.getElementById("delAutoInc").checked=false;
document.getElementById("delUnique").checked=false;
document.getElementById("delNotNull").checked=false;
document.getElementById("deleteButton").disabled=true;


document.getElementById("attrName").disabled=false;
document.getElementById("dataType").disabled=false;
document.getElementById("primKey").disabled=false;
document.getElementById("autoInc").disabled=false;
document.getElementById("unique").disabled=false;
document.getElementById("isNotNull").disabled=false;
document.getElementById("addButton").disabled=false;
tableBharo();
}
function EditAttribute()
{
var tC=document.getElementById("tableCode").value;
var v=parseInt(document.getElementById("editHiddenField").value);
tableComponents[tC].databaseTable.fields[v].name=document.getElementById("editAttrName").value;
tableComponents[tC].databaseTable.fields[v].dataType=document.getElementById("editDataType").value;
tableComponents[tC].databaseTable.fields[v].isPrimaryKey=document.getElementById("editPrimaryKey").checked;
tableComponents[tC].databaseTable.fields[v].isAutoIncrement=document.getElementById("editAutoInc").checked;
tableComponents[tC].databaseTable.fields[v].isUnique=document.getElementById("editUnique").checked;
tableComponents[tC].databaseTable.fields[v].isNull=document.getElementById("editNotNull").checked;
alert("succefully edit hua");
document.getElementById("editAttrName").disabled=true;
document.getElementById("editDataType").disabled=true;
document.getElementById("editPrimaryKey").disabled=true;
document.getElementById("editAutoInc").disabled=true;
document.getElementById("editUnique").disabled=true;
document.getElementById("editNotNull").disabled=true;
document.getElementById("editButton").disabled=true;

document.getElementById("editAttrName").value="";
document.getElementById("editDataType").value="";
document.getElementById("editPrimaryKey").checked=false;
document.getElementById("editAutoInc").checked=false;
document.getElementById("editUnique").checked=false;
document.getElementById("editNotNull").checked=false;


document.getElementById("attrName").disabled=false;
document.getElementById("dataType").disabled=false;
document.getElementById("primKey").disabled=false;
document.getElementById("autoInc").disabled=false;
document.getElementById("unique").disabled=false;
document.getElementById("isNotNull").disabled=false;
document.getElementById("addButton").disabled=false;
document.getElementById("editHiddenField").value="";
tableBharo();
}
function JSONToSend()
{
this.tableName=null;
this.projCode=null;
this.databaseTableFields=[];
this.numberOfFields=0;
this.engine=null;
}
function Table()
{
this.tableName=null;
}
function Save()
{
var flds=[];
var jsonToSend=new JSONToSend();
var table=new Table();
jsonToSend.projCode=projectCode;
var tName=tableComponents[0].databaseTable.name;
table.tableName=tableComponents[0].databaseTable.name;
jsonToSend.tableName=tableComponents[0].databaseTable.name;
var r=0;
while(r<tableComponents[0].databaseTable.fields.length)
{
jsonToSend.databaseTableFields.push(tableComponents[0].databaseTable.fields[r]);
flds.push(tableComponents[0].databaseTable.fields[r]);
r++;
}
alert(JSON.stringify(flds));
var m=JSON.stringify(flds);
jsonToSend.numberOfFields=r;
jsonToSend.note=document.getElementById("noteField").value;
jsonToSend.engine=document.getElementById("engine").value;
document.getElementById("jsonTextArea").value=JSON.stringify(tableComponents[0].databaseTable.fields);
var tab={
"argument-1":{
"projCode":projectCode,
"tableName":tName,
"engine":document.getElementById("engine").value,
"numberOfFields":r,
"databaseTableFields":m,
}
};
$.ajax('/dbproject/webservice/projectService/save',{
type:"POST",
contentType:'application/json',
dataType:'json',
data:JSON.stringify(tab),
success:function(res){
alert("Sahi hai");
alert(JSON.stringify(res));
},
error:function(err){
alert("Galat hai");
alert(JSON.stringify(err));
}
});
}
</script>
<style>
.navbar-default {
    background-color: #F8F8F8;
    border-color: #E7E7E7;
}
.addbtn 
{
 width:124px;
  background-color: #808080; /* Green */
  border: none;
  color: white;
  padding: 17px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 8px;
}

.modal-lg
{

width:950px;
}
input[type=text]{
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 2px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
.tableName
{
    height:40px;
}
.abtn{
padding: 0;
border: none;
background: none;
}
.noteDivision{
visibility:hidden;
}
.fieldTable{
font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
border-collapse: collapse;
width: 100%;
}
.addRowDivision{
float:left;
width:52%;
}
.deleteRowDivision{
float:left;
width:43%;
height:10%;
}
.editRowDivision{
width:100%;
max-height:10px;
height:100%;
}
.fieldModal{
width:100%;
}
</style>
  </head>

  <body id="page-top">
<textarea align="center" name='jsonTextArea' id='jsonTextArea' cols=10 rows=10></textarea>
    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" href="index.html">Toad Data Modeler</a>

      <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
      </button>

      <!-- Navbar Search -->
      <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
          <div class="input-group-append">
            <button class="btn btn-primary" type="button">
              <i class="fas fa-search"></i>
            </button>
          </div>
        </div>
      </form>

      <!-- Navbar -->
      <ul class="navbar-nav ml-auto ml-md-0">
        
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-user-circle fa-fw"></i>
          </a>
<p class="text-white"> ${emailId}</p>        </li>
      
</ul>

    </nav>

<!-----sIDE BAR---->

<ul class="sidebar navbar-nav">
        <li class="nav-item active">
<a class="nav-link " href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
<i class="fas fa-project-diagram"></i>            
<span>Title : ${title}</span>
<br>
</a> 
</li>
        <li class="nav-item active">
          <a class="nav-link" href="/dbproject/HomePage.jsp" >
<i class="fas fa-times"></i>	            
	 <span>Close</span>
          </a>
         </li>
       <li class="nav-item active">
          <a class="nav-link" href="tables.html">
            <i class="fas fa-sign-out-alt"></i>
            <span>logout</span></a>
        </li>
	 </ul>






<!---<nav class="navbar navbar-expand navbar-black bg-primary static-top" >
<b>Title : ${title} </b>
<a class="nav-link" href="/dbproject/HomePage.jsp"><font align="right" style="color:red;">Close</font> 
<i class="fa fa-close" ></i>
</a>
 </nav>--->

<!-- navbar-expand navbar-dark bg-dark static-top -->
    <nav class="navbar navbar-expand navbar-dark bg-light static-top">
<button type='button' id='addTable' style="background-color:grey" class="nav-link" onclick='add()'>
           <i style="background-color:white" class="fa fa-table"></i>
          </button>     
&nbsp;&nbsp;
<button type='button'  class="nav-link" onclick='Save()' id="save" role="button">
           <i style="background-color:white" class="far fa-save"></i>
          </button>     
</nav>
<canvas id='myCanvas' width='1341' height='700' style="border:1px solid grey"; onclick="draw(event)" ondblclick="OpenModal(event)">
</canvas><br>


    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
            <a class="btn btn-primary" href="/dbproject/login.html">Logout</a>
          </div>
        </div>
      </div>
    </div>



  <div class="modal fade" id="myModal" role="dialog">
<div class="modal-dialog">
          <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
  <h4 class="modal-title">Create project</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
          Title</br><input type='text' id='text' ></br>
<span class='text-danger' id='titleSpan'></span></br>
Architecture</br>
<select id='Architecture'>

<option value='1' selected>My Sql</option>
<option value='2'>Oracle</option>
<option value='3'>Sybase</option>
<option value='4'>Paradox</option>
</select>        
</div>
        <div class="modal-footer">
          <button type="button" onclick="check()"; class="btn btn-primary btn-default" >Create</button>
        </div>
      </div>
    </div>
  </div>
<!------------------------------------------------------->

<div class="modal show" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>


<!--------Bada Modal---------->
<div class="modal fade" id="largeModal" role="dialog" style="width:1250px;">
    <div class="modal-dialog modal-lg" >
    
      <!-- Modal content-->

      <div class="modal-content">
        <div class="modal-header" style="background-color:black">
<h4 class="modal-title"><b><font color="white">Table</font></b></h4>
          <button type="button" class="close" data-dismiss="modal" onclick="RemoveModal()">&times;</button>
                  </div>
        <div class="modal-body" id="modal-body">
<b>Table Name </b><input type="text" id="tableName" class="tableName">&nbsp;<button class="abtn" type='button' onclick="saveTableName()" ><i class="fas fa-save" style="font-size:31px;color:black"></i></button>
<br>
&nbsp;
<input type='hidden' name='tableCode' id='tableCode'>
  <ul class="nav nav-tabs">
    <li ><button type="button" class="btn btn-primary" onclick="note()"><b><font color="white">Table</font></b></button></li>
&nbsp;
    <li><button type="button" class="btn btn-primary" onclick="clearText()"><b><font color="white">Attribute</font></b></button></li>
      </ul>
<div id='noteDivision' class='noteDivision'>
<b>Note</b> <input type='text' id='noteField' name='noteField'><br>
<b>Engine</b> <input type='text' id='engine' name='engine'>
</div>

      </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<!------end----->







<!------Field Modal----------->

<div class="modal fade" id="fieldModal" role="dialog" style="width:1300px;">
    <div class="modal-dialog modal-lg" >
    
      <!-- Modal content-->

      <div class="modal-content">
        <div class="modal-header" style="background-color:black">
<h4 class="modal-title"><b><font color="white">Fields</b></font></h4>
          <button type="button" class="close" data-dismiss="modal" style="color:white;">&times;</button>
                  </div>
        <div class="modal-body" id="fieldsModalbody" style="overflow:scroll;">

<table align="left" id='fieldTable' class='fieldTable' border="1" bordercolor="green" style=border: 1px solid #ddd;>
<thead id='fieldTableHeader'>
<tr id='headRow' >
<th style="background-color:lightblue;"><b><font color="black">S.No.</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">Attribute</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">DataType</b></font></th>
<th style="background-color:lightblue;" ><b><font color="black">AutoIncr.</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">Unique</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">NotNull</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">DefaultValue</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">Delete</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">Edit</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">Up</b></font></th>
<th style="background-color:lightblue;"><b><font color="black">Down</b></font></th>
</tr>
</thead>
</table>
<div id='addRowDivision' class='addRowDivision'>
<div class="card card-login mx-auto mt-5">
 <div class="card-header" style="background-color:black;"><b><font color="white">Add</font></b></div>
<div class="card-body" class='addRowDivision'>
<input type="text" id="attrName" name="attrName" class="form-control" placeholder="Name"  required="required" style="height:6px;border-color:lightgrey;width:140px" autofocus="autofocus">
<select id='dataType' name="dataType" selected>
<option value='int' >int</option>
<option value='char'>char</option>
<option value='varchar'>varchar</option>
<option value='boolean'>boolean</option>
<option value='date'>date</option>

</select>        
<b>PrimaryKey</b> <input type='checkbox' id='primKey' name='primKey' required="required">
<b>AutoIncrement</b> <input type='checkbox' id='autoInc' name='autoInc' required="required">
<b>Unique</b> <input type='checkbox' id='unique' name='unique' required="required">
<b>NotNull</b> <input type='checkbox' id='isNotNull' name='isNotNull' required="required"><br>
<button class="btn btn-primary" id="addButton" type='button' onclick='AddAttribute()'>AddAttribute</button><br>


<div id='editRowDivision' style="height:10px;float:left" class='editRowDivision' >
<div class="card card-login mx-auto mt-5">
 <div class="card-header" style="background-color:black;"><b><font color="white">Edit</font></b></div>
<div class="card-body">
<b>Attribute</b><input type="text" id="editAttrName" name="editAttrName" class="form-control" style="height:5px;width:180px" autofocus="autofocus" disabled>
<select id='editDataType' name="editDataType" selected>
<option value='int' >int</option>
<option value='char'>char</option>
<option value='varchar'>varchar</option>
<option value='boolean'>boolean</option>
<option value='date'>date</option>

</select>        
<b>PrimaryKey</b><input type="checkbox" id="editPrimaryKey" name="editPrimaryKey" autofocus="autofocus" disabled>
<b>AutoIncrement</b><input type="checkbox" id="editAutoInc" name="editAutoInc" autofocus="autofocus" disabled>
<b>Unique</b><input type="checkbox" id="editUnique" name="editUnique" autofocus="autofocus" disabled>
<b>NotNull</b><input type="checkbox" id="editNotNull" name="editNotNull" autofocus="autofocus" disabled><br>
<button class="btn btn-primary" id="editButton" type='button' onclick='EditAttribute()' disabled>EditAttribute</button>
<input type='hidden' id='editHiddenField' name='editHiddenField'>
</div>
</div>
</div>




</div>
</div>
</div>



<div id='deleteRowDivision' class='deleteRowDivision'>
<div class="card card-login mx-auto mt-5">
 <div class="card-header" style="background-color:black;"><b><font color="white">Delete</font></b></div>
<div class="card-body" class='deleteRowDivision'>
<b>Attribute</b> <input type="text" id="delAttrName" name="delAttrName" class="form-control" style="height:6px;width:140px" autofocus="autofocus" disabled>
<b>DataType</b> <input type="text" id="delDataType" name="delDataType" class="form-control" style="height:6px;width:140px" autofocus="autofocus" disabled><br>
<b>PrimaryKey</b><input type="checkbox" id="delPrimaryKey" name="delPrimaryKey" autofocus="autofocus" disabled>
<b>AutoIncrement</b><input type="checkbox" id="delAutoInc" name="delAutoInc" autofocus="autofocus" disabled>
<b>Unique</b><input type="checkbox" id="delUnique" name="delUnique" autofocus="autofocus" disabled>
<b>NotNull</b><input type="checkbox" id="delNotNull" name="delNotNull" autofocus="autofocus" disabled><br>
<button class="btn btn-primary" id="deleteButton" type='button' onclick='DeleteAttribute()' disabled>DeleteAttribute</button>
</div>
</div>
</div>




</div>

        <div class="modal-footer">
<!-----Khatmn----->
          
        </div>
      </div>
      
    </div>
  </div>



    <!-- Bootstrap core JavaScript-->
    <script src="/dbproject/vendor/jquery/jquery.min.js"></script>
    <script src="/dbproject/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<script src="/dbproject/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/dbproject/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    
    <script src="/dbproject/vendor/datatables/jquery.dataTables.js"></script>
    <script src="/dbproject/vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/dbproject/js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="/dbproject/js/demo/datatables-demo.js"></script>
<script src="/dbproject/vendor2/bootstrap/js/popper.js"></script>
<script src="/dbproject/vendor2/bootstrap/js/bootstrap.min.js"></script>
<script src="/dbproject/vendor2/select2/select2.min.js"></script>
<script src="/dbproject/js2/main.js"></script>

   </body>

</html>