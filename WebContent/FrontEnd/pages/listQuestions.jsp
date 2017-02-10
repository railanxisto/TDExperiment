<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="model.Pattern_Comment"%>
<%@page import="model.CommentThemes"%>
<%@page import="DAO.CommentDAO"%>
<%@page import="model.ExperimentComment"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@page import="DAO.ExperimentDAO"%>
<%@page import="DAO.ExperimentCommentDAO"%>
<%@page import="model.Experiment"%>
<%@page import="model.Comment"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
<style type="text/css">
<!--
td div {
padding:5px; 
width:450px; 
height:220px; 
overflow:auto; 
}
-->
</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>TD EXPERIMENT</title>

    <!-- Bootstrap Core CSS -->
    <link href="../bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<%    
	String action = request.getParameter("action");
	int idParticipant = 0;
	int idExperiment = 0;
	int checkUsuario = session.getAttribute("idParticipant") == null ? 0 : (Integer) session.getAttribute("idParticipant");
	if(checkUsuario == 0){
		response.sendRedirect("../pages/login.html");
	}else{  
	    idParticipant = ((Integer) session.getAttribute("idParticipant")).intValue();
		idExperiment = ((Integer) session.getAttribute("idExperiment")).intValue(); 
	
	
	ArrayList<ExperimentComment> experimentCommentList = new ArrayList<ExperimentComment>();
	ArrayList<CommentThemes> commentThemesList = new ArrayList<CommentThemes>();
	ArrayList<Pattern_Comment> patternCommentList = new ArrayList<Pattern_Comment>();
	String path = "";

	ExperimentCommentDAO experimentCommentDAO = new ExperimentCommentDAO();
	experimentCommentList = experimentCommentDAO.getExperimentCommentList(idParticipant, idExperiment);
	int size = experimentCommentList.size();
	session.putValue("experimentCommentList", experimentCommentList);
		
	//experimentCommentList =(ArrayList<ExperimentComment>) session.getAttribute("experimentCommentList");
	Comment comment = new Comment();
	for(int i=0; i < experimentCommentList.size(); i++){ //Não necessita varrer a Lista se vai pegar apenas um comentário.
	//	if (experimentCommentList.size() > 0){
    //	if(experimentCommentList.get(i).getFlag() == 0){
    		int idComment = experimentCommentList.get(i).getIdComment();
    		int idExperimentComment = experimentCommentList.get(i).getId();
    		session.putValue("idExperimentComment", idExperimentComment); //Grava a session com o Login
    		comment = CommentDAO.getComment(idComment);
    		
    		commentThemesList = CommentDAO.getCommentThemes(idComment);
    		session.putValue("commentThemesList", commentThemesList);
    		
    		patternCommentList = CommentDAO.getPatternComment(idComment);
    		session.putValue("patternCommentList", patternCommentList);


    		break;
    	//}
    }
	
	//System.out.println("Lista: " + experimentCommentList.get(1).getIdComment());	
%>

<script type="text/javascript" language="javascript">
		function valida_form(){ 
			question1 = document.forms["formQuestion"]["question1"].value;
			question2 = document.forms["formQuestion"]["question2"].value;
			notes = document.forms["formQuestion"]["notes"].value;
			if((question1 == "") || question2 == ""){
				alert("Preencha Todos os Campos");
				return false
			}else{
				if(question1 < 1 || question1 > 10){
					alert("Valor deve estar entre 1 e 10");
					return false
				}
				document.formQuestion.submit();
			}

		}
		
		function somenteNumeros(num) {
	        var er = /[^0-9.]/;
	        er.lastIndex = 0;
	        var campo = num;
	        if (er.test(campo.value)) {
	          campo.value = "";
	        }
	    }
		
		function voltar(){
			alert('Ainda nao e possivel voltar');
		}
</script>

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation" style="margin-bottom: 10px">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">TD EXPERIMENT</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  Olá, <%=session.getAttribute("nameParticipant")%><i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
							 <li class="divider"></li>
                        <li><a href="../../Controle/controleLogin.jsp?action=Logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                       
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>
	</div>
	<form method="post" id="formQuestion" role="form" name="formQuestion" action="../../Controle/controleListQuestions.jsp?action=next">
	<div>
        <div id="page-wrapper"  style="padding-top: 5%">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
						<table class="table table-striped table-bordered table-hover">
                        <tr>
                        Total de Comentários: <%out.println(size);%> <%/*out.println(comment.getId());*/%>
                            <td> <div>
                                                       
							<%
								if(comment.getComment() != null){
									String aux = comment.getComment().replace("\n","<br/>");
									path = comment.getPath();
									//path = "../../../" +path.substring(path.indexOf("jfreechart-1.0.19"));
									path = "../../../" +path.substring(path.indexOf("jfreechart-1.0.19"));

									out.println(aux);
								}else{
									response.sendRedirect("https://goo.gl/forms/gbZxlzLdpDgd5iZ02");
									//out.println("Total" + size);
								}
							%>
							</div>
							</td>
							<td><b>Padrões Encontrados:        </b></br> 
							    <% 
							    	for(int i=0; i < patternCommentList.size();i++){
							    		out.println(patternCommentList.get(i).getPattern());
	            
							    %>
							    <br>
							    <%	}%>
							
							</td>
						</tr>
						</table>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                                <br>
								<center><a href="<%=path%>" target="_blank"> CLIQUE AQUI PARA VER O CÓDIGO FONTE</a><center><br><br>
								 <table class="table table-striped table-bordered table-hover">
                                    
                                    <tbody>
										<tr class="odd gradeX">
                                        	<td>De 1 à 10 quanto você acha que o comentário descreve uma Dívida Técnica?<font color="red"> *</font><br><i>Onde 1 indica que o comentário descreve muito pouco ou gera dúvidas em relação a se o comentário descreve mesmo uma situação de Dívida Técnica;</i><br>10 Indica que o comentário descreve claramente uma situação de DT</td>
											<td><input id="question1" name="question1" class="form-control" placeholder="1-10" value="" size="1" maxlength=2 lenght="10px" onkeyup="somenteNumeros(this);"></td>
											
                                           
                                        </tr>
										
								<% for(int i=0; i < commentThemesList.size();i++){%>
									<input type="hidden" name="qnt" value="<%=commentThemesList.size()%>">
										<tr class="odd gradeX">
                                        	<td>Você concorda que por causa do termo: <i><b>"<%=commentThemesList.get(i).getPattern()%>"</b></i>, o comentário está relacionado ao tema abaixo:</br>
											    <i> <b>"<%=commentThemesList.get(i).getTheme()%>"</i><font color="red"> *</font>
											</td>
											<td><input type="radio" name="question<%=i+3%>" value="" checked> Não
												<input type="radio" name="question<%=i+3%>" value="<%=commentThemesList.get(i).getTheme()%>"> Sim
											</td>
                                        </tr>
                                <%} } %>
                                
                                <tr class="odd gradeX">
                                            <td>Qual tipo de Dívida Técnica você acha que o comentário descreve?<font color="red"> *</font><br><i><font color="red">Para selecionar mais de uma opção, mantenha a tecla CTRL pressionada</font></i></td>
											<td>
												<select multiple name="question2" id="question2" size=11>
												  <option value="None">I couldn't identify any type</option>
												  <option value="Architecture Debt">Architecture Debt</option>
												  <option value="Build Debt">Build Debt</option>
												  <option value="Code Debt">Code Debt</option>
												  <option value="Defect Debt">Defect Debt</option>
												  <option value="Design Debt">Design Debt</option>
												  <option value="Documentation Debt">Documentation Debt</option>
												  <option value="People Debt">People Debt</option>
												  <option value="Requirement Debt">Requirement Debt</option>
												  <option value="Test Debt">Test Debt</option>
												  <option value="Infrastructure Debt">Infrastructure Debt</option>													  
												</select>
												<br>
											</td>		
                                        </tr>
                                        
                                        <tr class="odd gradeX">
                                        <div class="form-group">
                                            <td colspan="2"><label>Notes:</label><textarea type="textarea" rows="5" cols="10" class="form-control" name="notes" id="notes" placeholder="" value=""></textarea></td>
                                           
                                        </div>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
							<center>
							<button type="button"  class="btn btn-default" onclick="voltar();">Back</button>
							<button type="button"  class="btn btn-default" onclick="valida_form('next');">Next</button>
							</center>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    </form>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="../bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="../bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
    <script src="../bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="../dist/js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
                responsive: true
        });
    });
    </script>

</body>

</html>