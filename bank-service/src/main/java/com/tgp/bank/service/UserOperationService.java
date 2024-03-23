package com.tgp.bank.service;

import entity.UserOperation;

import java.util.List;

/**
 * @author 关于废人张
 * @date 2024/3/23 15:46
 * @Description 用户操作日志记录
 */
public interface UserOperationService {

    void saveOperator(UserOperation operation);

    void batchSaveOperator(List<UserOperation> userOperationList);

    List<UserOperation> selectListByUsername(String username);

}
