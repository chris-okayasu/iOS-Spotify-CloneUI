//
//  Sticky.swift
//  Sticky Image Banner
//
//  Created by chris on 2024/12/20.
//
/// Just call the struct, the image can be from your local project or by Internet
/// The size of the text is basically one paramether so if you use 50 for example
/// It will be title = 50 and subtitle = 25 since we are taking the number and divide by 2
/// I recoment use same color of your background as Shadow since I am applying a gradient
/// This should be use at the top of your screen, no idea what happens in any other area of your app.
/// It can also be used in Landscape.
import SwiftUI


// Main view that contains the image and the text over it
struct StickyImage: View {
    // URL or name of the image to be displayed
    var image: String
    // Title text displayed on top of the image
    var title: String?
    // Subtitle text displayed below the title
    var subtitle: String?
    // Size of the title, the subtitle will be half the size of the title
    var textSize: CGFloat?
    // Color for the shadow overlay to improve text visibility
    var shadowColor: Color
    // Flag to determine if a header should be displayed
    var withHeader: Bool = false
    // Title of the header (optional)
    var headerTitle: String? = nil
    // Color of the title
    var titleColor: Color? = nil
    // Action for the back button
    var onBackPressed: (() -> Void)?

    var body: some View {
        GeometryReader { geo in
            // Calculate the vertical offset of the scroll, used for dynamic resizing
            let scrollOffset = geo.frame(in: .global).minY
            // Determine the dynamic height of the image, ensuring a minimum height of 300
            let height = max(300 + scrollOffset, 300)

            VStack {
                // Conditionally render the header if `withHeader` is true
                if withHeader, let headerTitle = headerTitle {
                    ZStack {
                        HStack {
                            // Back button on the left
                            Image(systemName: "chevron.left")
                                .font(.title3)
                                .padding(10)
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                                .onTapGesture {
                                    onBackPressed?() // Trigger the back action
                                }

                            Spacer()
                        }
                        .padding()

                        // Centered title
                        Text(headerTitle)
                            .font(.title)
                            .foregroundColor(titleColor?.opacity(1) ?? Color.primary)
                            .bold()
                            .padding(.leading, 40) // To avoid overlap with the back button
                            
                    }
                    .padding(.top, 100)
                    .frame(height: 0) // Fixed height for the header
                    .background(Color.black.opacity(0.7)) // Background color for the header
                    .zIndex(1) // Ensure the header is above the image
                }
                
                // Use ZStack to layer the image and the text on top of it
                ZStack {
                    Rectangle()
                        .opacity(0.1)
                        .overlay(
                            // Display the image with dynamic resizing using AsyncImage
                            StickyImageLoader(urlString: image)
                        )
                        .frame(height: height) // Adjust height dynamically based on scroll offset
                        .clipped() // Clip any overflowing content to ensure the image doesn't spill outside
                        .overlay(
                            // Overlay the text on the image
                            VStack(alignment: .leading, spacing: 8) {
                                // Display the subtitle text (optional)
                                Text(subtitle ?? "")
                                    .font(.system(size: (textSize ?? 40)/2)) // Use half the textSize for subtitle
                                    .fontWeight(.bold) // Make the subtitle text bold
                                // Display the title text
                                Text(title ?? "")
                                    .font(.system(size: textSize ?? 40)) // Use the specified textSize for title
                                    .fontWeight(.bold) // Make the title text bold
                            }
                            .foregroundStyle(.colorLightGray) // Set the text color to light gray for better visibility
                            .padding(16) // Add padding around the text to avoid it touching the edges
                            .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left and take full width
                            .background(
                                // Add a gradient background to enhance the text's visibility
                                LinearGradient(
                                    colors: [shadowColor.opacity(0), shadowColor], // Gradient starts transparent and fades to shadowColor
                                    startPoint: .top, // Start from the top of the view
                                    endPoint: .bottom // End at the bottom of the view
                                )
                            )
                            , alignment: .bottomLeading // Align the text and gradient to the bottom-left of the image
                        )
                        .modifier(StickyModifier(startingHeight: 300, geo: geo)) // Apply sticky modifier to handle scroll behavior
                }
                .frame(height: height) // Set a fixed height for the header, which includes the image and text
            }
            .frame(height: 300) // Ensure GeometryReader has a fixed height
        }
        .frame(height: 300) // Ensure GeometryReader has a fixed height
    }
}

// Custom view for loading the image asynchronously
struct StickyImageLoader: View {
    var urlString: String
    
    @State private var imageLoaded: Bool = false
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                Color.gray.opacity(0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .onAppear {
                        imageLoaded = true
                    }
                    .scaleEffect(1.0, anchor: .center)
            case .failure:
                Color.red.opacity(0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            @unknown default:
                Color.gray.opacity(0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// View modifier for applying the stretch and scroll effect on the image
struct StickyModifier: ViewModifier {
    var startingHeight: CGFloat
    var geo: GeometryProxy
    var coordinateSpace: CoordinateSpace = .global

    func body(content: Content) -> some View {
        content
            .frame(width: geo.size.width, height: stretchedHeight())
            .clipped()
            .offset(y: stretchedOffset())
    }

    private func yOffset() -> CGFloat {
        geo.frame(in: coordinateSpace).minY
    }

    private func stretchedHeight() -> CGFloat {
        let offset = yOffset()
        return offset > 0 ? (startingHeight + offset) : startingHeight
    }

    private func stretchedOffset() -> CGFloat {
        let offset = yOffset()
        return offset > 0 ? -offset : 0
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        
        ScrollView {
            VStack {
                // Create the sticky image with the specified parameters, including header
                StickyImage(
                    image: "https://picsum.photos/800/800",
                    title: "Sticky Image",
                    subtitle: "This is a Sticky subtitle",
                    textSize: 40,
                    shadowColor: .black,
                    withHeader: true, // Display the header
                    headerTitle: "Playlist Header", // Title for the header
                    onBackPressed: {
                        print("Back button pressed") // Handle the back action
                    }
                )
            }
        }
    }
}
