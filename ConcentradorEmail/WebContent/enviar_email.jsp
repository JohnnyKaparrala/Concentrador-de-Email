<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="javax.mail.*, javax.mail.search.FlagTerm, java.util.*, javax.mail.internet.MimeMultipart, javax.mail.internet.MimeBodyPart, javax.mail.internet.InternetAddress, javax.mail.internet.MimeMessage, classes.*, bd.dbos.*, bd.daos.*, bd.core.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%		
	try{
		final String password = session.getAttribute("senha_atual").toString();
		final String username = session.getAttribute("email_atual").toString();
		String dest = request.getParameter("destinatario").toString();
		String assunto = request.getParameter("assunto").toString();
		String msg = request.getParameter("mensagem").toString();
		
		dest = dest.trim();
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS
        
        Session sas = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            Message message = new MimeMessage(sas);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(dest)
            );
            message.setSubject(assunto);
            message.setContent(msg, "text/html; charset=utf-8");

            Transport.send(message);

            System.out.println("Done");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
		response.sendRedirect("adm_email.jsp");
%>

<%= dest %>
<%= msg %>
<%= assunto %>
</body>
<% 
	} catch(Exception ex){
		session.setAttribute("msg", "Não foi possível enviar um email");
		response.sendRedirect("adm_email.jsp");
		//response.sendRedirect("login.jsp?erro="+ex.getMessage().replaceAll("\\s+","+"));
		//response.sendRedirect("login.jsp?erro=deu+erro");
	}
%>
</html>