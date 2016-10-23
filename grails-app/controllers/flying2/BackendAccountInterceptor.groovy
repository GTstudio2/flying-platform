package flying2


class BackendAccountInterceptor {
    BackendAccountInterceptor() {
        match(controller: "audit")
    }

    boolean before() {
        if (!session.backUser) {
            redirect(controller: 'account', action: 'backLogin', params: [isAlert: true])
            return false
        }
        true
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
