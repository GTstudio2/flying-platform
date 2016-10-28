package flying2

import file.FileUtil
import grails.transaction.Transactional

@Transactional
class CreationService {

    def createPhoto(params, userId, imgPath) {
        String folder = params.folder
        def user = User.get(userId)
        def stepImgList = params.stepImg
        Product p = new Product(user: user, type: "photo",coverImg: params.coverImg,folder: folder, name: params.name, intro: params.intro)
        Photo photo = new Photo(product: p)
        p.photo = photo
        p.save()
        int index = stepImgList.toString().indexOf(",")
        def separator = File.separator
//        String tempImgPath = imgPath.tempImgPath
        String showImgPath = imgPath.showImgPath
//        FileUtil.newFolder(showImgPath+File.separator+params.folder)
//        FileUtil.moveFile(tempImgPath+separator+params.folder+separator+params.coverImg, showImgPath+separator+params.folder+separator+params.coverImg)
        if (index != -1) {
            stepImgList.each{ img->
//            移动中图、大图、原图
//                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"o_"+img, showImgPath+separator+params.folder+separator+"o_"+img)
//                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"medium_"+img, showImgPath+separator+params.folder+separator+"medium_"+img)
//                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"large_"+img, showImgPath+separator+params.folder+separator+"large_"+img)
                def imgSize = img.ImageOperation.getImgSize(showImgPath+separator+params.folder+separator+"large_"+img)
                new Image(img: img, largeWidth: imgSize.width, largeHeight: imgSize.height, photo: photo).save()
            }
        }else{
//            println "single"
            String img = stepImgList
//            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"o_"+img, showImgPath+separator+params.folder+separator+"o_"+img)
//            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"medium_"+img, showImgPath+separator+params.folder+separator+"medium_"+img)
//            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"large_"+img, showImgPath+separator+params.folder+separator+"large_"+img)
            def imgSize = img.ImageOperation.getImgSize(showImgPath+separator+params.folder+separator+"large_"+img)
            new Image(img: img, largeWidth: imgSize.width, largeHeight: imgSize.height, photo: photo).save()
        }
    }
    def changePhoto(params, product, imgPath) {
        def stepImgList = params.stepImg
        product.coverImg = params.coverImg
        product.name = params.name
        product.intro = params.intro
//        Product p = new Product(type: "photo",coverImg: params.coverImg,folder: folder, name: params.name, intro: params.intro)
        Photo photo = product.photo
//        p.photo = photo
        product.save()
        int index = stepImgList.toString().indexOf(",")
        def separator = File.separator
//        String tempImgPath = imgPath.tempImgPath
        String showImgPath = imgPath.showImgPath
//        FileUtil.newFolder(showImgPath+File.separator+params.folder)
//        FileUtil.moveFile(tempImgPath+separator+params.folder+separator+params.coverImg, showImgPath+separator+params.folder+separator+params.coverImg)
        if (index != -1) {
            stepImgList.each{ img->
//            移动中图、大图、原图
//                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"o_"+img, showImgPath+separator+params.folder+separator+"o_"+img)
//                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"medium_"+img, showImgPath+separator+params.folder+separator+"medium_"+img)
//                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"large_"+img, showImgPath+separator+params.folder+separator+"large_"+img)
                def imgObj = Image.findByImg(img)
                if (!imgObj) {
                    def imgSize = img.ImageOperation.getImgSize(showImgPath+separator+product.folder+separator+"large_"+img)
                    new Image(img: img, largeWidth: imgSize.width, largeHeight: imgSize.height, photo: photo).save()
                }
            }
        }else{
//            println "single"
            String img = stepImgList
//            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"o_"+img, showImgPath+separator+params.folder+separator+"o_"+img)
//            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"medium_"+img, showImgPath+separator+params.folder+separator+"medium_"+img)
//            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"large_"+img, showImgPath+separator+params.folder+separator+"large_"+img)
            def imgObj = Image.findByImg(img)
            if (!imgObj) {
                def imgSize = img.ImageOperation.getImgSize(showImgPath + separator + product.folder + separator + "large_" + img)
                new Image(img: img, largeWidth: imgSize.width, largeHeight: imgSize.height, photo: photo).save()
            }
        }
    }

    def createVideo(params, userId, imgPath) {
        def user = User.get(userId)
        String folder = params.folder
        Product p = new Product(user: user, type: "video",coverImg: params.coverImg,folder: folder, name: params.name, intro: params.intro)
        Video v = new Video(params)
        p.video = v
        p.save()
//        def separator = File.separator
//        String tempImgPath = imgPath.tempImgPath
//        String showImgPath = imgPath.showImgPath
//        FileUtil.newFolder(showImgPath+File.separator+params.folder)
//        FileUtil.moveFile(tempImgPath+separator+params.folder+separator+params.coverImg, showImgPath+separator+params.folder+separator+params.coverImg)
    }
    def changeVideo(params, product, imgPath) {
        product.coverImg = params.coverImg
        product.name = params.name
        product.intro = params.intro
//        Product p = new Product(type: "video",coverImg: params.coverImg,folder: folder, name: params.name, intro: params.intro)
//        Video v = new Video(params)
        product.video.url = params.url
        product.save()
//        def separator = File.separator
//        String tempImgPath = imgPath.tempImgPath
//        String showImgPath = imgPath.showImgPath
//        FileUtil.newFolder(showImgPath+File.separator+params.folder)
//        FileUtil.moveFile(tempImgPath+separator+params.folder+separator+params.coverImg, showImgPath+separator+params.folder+separator+params.coverImg)
    }
}
