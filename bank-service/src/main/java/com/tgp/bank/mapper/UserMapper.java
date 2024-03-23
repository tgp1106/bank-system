package com.tgp.bank.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;


/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author tgp
 * @since 2023-09-11
 */


public interface UserMapper extends BaseMapper<User> {

    @Select("SELECT user_name FROM user")
    List<String> getAllUsernames();

    @Select("SELECT * FROM user")
    List<User> getAllUser();

    @Update("UPDATE user SET is_deleted = 0 WHERE user_name = #{userName}")
    boolean unfreezeUser(@Param("userName") String userName);




}
