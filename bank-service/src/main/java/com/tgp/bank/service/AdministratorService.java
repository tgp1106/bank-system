package com.tgp.bank.service;


import com.baomidou.mybatisplus.extension.service.IService;
import entity.Administrator;

/**
* @author tgp
* @description 针对表【administrator】的数据库操作Service
* @createDate 2023-09-23 20:02:17
*/
public interface AdministratorService extends IService<Administrator> {

    Administrator getByAdminNameAndPassword(String name, String password);
}
