package com.tgp.bank.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import entity.Administrator;

/**
* @author tgp
* @description 针对表【administrator】的数据库操作Mapper
* @createDate 2023-09-23 20:02:17
* @Entity com.tgp.bank.entity.Administrator
*/
public interface AdministratorMapper extends BaseMapper<Administrator> {
    Administrator selectByName(String name);
}




