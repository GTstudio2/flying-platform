package img

/**
 * Created by tarek on 2015/8/23.
 */
class ImageTools {
    def static showImg(imgPath, imgName, response) {
        try {
            if (imgName!=""&&new File(imgPath + "/" + imgName).exists()) {
                def is = new FileInputStream(imgPath + "/" + imgName);
                def len = is.available()
                byte[] data = new byte[len];
                for (int i = 0; i < len; i++) {
                    data[i] = (byte) is.read()
                }
                response.setContentType("image/*"); // 设置返回的文件类型
                def toClient = response.getOutputStream(); // 得到向客户端输出二进制数据的对象
                toClient.write(data); // 输出数据
                toClient.close()
                is.close();
            }else{
                return "failed"
            }
        }catch (Exception e){
            e.printStackTrace()
        }
    }
}
