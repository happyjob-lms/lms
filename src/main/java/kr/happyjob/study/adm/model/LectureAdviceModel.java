package kr.happyjob.study.adm.model;

public class LectureAdviceModel {

	//tb_lecture
	private int lec_no;
	private int test_no;
	private int classroom_no;
	private String lec_nm;
	private int lec_max_cnt;
	private int lec_cnt;
	private String lec_start;
	private String lec_end;
	
	
	//tb_userinfo(회원테이블)
	private String name;// 이름 
	private String loginID;
	
	
	public int getLec_no() {
		return lec_no;
	}
	public void setLec_no(int lec_no) {
		this.lec_no = lec_no;
	}
	public int getTest_no() {
		return test_no;
	}
	public void setTest_no(int test_no) {
		this.test_no = test_no;
	}
	public int getClassroom_no() {
		return classroom_no;
	}
	public void setClassroom_no(int classroom_no) {
		this.classroom_no = classroom_no;
	}
	public String getLec_nm() {
		return lec_nm;
	}
	public void setLec_nm(String lec_nm) {
		this.lec_nm = lec_nm;
	}
	public int getLec_max_cnt() {
		return lec_max_cnt;
	}
	public void setLec_max_cnt(int lec_max_cnt) {
		this.lec_max_cnt = lec_max_cnt;
	}
	public int getLec_cnt() {
		return lec_cnt;
	}
	public void setLec_cnt(int lec_cnt) {
		this.lec_cnt = lec_cnt;
	}
	public String getLec_start() {
		return lec_start;
	}
	public void setLec_start(String lec_start) {
		this.lec_start = lec_start;
	}
	public String getLec_end() {
		return lec_end;
	}
	public void setLec_end(String lec_end) {
		this.lec_end = lec_end;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
			
	
	
}
