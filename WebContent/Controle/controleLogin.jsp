<%@page import="DAO.ParticipantDAO"%>
<%@page import="model.Participant"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
	function chamar_alert(){
		alert("Preencha os campos");
	}
</script>
<title></title>
</head>

<body>
<%

String action = request.getParameter("action"); 


if (action.equalsIgnoreCase("Logar")){
  String login;
  String senha;

  // dados informados no formulário
  login = request.getParameter("login");
  senha = request.getParameter("senha");
 
  Participant participant = new Participant();
  ParticipantDAO participantDAO = new ParticipantDAO();
  participant = participantDAO.loginParticipant(login, senha);
  if(participant != null){
	  //int tipoUsuario = usuarioDAO.getTipoUsuario(usuario.getIdUsuario());
	  session.putValue("loginParticipant", participant.getLogin()); //Grava a session com o Login
	  session.putValue("nameParticipant", participant.getName()); //Grava a session com o Login
	  session.putValue("idParticipant", participant.getId()); //Grava a session com a Senha
	  session.putValue("idParticipant", participant.getId()); //Grava a session com a Senha

	  response.sendRedirect("../FrontEnd/pages/listExperiment.jsp");

  }else{
	  response.sendRedirect("../FrontEnd/pages/login.html?erro=1");
  }
}

if (action.equalsIgnoreCase("Logout")){
	  String login;
	  String senha;

	  // dados informados no formulário
	  session.putValue("idParticipant", null); 
	 
	  session.putValue("experimentCommentList", null); 
	  session.putValue("patternCommentList", null); 
	  session.putValue("idExperiment", null);
	  response.sendRedirect("../FrontEnd/pages/login.html");

}

if(action.equalsIgnoreCase("erro"))
%>

</body>
</html>