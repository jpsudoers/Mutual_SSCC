<!--#include file="../cnn_string.asp"-->
<%
Response.ContentType = "text/xml"
Response.AddHeader "Cache-control", "private"
Response.AddHeader "Expires", "-1"
Response.CodePage = 65001
Response.CharSet = "utf-8"
%>
<%
Dim DATOS
Dim oConn
SET oConn = Server.CreateObject("ADODB.Connection")
'oConn.Open("Provider=SQLOLEDB; User ID=sa;Password=SCL.2013.2013;data source=.\SQLEXPRESS;Initial Catalog=dbmas")
oConn.Open(MM_cnn_STRING)
Set DATOS = Server.CreateObject("ADODB.RecordSet")
DATOS.CursorType=3

sql = "select * from INSTRUCTOR_RELATOR where estado=1 order by NOMBRES asc"

DATOS.Open sql,oConn

Response.Write("<?xml version='1.0' encoding='utf-8' ?>"&chr(13))
Response.Write("<instructor>"&chr(13)) 

WHILE NOT DATOS.EOF
		Response.Write("<row>"&chr(13))
		Response.Write("<ID_INSTRUCTOR>"&DATOS("ID_INSTRUCTOR")&"</ID_INSTRUCTOR>"&chr(13))
		Response.Write("<NOMBRES>"&DATOS("NOMBRES")&" "&DATOS("A_PATERNO")&" "&DATOS("A_MATERNO")&"</NOMBRES>"&chr(13))
		Response.Write("</row>"&chr(13))
	DATOS.MoveNext
WEND
Response.Write("</instructor>") 
%>
