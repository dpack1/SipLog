import SwiftUI

struct BubblesAnimationView: View {
    let numberOfBubbles: Int
    let bubbleMinSize: CGFloat
    let bubbleMaxSize: CGFloat
    let bubbleMinSpeed: Double
    let bubbleMaxSpeed: Double

    @State private var bubbleData: [BubbleData] = []

    init(numberOfBubbles: Int, bubbleMinSize: CGFloat = 10, bubbleMaxSize: CGFloat = 50, bubbleMinSpeed: Double = 2.0, bubbleMaxSpeed: Double = 5.0) {
        self.numberOfBubbles = numberOfBubbles
        self.bubbleMinSize = bubbleMinSize
        self.bubbleMaxSize = bubbleMaxSize
        self.bubbleMinSpeed = bubbleMinSpeed
        self.bubbleMaxSpeed = bubbleMaxSpeed
    }

    var body: some View {
        GeometryReader { geometry in
            ForEach(bubbleData, id: \.id) { bubble in
                Circle()
                    .foregroundColor(.red.opacity(0.3))
                    .frame(width: bubble.size, height: bubble.size)
                    .position(bubble.position)
                    .opacity(bubble.opacity)
            }
        }
        .onAppear {
            generateBubbleData()
        }
    }

    private func generateBubbleData() {
        for _ in 0..<numberOfBubbles {
            let size = CGFloat.random(in: bubbleMinSize...bubbleMaxSize)
            let speed = Double.random(in: bubbleMinSpeed...bubbleMaxSpeed)
            let position = CGPoint(x: CGFloat.random(in: 0..<UIScreen.main.bounds.width), y: UIScreen.main.bounds.height)
            let opacity = Double.random(in: 0.5...1.0)
            bubbleData.append(BubbleData(id: UUID(), size: size, speed: speed, position: position, opacity: opacity))
        }
        animateBubbles()
    }

    private func animateBubbles() {
        for index in 0..<bubbleData.count {
            let bubble = bubbleData[index]
            let driftDirection: CGFloat = Bool.random() ? 3 : -3 // Randomly choose either 1 (right) or -1 (left)
            
            withAnimation(
                Animation.linear(duration: bubble.speed)
                    .repeatForever(autoreverses: false)
                    .delay(Double.random(in: 0...1.0))
            ) {
                bubbleData[index].position.y = -bubble.size
                bubbleData[index].position.x += driftDirection * CGFloat.random(in: 10...30) // Adjust the range as needed
            }
        }
    }

    struct BubbleData: Identifiable {
        let id: UUID
        let size: CGFloat
        let speed: Double
        var position: CGPoint
        let opacity: Double
    }
}

struct BubblesAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        BubblesAnimationView(numberOfBubbles: 20)
    }
}
