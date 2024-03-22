package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author：陶广鹏
 * @Package：dto
 * @Project：Bank-system
 * @name：TransferDto
 * @Date：2023/9/13 19:10
 * @Filename：TransferDto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TransferDto {
    private Double money = 0.0;
    private String userName;
    private String passWord;
    private String transferee;
}
