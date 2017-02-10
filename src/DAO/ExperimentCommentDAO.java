package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conexao.Conexao;
import model.ExperimentComment;

public class ExperimentCommentDAO {
	public static void updateFlag(int flag, int idExperimentComment) throws SQLException{
		Connection con = new Conexao().getConnection();
		String sql = "UPDATE EXPERIMENT_COMMENT SET FLAG = ? WHERE ID = ?;";
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setInt(1, flag);	
		statement.setInt(2, idExperimentComment);
		statement.executeUpdate();
		
		statement.close();
		
		con.close();
	}
		
	public ArrayList<ExperimentComment> getExperimentCommentList(int idParticipant, int idExperiment) throws SQLException{
		ArrayList<ExperimentComment> experimentCommentList = new ArrayList<>();
		Connection con = new Conexao().getConnection();	
	/*	String sql = "select ec.* "
				+ "from experiment_comment ec, participant p, experiment e, comments c "
				+ "where ec.idExperiment = e.id "
				+ "and p.idExperiment =  ec.idExperiment "
				+ "and ec.idComment = c.id "
				+ "and p.id = ?"
				+ "and e.id = ?"  
				+ "and ec.idExperiment NOT IN (Select idexperiment_comment from answers)"; // Aqui teria que ser o commentário e nao o comentário_experimento. //It was inserted to select only the comments that were not answered.
		*/
		String sql = "select ec.* from experiment_comment ec, participant p, comments c "
				+ "where ec.idExperiment = p.idExperiment "
				+ "and ec.idComment = c.id "
				+ "and p.id = ?"
				+ "and ec.idExperiment  = ?"  
				+ "and ec.id NOT IN "
				+ "(Select idexperiment_comment from answers where idparticipant = ?)";
		
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setInt(1, idParticipant);
		statement.setInt(2, idExperiment);
		statement.setInt(3, idParticipant);
		ResultSet rs = statement.executeQuery();
		
		while (rs.next()){
			ExperimentComment experimentComment = new ExperimentComment();
			experimentComment.setId(rs.getInt(1));
			experimentComment.setIdExperiment(rs.getInt(2));
			experimentComment.setIdComment(rs.getInt(3));
			experimentComment.setFlag(rs.getInt(4));
			experimentCommentList.add(experimentComment);
			
		}	
		statement.close();
		con.close();
		
		return experimentCommentList;	
	}
}
