package file

import java.text.SimpleDateFormat

/**
 * Created by nick on 2016/4/6.
 */
class ReadWriteFile {

    def static final FILE_PATH = "C:\\Users\\tarek\\Desktop\\aa.txt"
    //写文件，支持中文字符，在linux redhad下测试过
    public static void writeData(String str){
        try{
            File file=new File(FILE_PATH);
            if(!file.exists())
                file.createNewFile();
//            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            FileOutputStream out=new FileOutputStream(file,true); //如果追加方式用true
            StringBuffer sb=new StringBuffer();
//            sb.append("-----------"+sdf.format(new Date())+"------------\n");
            sb.append(str+"\n");
            out.write(sb.toString().getBytes("utf-8"));//注意需要转换对应的字符集
            out.close();
        }catch(IOException ex){
            System.out.println(ex.getStackTrace());
        }
    }
}
