package flying2

class ReplyComment {
    Date createDate = new Date()
    String content
    Boolean isChecked //如果此评论为回复评论，有一个被回复者的是否查看状态
    static belongsTo = [user: User, product: Product, comment: Comment]
    static constraints = {
    }
}
