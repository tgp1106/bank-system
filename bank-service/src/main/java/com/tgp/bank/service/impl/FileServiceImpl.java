package com.tgp.bank.service.impl;

import com.tgp.bank.service.FileService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import utils.execption.TgpException;
import utils.result.ResultCodeEnum;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @author 关于废人张
 * @date 2024/3/23 12:27
 * @Description
 */
@Service
public class FileServiceImpl implements FileService {

    @Value("${upload.prefix}")
    private String uploadMkdir;

    private final static Object lock = new Object();

    ExecutorService executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());

    @Override
    public String uploadFile(MultipartFile file) {
        File folder = new File(uploadMkdir);
        // 检查文件夹是否存在
        synchronized (lock) {
            if (!folder.exists()) {
                folder.mkdirs();
            }
        }
        String fileName = UUID.randomUUID().toString() + file.getOriginalFilename().replace("-", "_");
        executorService.execute(() -> {
            File dest = new File(uploadMkdir + fileName);
            try {
                file.transferTo(dest);
            } catch (IOException e) {
                e.printStackTrace();
                throw new TgpException(ResultCodeEnum.UPLOAD_ERROR);
            }
        });
        return fileName;
    }

    @Override
    public byte[] getImage(String imageName) {
        String imagePath = uploadMkdir + imageName; // 指定本地图片的路径
        File imageFile = new File(imagePath);
        try (FileInputStream fis = new FileInputStream(imageFile)) {
                return IOUtils.toByteArray(fis);
        } catch (IOException e) {
            e.printStackTrace();
            throw new TgpException(ResultCodeEnum.LOAD_ERROR);
        }
    }
}
