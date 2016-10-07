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
        String tempImgPath = imgPath.tempImgPath
        String showImgPath = imgPath.showImgPath
        FileUtil.newFolder(showImgPath+File.separator+params.folder)
        FileUtil.moveFile(tempImgPath+separator+params.folder+separator+params.coverImg, showImgPath+separator+params.folder+separator+params.coverImg)
        if (index != -1) {
            stepImgList.each{ img->
//            移动中图、大图、原图
                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"o_"+img, showImgPath+separator+params.folder+separator+"o_"+img)
                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"medium_"+img, showImgPath+separator+params.folder+separator+"medium_"+img)
                FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"large_"+img, showImgPath+separator+params.folder+separator+"large_"+img)
                def imgSize = img.ImageOperation.getImgSize(showImgPath+separator+params.folder+separator+"large_"+img)
                new Image(img: img, largeWidth: imgSize.width, largeHeight: imgSize.height, photo: photo).save()
            }
        }else{
//            println "single"
            String img = stepImgList
            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"o_"+img, showImgPath+separator+params.folder+separator+"o_"+img)
            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"medium_"+img, showImgPath+separator+params.folder+separator+"medium_"+img)
            FileUtil.moveFile(tempImgPath+separator+params.folder+separator+"large_"+img, showImgPath+separator+params.folder+separator+"large_"+img)
            def imgSize = img.ImageOperation.getImgSize(showImgPath+separator+params.folder+separator+"large_"+img)
            new Image(img: img, largeWidth: imgSize.width, largeHeight: imgSize.height, photo: photo).save()
        }
    }

    def createVideo(params, imgPath) {
        Product p = new Product(params)
        Video v = new Video(params)
        p.video = v
        p.save()
        def separator = File.separator
        String tempImgPath = imgPath.tempImgPath
        String showImgPath = imgPath.showImgPath
        FileUtil.newFolder(showImgPath+File.separator+params.folder)
        FileUtil.moveFile(tempImgPath+separator+params.folder+separator+params.coverImg, showImgPath+separator+params.folder+separator+params.coverImg)
    }
}
