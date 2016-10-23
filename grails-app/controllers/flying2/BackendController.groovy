package flying2

import grails.converters.JSON
import img.ImageOperation
import org.springframework.beans.factory.annotation.Value
import upLoad.ImgUploader

class BackendController {
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
        def m
        try {
            def p = Product.get(params.pid)
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

    def addToPreRecommend() {
        def m
        try {
            int status = backendService.addToPreRecommend(params)
            m = [status: "ok", recommendStatus: status]
        } catch (Exception e) {
            m = [status: "failed"]
        }
        render m as JSON
    }

    def changeRecommendStatus() {
        def m
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

    def auditProduct() {

    }


    def getAllProducts() {
        params.max = 8
        def tableParams = JSON.parse(params.p)
        def status
        switch (params.status){
            case 'notAudit': status = 0
                break
            case 'auditLater': status = 4
                break
            case 'appeal': status = 5
                break
            case 'auditProhibit': status = 6
                break
            case 'auditFailed': status = 3
                break
            case 'auditSuccess': status = 1
                break
            default: status = 'all'
        }

        def createDateSort = "asc"
        def sorts = []
        tableParams.columns.each { col ->
            sorts << col
        }
        def sort = tableParams.order[0].dir
        def orderIndex = tableParams.order[0].column
        def products = Product.createCriteria().list([offset: tableParams.start, max: tableParams.length]){
            if(status!="all"){
                eq("status", status)
            }
            order(sorts[orderIndex].data, sort)
        }
//        def products = Product.findAllByStatus(status ,[offset: tableParams.start, max: tableParams.length, sort: sorts[orderIndex].data, order: sort])
//        def recordsTotal = Product.countByStatus(status)
        def recordsTotal = Product.createCriteria().get{
            projections {
                count('id')
            }
            if(status!="all"){
                eq("status", status)
            }
        }
        def m = [:]
        m.recordsTotal = recordsTotal
        m.recordsFiltered = recordsTotal
        m.data = products
        render m as JSON
    }
    def getProduct() {
        def m = [:]
        Product productTmp = Product.get(params.id)
        def product = productTmp.collect{ product->
            [
                user: product.user,
                type: product.type,
                folder: product.folder,
                name: product.name,
                intro: product.intro,
                photo: product.photo?.images,
                audits: product.audits
            ]
        }
//        def audits = product[0].audits
//        audits.sort{ x, y->
//            x.createDate<=>y.createDate
//        }
//        println '-----------'
//        audits.each{
//            println it.createDate
//        }
        def audits = Audit.findAllByProduct(productTmp, [sort: 'createDate', order: 'desc'])
        m.product = product[0]
        m.audits = audits
        if(params.isAjax=='1'){
            render m as JSON
        }else{
            return m
        }
    }
}
