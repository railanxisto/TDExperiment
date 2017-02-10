package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conexao.Conexao;
import model.Participant;

public class ParticipantDAO {
	public boolean validarCpf(String cpf) throws SQLException{
		Connection con = new Conexao().getConnection();
		String sql = "SELECT NOME FROM USUARIO WHERE CPF=?";
		
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setString(1, cpf);
		ResultSet rs = statement.executeQuery();
		String nome = null;
		while (rs.next()){
			nome = rs.getString("nome");
		}
		statement.close();
		con.close();
		if ((nome != null)){
			return false;
		}else{
			return true;
		}
	}
	
//	public int getTipoUsuario(int idUsuario) throws SQLException{
//		Connection con = new Conexao().getConnection();
//		Secretario secretario;
//		Medico medico;
//		Administrador administrador;
//		SecretarioDAO secretarioDAO = new SecretarioDAO();
//		MedicoDAO medicoDAO = new MedicoDAO();
//		AdministradorDAO administradorDAO = new AdministradorDAO();
//		//medico.setIdMedico(-1);
//		//secretario.setIdSecretario(-1);
//		//administrador.setIdAdministrador(-1);
//		medico = medicoDAO.getMedicoUsuario(idUsuario);
//		secretario = secretarioDAO.getSecretarioUsuario(idUsuario);
//		administrador = administradorDAO.getAdministradorUsuario(idUsuario);
//
//
//		if (administrador.getIdAdministrador() != 0){
//			System.out.println("Adm" + administrador.getIdAdministrador());
//			return 0;
//		}else{
//			if(secretario.getIdSecretario() != 0){
//				System.out.println("Secretario");
//				return 1;
//			}else{
//				if(medico.getIdMedico() != 0){
//					System.out.println("medico");
//					return 2;
//				}else{
//					return -1;
//				}
//			}
//			}	
//		}
		
	public Participant loginParticipant(String login, String senha) throws SQLException{
		Connection con = new Conexao().getConnection();
		String sql = "SELECT id, name, login, pass, institution, email FROM PARTICIPANT WHERE login=? and pass=?";
		Participant participant = new Participant();
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setString(1, login);
		statement.setString(2, senha);
		ResultSet rs = statement.executeQuery();
		while (rs.next()){
			participant.setId(rs.getInt(1));
			participant.setName(rs.getString(2));
			participant.setLogin(rs.getString(3));
			participant.setPass(rs.getString(4));
			participant.setInstitution(rs.getString(5));
			participant.setEmail(rs.getString(6));
			return participant;
//			usuario.setAtivo(rs.getInt("ativo"));
//			usuario.setNome(rs.getString("nome"));
//			usuario.setDataNascimento(rs.getDate("dataNasc"));
//			usuario.setIdUsuario(rs.getInt("idUsuario"));
//			usuario.setLogin(rs.getString("login"));
//			usuario.setTelefone(rs.getString("telefone"));
//			usuario.setEmail(rs.getString("email"));
		}
		statement.close();
		con.close();
		return null;
	}
	
	
	public int getIdUsuario() throws SQLException{
		int idUsuario = -1;
		Connection con = new Conexao().getConnection();
		String sql = "SELECT MAX(IDUSUARIO) FROM USUARIO";
		
		PreparedStatement statement = con.prepareStatement(sql);
		ResultSet rs = statement.executeQuery();
		while (rs.next()){
			idUsuario = rs.getInt(1);
		}
		statement.close();
		con.close();
		
		return idUsuario;
	}
	
	public Participant getParticipant(Participant participant) throws SQLException{
		Connection con = new Conexao().getConnection();
		String sql = "SELECT id, name, login, senha, institution, email FROM PARTICIPANT "
				+ "WHERE ID=?";
		
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setInt(1, participant.getId());;
		ResultSet rs = statement.executeQuery();
		while (rs.next()){
			participant.setId(rs.getInt(1));
			participant.setName(rs.getString(2));
			participant.setLogin(rs.getString(3));
			participant.setPass(rs.getString(4));
			participant.setInstitution(rs.getString(5));
			participant.setEmail(rs.getString(6));
			
			;
		}
		statement.close();
		con.close();
		
		return participant;
	}
	
	public void cadastrarParticipant(Participant participant) throws SQLException{
		Connection con = new Conexao().getConnection();
		String sql = "INSERT INTO PARTICIPANT (name, login, pass, institution, email) "
				+ "VALUES (?,?,?,?,?)";
		
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setString(1, participant.getName());
		statement.setString(2, participant.getLogin());
		statement.setString(3, participant.getPass());
		statement.setString(4, participant.getInstitution());
		statement.setString(5, participant.getEmail());
		statement.executeUpdate();
		
		statement.close();
		con.close();
	}
}
