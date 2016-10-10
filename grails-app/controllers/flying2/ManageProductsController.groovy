package flying2

class ManageProductsController {
    def allProducts() {
        def products = Product.list()
        int photoCount = Product.countByType("photo")
        int videoCount = Product.countByType("video")
        [products: products, photoCount: photoCount, videoCount: videoCount]
    }
}
