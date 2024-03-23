package com.tgp.bank.controller;

import com.tgp.bank.service.FileService;
import org.apache.commons.io.IOUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import utils.result.Result;
import utils.result.ResultCodeEnum;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * @author 关于废人张
 * @date 2024/3/23 12:22
 * @Description 文件控制器
 */
@RestController
public class FileController {

    @Resource
    private FileService fileService;

    /**
     * 文件上传，并且返回文件访问地址
     */
    @PostMapping("/uploadFile")
    public Result<String> uploadFile(@RequestBody MultipartFile file) {
        if (file.isEmpty()) {
            return Result.fail();
        }
        String fileUrl = fileService.uploadFile(file);
        return Result.build(fileUrl, ResultCodeEnum.SUCCESS);
    }


    @RequestMapping("/imageProxy")
    @ResponseBody
    public byte[] getImage(@RequestParam("imageName") String imageName) {
        return fileService.getImage(imageName);
    }

}
