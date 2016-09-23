package flying2

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
}
