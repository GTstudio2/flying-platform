package fetch

import file.ReadWriteFile
import org.jsoup.Connection
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.nodes.Element

/**
 * Created by nick on 2016/4/8.
 */
class Fetch {
    def static void main(String[] args) {
//        int bb = 0
//        for(i in 1..27){
//            int count = (int)((Math.random()*3)+1)
//            println count
//            bb += count
//        }
//        println bb
//        println new Date().format("yyyy-MM-dd HH:mm:ss")
//        println fetchBaiduBaike("高圆圆")
//        fetchImg("高圆圆")
//        fetch360Baike("高圆圆")
//        println fetch360Baike("秋山祥子")
//        println FontConverter.TraToSim("張三")
//        ReadWriteFile.writeData("start date:"+new Date())
//        fetchUberhumor("http://uberhumor.com/page/7383")
//        ReadWriteFile.writeData("end date:"+new Date())
        fetchImg('http://qzapp.qlogo.cn/qzapp/101360743/82E02411B6343B1B1BD5096FD16565CF/100', 'C:\\Users\\Administrator\\Desktop\\temp')
    }

    def static getDoc(url, charset) {
        Document doc = Jsoup.parse(new URL(url).openStream(), charset, url);
        doc
    }

    /**
     * 百度百科抓取
     */
    def static fetchBaiduBaike(searchName) {
        String baiduBaikeUrl = "http://baike.baidu.com/item/" + searchName
        def doc = getDoc(baiduBaikeUrl, "UTF-8")
        def briefPanel = doc.select(".basicInfo-block").size()
        def fetchBeauty = [:]
        if (briefPanel > 0) {
            Element[] names = doc.select(".basicInfo-item.name")
            Element[] values = doc.select(".basicInfo-item.value")

            for (int i = 0; i < names.size(); i++) {
                def name = names[i].text().replaceAll("    ", "")
                def curVal = values[i].text()
                if (name == "国籍") {
                    fetchBeauty.nationality = curVal
//                    println "国籍:"+values[i].text()
                } else if (name == "中文名") {
                    fetchBeauty.chineseName = curVal
//                    println "中文名:"+values[i].text()
                } else if (name == "外文名"||name == "英文名") {
                    fetchBeauty.englishName = curVal
//                    println "外文名:"+values[i].text()
                } else if (name == "别名") {
                    fetchBeauty.japaneseName = curVal
//                    println "别名:"+values[i].text()
                } else if (name == "身高") {
                    fetchBeauty.height = curVal
//                    println "外文名:"+values[i].text()
//                    println "身高:"+values[i].text()
                } else if (name == "罩杯") {
                    fetchBeauty.bust = curVal
//                    println "罩杯:"+values[i].text()
                } else if (name == "出生日期") {
                    fetchBeauty.birthday = curVal
//                    println "出生日期:"+values[i].text()
                } else if (name == "体重") {
                    fetchBeauty.weight = curVal
//                    println "体重:"+values[i].text()
                }
            }
        }
        fetchBeauty
    }

    def static fetchImg(String src, String imgPath) {
//        println "img src is ${src}, imgPath is :${imgPath}"
        if (src.length()>0) {
            def flag = ""
            OutputStream os
            try {
                File f = new File(imgPath);
                if (!f.exists()) {
                    f.mkdirs()
                }
//            String src = e.attr("abs:src");//获取img中的src路径
                //获取后缀名
                String imageName = new Date().getTime()+".jpg"
//            String imageName = "1";
                //连接url
                URL url = new URL(src);
                URLConnection uri = url.openConnection();
                //获取数据流
                InputStream is = uri.getInputStream();
                //写入数据流
                os = new FileOutputStream(new File(imgPath, imageName));
                byte[] buf = new byte[1024];
                int l = 0;
                while ((l = is.read(buf)) != -1) {
                    os.write(buf, 0, l);
                }
                os.close()
                flag = imageName
            } catch (Exception e) {
                e.printStackTrace()
//                println "fetch img gone wrong,link is:" + src
                ReadWriteFile.writeData("fetch img gone wrong,link is:${src}")
            } finally {
                if (os) {
                    os.close()
                }
            }
            return flag
        }else{
            println "null url"
        }
    }

    def static fetchHeaderImg(String src, String imgPath) {
//        println "img src is ${src}, imgPath is :${imgPath}"
        if (src.length()>0) {
            def flag = ""
            OutputStream os
            try {
                File f = new File(imgPath);
                if (!f.exists()) {
                    f.mkdirs()
                }
//            String src = e.attr("abs:src");//获取img中的src路径
                //获取后缀名
                String imageName = src.substring(src.lastIndexOf(".") + 1, src.length());
                imageName = new Date().getTime() + "." + imageName
//            String imageName = "1";
                //连接url
                URL url = new URL(src);

                HttpURLConnection conn = (HttpURLConnection)url.openConnection();
                conn.setRequestMethod("GET");
                conn.setConnectTimeout(5 * 1000);
                conn.setRequestProperty("User-Agent","Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; en-US; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2");
//                URLConnection uri = url.openConnection();
                //获取数据流
                InputStream is = conn.getInputStream();
                //写入数据流
                os = new FileOutputStream(new File(imgPath, imageName));
                byte[] buf = new byte[1024];
                int l = 0;
                while ((l = is.read(buf)) != -1) {
                    os.write(buf, 0, l);
                }
                os.close()
                flag = imageName
            } catch (Exception e) {
                e.printStackTrace()
//                println "fetch img gone wrong,link is:" + src
                ReadWriteFile.writeData("fetch img gone wrong,link is:${src}")
            } finally {
                if (os) {
                    os.close()
                }
            }
            return flag
        }else{
            println "null url"
        }
    }

    def static fetch360Baike(searchName) {
        println "fetching..."
//        String baikeUrl = "http://baike.so.com/doc/search?word="+searchName
        String baikeUrl = "http://baike.so.com/doc/search"
//        String baikeUrl = "http://baike.so.com/doc/115692-122108.html"
//        def doc = getDoc(baikeUrl, "UTF-8")
        Document doc = Jsoup.connect(baikeUrl).header("yizhijoke.User-Agent", "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; en-US; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2").method(Connection.Method.POST)
                .data("word", searchName).timeout(30000).get() //需要模拟表单提交
        def baikeContent = doc.select("#baike-content")
        def fetchBeauty = [:]
        if (baikeContent.size() > 0) {
            Element[] baikelis = baikeContent.select(".bas-title")
            def baikelisSize = baikelis.size()
            Element[] infoDt = baikeContent.select("#basic-info dl>dt")
            Element[] infoCardlistName = baikeContent.select("#basic-info .cardlist-name")
            def stringContentList = []
            if (baikelisSize>0) {
                println "bas-title fetch......................."
                for (int i = 0; i < baikelis.size(); i++) {
                    def stringContent = [:]
                    stringContent.name = baikelis[i].select(".bas-title").text()
                    stringContent.value = baikelis[i].parent().select(".bas-cont").text()
                    stringContentList << stringContent
                }
            }else if(infoDt.size()>0){
                println "dl>dt fetch..................."
                for (int i = 0; i < infoDt.size(); i++) {
                    def stringContent = [:]
                    stringContent.name = infoDt[i].text()
                    stringContent.value = infoDt[i].parent().select("dd").text()
                    stringContentList << stringContent
                }
            }else if(infoCardlistName.size()>0){
                println "cardlist-name fetch..................."
                for (int i = 0; i < infoCardlistName.size(); i++) {
                    def stringContent = [:]
                    stringContent.name = infoCardlistName[i].text()
                    stringContent.value = infoCardlistName[i].parent().select(".cardlist-value").text()
                    stringContentList << stringContent
                }
            }
            stringContentList.each { c->
                def name = c.name
                def value = c.value
                if (name == "国籍"||name=="国籍：") {
                    fetchBeauty.nationality = value
//                    println "国籍:"+values[i].text()
                } else if (name == "中文名"||name == "姓名"||name =="中文名：") {
                    fetchBeauty.chineseName = value
//                    println "中文名:"+values[i].text()
                } else if (name == "外文名"||name=="外文名："||name=="外文名称：") {
                    fetchBeauty.englishName = value
//                    println "外文名:"+values[i].text()
                } else if (name == "别名"||name =="别名：") {
                    fetchBeauty.japaneseName = value
//                    println "别名:"+values[i].text()
                } else if (name == "身高"||name == "身高：") {
                    fetchBeauty.height = value
//                    println "外文名:"+values[i].text()
//                    println "身高:"+values[i].text()
                } else if (name == "罩杯"||name == "罩杯：") {
                    fetchBeauty.bust = value
//                    println "罩杯:"+values[i].text()
                } else if (name == "出生日期"||name == "出生日期：") {
                    fetchBeauty.birthday = value
//                    println "出生日期:"+values[i].text()
                } else if (name == "体重"||name == "体重：") {
                    fetchBeauty.weight = value
//                    println "体重:"+values[i].text()
                }
//                println "cut line"
            }
        }
//        println fetchBeautyList
        fetchBeauty
    }


}
