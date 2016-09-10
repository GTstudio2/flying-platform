package flying2
class Photo {
    static belongsTo = [product: Product]
    static hasMany = [images: Image]

    static constraints = {
    }
}
