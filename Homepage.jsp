<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 


<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Sign Up Successfully</title>

    <!-- Bootstrap core CSS-->
    <link href="/dbproject/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="/dbproject/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/dbproject/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/dbproject/css/sb-admin.css" rel="stylesheet">

<!--   <link href="/dbproject/bootstrap-modal-master/css/bootstrap.min.css" rel="stylesheet"> -->
 
 <script src="/dbproject/bootstrap-modal-master/js/modaljs.js"></script>
  <script src="/dbproject/bootstrap-modal-master/js/bootstrap.min.js"></script>
<script src='/dbproject/JQuery/jquery.js'></script>
<script src='webservice/js/TMService.js'></script>
<script src='webservice/js/projectService.js'></script>

<script>
function check()
{
alert(document.getElementById('title').value);
alert(document.getElementById('architecture').value);
$.ajax('/dbproject/webservice/projectService/create',{
type:"post",
data:{
"argument-1":document.getElementById('title').value,
"argument-2":document.getElementById('architecture').value
},
success:function(res){
if(res.success)
{
alert("success");
alert(JSON.stringify(res));
document.getElementById('argument-1').value=res.result.code;
//pcode=res.result.code;

var formm=document.getElementById("openProjectForm");
formm.submit();
}
else
{
alert("else me aa raha");
if(res.exception.title)
{
alert("hello");
document.getElementById('text').style.borderColor='#FF0000';
document.getElementById('titleSpan').innerHTML='*title exist';
}
}
},
error:function(err){
alert('afasfasfasfas');
alert(err.exception.title);
if(err.exception.title)
{
alert("hello");
document.getElementById('text').style.borderColor='#FF0000';
}
alert(JSON.Stringify(res));
}
});
}</script>
  </head>

  <body id="page-top">

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" href="index.html">Toad Data Modeler</a>

      <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
      </button>

      <!-- Navbar Search -->
      <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
      </form>

          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="messagesDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <i class="fas fa-user-circle fa-fw"> </i>
          <h7 class="text-danger">${emailId}</h7></a>
<!-- 
<p class="text-danger">${firstName}</p>
<p class="text-danger">${lastName}</p>
<!-- <span id="emailId"><p class="text-danger">${emailId}</p></span> -->          
-->
<div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <a class="dropdown-item" href="#">Settings</a>
            <a class="dropdown-item" href="#">Activity Log</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
          </div>
        </li>
      </ul>

    </nav>

    <div id="wrapper">

      <!-- Sidebar -->
 <ul class="sidebar navbar-nav">
        <li class="nav-item active">
          <a class="nav-link"  href="#myModal" data-toggle="modal">
  
        <i class="fab fa-creative-commons-remix"></i>
            <span>Create Project</span>
          </a>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    
<div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
 <h4 class="modal-title"><b>Create Project</b></h4>    
 <button type="button"  class="close" data-dismiss="modal">&times;</button>
         
        </div>
<form id='projectProcess' nonvalidate>
        <div class="modal-body">

<div class='form-group'>
<div class='form-row'>
<div class='col-md-12'>
<label for='title'><b> Title </b></label>

<input type='text' id='title' class='form-control' placeholder='Give Project Title'>

</div>
</div>
</div>
<div class='form-group'>
<div class='form-row'>
<div class='col-md-12'>
<label for='architecture'><b> Architecture </b></label>

<div class='form-label-group'>


<select required='required' class='form-control' id='architecture'>
<option value=1>MySQL-14</option>
<option value=2>MySQL</option>
<option value=3>Oracle</option>
<option value=4>Sybase</option>

</select>


</div>
</div>
</div>
</div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary btn-block" onclick='check()'>Create</button>
        </div>
</form>
      </div>
      
    </div>
  </div>

</li>



<li class="nav-item active">
          <a class="nav-link" href="#">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>My Subscription</span>
          </a>
        </li>        
<li class="nav-item active">
          <a class="nav-link" href="/dbproject/ChangeProfile.jsp">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Edit Profile</span>
          </a>
        </li>
<li class="nav-item active">
          <a class="nav-link" href="/dbproject/ChangePassword.jsp">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Change Password</span>
          </a>
        </li>
<li class="nav-item active">
          <a class="nav-link" href="/dbproject/webservice/memberService/logout">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Logout</span>
          </a>
        </li>
      </ul>


  <body class="bg-dark">


    
    <!-- Bootstrap core JavaScript-->
    <script src="/dbproject/vendor/jquery/jquery.min.js"></script>
    <script src="/dbproject/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/dbproject/vendor/jquery-easing/jquery.easing.min.js"></script>

  </body>







        <!-- Sticky Footer -->
        <footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright © Your Website 2018</span>
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
            <a class="btn btn-primary" href="login.html">Logout</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/dbproject/vendor/jquery/jquery.min.js"></script>
    <script src="/dbproject/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/dbproject/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="/dbproject/vendor/datatables/jquery.dataTables.js"></script>
    <script src="/dbproject/vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/dbproject/js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="/dbproject/js/demo/datatables-demo.js"></script>


   
<form id='openProjectForm' action='/dbproject/webservice/projectService/open' method='POST'>
<input type="hidden" id='argument-1' name='argument-1'>
</form>

  </body>

</html>