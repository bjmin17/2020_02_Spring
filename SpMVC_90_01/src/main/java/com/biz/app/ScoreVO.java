package com.biz.app;

public class ScoreVO {
	
	private int kor;
	private int eng;
	private int math;
	private int sci;
	private int mus;
	
	private int sum;
	private int avg;
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
	}
	public int getMath() {
		return math;
	}
	public void setMath(int math) {
		this.math = math;
	}
	public int getSci() {
		return sci;
	}
	public void setSci(int sci) {
		this.sci = sci;
	}
	public int getMus() {
		return mus;
	}
	public void setMus(int mus) {
		this.mus = mus;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public int getAvg() {
		return avg;
	}
	public void setAvg(int avg) {
		this.avg = avg;
	}
	public ScoreVO(int kor, int eng, int math, int sci, int mus, int sum, int avg) {
		super();
		this.kor = kor;
		this.eng = eng;
		this.math = math;
		this.sci = sci;
		this.mus = mus;
		this.sum = sum;
		this.avg = avg;
	}
	public ScoreVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
