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
    @Value('${filePath.headImgPath}')
    String headImgPath

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
        def product = Product.findById(params.id)
        def userId = session.user?.id
        def user
        if (userId) {
            user = User.get(userId)
        }
        [product: product, user: user]
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

    def headImg() {
        ImageTools.showImg(headImgPath+File.separator, params.img, response)
    }
}
