<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Detalhes do Pagamento</h1><br><br>
<%
	  String nome;
	  float valor, entrada;
	  int qparcelas;	  
	  
	  nome = request.getParameter("nome");
	  valor = Float.parseFloat(request.getParameter("valor"));
	  entrada = Float.parseFloat(request.getParameter("entrada"));
	  qparcelas = Integer.parseInt(request.getParameter("parcelas"));
	  
	  float valorAtual = valor - entrada;
	  
	  


	  
	  
	  

%>

Nome: <%= nome%><br>
Valor Total: <%= valor%><br>
Valor Entrada: <%= entrada%><br>
Valor de Cada Prestação:<br><% 
	for(int i = 0; i < qparcelas; i++){
		float valorParcela = valorAtual / qparcelas;
		out.println("   " + (i+1) + " - " + valorParcela + "<br>");
	}
%>

</body>
</html>