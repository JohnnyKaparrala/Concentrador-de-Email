<%@page import="com.sun.corba.se.pept.protocol.MessageMediator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.mail.*, javax.mail.search.FlagTerm, java.util.*, javax.mail.internet.MimeMultipart, classes.*, bd.dbos.*, bd.daos.*, bd.core.*, javax.mail.internet.MimeBodyPart, javax.mail.internet.MimeMultipart, javax.mail.Part"%>
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
String content = EmailMethods.getTextFromMimeMultipart((MimeMultipart)mensagem.getContent());

int qtdAnexo = EmailMethods.getQtdAnexo((MimeMultipart)mensagem.getContent());
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
                  <div class="email-title"><%= mensagem.getSubject() %></div>
                </div>
                <div class="header-action">
                  <div class="favorite">
                    <i class="material-icons">star_border</i>
                  </div>
                  <div class="email-label">
                    <i class="material-icons">label_outline</i>
                  </div>
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
                    <span class="mail-time"><%= mensagem.getSentDate().getHours() + ":" + mensagem.getSentDate().getMinutes() + " em " + mensagem.getSentDate().getDay() + "/" + mensagem.getSentDate().getMonth() + "/" +mensagem.getSentDate().getYear() %></span>
                    <i class="material-icons">reply</i>
                    <i class="material-icons">more_vert</i>
                  </div>
                </div>
                <div class="email-desc">
                  <p><%= content.toString() %></p>
                </div>
              </div>
              <!-- Email Content Ends -->
              <hr>
              <!-- Email Footer -->
              <div class="email-footer">
                <h6 class="footer-title">Attachments (<%= qtdAnexo %>)</h6>
                <div class="footer-action">
                  <div class="attachment-list">
                  <% 
                  float tamanhoArq = 0;
                  	for (int i = 0; i < ((MimeMultipart)mensagem.getContent()).getCount(); i++) {
                  		MimeBodyPart part = (MimeBodyPart) ((MimeMultipart)mensagem.getContent()).getBodyPart(i);
                  		
						if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) 
						{
							tamanhoArq = (part.getSize())/1000;
							part.saveFile((request.getContextPath() + "/anexos/" + part.getFileName()).toString());
							
							
							
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
                  %>
                  </div>
                  <div class="footer-buttons">
                    <a class="btn reply green"><i class="material-icons left">reply</i>Responder</a>
                    <a class="btn forward green"><i class="material-icons left">reply</i>Encaminhar</a>
                  </div>
                </div>
                <div class="reply-box d-none">
                  <form action="#">
                    <div class="input-field col s12">
                      <div id="mceu_11" class="mce-tinymce mce-container mce-panel" hidefocus="1" tabindex="-1" role="application" style="visibility: hidden; border-width: 1px; width: 100%;"><div id="mceu_11-body" class="mce-container-body mce-stack-layout"><div id="mceu_12" class="mce-top-part mce-container mce-stack-layout-item mce-first"><div id="mceu_12-body" class="mce-container-body"><div id="mceu_13" class="mce-container mce-menubar mce-toolbar mce-first" role="menubar" style="border-width: 0px 0px 1px;"><div id="mceu_13-body" class="mce-container-body mce-flow-layout"><div id="mceu_14" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-first mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_14" role="menuitem" aria-haspopup="true"><button id="mceu_14-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">File</span> <i class="mce-caret"></i></button></div><div id="mceu_15" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_15" role="menuitem" aria-haspopup="true"><button id="mceu_15-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">Edit</span> <i class="mce-caret"></i></button></div><div id="mceu_16" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_16" role="menuitem" aria-haspopup="true"><button id="mceu_16-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">View</span> <i class="mce-caret"></i></button></div><div id="mceu_17" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-last mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_17" role="menuitem" aria-haspopup="true"><button id="mceu_17-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">Format</span> <i class="mce-caret"></i></button></div></div></div><div id="mceu_18" class="mce-toolbar-grp mce-container mce-panel mce-last" hidefocus="1" tabindex="-1" role="group"><div id="mceu_18-body" class="mce-container-body mce-stack-layout"><div id="mceu_19" class="mce-container mce-toolbar mce-stack-layout-item mce-first mce-last" role="toolbar"><div id="mceu_19-body" class="mce-container-body mce-flow-layout"><div id="mceu_20" class="mce-container mce-flow-layout-item mce-first mce-btn-group" role="group"><div id="mceu_20-body"><div id="mceu_0" class="mce-widget mce-btn mce-first mce-disabled" tabindex="-1" role="button" aria-label="Undo" aria-disabled="true"><button id="mceu_0-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-undo"></i></button></div><div id="mceu_1" class="mce-widget mce-btn mce-last mce-disabled" tabindex="-1" role="button" aria-label="Redo" aria-disabled="true"><button id="mceu_1-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-redo"></i></button></div></div></div><div id="mceu_21" class="mce-container mce-flow-layout-item mce-btn-group" role="group"><div id="mceu_21-body"><div id="mceu_2" class="mce-widget mce-btn mce-menubtn mce-first mce-last mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_2" role="button" aria-haspopup="true"><button id="mceu_2-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">Formats</span> <i class="mce-caret"></i></button></div></div></div><div id="mceu_22" class="mce-container mce-flow-layout-item mce-btn-group" role="group"><div id="mceu_22-body"><div id="mceu_3" class="mce-widget mce-btn mce-first" tabindex="-1" aria-pressed="false" role="button" aria-label="Bold"><button id="mceu_3-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-bold"></i></button></div><div id="mceu_4" class="mce-widget mce-btn mce-last" tabindex="-1" aria-pressed="false" role="button" aria-label="Italic"><button id="mceu_4-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-italic"></i></button></div></div></div><div id="mceu_23" class="mce-container mce-flow-layout-item mce-btn-group" role="group"><div id="mceu_23-body"><div id="mceu_5" class="mce-widget mce-btn mce-first" tabindex="-1" aria-pressed="false" role="button" aria-label="Align left"><button id="mceu_5-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-alignleft"></i></button></div><div id="mceu_6" class="mce-widget mce-btn" tabindex="-1" aria-pressed="false" role="button" aria-label="Align center"><button id="mceu_6-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-aligncenter"></i></button></div><div id="mceu_7" class="mce-widget mce-btn" tabindex="-1" aria-pressed="false" role="button" aria-label="Align right"><button id="mceu_7-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-alignright"></i></button></div><div id="mceu_8" class="mce-widget mce-btn mce-last" tabindex="-1" aria-pressed="false" role="button" aria-label="Justify"><button id="mceu_8-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-alignjustify"></i></button></div></div></div><div id="mceu_24" class="mce-container mce-flow-layout-item mce-btn-group" role="group"><div id="mceu_24-body"><div id="mceu_9" class="mce-widget mce-btn mce-first" tabindex="-1" role="button" aria-label="Decrease indent"><button id="mceu_9-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-outdent"></i></button></div><div id="mceu_10" class="mce-widget mce-btn mce-last" tabindex="-1" role="button" aria-label="Increase indent"><button id="mceu_10-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-indent"></i></button></div></div></div><div id="mceu_25" class="mce-container mce-flow-layout-item mce-last mce-btn-group" role="group"><div id="mceu_25-body"></div></div></div></div></div></div></div></div><div id="mceu_26" class="mce-edit-area mce-container mce-panel mce-stack-layout-item" hidefocus="1" tabindex="-1" role="group" style="border-width: 1px 0px 0px;"><iframe id="post-reply_ifr" frameborder="0" allowtransparency="true" title="Rich Text Area. Press ALT-F9 for menu. Press ALT-F10 for toolbar. Press ALT-0 for help" style="width: 100%; height: 100px; display: block;"></iframe></div><div id="mceu_27" class="mce-statusbar mce-container mce-panel mce-stack-layout-item mce-last" hidefocus="1" tabindex="-1" role="group" style="border-width: 1px 0px 0px;"><div id="mceu_27-body" class="mce-container-body mce-flow-layout"><div id="mceu_28" class="mce-path mce-flow-layout-item mce-first"><div class="mce-path-item">&nbsp;</div></div><div id="mceu_29" class="mce-flow-layout-item mce-resizehandle"><i class="mce-ico mce-i-resize"></i></div><span id="mceu_30" class="mce-branding mce-widget mce-label mce-flow-layout-item mce-last"> Powered by <a href="https://www.tiny.cloud/?utm_campaign=editor_referral&amp;utm_medium=poweredby&amp;utm_source=tinymce" rel="noopener" target="_blank" role="presentation" tabindex="-1">Tiny</a></span></div></div></div></div><textarea name="post-reply" class="editor" id="post-reply" aria-hidden="true" style="display: none;">Reply Here</textarea>
                    </div>
                    <div class="input-field col s12">
                      <a class="btn reply-btn right">Responder</a>
                    </div>
                  </form>
                </div>
                <div class="forward-box d-none">
                  <hr>
                  <form action="#">
                    <div class="input-field col s12">
                      <i class="material-icons prefix"> person_outline </i>
                      <input id="email" type="email" class="validate">
                      <label for="email">To</label>
                    </div>
                    <div class="input-field col s12">
                      <i class="material-icons prefix"> title </i>
                      <input id="subject" type="text" class="validate">
                      <label for="subject">Subject</label>
                    </div>
                    <div class="input-field col s12">
                      <div id="mceu_42" class="mce-tinymce mce-container mce-panel" hidefocus="1" tabindex="-1" role="application" style="visibility: hidden; border-width: 1px; width: 100%;"><div id="mceu_42-body" class="mce-container-body mce-stack-layout"><div id="mceu_43" class="mce-top-part mce-container mce-stack-layout-item mce-first"><div id="mceu_43-body" class="mce-container-body"><div id="mceu_44" class="mce-container mce-menubar mce-toolbar mce-first" role="menubar" style="border-width: 0px 0px 1px;"><div id="mceu_44-body" class="mce-container-body mce-flow-layout"><div id="mceu_45" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-first mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_45" role="menuitem" aria-haspopup="true"><button id="mceu_45-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">File</span> <i class="mce-caret"></i></button></div><div id="mceu_46" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_46" role="menuitem" aria-haspopup="true"><button id="mceu_46-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">Edit</span> <i class="mce-caret"></i></button></div><div id="mceu_47" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_47" role="menuitem" aria-haspopup="true"><button id="mceu_47-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">View</span> <i class="mce-caret"></i></button></div><div id="mceu_48" class="mce-widget mce-btn mce-menubtn mce-flow-layout-item mce-last mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_48" role="menuitem" aria-haspopup="true"><button id="mceu_48-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">Format</span> <i class="mce-caret"></i></button></div></div></div><div id="mceu_49" class="mce-toolbar-grp mce-container mce-panel mce-last" hidefocus="1" tabindex="-1" role="group"><div id="mceu_49-body" class="mce-container-body mce-stack-layout"><div id="mceu_50" class="mce-container mce-toolbar mce-stack-layout-item mce-first mce-last" role="toolbar"><div id="mceu_50-body" class="mce-container-body mce-flow-layout"><div id="mceu_51" class="mce-container mce-flow-layout-item mce-first mce-btn-group" role="group"><div id="mceu_51-body"><div id="mceu_31" class="mce-widget mce-btn mce-first mce-disabled" tabindex="-1" role="button" aria-label="Undo" aria-disabled="true"><button id="mceu_31-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-undo"></i></button></div><div id="mceu_32" class="mce-widget mce-btn mce-last mce-disabled" tabindex="-1" role="button" aria-label="Redo" aria-disabled="true"><button id="mceu_32-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-redo"></i></button></div></div></div><div id="mceu_52" class="mce-container mce-flow-layout-item mce-btn-group" role="group"><div id="mceu_52-body"><div id="mceu_33" class="mce-widget mce-btn mce-menubtn mce-first mce-last mce-btn-has-text" tabindex="-1" aria-labelledby="mceu_33" role="button" aria-haspopup="true"><button id="mceu_33-open" role="presentation" type="button" tabindex="-1"><span class="mce-txt">Formats</span> <i class="mce-caret"></i></button></div></div></div><div id="mceu_53" class="mce-container mce-flow-layout-item mce-btn-group" role="group"><div id="mceu_53-body"><div id="mceu_34" class="mce-widget mce-btn mce-first" tabindex="-1" aria-pressed="false" role="button" aria-label="Bold"><button id="mceu_34-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-bold"></i></button></div><div id="mceu_35" class="mce-widget mce-btn mce-last" tabindex="-1" aria-pressed="false" role="button" aria-label="Italic"><button id="mceu_35-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-italic"></i></button></div></div></div><div id="mceu_54" class="mce-container mce-flow-layout-item mce-btn-group" role="group"><div id="mceu_54-body"><div id="mceu_36" class="mce-widget mce-btn mce-first" tabindex="-1" aria-pressed="false" role="button" aria-label="Align left"><button id="mceu_36-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-alignleft"></i></button></div><div id="mceu_37" class="mce-widget mce-btn" tabindex="-1" aria-pressed="false" role="button" aria-label="Align center"><button id="mceu_37-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-aligncenter"></i></button></div><div id="mceu_38" class="mce-widget mce-btn" tabindex="-1" aria-pressed="false" role="button" aria-label="Align right"><button id="mceu_38-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-alignright"></i></button></div><div id="mceu_39" class="mce-widget mce-btn mce-last" tabindex="-1" aria-pressed="false" role="button" aria-label="Justify"><button id="mceu_39-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-alignjustify"></i></button></div></div></div><div id="mceu_55" class="mce-container mce-flow-layout-item mce-btn-group" role="group"><div id="mceu_55-body"><div id="mceu_40" class="mce-widget mce-btn mce-first" tabindex="-1" role="button" aria-label="Decrease indent"><button id="mceu_40-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-outdent"></i></button></div><div id="mceu_41" class="mce-widget mce-btn mce-last" tabindex="-1" role="button" aria-label="Increase indent"><button id="mceu_41-button" role="presentation" type="button" tabindex="-1"><i class="mce-ico mce-i-indent"></i></button></div></div></div><div id="mceu_56" class="mce-container mce-flow-layout-item mce-last mce-btn-group" role="group"><div id="mceu_56-body"></div></div></div></div></div></div></div></div><div id="mceu_57" class="mce-edit-area mce-container mce-panel mce-stack-layout-item" hidefocus="1" tabindex="-1" role="group" style="border-width: 1px 0px 0px;"><iframe id="forward-editor_ifr" frameborder="0" allowtransparency="true" title="Rich Text Area. Press ALT-F9 for menu. Press ALT-F10 for toolbar. Press ALT-0 for help" style="width: 100%; height: 100px; display: block;"></iframe></div><div id="mceu_58" class="mce-statusbar mce-container mce-panel mce-stack-layout-item mce-last" hidefocus="1" tabindex="-1" role="group" style="border-width: 1px 0px 0px;"><div id="mceu_58-body" class="mce-container-body mce-flow-layout"><div id="mceu_59" class="mce-path mce-flow-layout-item mce-first"><div class="mce-path-item">&nbsp;</div></div><div id="mceu_60" class="mce-flow-layout-item mce-resizehandle"><i class="mce-ico mce-i-resize"></i></div><span id="mceu_61" class="mce-branding mce-widget mce-label mce-flow-layout-item mce-last"> Powered by <a href="https://www.tiny.cloud/?utm_campaign=editor_referral&amp;utm_medium=poweredby&amp;utm_source=tinymce" rel="noopener" target="_blank" role="presentation" tabindex="-1">Tiny</a></span></div></div></div></div><textarea name="post-forward" id="forward-editor" class="editor" aria-hidden="true" style="display: none;"></textarea>
                    </div>
                    <div class="input-field col s12">
                      <a class="btn forward-btn right">Encaminhar</a>
                    </div>
                  </form>
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
        <div class="container"><span>� 2019          <a href="#" target="_blank">Mali Inc.</a> Todos direitos reservados.</span><span class="right hide-on-small-only">Desenvolvido por <a href="#">Mali Inc.</a></span></div>
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