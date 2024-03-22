package entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 *
 * @TableName administrator
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Transaction {

    @TableId(value = "transaction_id", type = IdType.AUTO)
    private Long transaction_id;
    private String deposit;
    private Double money;
    private LocalDateTime currentTime;


}
