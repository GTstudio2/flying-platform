package upLoad

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

/**
 * upload image
 * Created by tarek on 2015/8/23.
 */
class ImgUploader {
    /**
     * 上传图片
     * @return
     * @throws Exception
     */
    def static String upLoadImg(imgPath, request) {
        try{
            def finalImgName = ""
            def prefix = "o_"
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap()
            for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
                MultipartFile mf = entity.getValue()
                //得到文件名称
                String fileName = mf.getOriginalFilename()
                //得到文件的后缀名
                String suffix = fileName.substring(fileName.lastIndexOf("."))
                //获取新的文件名称
                String newImgName = System.currentTimeMillis();

                finalImgName = prefix+newImgName+suffix
                if(mf.getSize()>0) {
                    InputStream stream = mf.getInputStream()
                    FileOutputStream fs = new FileOutputStream(imgPath +"/"+ finalImgName);
                    byte[] buffer = new byte[1024 * 1024];
                    int bytesum = 0;
                    int byteread = 0;
                    while ((byteread = stream.read(buffer)) != -1) {
                        bytesum += byteread;
                        fs.write(buffer, 0, byteread);
                        fs.flush();
                    }
                    fs.close();
                    stream.close();
                }
            }
            return finalImgName
        }catch (Exception e){
            e.printStackTrace()
        }
    }

}
