import SwiftUI
import Foundation

class ToggleState: ObservableObject {
    @Published var isPrimaryOptionSelected: Bool = false
    @Published var isRTL: Bool = false
}

struct IMSwitch: View {
    @StateObject var toggleState: ToggleState
    @Environment(\.layoutDirection) var direction
    
    private (set) var leftImage: Image
    private (set) var rightImage: Image
    private (set) var backgroundColor: Color
    private (set) var circleFilledColor: Color
    private (set) var animationType: Animation
    private (set) var animationLength: Double
    private (set) var activeColor: Color
    
    init(leftImage: Image,
         rightImage: Image,
         activeColor: Color,
         circleFilledColor: Color,
         backgroundColor: Color,
         animation: Animation = .default,
         animationLength: Double = 0.35,
         toggleState: ToggleState) {
        self.circleFilledColor = circleFilledColor
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.activeColor = activeColor
        self.backgroundColor = backgroundColor
        self.animationType = animation
        self.animationLength = animationLength
        self._toggleState = .init(wrappedValue: toggleState)
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                if !toggleState.isPrimaryOptionSelected {
                    Spacer()
                }
                
                Circle()
                    .fill(circleFilledColor)
                    .frame(width: geometry.size.width / 2,
                           height: geometry.size.height * 1.1)
                    .simultaneousGesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    self.toggleState.isPrimaryOptionSelected = true
                                } else {
                                    self.toggleState.isPrimaryOptionSelected = false
                                }
                            }
                    )
                    .onTapGesture {
                        self.toggleState.isPrimaryOptionSelected.toggle()
                    }
                
                if toggleState.isPrimaryOptionSelected {
                    Spacer()
                }
            }
            
            .overlay(content: {
                HStack {
                    leftImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                        .foregroundColor(toggleState.isPrimaryOptionSelected ? activeColor : circleFilledColor)
                        .onTapGesture {
                            if !toggleState.isPrimaryOptionSelected {
                                self.toggleState.isPrimaryOptionSelected.toggle()
                            }
                        }
                        .simultaneousGesture(
                            DragGesture()
                                .onEnded { value in
                                    if value.translation.width < 0 {
                                        self.toggleState.isPrimaryOptionSelected = !toggleState.isRTL
                                    } else {
                                        self.toggleState.isPrimaryOptionSelected = toggleState.isRTL
                                    }
                                }
                        )
                    Spacer()
                    rightImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                        .foregroundColor(toggleState.isPrimaryOptionSelected ? circleFilledColor : activeColor)
                        .onTapGesture {
                            if toggleState.isPrimaryOptionSelected {
                                self.toggleState.isPrimaryOptionSelected.toggle()
                            }
                        }
                        .simultaneousGesture(
                            DragGesture()
                                .onEnded { value in
                                    if value.translation.width < 0 {
                                        self.toggleState.isPrimaryOptionSelected = true
                                    } else {
                                        self.toggleState.isPrimaryOptionSelected = false
                                    }
                                }
                        )
                }
                .padding(EdgeInsets(top: geometry.size.height / 4,
                                    leading: geometry.size.width / 8,
                                    bottom: geometry.size.height / 4,
                                    trailing: geometry.size.width / 8))
            })
            .frame(width: geometry.size.width, height: geometry.size.height)
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .background(backgroundColor)
            .animation(animationType, value: animationLength)
            .cornerRadius(geometry.size.height / 1.6)
        }
        .shadow(radius: 8)
        .onAppear {
            toggleState.isRTL = direction == .rightToLeft
        }
    }
}

#if DEBUG
struct IMSwitch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                VStack(spacing: 50) {
                    IMSwitch(
                        leftImage: .init(systemName: "bicycle"),
                        rightImage: .init(systemName: "parkingsign.circle"),
                        activeColor: .white,
                        circleFilledColor: .yellow,
                        backgroundColor: Color.white.opacity(0.85), animation: .easeInOut,
                        animationLength: 0.35, toggleState: .init())
                    .frame(width: 200, height: 60)
                    .environment(\.layoutDirection, .leftToRight)
                    
                    IMSwitch(
                        leftImage: .init(systemName: "car"),
                        rightImage: .init(systemName: "parkingsign.circle"),
                        activeColor: .white,
                        circleFilledColor: .blue,
                        backgroundColor: Color.white.opacity(0.85), animation: .easeInOut,
                        animationLength: 0.35, toggleState: .init())
                    .frame(width: 200, height: 60)
                    .environment(\.layoutDirection, .leftToRight)
                    
                    IMSwitch(
                        leftImage: .init(systemName: "bus"),
                        rightImage: .init(systemName: "train.side.front.car"),
                        activeColor: .white,
                        circleFilledColor: .green,
                        backgroundColor: Color.white.opacity(0.85), animation: .easeInOut,
                        animationLength: 0.35, toggleState: .init())
                    .frame(width: 200, height: 60)
                    .environment(\.layoutDirection, .leftToRight)
                    
                    IMSwitch(
                        leftImage: .init(systemName: "person.3"),
                        rightImage: .init(systemName: "person"),
                        activeColor: .white,
                        circleFilledColor: .red,
                        backgroundColor: Color.white.opacity(0.85), animation: .easeInOut,
                        animationLength: 0.35, toggleState: .init())
                    .frame(width: 200, height: 60)
                    .environment(\.layoutDirection, .leftToRight)
                }
            }.previewDisplayName("Default preview 1")
        }
        Group {
            VStack(spacing: 50) {
                IMSwitch(
                    leftImage: .init(systemName: "bicycle"),
                    rightImage: .init(systemName: "parkingsign.circle"),
                    activeColor: .white,
                    circleFilledColor: .yellow,
                    backgroundColor: Color.white.opacity(0.85), animation: .easeInOut,
                    animationLength: 0.35, toggleState: .init())
                .frame(width: 200, height: 60)
                .environment(\.layoutDirection, .leftToRight)
                
                IMSwitch(
                    leftImage: .init(systemName: "car"),
                    rightImage: .init(systemName: "parkingsign.circle"),
                    activeColor: .white,
                    circleFilledColor: .blue,
                    backgroundColor: Color.white.opacity(0.85), animation: .easeInOut,
                    animationLength: 0.35, toggleState: .init())
                .frame(width: 200, height: 60)
                .environment(\.layoutDirection, .leftToRight)
                
                IMSwitch(
                    leftImage: .init(systemName: "bus"),
                    rightImage: .init(systemName: "train.side.front.car"),
                    activeColor: .white,
                    circleFilledColor: .green,
                    backgroundColor: Color.white.opacity(0.85), animation: .easeInOut,
                    animationLength: 0.35, toggleState: .init())
                .frame(width: 200, height: 60)
                .environment(\.layoutDirection, .leftToRight)
                
                IMSwitch(
                    leftImage: .init(systemName: "person.3"),
                    rightImage: .init(systemName: "person"),
                    activeColor: .white,
                    circleFilledColor: .red,
                    backgroundColor: Color.white.opacity(0.85), animation: .easeInOut,
                    animationLength: 0.35, toggleState: .init())
                .frame(width: 200, height: 60)
                .environment(\.layoutDirection, .leftToRight)
            }
        }.previewDisplayName("Default preview 1")
    }
}
#endif
