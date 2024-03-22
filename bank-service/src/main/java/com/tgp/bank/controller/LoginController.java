package com.tgp.bank.controller;


import com.alibaba.fastjson.JSON;
import com.tgp.bank.service.AdministratorService;
import com.tgp.bank.service.UserService;
import dto.FindBackDto;
import dto.RetrievepasswordDto;
import entity.Administrator;
import entity.User;
import model.AdminVo;
import model.LoginVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import utils.execption.TgpException;
import utils.jwt.JwtHelper;
import utils.result.Result;
import utils.result.ResultCodeEnum;

import javax.servlet.http.HttpSession;

import static com.tgp.bank.service.impl.UserServiceImpl.generateRandomNumber;


/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author tgp
 * @since 2023-09-11
 */


@Controller
public class LoginController {

    @Autowired
    UserService userService;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    AdministratorService administratorService;

    @PostMapping(value = ("login"))//登录接口
    @ResponseBody
    public Result login(@RequestBody LoginVo loginVo, HttpSession session) {



        User user = userService.getByUserNameAndPassword(loginVo.getUsername(), loginVo.getPassword());//当用户查询不到时返回错误信息



        session.setAttribute("token", JwtHelper.createToken(user.getUserId(), user.getUserName()));
        //保存在session里面
        session.setAttribute("loginUser",user);



        redisTemplate.opsForValue().set("isLoggedIn","true");

        redisTemplate.opsForValue().set("loginUsername",user.getUserName());

        return Result.ok();//由于@RestController注解，将msg转成json格式返回,
    }

    @PostMapping(value = ("administrator"))//管理员登录接口
    @ResponseBody
    public Result toadmin(@RequestBody AdminVo adminVo, HttpSession session) {
        Administrator loginAdministrator = (Administrator) session.getAttribute("loginAdministrator");
        if (loginAdministrator != null && loginAdministrator.getAdministratorName().equals(adminVo.getAdministrator_name()) ){
            throw new TgpException(ResultCodeEnum.FAIL.getCode(),"不要重复登录");
        }

        Administrator administrator = administratorService.getByAdminNameAndPassword(adminVo.getAdministrator_name(), adminVo.getAdministrator_password());//当用户查询不到时返回错误信息

        session.setAttribute("token", JwtHelper.createToken(administrator.getAdministratorId(), administrator.getAdministratorName()));
        //保存在session里面
        session.setAttribute("loginAdministrator",administrator);

        return Result.ok();//由于@RestController注解，将msg转成json格式返回,
    }
    @PostMapping(value = ("toregister"))//注册接口
    @ResponseBody
    public Result register(@RequestBody User register) {

        boolean b = userService.insertUser(register);//将用户信息插入
        if (!b) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "注册失败");
        }
        return Result.ok("注册成功");
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 关闭会话
        redisTemplate.delete("isLoggedIn");
        redisTemplate.delete("loginUsername");
        return "redirect:/login.jsp"; // 重定向到登录页面
    }

    @PostMapping(value = ("retrievepassword"))//接收用户名和对应手机号，返回验证码
    @ResponseBody
    public Result retrievepassword(@RequestBody RetrievepasswordDto retrievepasswordDto,HttpSession session) {


        if (!userService.selectByUserNameAndPhoneNumber(retrievepasswordDto.getUserName(),retrievepasswordDto.getPhone())) {
            throw new TgpException(ResultCodeEnum.FAIL.getCode(), "请核对用户名和手机号是否匹配");
        }
        String code = generateRandomNumber(6);
        session.setAttribute("code",code);
        return Result.ok("验证码为"+code);
    }

    @PostMapping(value = ("findback"))//验证验证码
    @ResponseBody
    public Result findback(@RequestBody FindBackDto findBackDto, HttpSession session) {
        boolean b = userService.verifyAndUpdate(findBackDto, session);
        if (!b){
            throw new TgpException(ResultCodeEnum.FAIL.getCode(),"重置密码失败,请重试或练习客服");
        }
        return Result.ok("更新成功，请尝试重新登录！");
    }



}

