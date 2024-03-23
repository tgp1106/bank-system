package com.tgp.bank.controller;

import dto.DepositDto;
import com.tgp.bank.service.UserService;
import dto.ModifyDto;
import dto.TransferDto;
import dto.WithDrawDto;
import entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import utils.execption.TgpException;
import utils.result.Result;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;


/**
 * @Author：陶广鹏
 * @Package：com.tgp.bank.controller
 * @Project：Bank-system
 * @name：UserController
 * @Date：2023/9/11 22:02
 * @Filename：UserController
 */
@Controller
public class UserMenuController {
    @Autowired
    UserService userService;

    @GetMapping("/index")
    public String index() {
        return "index";
    }

    @GetMapping("/withdraw")
    public String withdraw() {return "/withdraw-show";}

    @GetMapping("/deposit")
    public String deposit() {return "/deposit-show";}

    @GetMapping("/transfer")
    public String transfer(){return "/transfer-show";}

    @GetMapping("/modify")
    public String modify(){return "/modify-show";}

    @GetMapping("/admin")
    public String admin(Model model) {
        List<User> users = userService.selectList();
        model.addAttribute("users", users);
        return "admin-show";
    }

    @GetMapping("/userFreeze")
    @ResponseBody
    public Result userFreeze(@RequestParam("userName") String userName) {
        if (!userService.freezeUser(userName))
        {
            throw new TgpException(201,"冻结失败");
        }
        return Result.ok("冻结成功");
    }

    @GetMapping("/userUnfreeze")
    @ResponseBody
    public Result userUnfreeze(@RequestParam("userName") String userName) {
        if (!userService.fruserUnfreeze(userName))
        {
            throw new TgpException(201,"解冻结失败");
        }
        return Result.ok("解冻成功");
    }


    @ResponseBody
    @PostMapping("/deposit")
    public Result deposit(@RequestBody DepositDto depositDto) {


        boolean b = userService.userDeposit(depositDto);

        if (!b) {
            throw new TgpException(201, "存款失败");
        }
        LocalDateTime currentTime = LocalDateTime.now();
        // userService.recordTransaction( "deposit", depositDto.getMoney(),currentTime);
        return Result.ok("存款成功");
    }

    @ResponseBody
    @PostMapping("/withdraw")
    public Result withdraw(@RequestBody WithDrawDto withDrawDto) {
        if (withDrawDto.getMoney()< 0) {
            throw new TgpException(201, "取款不能为负");
        }
        boolean b = userService.withdraw(withDrawDto.getMoney(),withDrawDto.getUsername());
        if (!b) {
            throw new TgpException(201, "取款失败");
        }
        return Result.ok("取款成功");
    }



    @ResponseBody
    @PostMapping("/transfer")
    public Result transfer(@RequestBody TransferDto transferDto) {

        boolean b = userService.userTransferByUserName(transferDto.getMoney(), transferDto.getUserName(), transferDto.getTransferee());
        if (!b) {
            throw new TgpException(201, "取款失败");
        }
        return Result.ok("取款成功");
    }

    @ResponseBody
    @PostMapping("/modify")
    public Result modify(@RequestBody ModifyDto modifyDto, HttpSession session) {
        boolean b = userService.modifyUserMassage(modifyDto,session);
        if (!b) {
            throw new TgpException(201, "修改失败");
        }
        // 更新用户的信息
        User user = userService.getByUserName(modifyDto.getUserName());
        session.setAttribute("loginUser", user);
        return Result.ok("修改成功,请重新登录");
    }

    @ResponseBody
    @PostMapping("/updateUser")
    public Result updateUser(@RequestParam("userName") String userName) {
        boolean b = userService.updateUserMassage(userName);
        if (!b) {
            throw new TgpException(201, "修改失败");
        }
        return Result.ok("修改成功,请重新登录");
    }

    @ResponseBody
    @GetMapping("/updateBalance")
    public double updateBalance( HttpSession session) {
        User loginUser= (User) session.getAttribute("loginUser");
        String userName = loginUser.getUserName();
        User user = userService.getByUserName(userName);
        return user.getBalance();
    }
}
