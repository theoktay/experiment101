import SpriteKit

class GameScene: SKScene {
    var portalTimer: Timer?
    var currentPortal: SKSpriteNode?

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        spawnPortal()
    }

    func spawnPortal() {
        portalTimer?.invalidate()
        currentPortal?.removeFromParent()
        let portal = SKSpriteNode(color: .cyan, size: CGSize(width: 80, height: 80))
        portal.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(portal)
        currentPortal = portal

        // Portal disappears after a short time
        portal.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            SKAction.fadeOut(withDuration: 0.2),
            SKAction.removeFromParent()
        ])) { [weak self] in
            self?.gameOver()
        }
    }

    func gameOver() {
        // Simple game over: restart from beginning
        run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5)
        ])) { [weak self] in
            self?.spawnPortal()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let portal = currentPortal, portal.contains(touches.first!.location(in: self)) {
            spawnPortal()
        } else {
            gameOver()
        }
    }
}
