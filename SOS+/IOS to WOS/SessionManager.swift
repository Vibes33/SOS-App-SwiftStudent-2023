import WatchConnectivity

class SessionManager: NSObject, WCSessionDelegate, ObservableObject {
    
    static let shared = SessionManager()
    
    private override init() {
        super.init()
    }
    
    func startSession() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch session activated with state \(activationState.rawValue)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Received message on watch: \(message)")
   
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session Innactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("Session désactivée")
    }
    
}
