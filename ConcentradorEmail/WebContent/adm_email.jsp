<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.mail.*, javax.mail.search.FlagTerm, java.util.*, javax.mail.internet.MimeMultipart, javax.mail.internet.MimeMessage, classes.*, bd.dbos.*, bd.daos.*, bd.core.*, org.jsoup.*"%>
<!DOCTYPE html>
<%
boolean a = false;


if (session.getAttribute("usuario") == null) {
	response.sendRedirect("login.jsp");
}
else{
	
MeuResultSet emails = Emails.getEmailsDono(((Usuario)session.getAttribute("usuario")).getId());
Email atual;
if(!emails.first()){
	atual = new Email (-1,
	        -1,
	        "Cadastre um email na conta",
	        "",
	        "",
	        "",
	        "",
	        false);
	
	a = true;
}
else{
	if (session.getAttribute("atual_id") == null) {
		atual = new Email (emails.getInt("id"),
	    emails.getInt("id_dono"),
	    emails.getString("email"),
	    emails.getString("protocolo"),
	    emails.getString("host"),
	    emails.getString("porta"),
	    emails.getString("senha"),
	    emails.getBoolean("tem_ssl"));
		
		session.setAttribute("atual_id",emails.getInt("id"));
	} else {
		while (emails.getInt("id") != Integer.parseInt(session.getAttribute("atual_id").toString())) {
			emails.next();
		}
		
		atual = new Email (emails.getInt("id"),
	    emails.getInt("id_dono"),
	    emails.getString("email"),
	    emails.getString("protocolo"),
	    emails.getString("host"),
	    emails.getString("porta"),
	    emails.getString("senha"),
		emails.getBoolean("tem_ssl"));
	}
}


session.setAttribute("emailAtual",atual);

session.setAttribute("email_atual", atual.getEmail());
session.setAttribute("host_atual", atual.getHost());
session.setAttribute("porta_atual", atual.getPorta());
session.setAttribute("senha_atual", atual.getSenha());

int pagina_email = 1;
if (request.getParameter("pagina_email") != null) {
	pagina_email = Integer.parseInt(request.getParameter("pagina_email").toString());
}

pagina_email--;



Session s = Session.getDefaultInstance(new Properties( ));
Store store = s.getStore("imaps");
Folder[] pastas = new Folder[0];

boolean conectou = true;

if(atual.getId() != -1)
{
	try{
		store.connect(emails.getString("host"), Integer.parseInt(emails.getString("porta")), emails.getString("email"), emails.getString("senha"));
		pastas = store.getDefaultFolder().list("*");
	}
	catch(Exception err)
	{
		conectou = false;
	}
}
	

%>
<html class="loading" lang="en" data-textdirection="ltr"><!-- BEGIN: Head--><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
  	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <title>Malibox | <%=atual.getEmail() %></title>
    <link rel="shortcut icon" type="image/x-icon" href="files/tartaruga.png">
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
    <style>
    	.btn input[type='submit']{
			color: white !important;
		}
    </style>
    
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
	        <li class="sidebar-title">Op��es</li>
            <li><a class="text-sub modal-trigger" href="#modalCriarPasta" data-position="bottom" data-tooltip="Criar pasta"><i class="material-icons">create_new_folder</i>  Criar pasta</a></li>
            <li><a class="text-sub modal-trigger" href="#modalEditarPasta" data-position="bottom" data-tooltip="Criar pasta"><i class="material-icons">dns</i>  Editar Pastas</a></li>
            <li><a class="text-sub modal-trigger" href="#modalDeletarPasta" data-position="bottom" data-tooltip="Criar pasta"><i class="material-icons">delete_sweep</i>  Deletar Pasta</a></li>
            <li class="sidebar-title">Pastas</li>
            
	            <%
	            if(request.getParameter("pasta_atual") != null) {
	            	session.setAttribute("pasta_atual", request.getParameter("pasta_atual"));
	            } else {
	            	session.setAttribute("pasta_atual", "INBOX");
	            }
	            
	            	if(atual.getId() != -1 && conectou){           	
			            for(int i=0;i<pastas.length;i++)
			    		{
			            	System.out.println(pastas[i].toString());
			            	if(pastas[i].toString().equals("[Gmail]")){
			            		continue;
			            	}
			    			%>		
			    				<li id="<%=pastas[i].toString()%>">
						           	<form method="POST" class="text-sub">
						           	<input type="hidden" name="pasta_atual" value="<%=pastas[i].toString()%>">
						           	<button type="submit" class="text-sub" style="text-align:left !important;width:100%; padding: 0;border: none;background: none;"><a><i class="material-icons mr-2"> folder </i><%=pastas[i].toString().replace("[Gmail]/","")%></a></button>
						           	</form>
					           	</li>			    				
			    			<%
			    			
			    			if( session.getAttribute("pasta_atual").equals(pastas[i].toString())){
				            	%><script>document.getElementById("<%=pastas[i].toString()%>").className += " active green";</script><%
			          		}
			    		}
			            
		            }
	            %>    
          	
          </ul>
          
          
        </div>
      	<div class="ps__rail-x" style="left: 0px; bottom: 0px;">
      		<div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
      	</div><div class="ps__rail-y" style="top: 0px; height: 432px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 307px;"></div></div><div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; height: 383px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 238px;"></div></div></div>
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
        <div id="buttons" class="fadeUp animate" style="display: inline">
          <a class="waves-effect waves-light btn btn-large green btn tooltipped modal-trigger" href="#modalTrocar" data-position="bottom" data-tooltip="Trocar Email"><i class="large material-icons">supervisor_account</i></a>
          <a class="waves-effect waves-light btn btn-large green btn tooltipped modal-trigger" href="#modalNova" data-position="bottom" data-tooltip="Adicionar Email"><i class="large material-icons">person_add</i></a>
          <a class="waves-effect waves-light btn btn-large green btn tooltipped modal-trigger" href="#modalConfi" data-position="bottom" data-tooltip="Editar Email"><i class="large material-icons">edit</i></a>
          <a class="waves-effect waves-light btn btn-large green btn tooltipped modal-trigger" href="Sair.jsp" data-position="bottom" data-tooltip="Sair"><i class="large material-icons">power_settings_new</i></a>
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
              <span class="action-icons" style="display:inline-block">
                <i class="material-icons" onclick="window.location.reload();">refresh</i>
                <i class="material-icons delete-mails">delete</i>
                <i id="volta" class="material-icons">folder</i>
                <i id="volta" class="material-icons">navigate_before</i>
                <span class=""><%= (pagina_email + 1) %></span>
                <i id="avanca" class="material-icons">navigate_next</i>
              </span>
            </div>
            <div class="list-content"></div>
          </div>
          <div id="emails" class="collection email-collection ps ps--active-y" style="max-height: 454px !important;">
          <%   
          	if(atual.getId() == -1) { 
          		%>
          		
          		Sem conta de email cadastrado
          		<%
          	}
          	else
          if(!conectou){
        	  %>
        		
        		N�o foi possivel conectar no servidor do email atual. <br/>
        		Talvez tenha alguma informa��o do email atual errada. <br/>
        		<%
          }
          	else {
          		  Folder pasta = store.getFolder(session.getAttribute("pasta_atual").toString());
		          pasta.open( Folder.READ_ONLY );
		          
		          int tam1 = pasta.getMessageCount();
		          
		          %><script>let limite = <%= Math.ceil((double)pasta.getMessages().length / (double)10) %>;</script><%
		          
		          int tam2;
		          if (tam1 > 10) {
		        	  tam2 = 10;
		          } else {
		        	  tam2 = tam1;
		          }
		          
		          int qtdEmail = pagina_email * 10;
		          

		          Message[] messages = pasta.getMessages();
		          
		          for ( int i = tam1 - qtdEmail -1; i >= tam1 - tam2 - qtdEmail && i >= 0; i-- ) {
	        	  	MimeMessage cmsg = new MimeMessage((MimeMessage)messages[i]);
		        	String content;
        			content = cmsg.getContent().toString(); 
		        	  
		        	if (messages[i].isMimeType("text/plain")) {
		        		content = (String)messages[i].getContent().toString();
		        	} else if (messages[i].isMimeType("text/html")) {
		        		content = (String)messages[i].getContent();
		        		content = Jsoup.parse(content).toString();
		        	} else if (messages[i].isMimeType("multipart/*")) {
		        		content = EmailMethods.getTextFromMimeMultipart((MimeMultipart)messages[i].getContent());	  
		        	}
							        	  
		        %>
		       	<a href="#" class="collection-item animate fadeUp delay-1" >
		              <div class="list-left">
		                <label>
		                  <input type="checkbox" name="foo">
		                  <span></span>
		                </label>
		              </div>
		              <div class="list-content">
		                <div class="list-title-area">
		                  <div class="user-media">
		                    <img src="files/profilepic.png" alt="" class="circle z-depth-2 responsive-img avtar">
		                    <div class="list-title"><%= (messages[i].getFrom()[0]).toString() %> <% if(messages[i].getFlags().contains(Flags.Flag.SEEN)) { %> (Visto) <% } %></div>
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
		                <div class="list-date"> <%= String.format("%02d", messages[i].getSentDate().getHours()) + ":" + String.format("%02d", messages[i].getSentDate().getMinutes()) + " em " + String.format("%02d", messages[i].getSentDate().getDay()) + "/" + String.format("%02d", messages[i].getSentDate().getMonth()) + "/" + (messages[i].getSentDate().getYear() + 1900)%> </div>
		              </div>
		       		<form  action="email.jsp" method="GET">
		              <input name="id_email" style="display:none" value="<%= i %>">
		              <input type="submit" class="inpot" value="Abrir email" style="display:none">
		           </form>
	            </a>
	
		      	<%
		          }
          		}
	          	%>
          <div class="ps__rail-y" style="top: 0px; height: 328px; right: 0px;">
	          <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 78px;">
	          </div>
	      </div>
	      </div>
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
	<form action="enviar_email.jsp" method="POST">
	  <div class="modal-content">
	    <h5 class="mt-0">Nova Mensagem</h5>
	    <hr>
	    <div class="row">
	        <div class="row">
	          <div class="input-field col s12">
	            <i class="material-icons prefix"> person_outline </i>
	            <input placeholder="Destinat�rio(s)" type="text" class="validate" name="destinatario">
	          </div>
	          <div class="input-field col s12">
	            <i class="material-icons prefix"> title </i>
	            <input placeholder="Assunto" type="text" class="validate" name="assunto">
	          </div>
	          <div class="input-field col s12">
	            <textarea id="editorMsg" name="mensagem" ></textarea>
	          </div>
	        </div>
	    </div>
	  </div>
	  <div class="modal-footer">
	    <a class="btn modal-close waves-effect waves-light mr-2 red">
	      <i class="material-icons">cancel</i> Cancelar
	    </a>
	    <a class="btn waves-effect waves-light mr-2 green" type="submit">
	      <i class="material-icons">send</i><input type="submit" value="Enviar">
	    </a>
	 </form>
  </div>
</div>

<!-- Modal Structure -->
<div id="modalTrocar" class="modal border-radius-6" tabindex="0">
  <form class="col s12" action="Trocar.jsp" method="GET">
	  <div class="modal-content">
	    <h5 class="mt-0">Trocar email</h5>
	    <hr>
	    <div class="row">
	       <div class="input-field col s12">
		    <select class="browser-default" name="emailSelect">
		      <%
		      	if(emails.first())                                                 
		      	do {
		      	  	%> <option value="<%= emails.getInt("id") %>"><%= emails.getString("email") %></option> <%
		      	} while (emails.next());
		      %>
		    </select>
	 		</div>
	  	</div>
	  </div>
	  <div class="modal-footer">
	    <a class="btn modal-close waves-effect waves-light mr-2 red">
	      <i class="material-icons">cancel</i> Cancelar
	    </a>
	    <input type="submit" class="btn waves-effect waves-light mr-2 green" value="Trocar"/>
	 		</div>
	</form>
</div>

<!-- Modal Structure -->
<div id="modalConfi" class="modal border-radius-6" tabindex="0">
  <div class="modal-content">
    <h5 class="mt-0">Editar email</h5>
    <hr>
    <div class="row">
      <form class="col s12" method="POST" action="Alterar.jsp">
        <div class="row">
          <div class="input-field col s6">
            <i class="material-icons prefix"> mail </i>
            <input placeholder="Email" type="text" class="validate" name="emailA" id="emailA" value="<%=((Email)session.getAttribute("emailAtual")).getEmail()%>">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> lock </i>
            <input placeholder="Senha" type="password" class="validate" name="senhaA" id="senhaA" value="<%=((Email)session.getAttribute("emailAtual")).getSenha()%>">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> cloud </i>
            <input placeholder="Servidor" type="text" class="validate" name="hostA" id="hostA" value="<%=((Email)session.getAttribute("emailAtual")).getHost()%>">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> free_breakfast </i>
            <input placeholder="Porta" type="text" class="validate" name="portaA" id="portaA" value="<%=((Email)session.getAttribute("emailAtual")).getPorta()%>">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> language </i>
            <input placeholder="Protocolo" type="text" class="validate" name="protocoloA" id="protocoloA" value="<%=((Email)session.getAttribute("emailAtual")).getProtocolo()%>">
          </div>
        </div>
		  <div class="modal-footer">
		    <a class="btn modal-close waves-effect waves-light mr-2 red">
		      <i class="material-icons">cancel</i> Cancelar
		    </a>
		    <a class="btn modal-close waves-effect waves-light mr-2 green" type="submit">
		      <i class="material-icons">person_add</i><input type="submit" value="Alterar Email">
		    </a>
		</div>
      </form>
      <form method="POST" action="Deletar.jsp">
		    	<a class="btn modal-close waves-effect waves-light mr-2 red" type="submit">
		    		<i class="material-icons">delete</i><input type="submit" value="Deletar Atual"> 
		    	</a>
	   </form>
    </div>
  </div>
</div>

<!-- Modal Structure -->
<div id="modalNova" class="modal border-radius-6" tabindex="0">
  <div class="modal-content">
    <h5 class="mt-0">Adicionar Email</h5>
    <hr>
    <div class="row">
      <form class="col s12" method="POST" action="AdicionarEmail.jsp">
        <div class="row">
          <div class="input-field col s6">
            <i class="material-icons prefix"> mail </i>
            <input placeholder="Email" type="text" class="validate" name="email" id="email" onkeyup="hostRemendado()">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> lock </i>
            <input placeholder="Senha" type="password" class="validate" name="senha" id="senha">
          </div>       
          <div class="input-field col s6">
            <i class="material-icons prefix"> language </i>
            
			<select id="protocolo" name="protocolo" onchange="hostRemendado(); portaRecomendada();">
				<option value="" disabled selected>Escolha um Protocolo</option>
				<option value="imaps">IMAPs</option>
			</select>
		  </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> free_breakfast </i>
            <input placeholder="Porta" type="text" class="validate" name="porta" id="porta">
          </div>
          <div class="input-field col s6">
            <i class="material-icons prefix"> cloud </i>
            <input placeholder="Servidor" type="text" class="validate" name="host" id="host">
          </div>
        </div>
		  <div class="modal-footer">
		    <a class="btn modal-close waves-effect waves-light mr-2 red">
		      <i class="material-icons">cancel</i> Cancelar
		    </a>
		    <a class="btn modal-close waves-effect waves-light mr-2 green" type="submit">
		      <i class="material-icons">person_add</i><input type="submit" value="Adicionar Email">
		    </a>
		  </div>
      </form>
    </div>
  </div>
</div>
<!-- Modal Structure -->
<div id="modalCriarPasta" class="modal border-radius-6" tabindex="0">
  <div class="modal-content">
    <h5 class="mt-0">Criar Pasta</h5>
    <hr>
    <div class="row">
      <form class="col s12" method="POST" action="criarPasta.jsp">
        <div class="row">
          <div class="input-field col s12">
            <i class="material-icons prefix"> folder </i>
            <input id="nomePasta" placeholder="nome da pasta" type="text" class="validate" name="nomePasta" id="nomePasta">
          </div>
        </div>
		  <div class="modal-footer">
		    <a class="btn modal-close waves-effect waves-light mr-2 red">
		      <i class="material-icons">cancel</i> Cancelar
		    </a>
		    <a class="btn modal-close waves-effect waves-light mr-2 green" type="submit">
		      <i class="material-icons">create_new_folder</i><input type="submit" value="Criar Pasta">
		    </a>
		  </div>
      </form>
    </div>
  </div>
</div>
<!-- Modal Structure -->
<div id="modalEditarPasta" class="modal border-radius-6" tabindex="0">
  <div class="modal-content">
    <h5 class="mt-0">Editar Pastas</h5>
    <hr>
    <div class="row">
      <form class="col s12" method="POST" action="editarPasta.jsp">
        <div class="row">       	
        	<div class="input-field col s12">
        	<i class="material-icons prefix"> folder </i>
			  <select name="pasta">
			  	<option value="" disabled selected>Escolha uma pasta</option>
			  	<%
			  	for(int i=0;i<pastas.length;i++)
	    		{
			  		if(pastas[i].toString().contains("[Gmail]")){
	            		continue;
	            	}
			  		if(pastas[i].toString().equals("INBOX")){
	            		continue;
	            	}
	    			%>	
	    				<option values="<%=pastas[i].toString()%>"><%=pastas[i].toString().replace("[Gmail]/","")%></option>  				
	    			<%
	    		}
			  	%>
			  </select>
			  	
		 	</div>
		 	<div class="input-field col s12">
			  	<i class="material-icons prefix"> edit </i>
            	<input id="nomePasta" placeholder="nome da pasta" type="text" class="validate" name="nomePasta" id="nomePasta">
          	</div>
		</div>
        
	  <div class="modal-footer">
	    <a class="btn modal-close waves-effect waves-light mr-2 red">
	      <i class="material-icons">cancel</i> Cancelar
	    </a>
	    <a class="btn modal-close waves-effect waves-light mr-2 green" type="submit">
	      <i class="material-icons">more</i><input type="submit" value="Editar Pasta">
	    </a>
	    
	  </div>
		  
      </form>
    </div>
  </div>
</div>
<!-- Modal Structure -->
<div id="modalDeletarPasta" class="modal border-radius-6" tabindex="0">
  <div class="modal-content">
    <h5 class="mt-0">Deletar Pasta</h5>
    <hr>
    <div class="row">
      <form class="col s12" method="POST" action="deletarPasta.jsp">
        <div class="row">       	
        	<div class="input-field col s12">
        	<i class="material-icons prefix"> folder </i>
			  <select name="pasta">
			  	<option value="" disabled selected>Escolha uma pasta</option>
			  	<%
			  	for(int i=1;i<pastas.length;i++)
	    		{
	            	if(pastas[i].toString().contains("[Gmail]")){
	            		continue;
	            	}
			  		if(pastas[i].toString().equals("INBOX")){
	            		continue;
	            	}
	    			%>	
	    				<option values="<%=pastas[i].toString()%>"><%=pastas[i].toString().replace("[Gmail]/","")%></option>  				
	    			<%
	    		}
			  	%>
			  </select>			  	
		 	</div>
		</div>
        
	  <div class="modal-footer">
	    <a class="btn modal-close waves-effect waves-light mr-2 red">
	      <i class="material-icons">cancel</i> Cancelar
	    </a>
	    <a class="btn modal-close waves-effect waves-light mr-2 green" type="submit">
	      <i class="material-icons">delete</i><input type="submit" value="Deletar Pasta">
	    </a>
	    
	  </div>
		  
      </form>
    </div>
  </div>
</div>
<!--  -->

          </div>
        </div>
      </div>
    </div>

    <footer class="page-footer footer footer-static footer-dark gradient-45deg-indigo-purple gradient-shadow navbar-border navbar-shadow">
      <div class="footer-copyright">
        <div class="container"><span>@ 2019          <a href="#" target="_blank">Mali Inc.</a> Todos direitos reservados.</span><span class="right hide-on-small-only">Desenvolvido por <a href="#">Mali Inc.</a></span></div>
      </div>
    </footer>
</body>
    
     <!-- END: Page Main-->
	   <!-- END: Footer-->
    <!-- BEGIN VENDOR JS-->
     <script src="files/vendors.min.js" type="text/javascript"></script>
    <!-- BEGIN PAGE LEVEL JS-->
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js"></script>
    <script type="text/javascript">
		tinymce.init({selector:'#editorMsg'});
    <%
			if(request.getParameter("erro")!=null){
			%>
					M.toast({html: '<%= request.getParameter("erro") %>'});
				<%
			}
			else if ( session.getAttribute("bem_vindo")!= null && session.getAttribute("bem_vindo").equals("s")){
				%> M.toast({html: 'Bem vindo!'}); <%
				session.setAttribute("bem_vindo", "n");
			}
    
    		store.close();
    %>
    
    
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
      function hostRemendado()
      {
    	 if($("#protocolo").val() != null)
    	 	$("#host").val($("#protocolo").val().split("s")[0] + "." + $("#email").val().split("@")[$("#email").val().split("@").length-1]);
    	 else
    		 $("#host").val("." + $("#email").val().split("@")[$("#email").val().split("@").length-1]);
      }
      
      function portaRecomendada()
      {
    	 if($("#protocolo").val() == "imaps")
    		 $("#porta").val("993");
    	 else
    		 $("#porta").val("escolha o imaps");
    	 	
      }
      
      function findGetParameter(parameterName) {
    	    var result = null,
    	        tmp = [];
    	    var items = location.search.substr(1).split("&");
    	    for (var index = 0; index < items.length; index++) {
    	        tmp = items[index].split("=");
    	        if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
    	    }
    	    return result;
    	}
      
      $(document).ready(function(){
    	function muda_pag(passo) {
       	  let pag = findGetParameter("pagina_email");
       	  
       		let sum = parseInt(pag) + parseInt(passo);
       	  if (passo < 0 && sum > 0) {
       	  		window.location.href= location.protocol + '//' + location.host + location.pathname + "?pagina_email=" + sum;
       	  }
       	   
       	  if (passo > 0 && sum <= limite) {
       		  window.location.href= location.protocol + '//' + location.host + location.pathname + "?pagina_email=" + sum;
       	  }
        }
    	
    		$("#avanca").click(function(e) {
    			muda_pag(1);
    		})
          
    		$("#volta").click(function(e) {
    			muda_pag(-1);
    		})
          
    	  	$('.dropdown-trigger').dropdown();
    	  
    	    $('.modal').modal();

    	    $('select').formSelect();
    	    
    	    $('.emailBimba').click(function(e) {
    	    	var a = e.target;
    	    	var b = a.find('.inpot')[0];
    	    	
    	    	b.click();
    	    });
    	    
    	    $('.collection-item').click(function (e) {
    	    	$(this).find('.inpot')[0].click();
    	    });
    	    
    	    console.log(<%= pagina_email%> );
    	    
    	    tinymce.init({
    	    	plugins: [
    	            "advlist autolink lists link image charmap print preview anchor",
    	            "searchreplace visualblocks code fullscreen",
    	            "insertdatetime media table contextmenu paste"
    	        ],
    	    	toolbar: "insertfile undo redo | link image | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent",
    	        selector: "textarea",
    	        setup: function (editor) {
    	            editor.on('change', function () {
    	                editor.save();
    	            });
    	        }
    	    });
    	    
    	    $(".tox-notification").css({"display":"none"});
    	    
    	  });
      
     
    </script>
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN PAGE VENDOR JS-->
    <script src="files/jquery-sortable-min.js"></script>
    <script src="files/jquery.waypoints.min.js"></script>
    <!-- END PAGE VENDOR JS-->    
    <script src="files/app-email.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL JS-->
    <%
    if (a){
    	%><script>M.toast({html: 'N�o h� emails cadastrados na sua conta! Cadastre-os!'})</script><%
    }
    %><script>
    </script>
    <%}%>