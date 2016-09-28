package flying2

class UserHomeShow {
    Date createDate = new Date()

    static belongsTo = [product: Product, user: User]
    static constraints = {
    }
}
