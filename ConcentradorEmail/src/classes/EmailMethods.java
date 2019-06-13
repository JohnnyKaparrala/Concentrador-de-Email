package classes;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.Part;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;

public class EmailMethods {
	public static String getTextFromMimeMultipart(MimeMultipart mimeMultipart)  throws MessagingException, IOException{
	      String result = "";
	      int count = mimeMultipart.getCount();
	      for (int i = 0; i < count; i++) {
	          BodyPart bodyPart = mimeMultipart.getBodyPart(i);
	          if (bodyPart.isMimeType("text/plain")) 
	          {
	            //is a text
	              result = result + "\n" + bodyPart.getContent();
	              break;
	          } else 
	            if (bodyPart.isMimeType("text/html")) 
	            {
	            	result = (String) bodyPart.getContent();
	            }
	            else
	              if (bodyPart.getContent() instanceof MimeMultipart)
	              {
	                //� um multipart
	                result = result + getTextFromMimeMultipart((MimeMultipart)bodyPart.getContent());
	              }
	              else 
	              {
	                //anexo
	                MimeBodyPart part = (MimeBodyPart) mimeMultipart.getBodyPart(i);
	                
	                if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) 
	                {
	                    // essa parte � o anexo
	                  /*System.out.println("Esse email tem um anexo, voc� quer salva-lo?(S/N)");
	                  BufferedReader teclado = new BufferedReader(new InputStreamReader(System.in));
	                  if(teclado.readLine().trim().toLowerCase().equals("s"))
	                  {
	                    part.saveFile("c:/Temp/attachments/" + part.getFileName());
	                    System.out.println("salvo em c:/temp/attachments/" + part.getFileName());
	                  }*/
	                }
	              }
	      }
	      return result;
	  }
	
	public static int getQtdAnexo(MimeMultipart mimeMultipart)  throws MessagingException, IOException{ 
		int qtd = 0;
		int count = mimeMultipart.getCount();
		for (int i = 0; i < count; i++) {
			BodyPart bodyPart = mimeMultipart.getBodyPart(i);
			if (bodyPart.isMimeType("text/plain")) 
			{
				break;
			} else 
				if (bodyPart.isMimeType("text/html")) 
				{
					String html = (String) bodyPart.getContent();
				}
				else
					if (bodyPart.getContent() instanceof MimeMultipart)
					{
					}
					else 
					{
						//anexo
						MimeBodyPart part = (MimeBodyPart) mimeMultipart.getBodyPart(i);
						
						if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) 
						{
							qtd++;
							// essa parte � o anexo
						}	
              }
      }
      return qtd;
	}
}
