<!--#include file="../conexion.asp"-->
<%

Response.CodePage = 65001
Response.CharSet = "utf-8"

query = "Select ID_EMPRESA,RUT,UPPER(R_SOCIAL) as R_SOCIAL "
query = query&" FROM EMPRESAS"
query = query&" WHERE EMPRESAS.RUT LIKE '%"&Request("txt")&"%' AND EMPRESAS.TIPO IN (1,2) AND EMPRESAS.PREINSCRITA=1 "
query = query&" AND (EMPRESAS.ESTADO=1 or (EMPRESAS.ESTADO=0 and EMPRESAS.ID_EMPRESA=1174))"
query = query&" OR EMPRESAS.R_SOCIAL LIKE '%"&Request("txt")&"%' AND EMPRESAS.TIPO IN (1,2) AND EMPRESAS.PREINSCRITA=1 "
query = query&" AND (EMPRESAS.ESTADO=1 or (EMPRESAS.ESTADO=0 and EMPRESAS.ID_EMPRESA=1174))"

SET rs = conn.execute(query)
While not rs.EOF
	Response.Write("<li onclick=""fill2('"&rs("ID_EMPRESA")&"','"&rs("RUT")&"');"">("&rs("RUT")&") "&rs("R_SOCIAL")&"</li>")
	rs.MoveNext
wend
%>