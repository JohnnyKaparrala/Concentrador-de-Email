<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try {
	   String filename = "C:\\downloadJSP\\myFile.txt";
	 
	   // set the http content type to "APPLICATION/OCTET-STREAM
	   response.setContentType("APPLICATION/OCTET-STREAM");
	 
	   // initialize the http content-disposition header to
	   // indicate a file attachment with the default filename
	   // "myFile.txt"
	   String disHeader = "Attachment;
	   Filename=\"myFile.txt\"";
	   response.setHeader("Content-Disposition", disHeader);
	 
	   // transfer the file byte-by-byte to the response object
	   File fileToDownload = new File(filename);
	   FileInputStream fileInputStream = new
	      FileInputStream(fileToDownload);
	   int i;
	   while ((i=fileInputStream.read())!=-1)
	   {
	      out.write(i);
	   }
	   fileInputStream.close();
	   out.close();
	   }catch(Exception e) // file IO errors
	   {
	   e.printStackTrace();
	} catch(Exception e) {
		
	}
%>
</body>
</html>