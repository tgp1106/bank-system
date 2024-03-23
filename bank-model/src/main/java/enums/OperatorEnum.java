package enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author 关于废人张
 * @date 2024/3/23 16:05
 * @Description
 */
@Getter
@AllArgsConstructor
public enum OperatorEnum {

    DEPOSIT("存款",0),
    WITHDRAW("取款",1),
    TRANSFER("转账",2);

    private String operator;
    private Integer code;

}
