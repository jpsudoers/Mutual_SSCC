<%
on error resume next
%>
<!--#include file="../conexion.asp"-->
<%
Response.CodePage = 65001
Response.CharSet = "utf-8"
vid = Request("id")
dim query
query="select ID_PROGRAMA,ID_MUTUAL,ID_INSTRUCTOR,ID_SEDE,SENCE,TIPO,"
query= query&"CONVERT(VARCHAR(10),FECHA_APERTURA, 105) as FECHA_APERTURA,"
query= query&"CONVERT(VARCHAR(10),FECHA_CIERRE, 105) as FECHA_CIERRE,"
query= query&"CONVERT(VARCHAR(10),FECHA_INICIO_, 105) as FECHA_INICIO_,"
query= query&"CONVERT(VARCHAR(10),FECHA_TERMINO, 105) as FECHA_TERMINO,VALOR,CUPOS,INSCRITOS"
query= query&",VACANTES,ESTADO "
query= query&" from PROGRAMA where ID_PROGRAMA="&vid

set rsEmp = conn.execute (query)

if not rsEmp.eof and not rsEmp.bof then 
%>
 <form name="frmProgramacion" id="frmProgramacion" action="../Copia de programacion/programacion/modificar.asp" method="post">
   <table cellspacing="0" cellpadding="1" border=0>
     <tr>
       <td width="155">C&oacute;digo Curso :</td>
       <td width="200"><select id="Curriculo" name="Curriculo" tabindex="1" onchange="cargaDatos(this.value);"></select></td>
       <td width="20" ><input type="hidden" id="txtId" name="txtId" value="<%=rsEmp("ID_PROGRAMA")%>"  /><input type="hidden" id="txtIdCurriculo" name="txtIdCurriculo" value="<%=rsEmp("ID_MUTUAL")%>" /></td>
       <td width="120">Nombre :</td>
       <td width="172" colspan="4"><label id="txtCurso" name="txtCurso"></label></td>
     </tr>
     <tr>
	   <td width="155">Sence :</td>
       <td width="200"><input type="radio" name="Sence_SI" id="Sence_SI" disabled value="0">Si
		   				<input type="radio" name="Sence_NO" id="Sence_NO" value="1" disabled>No</td> 
       <td width="20"></td>
       <td width="120"></td>
       <td width="172"></td>
       <td width="20"></td>
       <td width="90"></td>
       <td width="131"></td>
      </tr>
     <tr>
       <td>Intructor :</td>
       <td><select id="Instructor" name="Instructor" tabindex="2"></select></td>
        <td><input type="hidden" id="txtIdInstructor" name="txtIdInstructor" value="<%=rsEmp("ID_INSTRUCTOR")%>" /></td>
     </tr>
     <tr>
       <td>Sede :</td>
       <td><select id="Sede" name="Sede" tabindex="3"></select></td>
        <td><input type="hidden" id="txtIdSede" name="txtIdSede" value="<%=rsEmp("ID_SEDE")%>" /></td>
     </tr>
    <tr>
       <td>Tipo :</td>
         <td><select id="Tipo" name="Tipo" tabindex="3"></select></td>
          <td><input type="hidden" id="txtTipo" name="txtTipo" value="<%=rsEmp("TIPO")%>" /></td>
     </tr>
     <tr>
       <td>Fecha Apertura :</td>
       <td><input id="txtFechApertura" name="txtFechApertura" type="text" tabindex="7" maxlength="50" value="<%=rsEmp("FECHA_APERTURA")%>" size="12"/></td>
       <td></td>
       <td>Fecha Cierre :</td>
       <td><input id="txtFechCierre" name="txtFechCierre" type="text" tabindex="8" maxlength="50" value="<%=rsEmp("FECHA_CIERRE")%>" size="12"/></td>
     </tr>
     <tr>
       <td>Fecha Inicio :</td>
       <td><input id="txtFechInicio" name="txtFechInicio" type="text" tabindex="9" maxlength="50" value="<%=rsEmp("FECHA_INICIO_")%>" size="12"/></td>
       <td></td>
       <td>Fecha Termino :</td>
       <td><input id="txtFechTermino" name="txtFechTermino" type="text" tabindex="10" maxlength="50" value="<%=rsEmp("FECHA_TERMINO")%>" size="12"/></td>
     </tr>
       <tr>
       <td>Valor :</td>
       <td><label id="txtValor" name="txtValor">&nbsp;</label></td>
     </tr>
      <tr>
       <td>Cupos :</td>
       <td><input id="txtCupo" name="txtCupo" type="text" tabindex="12" maxlength="50" value="<%=rsEmp("CUPOS")%>" size="12"  onKeyPress="return acceptNum(event)"/></td>
       <td></td>
       <td>Inscritos :</td>
       <td><label id="txtInscritos" name="txtInscritos"></label></td>
       <td></td>
       <td>Vacantes :</td>
       <td><label id="txtVacantes" name="txtVacantes"><%=rsEmp("VACANTES")%></label></td>
     </tr>
   </table>
</form> 
<%
   else
%> <form name="frmProgramacion" id="frmProgramacion" action="../Copia de programacion/programacion/insertar.asp" method="post">
   <table cellspacing="0" cellpadding="1" border=0>
     <tr>
       <td width="155">C&oacute;digo Curso :</td>
       <td width="200"><select id="Curriculo" name="Curriculo" tabindex="1" onchange="cargaDatos(this.value);"></select></td>
       <td width="20" ></td>
       <td width="120">Nombre :</td>
       <td width="172" colspan="4"><label id="txtCurso" name="txtCurso"></label></td>
     </tr>
     <tr>
	   <td width="155">Sence :</td>
		   <%
               if(rsEmp("SENCE")=0)then
               senceSi="checked"
               else
               senceNo="checked"
               end if
           %>
         <td width="200"><input type="radio" name="Sence_SI" id="Sence_SI" disabled value="0">Si
		   				<input type="radio" name="Sence_NO" id="Sence_NO" value="1" disabled>No</td> 
       <td width="20"></td>
       <td width="120"></td>
       <td width="172"></td>
       <td width="20"></td>
       <td width="90"></td>
       <td width="131"></td>
      </tr>
     <tr>
       <td>Intructor :</td>
       <td><select id="Instructor" name="Instructor" tabindex="2"></select></td>
     </tr>
     <tr>
       <td>Sede :</td>
       <td><select id="Sede" name="Sede" tabindex="3"></select></td>
     </tr>
     <tr>
       <td>Tipo :</td>
         <td><select id="Tipo" name="Tipo" tabindex="3"></select></td>
     </tr>
     <tr>
       <td>Fecha Apertura :</td>
       <td><input id="txtFechApertura" name="txtFechApertura" type="text" tabindex="7" maxlength="50" size="12"/></td>
       <td></td>
       <td>Fecha Cierre :</td>
       <td><input id="txtFechCierre" name="txtFechCierre" type="text" tabindex="8" maxlength="50" size="12"/></td>
     </tr>
     <tr>
       <td>Fecha Inicio :</td>
       <td><input id="txtFechInicio" name="txtFechInicio" type="text" tabindex="9" maxlength="50" size="12"/></td>
       <td></td>
       <td>Fecha Termino :</td>
       <td><input id="txtFechTermino" name="txtFechTermino" type="text" tabindex="10" maxlength="50" size="12"/></td>
     </tr>
       <tr>
       <td>Valor :</td>
       <td><label id="txtValor" name="txtValor">&nbsp;</label></td>
     </tr>
      <tr>
       <td>Cupos :</td>
       <td><input id="txtCupo" name="txtCupo" type="text" tabindex="12" maxlength="50" size="12" onkeyup="calcula()"  onKeyPress="return acceptNum(event)"/></td>
       <td></td>
       <td>Inscritos :</td>
       <td><label id="txtInscritos" name="txtInscritos"></label></td>
       <td></td>
       <td>Vacantes :</td>
       <td><label id="txtVacantes" name="txtVacantes"></label></td>
     </tr>
   </table>
</form> 
<%
   end if
%>
<div id="messageBox1" style="height:100px;overflow:auto;width:300px;"> 
  	<ul></ul> 
</div> 
