package img

import grails.util.Environment
import org.im4java.core.ConvertCmd
import org.im4java.core.IMOperation
import org.im4java.core.Info

class ImageOperation {
    static String imageMagickPath = "C:\\Program Files\\ImageMagick-6.9.3-Q16"
    static {
        if (Environment.current == Environment.PRODUCTION) {
            imageMagickPath = "C:\\Program Files (x86)\\ImageMagick-6.3.8-Q16"
        }
    }

    /**
     * ImageMagick的路径
     */
//    public static final String IMAGE_MAGICK_PATH = "D:\\Software\\developInstalled\\ImageMagick-6.9.0-Q8";
//    public static final String IMAGE_MAGICK_PATH = "C:\\Program Files\\ImageMagick-6.9.3-Q16"; //production imagemagick path
    static{
        /**
         * 获取ImageMagick的路径
         */
        //Properties prop = new PropertiesFile().getPropertiesFile();
        //linux下不要设置此值，不然会报错
        //IMAGE_MAGICK_PATH = prop.getProperty("IMAGE_MAGICK_PATH");
    }

    /**
     * 根据坐标裁剪图片
     *
     * @param srcPath   要裁剪图片的路径
     * @param newPath   裁剪图片后的路径
     * @param x   起始横坐标
     * @param y   起始挫坐标
     * @param x1  结束横坐标
     * @param y1  结束挫坐标
     */
    public static void cropImage(String srcPath, String newPath, int maxWidth, int x1, int y1, int x2,
                                 int y2)  throws Exception {
        int width = x2 - x1;
        int height = y2 - y1;
        IMOperation op = new IMOperation();
        op.addImage(srcPath);
        /**
         * width：裁剪的宽度
         * height：裁剪的高度
         * x：裁剪的横坐标
         * y：裁剪的挫坐标
         */
//        println width
//        println height
        op.crop(width, height, x1, y1);
        op.resize(maxWidth, null);
        op.addImage(newPath);
        ConvertCmd convert = new ConvertCmd();
        //linux下不要设置此值，不然会报错
        convert.setSearchPath(imageMagickPath);
        convert.run(op);
    }

    /**
     * 根据尺寸缩放图片
     * @param width  缩放后的图片宽度
     * @param height  缩放后的图片高度
     * @param srcPath   源图片路径
     * @param newPath   缩放后图片的路径
     */
    public static void cutImage(int width, int height, String srcPath, String newPath) throws Exception {
        IMOperation op = new IMOperation();
        op.addImage(srcPath);
        op.resize(width, height);
        op.addImage(newPath);
        ConvertCmd convert = new ConvertCmd();
        //linux下不要设置此值，不然会报错
        convert.setSearchPath(imageMagickPath);
        convert.run(op);
    }


    /**
     * 根据宽度缩放图片
     * @param width  缩放后的图片宽度
     * @param srcPath   源图片路径
     * @param newPath   缩放后图片的路径
     */
    public static void cutImage(int width, String srcPath, String newPath) throws Exception {
        IMOperation op = new IMOperation();
        op.addImage(srcPath);
        op.resize(width, null);
        op.addImage(newPath);
        ConvertCmd convert = new ConvertCmd();
        //linux下不要设置此值，不然会报错
        convert.setSearchPath(imageMagickPath);
        convert.run(op);
    }

    /**
     * 给图片加水印
     * @param srcPath   源图片路径
     */
    public static void addImgText(String srcPath) throws Exception {
        IMOperation op = new IMOperation();
        op.font("宋体").gravity("southeast").pointsize(18).fill("#BCBFC8").draw("text 5,5 juziku.com");

        op.addImage();
//        op.addImage();
        ConvertCmd convert = new ConvertCmd();

        //linux下不要设置此值，不然会报错
        convert.setSearchPath(imageMagickPath);

        convert.run(op,srcPath,srcPath);
    }


    def static getImgSize(String srcPath) throws Exception {
        IMOperation op = new IMOperation();
        op.addImage(srcPath);
        op.autoOrient()
        op.addImage(srcPath);
        ConvertCmd convert = new ConvertCmd();
        //linux下不要设置此值，不然会报错
        convert.setSearchPath(imageMagickPath);
        convert.run(op);
        Info info = new Info(srcPath);
        int width = info.getImageWidth();
        int height = info.getImageHeight();
        [width: width, height: height]
    }


    public static void main(String[] args) throws Exception{
//        println imageMagickPath
//        cutImage("images/20071029192539752_2.jpg", "images/new.jpg", 0, 0, 20, 20);
//        cutImage(810, "C:\\Users\\Administrator\\Desktop\\1.jpg", "C:\\Users\\Administrator\\Desktop\\new2.JPG");
        println getImgSize("C:\\Users\\Administrator\\Desktop\\1.jpg")
//        addImgText("C:\\Users\\Administrator\\Desktop\\temp\\scenery\\13.jpg");
//        IMOperation op = new IMOperation()
//        op.addImage("D:\\360cloud\\photos\\temp\\oma2.jpg")
//        op.autoOrient()
//        op.addImage("D:\\360cloud\\photos\\temp\\oriented-oma.jpg");
//        ConvertCmd convert = new ConvertCmd();
//        convert.setSearchPath(IMAGE_MAGICK_PATH);
//        convert.run(op);
//        println "hello"
//        cropImage("D:\\360cloud\\photos\\temp\\oma2.jpg", "D:\\360cloud\\photos\\temp\\c_oma2.jpg", 100, 100, 200, 200)
    }
}
