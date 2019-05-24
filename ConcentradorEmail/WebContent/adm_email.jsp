<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.mail.*, javax.mail.search.FlagTerm, java.util.*, javax.mail.internet.MimeMultipart, classes.*, bd.dbos.*, bd.daos.*, bd.core.*"%>
<!DOCTYPE html>
<!-- saved from url=(0057)file:///C:/Users/u17186/Desktop/templateConcentrador.html -->
<%
MeuResultSet emails = Emails.getEmailDonos(((Usuario)session.getAttribute("usuario")).getId());
emails.first();
Email atual = new Email((int)emails.getInt(1),(int)emails.getInt(2),(String)emails.getString(3),(String)emails.getString(4),(String)emails.getString(5),(String)emails.getString(6),(String)emails.getString(7),(boolean)emails.getBoolean(8));
%>
<html class="loading" lang="en" data-textdirection="ltr"><!-- BEGIN: Head--><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <title>MaliBox | <%= atual.getEmail() %></title>
    <link rel="shortcut icon" type="image/x-icon" href="files/tartaruga.png">
    <link href="icon" rel="stylesheet">
    <!-- BEGIN: VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="files/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="files/flag-icon.min.css">
    <!-- END: VENDOR CSS-->
    <!-- BEGIN: Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="files/materialize.css">
    <link rel="stylesheet" type="text/css" href="files/style_mat.css">
    <link rel="stylesheet" type="text/css" href="files/app-sidebar.css">
    <link rel="stylesheet" type="text/css" href="files/app-email.css">
    <!-- END: Page Level CSS-->
    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="files/style.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- END: Custom CSS-->
    </head>
  <!-- END: Head-->
  <body class="vertical-layout vertical-menu-collapsible page-header-dark vertical-modern-menu 2-columns  app-page" data-open="click" data-menu="vertical-modern-menu" data-col="2-columns">
    <!-- BEGIN: Page Main-->
    <div id="main">
      <div class="row">
        <div class="content-wrapper-before gradient-45deg-indigo-purple"></div>
        <div class="col s12">
          <div class="container">
            <!-- Sidebar Area Starts -->
<div class="sidebar-left sidebar-fixed">
  <div class="sidebar">
    <div class="sidebar-content">
      <div class="sidebar-header">
        <div class="sidebar-details">
          <h5 class="m-0 sidebar-title"><img src="files/tartaruga.png" height="25"> MaliBox</h5>
          <div class="row valign-wrapper mt-10 pt-2 animate fadeLeft">
            <div class="col s2 media-image">
              <img src="files/profilepic.png" alt="" class="circle z-depth-2 responsive-img">
              <!-- notice the "circle" class -->
            </div>
            <div class="col s10">
              <p class="m-0 font-weight-700 text-white"><%= ((Usuario)session.getAttribute("usuario")).getNick() %></p>
              <p class="m-0 font-weight-700"><%= atual.getEmail() %></p>
            </div>
          </div>
        </div>
      </div>
      <div id="sidebar-list" class="sidebar-menu list-group position-relative animate fadeLeft ps ps--active-y">
        <div class="sidebar-list-padding app-sidebar" id="email-sidenav">
          <ul class="email-list display-grid">
            <li class="sidebar-title">Pastas</li>
            <li class="active green"><a href="#" class="text-sub"><i class="material-icons mr-2"> mail_outline </i> Inbox</a></li>
            <li><a href="#" class="text-sub"><i class="material-icons mr-2"> send </i> Enviados</a></li>
            <li><a href="#" class="text-sub"><i class="material-icons mr-2"> description </i> Rascunhos</a></li>
            <li><a href="#" class="text-sub"><i class="material-icons mr-2"> info_outline </i> Span</a></li>
            <li><a href="#" class="text-sub"><i class="material-icons mr-2"> delete </i> Lixeira</a></li>
            <li><a href="#" class="text-sub"><i class="material-icons mr-2"> create_new_folder </i> Criar pasta</a></li>
            <li class="sidebar-title">Filtros</li>
            <li><a href="#" class="text-sub"><i class="material-icons mr-2"> star_border </i> Marcados</a></li>
            <li><a href="#" class="text-sub"><i class="material-icons mr-2"> label_outline </i> Importante</a></li>
          </ul>
        </div>
      <div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; height: 432px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 307px;"></div></div><div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; height: 383px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 238px;"></div></div></div>
      <a href="#" data-target="email-sidenav" class="sidenav-trigger hide-on-large-only"><i class="material-icons">menu</i></a>
    </div>
  </div>
</div>
<!-- Sidebar Area Ends -->

<!-- Content Area Starts -->
<div class="app-email">
  <div class="content-area content-right">
    <div class="app-wrapper">
      <div id="jerj">
        <div id="search_bar" class="app-search" style="display: grid">
          <i class="material-icons mr-2 search-icon">search</i>
          <input  onkeyup="filtrar()" type="text" placeholder="Procurar email" class="app-filter" id="email_filter">
        </div>
        <div id="buttons" class="fadeUp animate">
          <a class="waves-effect waves-light btn btn-large green btn tooltipped modal-trigger" href="#modalTrocar" data-position="bottom" data-tooltip="Trocar Email"><i class="large material-icons">supervisor_account</i></a>
          <a class="waves-effect waves-light btn btn-large green btn tooltipped modal-trigger" href="#modalNova" data-position="bottom" data-tooltip="Adicionar Email"><i class="large material-icons">person_add</i></a>
          <a class="waves-effect waves-light btn btn-large green btn tooltipped modal-trigger" href="#modalConfi" data-position="bottom" data-tooltip="Editar Email"><i class="large material-icons">edit</i></a>
          <a class="waves-effect waves-light btn btn-large green btn tooltipped modal-trigger" href="login.html" data-position="bottom" data-tooltip="Sair"><i class="large material-icons">power_settings_new</i></a>
        </div>
      </div>
      <div class="card card card-default scrollspy border-radius-6 fixed-width">
        <div class="card-content p-0">
          <div class="email-header">
            <div class="left-icons">
              <span class="header-checkbox">
                <label>
                  <input type="checkbox" onclick="toggle(this)">
                  <span></span>
                </label>
              </span>
              <span class="action-icons">
                <i class="material-icons" onclick="window.location.reload();">refresh</i>
                <i class="material-icons">mail_outline</i>
                <i class="material-icons">label_outline</i>
                <i class="material-icons">folder_open</i>
                <i class="material-icons">info_outline</i>
                <i class="material-icons delete-mails">delete</i>
              </span>
            </div>
            <div class="list-content"></div>
            <div class="email-action">
              <span class="email-options"><i class="material-icons grey-text">more_vert</i></span>
            </div>
          </div>
          <div id="emails" class="collection email-collection ps ps--active-y" style="max-height: 454px !important;">
          <%         
	          Session s = Session.getDefaultInstance(new Properties( ));
	          Store store = s.getStore("imaps");
	          store.connect("imap.googlemail.com", 993, "teste.rip.luquinhas@gmail.com", "123456senha");
	          Folder inbox = store.getFolder( "INBOX" );
	          inbox.open( Folder.READ_ONLY );
	
	          // Fetch unseen messages from inbox folder
	          Message[] messages = inbox.getMessages();
	          
	          for ( int i = messages.length-1; i>=0; i-- ) {
	        	  String content = EmailMethods.getTextFromMimeMultipart((MimeMultipart)messages[i].getContent());
	       	%>
	       	<a href="#" class="collection-item animate fadeUp delay-1">
              <div class="list-left">
                <label>
                  <input type="checkbox" name="foo">
                  <span></span>
                </label>
                <div class="favorite">
                  <i class="material-icons">star_border</i>
                </div>
                <div class="email-label">
                  <i class="material-icons">label_outline</i>
                </div>
              </div>
              <div class="list-content">
                <div class="list-title-area">
                  <div class="user-media">
                    <img src="files/profilepic.png" alt="" class="circle z-depth-2 responsive-img avtar">
                    <div class="list-title"><%= (messages[i].getFrom()[0]).toString() %></div>
                  </div>
                  <div class="title-right">
                    <span class="attach-file">
                      <i class="material-icons">attach_file</i>
                    </span>
                  </div>
                </div>
                <div class="list-desc"><span class="emailcoisa"><%= content.toString() %></span></div>
              </div>
              <div class="list-right">
                <div class="list-date"> <%= messages[i].getSentDate().getHours() + ":" + messages[i].getSentDate().getMinutes() + " em " + messages[i].getSentDate().getDay() + "/" + messages[i].getSentDate().getMonth() + "/" + messages[i].getSentDate().getYear()%> </div>
              </div>
            </a>

	                
	      	<%
	          }
          	%>
          <div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; height: 377px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 104px;"></div></div><div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; height: 328px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 78px;"></div></div></div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Content Area Ends -->

<!-- Add new email popup -->
<div style="bottom: 54px; right: 19px;" class="fixed-action-btn direction-top active">
  <a class="btn-floating btn-large primary-text gradient-shadow modal-trigger green btn tooltipped" data-position="left" data-tooltip="Novo email" href="#modal1">
    <i class="material-icons">add</i>
  </a>
</div>
<!-- Add new email popup Ends-->

<!-- Modal Structure -->
<div id="modal1" class="modal border-radius-6" tabindex="0">
  <div class="modal-content">
    <h5 class="mt-0">Nova Mensagem</h5>
    <hr>
    <div class="row">
      <form class="col s12">
        <div class="row">
          <div class="input-field col s12">
            <i class="material-icons prefix"> person_outline </i>
            <input placeholder="Destinatário(s)" type="text" class="validate">
          </div>
          <div class="input-field col s12">
            <i class="material-icons prefix"> title </i>
            <input placeholder="Assunto" type="text" class="validate">
          </div>
          <div class="input-field col s12">
            <textarea name="content" id="editor"></textarea>
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="modal-footer">
    <a class="btn modal-close waves-effect waves-light mr-2 red">
      <i class="material-icons">cancel</i> Cancelar
    </a>
    <a class="btn modal-close waves-effect waves-light mr-2 green">
      <i class="material-icons">send</i> Enviar
    </a>
  </div>
</div>
<div id="modalTrocar" class='modal modal-fixed-footer'>
  <div class='modal-content'>
    <h5 class="mt-0">Trocar email</h5>
    <hr>
    <div class="row">
      <form class="col s12">
		<div class="">
          <select>
	          <%
	           do {
		      %>
              <option value="<%= (int)emails.getInt("id") %>"><%=  (String)emails.getString("email") %></option>
              <%
	          } while (emails.next());
              %>
          </select>
          <label>Email</label>
        </div>
      </form>
    </div>
  </div>
  <div class="modal-footer">
    <a class="btn modal-close waves-effect waves-light mr-2 red">
      <i class="material-icons">cancel</i> Cancelar
    </a>
    <a class="btn modal-close waves-effect waves-light mr-2 green">
      <i class="material-icons">send</i> Enviar
    </a>
  </div>
</div>

<!-- Modal Structure -->
<div id="modalConfi" class="modal border-radius-6" tabindex="0">
  <div class="modal-content">
    <h5 class="mt-0">Editar email</h5>
    <hr>
    <div class="row">
      <form class="col s12">
        <div class="row">
          <div class="input-field col s6">
            <i class="material-icons prefix"> mail </i>
            <input placeholder="Email" type="text" class="validate">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> lock </i>
            <input placeholder="Senha" type="password" class="validate">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> cloud </i>
            <input placeholder="Servidor" type="password" class="validate">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> free_breakfast </i>
            <input placeholder="Porta" type="password" class="validate">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> language </i>
            <input placeholder="Protocolo" type="password" class="validate">
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="modal-footer">
    <a class="btn modal-close waves-effect waves-light mr-2 red">
      <i class="material-icons">cancel</i> Cancelar
    </a>
    <a class="btn modal-close waves-effect waves-light mr-2 green">
      <i class="material-icons">edit</i> Editar Email
    </a>
  </div>
</div>

<!-- Modal Structure -->
<div id="modalNova" class="modal border-radius-6" tabindex="0">
  <div class="modal-content">
    <h5 class="mt-0">Adicionar Email</h5>
    <hr>
    <div class="row">
      <form class="col s12" method="POST" action="add_email.jsp">
        <div class="row">
          <div class="input-field col s6">
            <i class="material-icons prefix"> mail </i>
            <input id="email" placeholder="Email" type="text" class="validate">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> lock </i>
            <input id="email_senha" placeholder="Senha" type="password" class="validate">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> cloud </i>
            <input id="servidor" placeholder="Servidor" type="password" class="validate">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> free_breakfast </i>
            <input id="porta" placeholder="Porta" type="password" class="validate">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> language </i>
            <input id="protocolo" placeholder="Protocolo" type="password" class="validate">
          </div>
        </div>
		  <div class="modal-footer">
		    <a class="btn modal-close waves-effect waves-light mr-2 red">
		      <i class="material-icons">cancel</i> Cancelar
		    </a>
		    <a class="btn modal-close waves-effect waves-light mr-2 green" type="submit">
		      <i class="material-icons">person_add</i> Adicionar Email
		    </a>
		  </div>
      </form>
    </div>
  </div>
</div>

          </div>
        </div>
      </div>
    </div>
    <!-- END: Page Main-->

    <!-- BEGIN: Footer-->

    <footer class="page-footer footer footer-static footer-dark gradient-45deg-indigo-purple gradient-shadow navbar-border navbar-shadow">
      <div class="footer-copyright">
        <div class="container"><span>© 2019          <a href="#" target="_blank">Mali Inc.</a> Todos direitos reservados.</span><span class="right hide-on-small-only">Desenvolvido por <a href="#">Mali Inc.</a></span></div>
      </div>
    </footer>

    <!-- END: Footer-->
    <!-- BEGIN VENDOR JS-->
    <script src="files/vendors.min.js" type="text/javascript"></script>
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN PAGE VENDOR JS-->
    <script src="files/jquery-sortable-min.js"></script>
    <script src="files/tinymce.min.js"></script>
    <script src="files/jquery.waypoints.min.js"></script>
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <script src="files/app-email.js" type="text/javascript"></script>
    <script src="files/https://cdn.ckeditor.com/ckeditor5/12.1.0/classic/ckeditor.js"></script>
    <script type="text/javascript">
    $('select').formSelect();
    $('select').material_select();
    
      ClassicEditor
      .create( document.querySelector( '#editor' ) ).catch( error => {
          console.error( error );
      } );

      M.toast({html: 'Bem vindo(a)!'})

      function filtrar() {
        var input, filter, ul, li, a, i, txtValue;
        input = document.getElementById("email_filter");
        filter = input.value.toUpperCase();
        ul = document.getElementById("emails");
        li = ul.getElementsByTagName("a");
        for (i = 0; i < li.length; i++) {
            elenome = $(li[i]).find(".list-title");
            a = elenome[0];
            txtValue = a.textContent || a.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
              } else {
                li[i].style.display = "none";
            }
        }
    }
    </script>
    <!-- END PAGE LEVEL JS-->