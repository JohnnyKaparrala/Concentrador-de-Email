<%@page import="com.sun.corba.se.pept.protocol.MessageMediator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.mail.*, javax.mail.search.FlagTerm, java.util.*, javax.mail.internet.MimeMultipart, classes.*, bd.dbos.*, bd.daos.*, bd.core.*, javax.mail.internet.MimeBodyPart, javax.mail.internet.MimeMultipart, javax.mail.Part, org.jsoup.*"%>
<!DOCTYPE html>
<%
boolean a = false;

if (session.getAttribute("usuario") == null) {
	response.sendRedirect("login.jsp");
}
else {
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
else {
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
Session s = Session.getDefaultInstance(new Properties( ));
Store store = s.getStore("imaps");
store.connect(emails.getString("host"), Integer.parseInt(emails.getString("porta")), emails.getString("email"), emails.getString("senha"));
Folder inbox = store.getFolder( "INBOX" );
inbox.open( Folder.READ_ONLY );
		
// Fetch unseen messages from inbox folder
Message[] messages = inbox.getMessages();

int index = Integer.parseInt(request.getParameter("id_email"));

Message mensagem = messages[index];
//mensagem.setFlag(Flags.Flag.SEEN, true);
//String content = EmailMethods.getTextFromMimeMultipart((MimeMultipart)mensagem.getContent());
int qtdAnexo;
try {
	qtdAnexo = EmailMethods.getQtdAnexo((MimeMultipart)mensagem.getContent());
} catch (Exception e) {
	qtdAnexo = -1;
}
String content = (String)mensagem.getContent().toString();
if (mensagem.isMimeType("text/plain")) {
	content = (String)mensagem.getContent().toString();
} else if (mensagem.isMimeType("text/html")) {
	content = mensagem.getContent().toString();
	content = Jsoup.parse(content).toString();
} else if (mensagem.isMimeType("multipart/*")) {
	content = EmailMethods.getTextFromMimeMultipart((MimeMultipart)mensagem.getContent());	  
}
%>
<html class="loading" lang="en" data-textdirection="ltr"><!-- BEGIN: Head--><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
  <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <title>MaliBox | <%= atual.getEmail() %></title>
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
    
    <style rel="stylesheet" type="text/css">
    	
    </style>
    
    </head>
  <!-- END: Head-->
  <body class="vertical-layout vertical-menu-collapsible page-header-dark vertical-modern-menu 2-columns  app-page" data-open="click" data-menu="vertical-modern-menu" data-col="2-columns">
    <!-- BEGIN: Page Main-->
    <main>
    <div id="main">
      <div class="row">
        <div class="content-wrapper-before gradient-45deg-indigo-purple"></div>
        <div class="col s12">
          <div class="app-email-content">
  <div class="content-area" style="margin: 0 auto;margin-top:124px;">
    <div class="app-wrapper">
      <div class="card card-default scrollspy border-radius-6 fixed-width">
        <div class="card-content pt-0">
          <div class="row">
            <div class="col s12">
              <!-- Email Header -->
              <div class="email-header">
                <div class="subject">
                  <div class="back-to-mails">
                    <a href="adm_email.jsp"><i class="material-icons">arrow_back</i></a>
                  </div>
                  <div class="email-title"><%= (mensagem.getSubject()==null)?"Sem assunto":mensagem.getSubject() %></div>
                </div>
              </div>
              <!-- Email Header Ends -->
              <hr>
              <!-- Email Content -->
              <div class="email-content">
                <div class="list-title-area">
                  <div class="user-media">
                    <img src="files/profilepic.png" alt="" class="circle z-depth-2 responsive-img avtar">
                    <div class="list-title">
                      <span class="name"><%= (mensagem.getFrom()[0]).toString() %></span>
                      <span class="to-person">para mim</span>
                    </div>
                  </div>
                  <div class="title-right">
                    <span class="mail-time"><%= String.format("%02d", mensagem.getSentDate().getHours()) + ":" + String.format("%02d", mensagem.getSentDate().getMinutes()) + " em " + String.format("%02d", mensagem.getSentDate().getDay()) + "/" + String.format("%02d", mensagem.getSentDate().getMonth()) + "/" + (mensagem.getSentDate().getYear() + 1900)%></span>
                  </div>
                </div>
                <div class="email-desc">
                  <p><%= content %></p>
                </div>
              </div>
              <!-- Email Content Ends -->
              <hr>
              <!-- Email Footer -->
              <div class="email-footer">
              <% if (qtdAnexo != -1) { %>
                <h6 class="footer-title">Anexos (<%= qtdAnexo %>)</h6>
                <div class="footer-action">
                  <div class="attachment-list">
                  <% 
                  float tamanhoArq = 0;
                  	for (int i = 0; i < ((MimeMultipart)mensagem.getContent()).getCount(); i++) {
                  		MimeBodyPart part = (MimeBodyPart) ((MimeMultipart)mensagem.getContent()).getBodyPart(i);
                  		
						if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) 
						{
							tamanhoArq = (part.getSize())/1000;
							//part.saveFile((request.getContextPath() + "/anexos/" + part.getFileName()).toString());
							
                  %>
                  	<script>console.log("<%= ("/ConcentracorEmail/WebContent/anexos/" + part.getFileName()).toString().replace(" ", "%20") %>");</script>
                    <div class="attachment">
                      <div class="size">
                        <span class="grey-text"><%= part.getFileName() %></span>
                        <span class="grey-text">(<%= tamanhoArq %>Kb)</span>
                      </div>
                      <div class="links">
                       	<a href="anexos/<%= part.getFileName() %>" class="Right">
                         	<i class="material-icons">file_download</i>
                       	</a>
                      </div>
                    </div>
                  <% 
						}
                  	}
              }
                  %>
                  </div>
                </div>
              </div>
              <!-- Email Footer Ends -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
      </div>
    </div>
   </div>
</main>

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
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN PAGE VENDOR JS-->
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <!-- BEGIN: Footer-->
    
    <script src="files/app-email.js" type="text/javascript"></script>
    <script type="text/javascript">
    
    
    
      ClassicEditor
      .create( document.querySelector( '#editor' ) ).catch( error => {
          console.error( error );
      } );

      M.toast({html: 'Bem vindo(a)!'});

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
      
      $(document).ready(function(){
    	    $('.modal').modal();

    	    $('select').formSelect();
    	    $('select').material_select();
    	  });
    </script>
    <!-- END PAGE LEVEL JS-->
    <%
    
    if (a){
    	%><script>M.toast({html: 'N�o h� emails cadastrados na sua conta! Cadastre-os!'})</script><%
    }
    %><script>
    </script>
    <%}%>