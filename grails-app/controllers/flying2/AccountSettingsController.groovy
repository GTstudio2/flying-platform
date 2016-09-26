package flying2

import grails.converters.JSON

class AccountSettingsController {

    /**
     * 基本信息
     */
    def basicInfo() {
    }

    /**
     * 安全设置
     */
    def security() {}

    /**
     * 空间首页展示方式
     */
    def homeDisplayWay() {
        def u = User.get(session.user?.id)
        def products = Product.findAllByUser(u, [max: 10])
        [products: products, user: u]
    }

    def allProducts() {
        println 234
        def products = Product.list()
        def recordsTotal = products.size()
        def m = [:]
        m.recordsTotal = recordsTotal
        m.recordsFiltered = recordsTotal
        m.data = products
        render m as JSON
    }
}
