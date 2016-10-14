package flying2

class Comment {
    Date createDate = new Date()
    String content
    static belongsTo = [user: User, product: Product]
    static constraints = {
    }
}
