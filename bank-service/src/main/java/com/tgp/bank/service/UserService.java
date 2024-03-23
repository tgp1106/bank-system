package com.tgp.bank.service;


import com.baomidou.mybatisplus.extension.service.IService;
import dto.FindBackDto;
import dto.ModifyDto;
import entity.User;
import dto.DepositDto;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author tgp
 * @since 2023-09-11
 */
public interface UserService extends IService<User> {
    User getByUserName(String name);//通过用户名得到用户信息

    boolean freezeUser(String userName);

    User getByUserNameAndPassword(String name,String password);//通过用户名得到用户信息

   boolean insertUser(User register);//插入新用户


    boolean userDeposit(DepositDto depositDto);

    public boolean withdraw(double money,String username);

    boolean userTransferByUserName(double money, String username, String transferee);

    boolean modifyUserMassage(ModifyDto modifyDto, HttpSession session);

    String getPasswordByusername(String username);

    boolean selectByUserNameAndPhoneNumber(String userName, String phone);

    boolean verifyAndUpdate(FindBackDto findBackDto, HttpSession session);

    public List<String> getAllUsernames();

    boolean fruserUnfreeze(String userName);

    boolean updateUserMassage(String userName);

    List<User> selectList();


}
