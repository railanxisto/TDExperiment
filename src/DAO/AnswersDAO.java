package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import conexao.Conexao;
import model.Answers;

public class AnswersDAO {
	public static void insertAnswers(Answers answers) throws SQLException{
		Connection con = new Conexao().getConnection();
		String sql = "INSERT INTO ANSWERS (IDPARTICIPANT, IDEXPERIMENT_COMMENT, QUESTION1, QUESTION2, QUESTION3, NOTES) VALUES (?,?,?,?,?,?)";
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setInt(1, answers.getIdParticipant());
		statement.setInt(2, answers.getIdexperiment_comment());
		statement.setString(3, answers.getQuestion1());
		statement.setString(4, answers.getQuestion2());
		statement.setString(5, answers.getQuestion3());
		statement.setString(6, answers.getNotes());
		statement.executeUpdate();
		statement.close();
		con.close();
	}
}
