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

    var body: some View {
        GeometryReader { geo in
            // Calculate the vertical offset of the scroll, used for dynamic resizing
            let scrollOffset = geo.frame(in: .global).minY
            // Determine the dynamic height of the image, ensuring a minimum height of 300
            let height = max(300 + scrollOffset, 300)

            VStack {
                // Use ZStack to layer the image and the text on top of it
                ZStack {
                    // Display the image with dynamic resizing using AsyncImage
                    StickyImageLoader(urlString: image)
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
                        // Apply the sticky modifier to make the image stretch with the scroll effect
                        .modifier(StickyModifier(startingHeight: 300, geo: geo))
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
    // URL string to load the image
    var urlString: String
    
    @State private var imageLoaded: Bool = false // State variable to track if the image is loaded
    
    var body: some View {
        // Use AsyncImage to load the image from the URL
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                // Placeholder view displayed while the image is loading
                Color.gray.opacity(0.3) // Display a gray placeholder
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the space
            case .success(let image):
                // Image loaded successfully
                image
                    .resizable() // Make the image resizable to fit its container
                    .scaledToFill() // Scale the image to fill the container, potentially cropping it
                    .clipped() // Clip any overflow of the image that goes beyond its bounds
                    .onAppear {
                        imageLoaded = true // Set the imageLoaded state to true when the image appears
                    }
                    // Apply scale effect and anchor it to the center of the container
                    .scaleEffect(1.0, anchor: .center)
            case .failure:
                // Placeholder in case the image fails to load
                Color.red.opacity(0.3) // Display a red failure placeholder
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the space
            @unknown default:
                // Default fallback for unknown states (should not be needed)
                Color.gray.opacity(0.3) // Display a gray fallback placeholder
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the space
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the image fills its container
    }
}

// View modifier for applying the stretch and scroll effect on the image
struct StickyModifier: ViewModifier {
    var startingHeight: CGFloat // The initial height of the image
    var geo: GeometryProxy // GeometryProxy to track the image's position and size
    var coordinateSpace: CoordinateSpace = .global // Coordinate space to use for positioning

    func body(content: Content) -> some View {
        content
            .frame(width: geo.size.width, height: stretchedHeight()) // Set the width and dynamic height of the content
            .clipped() // Clip any content that overflows the frame
            .offset(y: stretchedOffset()) // Apply the vertical offset based on scroll position
    }

    private func yOffset() -> CGFloat {
        geo.frame(in: coordinateSpace).minY // Get the Y offset of the content
    }

    private func stretchedHeight() -> CGFloat {
        let offset = yOffset() // Get the current Y offset
        return offset > 0 ? (startingHeight + offset) : startingHeight // Increase the height as the user scrolls down
    }

    private func stretchedOffset() -> CGFloat {
        let offset = yOffset() // Get the current Y offset
        return offset > 0 ? -offset : 0 // Apply a negative offset to stretch the content when scrolling up
    }
}

#Preview {
    ZStack {
        // Set the background to black for contrast
        Color.black.edgesIgnoringSafeArea(.all)
        
        // ScrollView to allow scrolling of the content
        ScrollView {
            VStack {
                // Create the sticky image with the specified parameters
                StickyImage(
                    image: "https://picsum.photos/800/800", // Image URL to load
                    title: "Sticky Image", // Title text to display
                    subtitle: "This is a Sticky subtitle", // Subtitle text to display
                    textSize: 40, // Set the size of the title text
                    shadowColor: .black // Shadow color for the gradient overlay
                )
            }
        }
    }
}
