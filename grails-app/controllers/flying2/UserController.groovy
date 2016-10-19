package flying2

import grails.converters.JSON

class UserController {

    def attentionTo() {
        User user = User.get(session.user?.id)
        def m = [:]
        if(!user){
            m.status = "failed"
            m.msg = "noUser"
        }else{
            User attentionUser = User.get(params.attentionId)
            if (attentionUser) {
                def attention =  user.attentions.find{
                    it.id as String == params.attentionId
                }
                if (attention) {
                    user.attentions.remove(user.get(params.attentionId))
                    m.action = 'remove'
                }else{
                    user.attentions.add(attentionUser)
                    m.action = 'add'
                }
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
