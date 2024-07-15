import SwiftUI

struct Song: Identifiable {
    let id = UUID()
    let coverImageName: String
    let title: String
    let artist: String
    var likeCount: Int
}

struct FeedView: View {
    var body: some View {
        TabView {
            FriendsFeedView()
                .tabItem {
                    Label("Friends", systemImage: "person.2.fill")
                }
            
            DiscoverFeedView()
                .tabItem {
                    Label("Discover", systemImage: "globe")
                }
            
            Text("Create")
                .tabItem {
                    Image(systemName: "plus.rectangle.fill")
                }
            
            Text("Inbox")
                .tabItem {
                    Label("Inbox", systemImage: "envelope.fill")
                }
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct FriendsFeedView: View {
    let songs: [Song] = [
        Song(coverImageName: "cover1", title: "Bohemian Rhapsody", artist: "Queen", likeCount: 25),
        Song(coverImageName: "cover2", title: "Imagine", artist: "John Lennon", likeCount: 30),
        Song(coverImageName: "cover3", title: "Billie Jean", artist: "Michael Jackson", likeCount: 45)
    ]
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VerticalPagingScrollView(currentIndex: $currentIndex, itemCount: songs.count) {
                ForEach(Array(songs.enumerated()), id: \.element.id) { index, song in
                    VStack(spacing: 0) {
                        ZStack(alignment: .topTrailing) {
                            SongCoverView(song: song)
                                .frame(width: geometry.size.width, height: geometry.size.width)
                        }
                        
                        SongInfoView(song: song)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color(UIColor.systemBackground))
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DiscoverFeedView: View {
    let songs: [Song] = [
        Song(coverImageName: "cover4", title: "Hey Jude", artist: "The Beatles", likeCount: 50),
        Song(coverImageName: "cover5", title: "Smells Like Teen Spirit", artist: "Nirvana", likeCount: 60),
        Song(coverImageName: "cover6", title: "Hotel California", artist: "Eagles", likeCount: 70)
    ]
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VerticalPagingScrollView(currentIndex: $currentIndex, itemCount: songs.count) {
                ForEach(Array(songs.enumerated()), id: \.element.id) { index, song in
                    VStack(spacing: 0) {
                        ZStack(alignment: .topTrailing) {
                            SongCoverView(song: song)
                                .frame(width: geometry.size.width, height: geometry.size.width)
                        }
                        
                        SongInfoView(song: song)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color(UIColor.systemBackground))
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SongCoverView: View {
    let song: Song
    
    var body: some View {
        ZStack {
            Color.gray
            
            Image(song.coverImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
        }
    }
}

struct SongInfoView: View {
    @State var song: Song
    @State private var showComments = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(song.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(song.artist)
                        .font(.subheadline)
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                VStack(spacing: 20) {
                    ProfilePictureView()
                        .frame(width: 40, height: 40)
                        .padding(.top)
                    
                    Button(action: { song.likeCount += 1 }) {
                        VStack {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("\(song.likeCount)")
                                .font(.subheadline)
                        }
                    }
                    
                    Button(action: { showComments.toggle() }) {
                        Image(systemName: "message.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button(action: { print("Play/Pause tapped") }) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                }
                .padding()
            }
            .background(Color(UIColor.secondarySystemBackground))
            
            if showComments {
                CommentSection(comment: .constant(""))
            }
        }
    }
}

struct CommentSection: View {
    @Binding var comment: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                TextField("Add a comment...", text: $comment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Post") {
                    // Handle posting comment
                    comment = ""
                }
                .disabled(comment.isEmpty)
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    CommentView(username: "User1", comment: "Great song!")
                    CommentView(username: "User2", comment: "Love this!")
                    CommentView(username: "User3", comment: "Classic!")
                }
                .padding(.horizontal)
            }
            .frame(height: 100)
        }
        .padding(.vertical)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct CommentView: View {
    let username: String
    let comment: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
            VStack(alignment: .leading) {
                Text(username).fontWeight(.bold)
                Text(comment)
            }
        }
    }
}

struct ProfilePictureView: View {
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .background(Color.gray)
            .clipShape(Circle())
    }
}

struct VerticalPagingScrollView<Content: View>: View {
    @Binding var currentIndex: Int
    let itemCount: Int
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    
    init(currentIndex: Binding<Int>, itemCount: Int, @ViewBuilder content: () -> Content) {
        self._currentIndex = currentIndex
        self.itemCount = itemCount
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.content
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(y: -CGFloat(self.currentIndex) * geometry.size.height)
                    .offset(y: self.translation)
                    .animation(.interactiveSpring(), value: currentIndex)
                    .gesture(
                        DragGesture().updating(self.$translation) { value, state, _ in
                            state = value.translation.height
                        }.onEnded { value in
                            let offset = value.translation.height / geometry.size.height
                            let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                            self.currentIndex = min(max(Int(newIndex), 0), self.itemCount - 1)
                        }
                    )
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
