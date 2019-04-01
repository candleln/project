package com.projecthh.common;

import java.util.Random;

public class AuthKeyCreator {
	private int size;

	public String getKey(int size) {
		this.size = size;
		return init();
	}

	private String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();

		int num = 0;
		
		while (sb.length() < size) {
			num = ran.nextInt(75) + 48;

			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}
		}
		return sb.toString();
	}
}