package entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * @author 关于废人张
 * @date 2024/3/23 1:07
 * @Description 定时发布
 */
@Data
@TableName("schedule_announcements")
@Accessors(chain = true)
public class ScheduledAnnouncements {
    private int id;
    private String content;
    private String author;
    private Date publishedAt;

}
