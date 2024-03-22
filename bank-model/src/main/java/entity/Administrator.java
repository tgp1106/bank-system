package entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 *
 * @TableName administrator
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Administrator implements Serializable {
    /**
     *
     */
    @TableId(value = "administrator_id", type = IdType.AUTO)
    private Long administratorId;

    /**
     *
     */

    private String administratorName;

    /**
     *
     */

    private String administratorPassword;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

}
