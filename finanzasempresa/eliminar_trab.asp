<!--#include file="../conexion.asp"-->
<%Response.CodePage = 65001
Response.CharSet = "utf-8"
Response.ContentType="text/xml"
Response.Write("<?xml version='1.0' encoding='UTF-8'?>")
Response.Write("<eliminar>") 

on error resume next

dim query
query = "UPDATE EMP_INS_USR SET ESTADO = 0 WHERE ID_EMP_USU = "&Request("idc")

conn.execute (query)

Response.Write("<sql>"&query&"</sql>")

if err.number <> 0 then
	Response.Write("<commit>false</commit>")
else
	Response.Write("<commit>true</commit>")
end if
Response.Write("</eliminar>") 
%>