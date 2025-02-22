<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
if(session.getAttribute("usuario") != null)
{
	response.sendRedirect("adm_email.jsp");
}
else{
%>

<!DOCTYPE html>
<!-- saved from url=(0057)file:///C:/Users/u17186/Desktop/templateConcentrador.html -->
<html class="loading" lang="en" data-textdirection="ltr"><!-- BEGIN: Head--><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
        <title>MaliBox | Login</title>
        <link rel="shortcut icon" type="image/x-icon" href="files/tartaruga.png">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- BEGIN: VENDOR CSS-->
        <link rel="stylesheet" type="text/css" href="files/vendors.min.css">
        <!-- END: VENDOR CSS-->
        <!-- BEGIN: Page Level CSS-->
        <link rel="stylesheet" type="text/css" href="files/materialize.css">
        <link rel="stylesheet" type="text/css" href="files/style_mat.css">
        <link rel="stylesheet" type="text/css" href="files/login.css">
        <!-- END: Page Level CSS-->
        <!-- BEGIN: Custom CSS-->
        <<!-- END: Custom CSS-->
        
        
        <!-- BEGIN VENDOR JS-->
	    <script src="files/vendors.min.js" type="text/javascript"></script>
	    <!-- BEGIN VENDOR JS-->
	    <!-- BEGIN PAGE VENDOR JS-->
	    <script src="files/jquery-sortable-min.js"></script>
	    <script src="files/jquery.waypoints.min.js"></script>
	    <!-- END PAGE VENDOR JS-->
	    <!-- BEGIN THEME  JS-->
	    <script src="files/plugins.js" type="text/javascript"></script>
	    <script src="files/custom-script.js" type="text/javascript"></script>
	    <script src="files/customizer.js" type="text/javascript"></script>
	    <!-- END THEME  JS-->
	    <!-- BEGIN PAGE LEVEL JS-->
	    <!-- END PAGE LEVEL JS-->
	    <style>
	    	.btn input[type='submit']{
				color: white !important;
			}
	    </style>
    </head>
  <!-- END: Head-->
  <body class="vertical-layout vertical-menu-collapsible page-header-dark vertical-modern-menu 1-column login-bg  blank-page blank-page" data-open="click" data-menu="vertical-modern-menu" data-col="1-column">
    <div class="row">
      <div class="col s12">
        <div class="container"><div id="login-page" class="row">
  <div class="col s12 m6 l4 z-depth-4 card-panel border-radius-6 login-card bg-opacity-8">
    <%
      	if(request.getParameter("erro")!=null){
      		%><script>M.toast({html: '<%=request.getParameter("erro")%>'})</script><%
      	}
      %>
    <form class="login-form" action="Logar.jsp" method="POST">
      <div class="row">
        <div class="input-field col s12">
          <h5 class="ml-4">Entrar</h5>
        </div>
      </div>
      <div class="row margin">
        <div class="input-field col s12">
          <i class="material-icons prefix pt-2">person_outline</i>
          <input placeholder="Usu�rio" id="user" name="user" type="text" class="validate">
        </div>
      </div>
      <div class="row margin">
        <div class="input-field col s12">
          <i class="material-icons prefix pt-2">lock_outline</i>
          <input placeholder="Senha" id="senha" name="senha" type="password" class="validate">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input type="submit" class="btn waves-effect waves-light border-round gradient-45deg-purple-deep-orange col s12" style="
          background: linear-gradient(45deg, #c2b280, #52bbb1) !important;" value="Logar">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6 m6 l6">
          <p class="margin medium-small"><a href="cadastro.jsp">Registre-se agora!</a></p>
        </div>
      </div>
    </form>
  </div>
</div>
        </div>
      </div>
    </div><% } %>