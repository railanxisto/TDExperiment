package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conexao.Conexao;
import model.Experiment;

public class ExperimentDAO {
	public ArrayList<Experiment> getExperimentList(int idParticipant) throws SQLException{
		ArrayList<Experiment> ExperimentList = new ArrayList<>();
		Connection con = new Conexao().getConnection();
		
		
		String sql = "SELECT * FROM EXPERIMENT E, PARTICIPANT P WHERE P.IDEXPERIMENT = E.ID AND P.ID = ?";
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setInt(1, idParticipant);
		ResultSet rs = statement.executeQuery();
		
		while (rs.next()){
			Experiment Experiment = new Experiment();
			Experiment.setId(rs.getInt(1));
			Experiment.setDescription(rs.getString(2));
			ExperimentList.add(Experiment);
			
		}	
		statement.close();
		con.close();
		
		return ExperimentList;	
	}
}
