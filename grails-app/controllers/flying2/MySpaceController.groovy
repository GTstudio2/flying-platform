package flying2

class MySpaceController {

    def home() {
        def u = User.get(session.user?.id)
        def products = Product.findAllByUser(u, [max: 10])
        [products: products, user: u]
    }

    def products() {
        def u = User.get(session.user?.id)
        def products = []
        def productCount
        if (u) {
            params.max = 8
            products = Product.findAllByTypeAndUser(params.classify, u, params+[])
            productCount = Product.countByTypeAndUser(params.classify, u)
        }
        [products: products, productCount: productCount, user: u]
    }
}
