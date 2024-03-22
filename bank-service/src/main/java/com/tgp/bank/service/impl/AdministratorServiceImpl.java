package com.tgp.bank.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tgp.bank.mapper.AdministratorMapper;
import com.tgp.bank.service.AdministratorService;
import entity.Administrator;
import org.springframework.stereotype.Service;
import utils.execption.TgpException;
import utils.result.ResultCodeEnum;

/**
* @author tgp
* @description 针对表【administrator】的数据库操作Service实现
* @createDate 2023-09-23 20:02:17
*/
@Service
public class AdministratorServiceImpl extends ServiceImpl<AdministratorMapper, Administrator>
    implements AdministratorService{

    @Override
    public Administrator getByAdminNameAndPassword(String name, String password) {
        Administrator administrator = this.getOne(new LambdaQueryWrapper<Administrator>().eq(Administrator::getAdministratorName, name));//从数据库中获得一条记录，where条件为username=参数name
        if (administrator == null) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "管理员不存在");
        }
        System.out.println(administrator);
        if (!password.equals(administrator.getAdministratorPassword())) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "密码错误");
        }
        return administrator;
    }
}




