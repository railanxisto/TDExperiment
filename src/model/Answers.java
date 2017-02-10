package model;

public class Answers {
	private int id;
	private int idParticipant;
	private int idexperiment_comment;
	private String question1;
	private String question2;
	private String question3;
	private String notes;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdParticipant() {
		return idParticipant;
	}
	public void setIdParticipant(int idParticipant) {
		this.idParticipant = idParticipant;
	}
	public int getIdexperiment_comment() {
		return idexperiment_comment;
	}
	public void setIdexperiment_comment(int idexperiment_comment) {
		this.idexperiment_comment = idexperiment_comment;
	}
	public String getQuestion1() {
		return question1;
	}
	public void setQuestion1(String question1) {
		this.question1 = question1;
	}
	public String getQuestion2() {
		return question2;
	}
	public void setQuestion2(String question2) {
		this.question2 = question2;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getQuestion3() {
		return question3;
	}
	public void setQuestion3(String question3) {
		this.question3 = question3;
	}
	
	
}
