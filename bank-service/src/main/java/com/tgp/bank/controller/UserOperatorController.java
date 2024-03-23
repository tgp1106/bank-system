package com.tgp.bank.controller;

import com.tgp.bank.service.UserOperationService;
import entity.UserOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import utils.result.Result;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 关于废人张
 * @date 2024/3/23 14:56
 * @Description
 */
@RestController
public class UserOperatorController {

    @Resource
    private UserOperationService userOperationService;

    @GetMapping("/getOperatorList")
    public Result<List<UserOperation>> getOperatorList(@RequestParam("username") String username) {
        return Result.build(userOperationService.selectListByUsername(username));
    }

}
