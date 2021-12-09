<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Change Profile Form</title>
<!-- Bootstrap core CSS-->
<link href="/dbproject/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom fonts for this template-->
<link href="/dbproject/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<!-- Custom styles for this template-->
<link href="/dbproject/css/sb-admin.css" rel="stylesheet">


<script src='webservice/js/TMService.js'></script>
<script src='webservice/js/memberService.js'></script>
<script>


function processInstallationForm()
{



var checkk=document.getElementById('checkk').checked;
var password=document.getElementById('password').value;
var confirmPassword=document.getElementById('confirmPassword').value;

var member=new Member();
member.emailId=document.getElementById('emailId').value;

if(password!=confirmPassword){
document.getElementById("confirmPassword").style.borderColor="#FF0000";
document.getElementById("confirmPasswordSpan").innerHTML="Password Not matched";
}

member.password=document.getElementById('password').value;
member.firstName=document.getElementById('firstName').value;
member.lastName=document.getElementById('lastName').value;
member.mobileNumber=document.getElementById('mobileNumber').value;
member.numberOfProjects=document.getElementById('numOfProject').value;

member.code=0;
this.firstName="";
this.lastName="";
this.mobileNumber="";
this.status="";
this.numberOfProjects=0;


var memberServiceManager=new MemberServiceManager();

if(checkk==false){alert('Please allow the conditions');
return;
}

memberServiceManager.changeProfile(member,function(res){
var ff=document.getElementById("homepage");
ff.submit();

alert("Profile Updated");
},function(err){
alert('Some problem');
alert(JSON.stringify(err));

if(err.FirstName)
{
document.getElementById("firstName").style.borderColor="#FF0000";
document.getElementById("firstNameSpan").innerHTML="First Name invalid";
}
if(err.EmailId)
{
document.getElementById("emailId").style.borderColor="#FF0000";
document.getElementById("emailIdSpan").innerHTML="Invalid EmailId";
}
if(err.EmailIdReg)
{
document.getElementById("emailId").style.borderColor="#FF0000";
document.getElementById("emailIdSpan").innerHTML="Invalid EmailId";
}






if(err.LastName)
{
document.getElementById("lastName").style.borderColor="#FF0000";
document.getElementById("lastNameSpan").innerHTML="Invalid LastName";

}
if(err.MobileNumber)
{
document.getElementById("mobileNumber").style.borderColor="#FF0000";
document.getElementById("mobileNumberSpan").innerHTML="Invalid MobileNumber";
}
if(err.MobileNumberReg)
{
document.getElementById("mobileNumber").style.borderColor="#FF0000";
document.getElementById("mobileNumberSpan").innerHTML="Invalid MobileNumber";
}
if(err.Password)
{
document.getElementById("password").style.borderColor="#FF0000";
document.getElementById("passwordSpan").innerHTML="Invalid Password";
}
if(document.getElementById("confirmPassword").value.length==0)
{
document.getElementById("confirmPassword").style.borderColor="#FF0000";
document.getElementById("confirmPasswordSpan").innerHTML="Please Reenter password";
}


});

}
</script>
</head>
<body class="bg-dark">
<div id="logo-container" class="col-md-4 col-md-offset-1">
<img src="images/logo.png" class="img-responsive" alt="LOGO">
</div>
<div class="container">
<div class="card card-register mx-auto mt-5">
<div class="card-header"><h2><center><b>Change Profile</b></center></h2>Please fill the details below</div>
<div class="card-body">

<form id='installationForm' novalidate>

<!--------------------div-->
<div class='form-group has-error' id='databaseServerGroup'>
<div class='form-row'>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='firstName' class='form-control' placeholder='First Name' required='required' autofocus='autofocus' onkeypress='document.getElementById("firstName").style.borderColor="#92a8d1" , document.getElementById("firstNameSpan").innerHTML="" ' value=${firstName}>
<span class="text-danger" id="firstNameSpan"></span>
<label for='firstName'>First Name</label>
<div class="invalid-feedback">Please enter first name.</div>
</div>
</div>
<br>
<div class='col-md-6'>
<div class='form-label-group'>
<input type='text' id='lastName' class='form-control' placeholder='Last Name' required='required' autofocus='autofocus' onkeypress='document.getElementById("lastName").style.borderColor="#92a8d1",document.getElementById("lastNameSpan").innerHTML="" ' value=${lastName}>
<span class="text-danger" id="lastNameSpan"></span>
<label for='lastName'>Last Name</label>
<div class="invalid-feedback">Please enter last name.</div>
</div>
</div>
</div>
</div>
<!--------------------div-->

<div class='form-group'>
<div class='form-row'>
<div class='col-md-12'>
<div class='form-label-group'>
<input type='text' id='emailId' disabled="disabled" placeholder='Email Id' required='required' class='form-control' onkeypress='document.getElementById("emailId").style.borderColor="#92a8d1", document.getElementById("emailIdSpan").innerHTML="" ' value=${emailId}>
<span class="text-danger" id="emailIdSpan"></span>

<label for='emailId'>Email Id</label>
</div>
</div>
</div>
</div>


<div class='form-group'>
<div class='form-row'>

<div class='col-md-12'>
<div class='form-label-group'>
<input type='password' id='password'  placeholder='Password' required='required' class='form-control' onkeypress='document.getElementById("password").style.borderColor="#92a8d1", document.getElementById("passwordSpan").innerHTML="" '>
<span class="text-danger" id="passwordSpan"></span>

<label for='password'>Password</label>
</div>
</div>
</div>
</div>
<div class='form-group'>
<div class='form-row'>

<div class='col-md-12'>
<div class='form-label-group'>
<input type='password' id='confirmPassword' placeholder='ReEnter Password' required='required' class='form-control' onkeypress='document.getElementById("confirmPassword").style.borderColor="#92a8d1",  document.getElementById("confirmPasswordSpan").innerHTML="" '>
<span class="text-danger" id="confirmPasswordSpan"></span>

<label for='confirmPassword'>ReEnter Password</label>
</div>
</div>
</div>
</div>

<div class='form-group'>
<div class='form-row'>

<div class='col-md-12'>
<div class='form-label-group'>
<input type='text' id='mobileNumber' disabled="disabled" placeholder='Sonu' required='required' class='form-control' onkeypress='document.getElementById("mobileNumber").style.borderColor="#92a8d1" , document.getElementById("mobileNumberSpan").innerHTML="" ' value=${mobileNumber}>
<span class="text-danger" id="mobileNumberSpan"></span>
<label for='mobileNumber'>Mobile Number</label>
</div>
</div>
</div>
</div>
<div class='form-group'>
<div class='form-row'>

<div class='col-md-12'>
<div class='form-label-group'>
<input type='number' id='numOfProject' placeholder='0' required='required' class='form-control' onkeypress='document.getElementById("numOfProject").style.borderColor="#92a8d1" , document.getElementById("numOfProject").innerHTML="" '>
<label for='numOfProject'>Number Of Project</label>
</div>
</div>
</div>
</div>


<div class='checkbox'>
<label> <input type='checkbox' id='checkk' required='required'>I accept all terms and conditions</label>
</div>
<button type='button' onclick='processInstallationForm()' class="btn btn-primary btn-block">Change My Profile</button>
<a href='FAQ.jsp'>Facing Some Problem!!!!! </a></center>
</form>
</div>
</div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="/dbproject/vendor/jquery/jquery.min.js"></script>
<script src="/dbproject/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/dbproject/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- waiting for plugin -->
<script src="/dbproject/vendor/waiting/bootstrap-waitingfor.js"></script>

<form id='homepage' action='Homepage.jsp'></form>
</body>
</html>