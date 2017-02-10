package model;

public class ExperimentComment {
	private int id;
	private int idExperiment;
	private int idComment;
	private int flag;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdExperiment() {
		return idExperiment;
	}
	public void setIdExperiment(int idExperiment) {
		this.idExperiment = idExperiment;
	}
	public int getIdComment() {
		return idComment;
	}
	public void setIdComment(int idComment) {
		this.idComment = idComment;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}	
}
