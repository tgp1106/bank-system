package com.tgp.bank.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.tgp.bank.mapper.UserOperationMapper;
import com.tgp.bank.service.UserOperationService;
import entity.UserOperation;
import org.springframework.stereotype.Service;
import utils.execption.TgpException;
import utils.result.ResultCodeEnum;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 关于废人张
 * @date 2024/3/23 15:47
 * @Description
 */
@Service
public class UserOperationServiceImpl implements UserOperationService {

    @Resource
    private UserOperationMapper userOperationMapper;

    @Override
    public void saveOperator(UserOperation operation) {
        if (ObjectUtil.isEmpty(operation.getOperation()) ||
                ObjectUtil.isEmpty(operation.getOperationUsername()) ||
                ObjectUtil.isEmpty(operation.getOperationAmount())) {
            throw new TgpException(ResultCodeEnum.SAVE_OPERATOR_ERROR);
        }
        userOperationMapper.insert(operation);
    }

    @Override
    public void batchSaveOperator(List<UserOperation> userOperationList) {
        if (!CollectionUtil.isEmpty(userOperationList)) {
            userOperationMapper.batchInsert(userOperationList);
        }
    }

    @Override
    public List<UserOperation> selectListByUsername(String username) {
        LambdaQueryWrapper<UserOperation> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserOperation::getTransferName,username).or().eq(UserOperation::getOperationUsername,username);
        return userOperationMapper.selectList(wrapper);
    }

}
