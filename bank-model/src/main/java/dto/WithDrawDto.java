package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WithDrawDto {

    private Double money = 0.0;
    private String username;
    private String password;


}
