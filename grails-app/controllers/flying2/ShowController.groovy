package flying2

import img.ImageTools
import org.springframework.beans.factory.annotation.Value

class ShowController {
    @Value('${filePath.tempImgPath}')
    String tempImgPath
    @Value('${filePath.showImgPath}')
    String showImgPath
    @Value('${filePath.homeImgPath}')
    String homeImgPath

    def index() {
        def photoRecommends = Recommend.findAll{
            status == 1 && product.type == "photo"
        }
        def videoRecommends = Recommend.findAll{
            status == 1 && product.type == "video"
        }
        [photoRecommends: photoRecommends, videoRecommends: videoRecommends]
    }

    def productList() {
        params.max = 12
        params.type!="photo"&&params.type!="video"?params.type="photo":""
        def products = Product.findAllByType(params.type, [max: params.max, offset: params.offset])
        def productsCount = Product.countByType(params.type)
        [products: products, productsCount: productsCount]
    }
    def photoDetail() {
        def photoProduct = Product.findById(params.id)
        [photoProduct: photoProduct]
    }

    def videoDetail() {
        def videoProduct = Product.findById(params.id)
        [videoProduct: videoProduct]
    }

    def contactUs() {
        
    }

    def tempShowImg() {
        ImageTools.showImg(tempImgPath+File.separator, params.img, response)
    }
    def bannerShowImg() {
        ImageTools.showImg(homeImgPath+File.separator, params.img, response)
    }
    def showImg() {
        ImageTools.showImg(showImgPath+File.separator, params.img, response)
    }
}
