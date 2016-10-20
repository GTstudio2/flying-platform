package flying2

class MySpaceController {

    def home() {
//        def u = User.get(session.user?.id)
        def u
        if (params.id) {
            u = User.get(params.id)
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
        if (params.id) {
            u = User.get(params.id)
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

    def attentions() {
        User user
        if (params.id) {
            user = User.get(params.id)
        }else if (session.user) {
            user = User.get(session.user.id)
        }
//        user.attentions.each{
//            println it.attentionsCount
//        }
        def m = [:]
        m.user = user
        m
    }

    def manageProducts() {

    }
}
