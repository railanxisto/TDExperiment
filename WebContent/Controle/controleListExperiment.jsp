<%@page import="DAO.ExperimentCommentDAO"%>
<%@page import="model.ExperimentComment"%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Participant"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	if(session.isNew()){
		response.sendRedirect("../FrontEnd/pages/login.html");
	}

	Participant participant = new Participant();
	int idExperiment = 0;
	int idParticipant = 0;
	int checkUsuario = session.getAttribute("idParticipant") == null ? 0 : (Integer) session.getAttribute("idParticipant");
	if(checkUsuario == 0){
		response.sendRedirect("../pages/login.html?");
	}else{  
		idExperiment = Integer.parseInt(request.getParameter("idExperiment")); 
		idParticipant = ((Integer) session.getAttribute("idParticipant")).intValue();
	}
	
	ArrayList<ExperimentComment> experimentCommentList = new ArrayList<ExperimentComment>();
	ExperimentCommentDAO experimentCommentDAO = new ExperimentCommentDAO();
	experimentCommentList = experimentCommentDAO.getExperimentCommentList(idParticipant, idExperiment);
	
	session.putValue("experimentCommentList", experimentCommentList);
	session.putValue("idExperiment", idExperiment); //Grava a session com a Senha
	response.sendRedirect("../FrontEnd/pages/listQuestions.jsp");

%>
</body>
</html>