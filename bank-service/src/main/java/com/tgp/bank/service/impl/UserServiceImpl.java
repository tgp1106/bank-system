package com.tgp.bank.service.impl;


import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tgp.bank.mapper.UserMapper;
import com.tgp.bank.service.UserService;
import dto.FindBackDto;
import dto.ModifyDto;
import entity.Transaction;
import entity.User;
import dto.DepositDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import utils.MD5;
import utils.execption.TgpException;
import utils.result.ResultCodeEnum;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;


/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author tgp
 * @since 2023-09-11
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public User getByUserName(String name) {
        User user = this.getOne(new LambdaQueryWrapper<User>().eq(User::getUserName, name));//从数据库中获得一条记录，where条件为username=参数name
        return user;
    }

    @Override
    public User getByUserNameAndPassword(String name, String password) {
        User user = this.getOne(new LambdaQueryWrapper<User>().eq(User::getUserName, name));//从数据库中获得一条记录，where条件为username=参数name
        if (user == null) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "用户不存在或被冻结");
        }
        System.out.println(user);
        if (!MD5.encrypt(password).equals(user.getPassWord())) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "密码错误");
        }
        return user;
    }

    @Override
    public boolean insertUser(User register) {
        String regex = "^1\\d{10}$";
      if (!register.getPhoneNumber().matches(regex)){
          throw new TgpException(ResultCodeEnum.FAIL.getCode(), "用户手机号格式不正确");
      }
        User user = getByUserName(register.getUserName());
        if (user != null) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "用户已存在");
        }
        register.setPassWord(MD5.encrypt(register.getPassWord()));
      //当你的实体中的主键为null时，他就会执行insert操作，当你的主键不为空时，它就会执行updata操作
        return this.saveOrUpdate(register);
    }


    @Override
    public boolean userDeposit(DepositDto depositDto) {

        double money = depositDto.getMoney();
        String username = depositDto.getUsername();

        User user = getByUserName(username);
        if (user == null) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "用户不存在");
        }

        if (money < 0) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "存款不能为负");
        }

        Double balance = user.getBalance();
        user.setBalance(balance + money);
        return this.saveOrUpdate(user);//主键不为空时，它会执行updata操作,更新用户余额
    }

    public double getUserBalance(String username) {//获取用户余额
        User user = this.getByUserName(username);
        Double balance = user.getBalance();
        return balance;
    }

    @Override
    public List<String> getAllUsernames() {
        return baseMapper.getAllUsernames();
    }

    @Override
    public boolean fruserUnfreeze(String userName) {

        // 执行恢复操作
        return baseMapper.unfreezeUser(userName);

    }

    @Override
    public boolean updateUserMassage(String userName) {

        // 执行恢复操作
        return baseMapper.unfreezeUser(userName);

    }

    @Override
    public List<User> selectList() {
        return baseMapper.getAllUser();
    }


    @Override
    public boolean freezeUser(String userName) {
        return remove(new LambdaQueryWrapper<User>().eq(User::getUserName, userName));
    }
    @Override
    public boolean withdraw(double money, String username) {//
        User user = this.getByUserName(username);
        Double balance = user.getBalance();
        user.setBalance(balance - money);
        if (user.getBalance() < 0) {
            return false;
        }
        boolean b = this.saveOrUpdate(user);//主键不为空时，它会执行updata操作,更新用户余额
        return b;
    }

    @Override
    @Transactional
    public boolean userTransferByUserName(double money, String username, String transferee) {
        if (money< 0) {
            throw new TgpException(201, "转账金额不能为负");
        }
        User user = this.getByUserName(username);
        Double balance = user.getBalance();
        user.setBalance(balance - money);
        if (user.getBalance() < 0) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(),"转账金额不能超过用户余额！");
        }
        User theTransferee = this.getByUserName(transferee);
        if (theTransferee == null){
            throw new TgpException(ResultCodeEnum.FAIL.getCode(),"转账用户不存在，请核对后输入！");
        }
        Double transfereeBalance = theTransferee.getBalance();
        theTransferee.setBalance(transfereeBalance + money);
        this.saveOrUpdate(user);
        boolean b = this.saveOrUpdate(theTransferee);
        return b;

    }

    @Override
    public boolean modifyUserMassage(ModifyDto modifyDto, HttpSession session) {
        if (!modifyDto.getPhone().matches("\\d+")){
        throw new TgpException(ResultCodeEnum.FAIL.getCode(),"手机号必须为纯数字！");
        }
        User user = getByUserName(modifyDto.getUserName());
        if (ObjectUtil.isEmpty(user)) {
            throw new TgpException(ResultCodeEnum.USERS_NOT_EXISTS);
        }
        user.setPassWord(MD5.encrypt(modifyDto.getPassWord()));
        user.setPhoneNumber(modifyDto.getPhone());
        user.setFileUrl(modifyDto.getFileUrl());

        return saveOrUpdate(user);
    }

    @Override
    public String getPasswordByusername(String username) {
        User user = this.getByUserName(username);
        return user.getPassWord();
    }

    @Override
    public boolean selectByUserNameAndPhoneNumber(String userName, String phone) {
        User user = this.getOne(new LambdaQueryWrapper<User>().eq(User::getUserName, userName).eq(User::getPhoneNumber, phone));
        if (user != null){
            return true;
        }
        return false;
    }

    @Override
    public boolean verifyAndUpdate(FindBackDto findBackDto, HttpSession session) {//验证并更新用户密码
        String code = (String) session.getAttribute("code");
        if (code!=null&&!findBackDto.getCode().equals(code)){
            throw new TgpException(ResultCodeEnum.FAIL.getCode(),"验证码错误，请重新输入");
        }
        session.removeAttribute("code");
        String newPassword = findBackDto.getNewPassword();
        String encrypt = MD5.encrypt(newPassword);
        boolean update = this.update(new LambdaUpdateWrapper<User>().eq(User::getUserName, findBackDto.getUserName())
                .set(User::getPassWord, encrypt));
        return update;
    }

    public static String generateRandomNumber(int length) {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            sb.append(random.nextInt(10));
        }

        return sb.toString();
    }


}
