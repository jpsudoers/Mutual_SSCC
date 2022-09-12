<!--#include file="../cnn_string.asp"-->
<%
Response.ContentType = "text/xml"
Response.AddHeader "Cache-control", "private"
Response.AddHeader "Expires", "-1"
Response.CodePage = 65001
Response.CharSet = "utf-8"

pagina=1
if(Request("page")<>"")then pagina = CInt(Request("page"))

limite = 1
if(Request("rows")<>"")then limite = CInt(Request("rows"))

orden = "ASC"
if(Request("sord") <> "")then orden = Request("sord")

columna = "r_social"
if(Request("sidx") <> "")then columna = Request("sidx")

node=0
if(request("nodeid")<>"")then node=cInt(request("nodeid"))
%>
<%
Dim DATOS
Dim oConn
SET oConn = Server.CreateObject("ADODB.Connection")
'oConn.Open("Provider=SQLOLEDB; User ID=sa;Password=SCL.2013.2013;data source=.\SQLEXPRESS;Initial Catalog=dbmas")
oConn.Open(MM_cnn_STRING)
Set DATOS = Server.CreateObject("ADODB.RecordSet")
DATOS.CursorType=3

buscar="1=1"
if(Request("texto")<>"")then
	if(Request("tipo")<>" = '")then
		buscar=Request("campo")&Request("tipo")&"%"&Request("texto")&"%'"
	else
		buscar=Request("campo")&Request("tipo")&Request("texto")&"'"
	end if
end if

sql = "SELECT ID_EMPRESA,RUT,UPPER(R_SOCIAL) AS R_SOCIAL,ACTIVA from empresas WHERE ESTADO=1 AND TIPO=1 AND PREINSCRITA=1 AND "&buscar&" ORDER BY "&columna&" "&orden

DATOS.Open sql,oConn
total_pages = 0
if( DATOS.RecordCount >0 )then 
	IF((DATOS.RecordCount MOD limite)>0)THEN
		total_pages = FIX(DATOS.RecordCount/limite )+1
	ELSE
		total_pages = (DATOS.RecordCount/limite)
	END IF	
ELSE
		total_pages = 1	
END IF	

if (pagina > total_pages) then pagina=total_pages
inicio = (limite*pagina) - limite 
Response.Write("<?xml version='1.0' encoding='utf-8' ?>"&chr(13))
Response.Write("<rows>"&chr(13)) 
Response.Write("<page>"&pagina&"</page>"&chr(13))
Response.Write("<total>"&total_pages&"</total>"&chr(13))
Response.Write("<records>"&DATOS.RecordCount&"</records>"&chr(13))

fila=0
WHILE NOT DATOS.EOF
	if(fila>=inicio AND fila<(limite*pagina))then
		Response.Write("<row id="""&fila&""">"&chr(13))
		Response.Write("<cell><![CDATA["&replace(FormatNumber(mid(DATOS("rut"), 1,len(DATOS("rut"))-2),0)&mid(DATOS("rut"), len(DATOS("rut"))-1,len(DATOS("rut"))),",",".")&"]]></cell>"&chr(13))
		Response.Write("<cell><![CDATA["&DATOS("r_social")&"]]></cell>"&chr(13))
		
		if(DATOS("ACTIVA")="0")then
		Response.Write("<cell><![CDATA[<span class=""ui-state-valid"" ><a href=""#"" title=""Activar Empresa"" class=""ui-icon ui-icon-circle-close"" name=""aContrato"" onclick=""actDes_Empresa("&DATOS("ID_EMPRESA")&","&DATOS("ACTIVA")&")""></a></span>]]></cell>"&chr(13))
		else
		Response.Write("<cell><![CDATA[<span class=""ui-state-valid"" ><a href=""#"" title=""Desactivar Empresa"" class=""ui-icon ui-icon-circle-check"" name=""aContrato"" onclick=""actDes_Empresa("&DATOS("ID_EMPRESA")&","&DATOS("ACTIVA")&")""></a></span>]]></cell>"&chr(13))
		end if
		
		Response.Write("<cell><![CDATA[<span class=""ui-state-valid"" ><a href=""#"" title=""Modificar Registro"" class=""ui-icon ui-icon-pencil"" name=""aContrato"" onclick=""update("&DATOS("ID_EMPRESA")&")""></a></span>]]></cell>"&chr(13))
Response.Write("<cell><![CDATA[<span class=""ui-state-valid"" ><a href=""#"" title=""Eliminar Registro"" class=""ui-icon ui-icon-trash"" name=""aContrato"" onclick=""eliminar("&DATOS("ID_EMPRESA")&")""></a></span>]]></cell>"&chr(13))
		Response.Write("</row>"&chr(13))
	end if
	fila=fila+1
	DATOS.MoveNext
WEND
Response.Write("</rows>") 
%>