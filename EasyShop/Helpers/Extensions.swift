import SwiftUI

// MARK: - VIEWS

extension View {
    func reusableHstack(radius: CGFloat, stroke: CGFloat, colorF: Color, colorB: Color) -> some View {
        self
            .overlay(RoundedRectangle(cornerRadius: radius)
                        .stroke(lineWidth: stroke)
                        .foregroundColor(colorF))
            .padding()
            .background(colorB)
    }
    func reusableTabbar(width: CGFloat, height: CGFloat, maskRadius: CGFloat, overlayRadius: CGFloat, strokeColor: Color) -> some View {
        self
            .frame(width: width, height: height)
            .mask(RoundedRectangle(cornerRadius: maskRadius))
            .overlay(RoundedRectangle(cornerRadius: overlayRadius)
                        .stroke(strokeColor))
    }
    func reusableTakenImage(place: Edge.Set, padding: CGFloat, height: CGFloat, shape: Rectangle) -> some View {
        self
            .padding(place, padding)
            .frame(height: height)
            .contentShape(shape)
    }
    
    func reusableStack(opacity: Double, colorF: Color) -> some View {
        self
            .opacity(opacity)
            .foregroundColor(colorF)
    }
}

// MARK: - IMAGE

extension Image {
    func displayImage(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .frame(width: width, height: height)
    }
    func reusableSelectedImage(scale: Scale, coloF: Color) -> some View {
        self
            .imageScale(scale)
            .foregroundColor(coloF)
    }
    func reusableButtonImage(scale: Scale, width: CGFloat, height: CGFloat, colorF: Color, opacity: Double) -> some View {
        self
            .imageScale(scale)
            .frame(width: width, height: height)
            .foregroundColor(colorF)
            .opacity(opacity)
    }
}

// MARK: - TEXT

extension Text {
    func reusableText(colorF: Color, size: CGFloat, place: Edge.Set, padding: CGFloat) -> some View {
        self
            .foregroundColor(colorF)
            .font(Font.system(size: size))
            .padding(place, padding)
    }
    func reusableTextItem(colorF: Color, size: CGFloat) -> some View {
        self
            .foregroundColor(colorF)
            .font(Font.system(size: size))
        
    }
    func reusableLabel(font: Font, size: CGFloat, design: Font.Design, color: Color) -> some View {
        self
            .font(font)
            .font(Font.system(size: size, design: design))
            .foregroundColor(color)
    }
}

// MARK: - SHAPE

extension Shape {
    func reusableShape(width: CGFloat, heigth: CGFloat, color: Color) -> some View {
        self
            .frame(width: width, height: heigth)
            .foregroundColor(color)
    }
}

// MARK: - TEXTFIELD

extension TextField {
    func reusableTextField(height: CGFloat, color: Color, fontSize: CGFloat, alignment: TextAlignment, autocorrection: Bool, limit: Int) -> some View {
        self
            .frame(height: height)
            .background(color)
            .font(Font.system(size: fontSize))
            .multilineTextAlignment(alignment)
            .disableAutocorrection(autocorrection)
            .lineLimit(limit)
        
    }
}
/*
 
//    func reusableImage(width: CGFloat, height: CGFloat, padding: CGFloat) -> some View {
//        self  // SettingsView
//            .resizable()
//            .frame(width: width, height: height)
//            .padding(padding)
//    }
 
 //    func reusableChevron(place: Edge.Set, size: CGFloat, weight: Font.Weight) -> some View {
 //        self
 //            .padding(place)
 //            .font(.system(size: size, weight: weight))
 //    }
 //    func reusableIcon(size: CGFloat, weight: Font.Weight, desing: Font.Design, color: Color) -> some View {
 //        self
 //            .font(.system(size: size, weight: weight, design: desing))
 //            .foregroundColor(color)
 //    }
 //    func reusableIconApp(rendering: Image.TemplateRenderingMode, width: CGFloat, height: CGFloat, corner: CGFloat) -> some View {
 //        self
 //            .renderingMode(rendering)
 //            .resizable()
 //            .scaledToFit()
 //            .frame(width: width, height: height)
 //            .cornerRadius(corner)
 //    }
 */
