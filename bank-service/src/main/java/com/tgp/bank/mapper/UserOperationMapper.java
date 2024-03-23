package com.tgp.bank.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import entity.UserOperation;

import java.util.List;

/**
 * @author 关于废人张
 * @date 2024/3/23 15:58
 * @Description
 */
public interface UserOperationMapper extends BaseMapper<UserOperation> {
    void batchInsert(List<UserOperation> userOperationList);
}
