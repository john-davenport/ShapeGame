import SwiftUI

struct About: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("About The Game")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("""
ShapeGame was created out of a curiousity to see how far I could push Swift Playgrounds. Let me tell you - this wasn't easy - but it was a fun challenge.

As a hobbyst and someone who enjoys experimentation with things. This project has given some great hope for what the future of iPad game development might become.

Over several weeks I worked with Swift Playgrounds to build this game, it was never designed to be a work of art, or a fully fleshed out game, but rather a proof of concept. I believe I've achieved that with this project and I hope that you enjoy the game.

While I am optmistic as to the direction that Swift Playgrounds has taken game development on an iPad, it is still not Xcode. It's a playground first and foremost and definitely is not recommended to drop your projects in Xcode for playgrounds.

If you're interested in seeing some of the development process of ShapeGame I took time to document the steps along the way on my YouTube channel. I have also made the code available for those who are interested on GitHub which you can find links to over on YouTube.

Thank you for trying this game and being a part of this creative process with Swift Playgrounds. Let me know what you think by leaving a review on the AppStore or commenting on one of the videos in the series on YouTube.
""")
            }
            .padding(.top, 50)
            .padding()
        }
        
    }
}
