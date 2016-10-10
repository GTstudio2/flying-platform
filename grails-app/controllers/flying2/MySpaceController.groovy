package flying2

class MySpaceController {

    def home() {
//        def u = User.get(session.user?.id)
        def u
        if (params.userId) {
            u = User.get(params.userId)
        }else if (session.user) {
            u = User.get(session.user.id)
        }
        if (u) {
            def products = Product.findAllByUser(u, [max: 10])
            [products: products, user: u]
        }else{
            redirect(view: "404")
        }
    }

    def products() {
        def u
        if (params.userId) {
            u = User.get(params.userId)
        }else if (session.user) {
            u = User.get(session.user.id)
        }
        if (u) {
            def products
            def productCount
            params.max = 8
            products = Product.findAllByTypeAndUser(params.classify, u, params+[])
            productCount = Product.countByTypeAndUser(params.classify, u)
            [products: products, productCount: productCount, user: u]
        }else{
            redirect(view: "404")
        }
    }

    def manageProducts() {

    }
}
