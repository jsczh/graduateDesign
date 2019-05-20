package com.mapper;

import java.util.List;

import com.bean.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);
    
    User selectByUsername(String username);
    
    User selectByEmail(String email);
    
    User selectByNickname(String nickname);
    
    List<Integer> selectAllUserId();

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    User login(User record);
}