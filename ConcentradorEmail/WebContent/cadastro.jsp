<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="bd.*,bd.daos.*,bd.dbos.*,bd.core.*"%>
<!DOCTYPE html>
<!-- saved from url=(0057)file:///C:/Users/u17186/Desktop/templateConcentrador.html -->
<html class="loading" lang="en" data-textdirection="ltr"><!-- BEGIN: Head--><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
        <title>MaliBox | Cadastro</title>
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
        <!-- END: Custom CSS-->
    </head>
  <!-- END: Head-->  
  <body class="vertical-layout vertical-menu-collapsible page-header-dark vertical-modern-menu 1-column login-bg  blank-page blank-page" data-open="click" data-menu="vertical-modern-menu" data-col="1-column">
    <div class="row">
      <div class="col s12">
        <div class="container"><div id="login-page" class="row">
  <div class="col s12 m6 l4 z-depth-4 card-panel border-radius-6 login-card bg-opacity-8">
    <form class="login-form" action="Cadastrar.jsp" method="GET">
      <div class="row">
            <div class="input-field col s12">
            <h5 class="ml-4">Cadastro</h5>
            <p class="ml-4">A malignitude o aguarda!</p>
            </div>
      </div>
      <div class="row margin">
        <div class="input-field col s12">
          <i class="material-icons prefix pt-2">person_outline</i>
          <input placeholder="Usuário" name="nick" id="nick" type="text" class="validate">
        </div>
      </div>
      <div class="row margin">
        <div class="input-field col s12">
          <i class="material-icons prefix pt-2">mail</i>
          <input placeholder="Email" name="email" id="email" type="text" class="validate">
        </div>
      </div>
      <div class="row margin">
        <div class="input-field col s12">
          <i class="material-icons prefix pt-2">lock_outline</i>
          <input placeholder="Senha" name="senha" id="senha" type="password" class="validate">
        </div>
      </div>
      <div class="row margin">
        <div class="input-field col s12">
          <i class="material-icons prefix pt-2">lock_outline</i>
          <input placeholder="Confirmar senha" name="senha_cnf" id="senha_cnf" type="password" class="validate">
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input type="submit" class="btn waves-effect waves-light border-round gradient-45deg-purple-deep-orange col s12" style="
          background: linear-gradient(45deg, #c2b280, #52bbb1) !important;" >Cadastrar</input>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6 m6 l6">
          <p class="margin medium-small"><a href="login.html">Já tem uma conta? Entre aqui!</a></p>
        </div>
      </div>
    </form>
  </div>
</div>
        </div>
      </div>
    </div>

    <!-- BEGIN VENDOR JS-->
    <script src="vendors.min.js" type="text/javascript"></script>
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