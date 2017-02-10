<%@page import="model.Answers"%>
<%@page import="DAO.AnswersDAO"%>
<%@page import="model.ExperimentComment"%>
<%@page import="DAO.ExperimentCommentDAO"%>
<%@page import="model.ExperimentComment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	int idExperiment = 0;
	int idParticipant = 0;
	int idExperimentComment = 0;
	int checkUsuario = session.getAttribute("idParticipant") == null ? 0 : (Integer) session.getAttribute("idParticipant");
	if(checkUsuario == 0){
		response.sendRedirect("../pages/login.html?");
	}else{  
		idExperiment = ((Integer) session.getAttribute("idExperiment")).intValue();
		idExperimentComment = ((Integer) session.getAttribute("idExperimentComment")).intValue();
		idParticipant = ((Integer) session.getAttribute("idParticipant")).intValue();
	}
	String action = request.getParameter("action");
	//int idParticipant = ((Integer) session.getAttribute("idParticipant")).intValue();
	String question1 = request.getParameter("question1");
	//String question2 = request.getParameter("question2");
	String [] question2 = request.getParameterValues("question2");
	//System.out.print("Teste Type:" + question2);
	
	String question3 = "";
	
	int qnt = Integer.parseInt(request.getParameter("qnt"));
	int cont = 0;
	boolean flag = true;
	for(int i=0; i < qnt; i++){
		int aux = i+3;
		String auxString = request.getParameter("question"+aux);
		//System.out.println(auxString);
	  if (auxString != null)
	  {	  
		if(!auxString.equalsIgnoreCase("''")){
			if(cont == 0)
				question3 = auxString;
			else
				question3 = question3 + ", " + auxString;
		
		  cont++;
	    }
	  }
      else {
    	  flag = false;
    	  //response.sendRedirect("../FrontEnd/pages/error.html");
      }
	}
	
	String notes = request.getParameter("notes");
	int qtdTypes = question2.length;
	//System.out.println("qtdTypes: " + qtdTypes);
	String auxQuestion2 = "";
	ExperimentCommentDAO experimentCommentDAO = new ExperimentCommentDAO();
	if(action.equalsIgnoreCase("next") && flag)
	{
		Answers answers = new Answers();
		answers.setIdParticipant(idParticipant);
		answers.setIdexperiment_comment(idExperimentComment);
		answers.setQuestion1(question1);
		
		//Recuperando os tipos de DT
		for (int i=0; i < qtdTypes; i++)
		{
			auxQuestion2 += ", " + question2[i];
		}
		
		answers.setQuestion2(auxQuestion2);
		
		answers.setQuestion3(question3);
		answers.setNotes(notes);
		//experimentCommentDAO.updateFlag(1, idExperimentComment);
		AnswersDAO.insertAnswers(answers);
	
	    response.sendRedirect("../FrontEnd/pages/listQuestions.jsp");
	}
	else
	{
		response.sendRedirect("../FrontEnd/pages/error.html");
	}

 %>
</body>
</html>