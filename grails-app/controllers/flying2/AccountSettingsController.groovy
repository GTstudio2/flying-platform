package flying2

import grails.converters.JSON
import img.ImageOperation
import org.springframework.beans.factory.annotation.Value
import upLoad.ImgUploader

import java.text.SimpleDateFormat

class AccountSettingsController {
    @Value('${filePath.headImgPath}')
    String headImgPath
    def accountService
    def mailService

    /**
     * 基本信息
     */
    def basicInfo() {
        def user = User.get(session.user.id)
        [user: user]
    }

    def resetBasicInfo() {
        User user = User.get(session.user.id)
        def m = [:]
        def birthday
        try {
            birthday = new SimpleDateFormat('yyyy-MM-dd').parse(params.birthday)
        }catch (Exception e){
            m.status = "failed"
            m.tip = "birthday is not valid"
        }
        user.username = params.username
        user.birthday = birthday
        user.sex = Integer.parseInt(params.sex)
        user.save()
        if (user) {
            m.status = "success"
            m.tip = "修改成功"
        }else{
            m.status = "failed"
            m.tip = "修改失败"
        }
        m
    }

    def changeHead() {
        String user = session.user.username
        String tempFolderName = System.currentTimeMillis()
        String folder = user+"_"+tempFolderName
        String newTempFolder = headImgPath+File.separator+folder
        new File(newTempFolder).mkdir()
        def u = User.get(session.user.id)
        [folder: folder, user: u]
    }
    def uploadImg() {
        String info
        String oImg = ImgUploader.upLoadImg(headImgPath+File.separator+params.folder, request)
        String upLoadedImg = headImgPath+File.separator+params.folder+File.separator+oImg
        int oImgWidth = ImageOperation.getImgSize(upLoadedImg).width
//        中等图片
//        int mediumMaxWidth = 1200
        int mediumMaxWidth = 600
        String noDecorationImgName = oImg.substring(2, oImg.length())
        if (oImgWidth > mediumMaxWidth) {
            String mediumImg = "medium_"+noDecorationImgName
            info = noDecorationImgName
            ImageOperation.cutImage(mediumMaxWidth, upLoadedImg, headImgPath+File.separator+params.folder+File.separator+mediumImg)
        }else{
            info = "sizeNotReached"
        }
        render info
    }
    def cropHeadImg() {
        String coverImg = params.imgName
        String newImgLocation = headImgPath+File.separator+params.folder+File.separator+coverImg
        String imgLocation = headImgPath+File.separator+params.folder+File.separator+"medium_"+params.imgName
//        String newWholeImgLocation = showImgPath+"\\"+newImgLocation
        int oImgWidth = ImageOperation.getImgSize(imgLocation).width
        def scaling = oImgWidth/params.iWidth.toDouble()
        ImageOperation.cropImage(
                imgLocation,
                newImgLocation,
                100,
                (params.x1.toDouble()*scaling).toInteger(),
                (params.y1.toDouble()*scaling).toInteger(),
                (params.x2.toDouble()*scaling).toInteger(),
                (params.y2.toDouble()*scaling).toInteger()
        )
        render coverImg
    }

    def updateHeadImg() {
        User user = User.get(session.user.id)
        def m = [:]
        user.headImg = params.headImg
        user.folder = params.folder
        user.save()
        if (user) {
            m.status = "success"
            m.tip = "修改成功"
        }else{
            m.status = "failed"
            m.tip = "修改失败"
        }
        m
    }

    /**
     * 安全设置
     */
    def security() {}

    def sendVerifyCodeEmail() {
        println 'sending...'
        mailService.sendMail {
            to "963008227@qq.com"
            from "tjtj54tj@163.com"
            subject "Hello John"
            text "this is some text"
        }
        println '...done'
    }
    /**
     * 空间首页展示方式
     */
    def homeDisplayWay() {
        def u = User.get(session.user?.id)
        def products = Product.findAllByUser(u, [max: 10])
        [products: products, user: u]
    }

    def userHomeShow() {
        def u = User.get(session.user?.id)
        def userHomeShowList = UserHomeShow.findAllByUser(u)
        def show = userHomeShowList.collect{ show->
            return [product: show.product]
        }
        def products = []
        show.each {
            products << it.product
        }
//        JSON.use('deep'){
//            render product as JSON
//        }
//        JSON.registerObjectMarshaller(UserHomeShow){ return Product of product}
        render products as JSON
    }

    def updateUserHomeShow() {
        def user = User.get(session.user?.id)
        def m = [:]
        if(!user){
            m.status = "failed"
            m.msg = "noUser"
            render m as JSON
            return
        }
        def product = Product.get(params.pId)
        if (params.shown!="true") {
            def count = UserHomeShow.countByProduct(product)
            if (!count) {
                new UserHomeShow(product: product, user: user).save()
                product.homeShow = 1
                m.status = "success"
            }else{
                def show = UserHomeShow.findByProduct(product)
                show.delete()
                product.homeShow = 0
                m.status = "success"
            }
        }else{
            def show = UserHomeShow.findByProduct(product)
            if (show) {
                show.delete()
                product.homeShow = 0
                m.status = "success"
            }else{
                m.stauts = "failed"
                m.msg = "未找到作品！"
            }
        }
        render m as JSON
    }

    def allProducts() {
        def tableParams = JSON.parse(params.p)
        def createDateSort = "asc"
        if(tableParams.columns[3].orderable){
            createDateSort = tableParams.order[0].dir
        }
        def products = Product.findAllByStatus(1, [offset: tableParams.start, max: tableParams.length, sort: "createDate", order: createDateSort])
        def recordsTotal = Product.countByStatus(1)
        def m = [:]
        m.recordsTotal = recordsTotal
        m.recordsFiltered = recordsTotal
        m.data = products
        render m as JSON
    }
}
