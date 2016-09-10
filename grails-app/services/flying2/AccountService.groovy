package flying2

import grails.transaction.Transactional

@Transactional
class AccountService {

    def isRepeat(str, type) {
        def u
        if(type=="username"){
            u = User.findByUsername(str)
        }else if(type=="email"){
            u = User.findByEmail(str)
        }
        if(u){
            return true
        }else{
            return false
        }
    }
}
