package flying2
class Product {
    Date createDate = new Date()
    String folder
    String coverImg
    String name
    String intro
    String type

    static belongsTo = [user: User]
    static hasOne = [photo: Photo,video: Video]
    static constraints = {
        photo nullable: true
        video nullable: true
        intro nullable: true
    }
}
