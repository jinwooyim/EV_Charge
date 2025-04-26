package com.boot.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

public interface MemberDAO {
	public void registUser(HashMap<String, String> param);

	public int user_id_check(@Param("user_id") String id);

	public int login(@Param("user_id") String id, @Param("user_password") String pw);
}