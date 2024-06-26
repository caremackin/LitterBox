//
//  ProgressBar.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/21/24.
//
import SwiftUI
struct Progress: View {
    @State var progressValue: Float = 0.0
    var body: some View {
        VStack{
            ProgressBar(progress: self.$progressValue)
                .frame(width: 160.0, height: 160.0)
                .padding(20.0).onAppear(){
                    self.progressValue = 0.30
                }
            Button("Save Money!"){
                if (progressValue) < 1.0 {
                    self.progressValue += 0.10
                } else {
                    progressValue -= 1.0
                }
            }
        }
    }
}
struct ProgressBar: View {
    @Binding var progress: Float
    var color: Color = Color(red: 2.35, green: 0.57, blue: 1.36)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            Circle()
                . trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth:12.0, lineCap:.round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees:270))
                .animation(.easeInOut(duration:2.0))
        }
    }
}
struct Progress_Previews:
    PreviewProvider{
    static var previews: some View{
        Progress()
    }
    
}

