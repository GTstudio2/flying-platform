package flying2

import grails.converters.JSON

class UserController {

    def attentionTo() {
        User user = User.get(session.user?.id)
        def m = [:]
        if(!user){
            m.status = "failed"
            m.tip = "noUser"
        }else{
            User attentionUser = User.get(params.attentionId)
            if (attentionUser) {
                def attention =  user.attentions.find{
                    it.id as String == params.attentionId
                }
                if (attention) {
                    user.attentions.remove(attention)
                    attention.removeFromFans(user)
                    m.action = 'remove'
                }else{
                    user.addToAttentions(attentionUser)
//                    user.attentions.add(attentionUser)
                    attentionUser.addToFans(user)
//                    attentionUser.fans.add(user)
                    m.action = 'add'
                }
//                println 'fans count:'+attentionUser.fans.size()
                attentionUser.fansCount = attentionUser.fans.size()
                user.attentionsCount = user.attentions.size()
                user.save()
                m.status = "success"
            }else{
                m.status = "failed"
                m.msg = "被关注者不存在"
            }
        }
        render m as JSON
    }
}
