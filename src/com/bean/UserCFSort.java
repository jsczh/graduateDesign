package com.bean;

public class UserCFSort implements Comparable<UserCFSort>{
	private int index;
	private int similarity;
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public int getSimilarity() {
		return similarity;
	}
	public void setSimilarity(int similarity) {
		this.similarity = similarity;
	}
	
	@Override
    public int compareTo(UserCFSort cfSort) {
        // TODO Auto-generated method stub
		if(this.similarity < cfSort.similarity)
			return 1;
		else 
        	return -1;
    }

	
}
