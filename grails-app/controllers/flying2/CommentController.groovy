package flying2

import grails.converters.JSON

class CommentController {

    def getComments() {
        def product = Product.get(params.productId)
        int max = 10
        int offset = (Integer.parseInt(params.pageNo)-1)*max

        def comments = Comment.findAllByProduct(product, [offset: offset, max: max, sort: "createDate", order: "desc"])
        def totalComment = Comment.countByProduct(product)
        def m = [:]
        m.comments = comments
        m.totalComment = totalComment
        render m as JSON
    }
    def addComment() {
        def m = [:]
        def user = User.get(session.user.id)
        def product = Product.findByUserAndId(user, params.productId)
        if (product) {
            def comment = new Comment(content: params.comment, user: user, product: product).save()
            if (comment) {
                m.status = "success"
                m.id = comment.id
            }else{
                m.status = "failed"
                m.tips = "添加评论失败"
            }
        }else{
            m.status = "failed"
            m.tips = "添加评论失败"
        }
        render m as JSON
    }
}
