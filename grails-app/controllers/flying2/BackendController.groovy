package flying2

import grails.converters.JSON
import img.ImageOperation
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.actuate.health.DataSourceHealthIndicator
import upLoad.ImgUploader

class BackendController {
    @Value('${filePath.tempImgPath}')
    String tempImgPath
    @Value('${filePath.showImgPath}')
    String showImgPath
    @Value('${filePath.homeImgPath}')
    String homeImgPath

    static defaultAction = "allProductions"
    def backendService

    def allProductions() {
        def products = Product.list()
        int photoCount = Product.countByType("photo")
        int videoCount = Product.countByType("video")
        def recommends = Recommend.list()
        [products: products, photoCount: photoCount, videoCount: videoCount, recommends: recommends]
    }

    def delProduct() {
        def m = [:]
        try {
            def p = DataSourceHealthIndicator.Product.get(params.pid)
            def r = Recommend.findByProduct(p)
            if (r) {
                m = [status: "recommend"]
            }else{
                p.delete()
                m = [status: "ok"]
            }
        } catch (Exception e) {
            m = [status: "failed"]
        }
        render m as JSON
    }

    def createProduct() {
        params.type!="photo"&&params.type!="video"?params.type="photo":""
        String backUserName = session.backUser.username
        String tempFolderName = System.currentTimeMillis()
        String folder = backUserName+"_"+params.type+"_"+tempFolderName
        String newTempFolder = tempImgPath+File.separator+folder
        new File(newTempFolder).mkdir()
        [folder: folder]
//        String tempFile = "o_1463409038736.JPG"
//        println tempFile.substring(2, tempFile.length())

//        println "tempImgPath is:"+tempImgPath
    }

    def uploadImg() {
        String info
        String oImg = ImgUploader.upLoadImg(tempImgPath+File.separator+params.folder, request)
        String upLoadedImg = tempImgPath+File.separator+params.folder+File.separator+oImg
        int oImgWidth = ImageOperation.getImgSize(upLoadedImg).width
//        中等图片
//        int mediumMaxWidth = 1200
        int mediumMaxWidth = 800
        String noDecorationImgName = oImg.substring(2, oImg.length())
        if (oImgWidth > mediumMaxWidth) {
            String mediumImg = "medium_"+noDecorationImgName
            info = noDecorationImgName
            ImageOperation.cutImage(mediumMaxWidth, upLoadedImg, tempImgPath+File.separator+params.folder+File.separator+mediumImg)
//            大图片
//            int largeMaxWidth = 1920
            int largeMaxWidth = 1000
            if (oImgWidth > largeMaxWidth) {
                String largeImg = "large_"+noDecorationImgName
                ImageOperation.cutImage(largeMaxWidth, upLoadedImg, tempImgPath+File.separator+params.folder+File.separator+largeImg)
            }
        }else{
            info = "sizeNotReached"
        }
        render info
    }

    def cropCoverImg() {
        String coverImg = "c_"+params.imgName
        String newImgLocation = tempImgPath+File.separator+params.folder+File.separator+coverImg
        String imgLocation = tempImgPath+File.separator+params.folder+File.separator+"medium_"+params.imgName
//        String newWholeImgLocation = tempImgPath+"\\"+newImgLocation
        int oImgWidth = ImageOperation.getImgSize(imgLocation).width
        def scaling = oImgWidth/params.iWidth.toDouble()
        ImageOperation.cropImage(
                imgLocation,
                newImgLocation,
                400,
                (params.x1.toDouble()*scaling).toInteger(),
                (params.y1.toDouble()*scaling).toInteger(),
                (params.x2.toDouble()*scaling).toInteger(),
                (params.y2.toDouble()*scaling).toInteger()
        )
        render coverImg
    }
//    def upLoadBeautyImg() {
//        String fName = params.fName
//        String imgPath = tempImgPath+File.separator+fName
//        def uploadedImgName = ImgUploader.upLoadImg(imgPath, request)
//        String prefix = "s_"
//        def uploadedImgLocation = imgPath+File.separator+uploadedImgName
//        int oImgWidth = ImageOperation.getImgWidth(uploadedImgLocation)
//        int maxWidth = 810
//        def showImgName = prefix+uploadedImgName
//        def finalImgLocation = imgPath+File.separator+showImgName
//        if (oImgWidth > maxWidth) {
//            ImageOperation.cutImage(maxWidth, uploadedImgLocation, finalImgLocation)
//            render fName+File.separator+showImgName
//        }else{
//            render fName+File.separator+uploadedImgName
//        }
//    }

    def doCreate() {
        def tip = [:]
        try {
            String type = params.type
//            new Video(params).save()
            def imgPath = [tempImgPath: tempImgPath, showImgPath: showImgPath]
            def userId = session.backUser.id
            if (type == "photo") {
                backendService.createPhoto(params, userId, imgPath)
            }else if (type == "video") {
                backendService.createVideo(params, userId, imgPath)
            }
            tip.status = "success"
            tip.content = "成功啦！"
        } catch (Exception e) {
            e.printStackTrace()
            tip.status = "failed"
            tip.content = "保存失败！"
        }
        render(view: "/backend/statusTips", model: [tip: tip])
    }

    def addToPreRecommend() {
        def m = [:]
        try {
            int status = backendService.addToPreRecommend(params)
            m = [status: "ok", recommendStatus: status]
        } catch (Exception e) {
            m = [status: "failed"]
        }
        render m as JSON
    }

    def changeRecommendStatus() {
        def m = [:]
        try {
            int status = 1
            if (params.isRecommend=="true") {
                status = 0
            }
            def recommend = Recommend.get(params.rId)
            String type = recommend.product.type
            def typeRecommend = Recommend.findAll{
                product.type == type&&status == 1
            }
            if (status==0||typeRecommend.size() < 8) {
                if (recommend) {
                    recommend.status = status
                    recommend.save()
                }
                m = [status: "ok", recommendStatus: status]
            }else{
                status = 2
                m = [status: "ok", recommendStatus: status]
            }
        } catch (Exception e) {
            e.printStackTrace()
            m = [status: "failed"]
        }
        render m as JSON
    }
    def delRecommend() {
        def m = [:]
//        try {
//            def r = flying2.Recommend.get(params.rId)
//            if (r) {
//                def rh = new flying2.RecommendHistory(
//                        createDate: r.createDate,
//                        status: r.status,
//                        orderId: r.orderId,
//                        reason: r.reason,
//                        productName: r.product.name
//                )
//                rh.save()
//                if (rh) {
//                    r.delete()
//                    m = [status: "ok"]
//                }
//            }
//        } catch (Exception e) {
//            m = [status: "failed"]
//        }
        render m as JSON
    }


    def homeManage() {
        params.type!="banner"&&params.type!="recommend"?params.type="banner":""
        if (params.type == "recommend") {
            def recommends = Recommend.list()
            int photoCount = recommends.findAll {it.product.type=="photo"}.size()
            int videoCount = recommends.findAll {it.product.type=="video"}.size()
            [recommends: recommends, photoCount: photoCount, videoCount: videoCount]
        }
    }
    def uploadBannerImg() {
        String info
        String oImg = ImgUploader.upLoadImg(homeImgPath+File.separator, request)
        String upLoadedImg = homeImgPath+File.separator+File.separator+oImg
        int oImgWidth = ImageOperation.getImgSize(upLoadedImg).width
//        中等图片
        String noDecorationImgName = oImg.substring(2, oImg.length())
//            大图片
        int largeMaxWidth = 1920
        if (oImgWidth > largeMaxWidth) {
            info = noDecorationImgName
            String largeImg = "homeBanner_"+noDecorationImgName
            ImageOperation.cutImage(largeMaxWidth, upLoadedImg, homeImgPath+File.separator+File.separator+largeImg)
        }else{
            info = "sizeNotReached"
        }
        render info
    }
}
