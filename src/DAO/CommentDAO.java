package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.Statement;
import java.util.ArrayList;

import conexao.Conexao;
import model.Comment;
import model.CommentThemes;
//import model.Experiment;
import model.Pattern_Comment;

/**
 * CommentDataSource contains the methods to handle
 * the comments records in the database
 */
public class CommentDAO {

	/**Insert a comment record on the database
	 * 
	 * @param comment - the comment's content
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	
	
	
	
	public static Comment getComment(int idComment) throws ClassNotFoundException, SQLException{
		Comment comment = new Comment();
		Connection con = new Conexao().getConnection();

		String sql = "SELECT * FROM COMMENTS WHERE ID = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, idComment);
		ResultSet rs;
		rs = stmt.executeQuery();
		if ( rs.next() ) {
			comment.setId(rs.getInt("ID"));
			comment.setComment(rs.getString("COMMENT"));
			comment.setPath(rs.getString("path"));
		}		
		rs.close();
		stmt.close();
		con.close();
		return comment;
	}
	
/*	public static void updComment() throws ClassNotFoundException, SQLException
	{
		
		Connection con = new Conexao().getConnection();

		String sql = "SELECT * FROM COMMENTS where id = 1";
		PreparedStatement stmt = con.prepareStatement(sql);
		ResultSet rs;
		rs = stmt.executeQuery();
		int id = 0;
		String path = "";
		String path2 = "";
		if ( rs.next() ) {
			id = rs.getInt("ID");
			path = rs.getString("path");
			path2 = path.substring(path.indexOf("argouml_projects"));
			System.out.println("path1: " + path);
			System.out.println("path2: " + path2);
		}		
		rs.close();
		stmt.close();
		con.close();
	} */
	
	
	
	

	public static ArrayList<CommentThemes> getCommentThemes(int idComment) throws ClassNotFoundException, SQLException {
		Connection con = new Conexao().getConnection();
		ArrayList<CommentThemes> commentThemesList = new ArrayList<>();
		String sql = "select pc.idComment, p.pattern, t.theme from pattern_comment pc, theme t, pattern_theme pt, pattern p, comments c where pc.idPattern = p.id and c.id = pc.idcomment and pc.idPattern = pt.idPattern and t.id = pt.idTheme and t.id =pt.idTheme and pc.idComment=? order by pc.idComment";
		PreparedStatement statement = con.prepareStatement(sql);
		statement.setInt(1, idComment);
		ResultSet rs = statement.executeQuery();
		
		while (rs.next()) {
			CommentThemes commentThemes = new CommentThemes();
			commentThemes.setIdComment(rs.getInt(1));
			commentThemes.setPattern(rs.getString(2));
			commentThemes.setTheme(rs.getString(3));
			commentThemesList.add(commentThemes);
		}

		rs.close();
		con.close();

		return commentThemesList;
	}
	
	
	
	
	public static ArrayList<Pattern_Comment> getPatternComment(int idComment) throws ClassNotFoundException, SQLException {
		Connection con = new Conexao().getConnection();
		ArrayList<Pattern_Comment> patternCommentList = new ArrayList<>();
		String sql = "select pc.idComment, p.pattern from pattern p, pattern_comment pc, comments c where p.id = pc.idPattern and pc.idComment = c.id and pc.idComment = ?";

		PreparedStatement statement = con.prepareStatement(sql);
		statement.setInt(1, idComment);
		ResultSet rs = statement.executeQuery();
		
		while (rs.next()) {
			Pattern_Comment pattern_Comment = new Pattern_Comment();
			pattern_Comment.setIdComment(rs.getInt(1));
			pattern_Comment.setPattern(rs.getString(2));
			patternCommentList.add(pattern_Comment);
		}

		rs.close();
		con.close();

		return patternCommentList;
	}
}
