package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author：陶广鹏
 * @Package：com.tgp.bank.dto
 * @Project：Bank-system
 * @name：DepositDto
 * @Date：2023/9/12 23:11
 * @Filename：DepositDto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DepositDto {

    private Double money = 0.0;
    private String username;
    private String password;



}


