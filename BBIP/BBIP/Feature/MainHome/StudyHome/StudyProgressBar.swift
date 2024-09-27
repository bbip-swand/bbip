import SwiftUI

struct StudyProgressBar: View {
    @State private var progress: CGFloat = 0
    private let totalWeek: Int
    private let currentWeek: Int
    private let periodString: String
    
    init(
        totalWeek: Int,
        currentWeek: Int,
        periodString: String
    ) {
        self.totalWeek = totalWeek
        self.currentWeek = currentWeek
        self.periodString = periodString
    }
    
    var targetProgress: CGFloat {
        guard totalWeek > 0 else { return 0 }
        return CGFloat(currentWeek) / CGFloat(totalWeek)
    }
    
    var redDotPositionX: CGFloat {
        guard totalWeek > 0 else { return 0 }
        return progressBarWidth * progress
    }
    
    var progressBarWidth: CGFloat {
        UIScreen.main.bounds.width - 60
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.mainWhite)
                .frame(height: 78)
            
            VStack(spacing: 10) {
                HStack(alignment: .top, spacing: 5) {
                    Text("\(currentWeek)R")
                    Text("/ \(totalWeek)R")
                        .foregroundStyle(.gray5)
                    
                    Spacer()
                    
                    Text("(\(periodString))")
                        .font(.bbip(.caption2_m12))
                        .foregroundStyle(.gray5)
                }
                .padding(.leading, 18)
                .padding(.trailing, 15)
                .font(.bbip(.title3_sb20))
                
                ZStack(alignment: .leading) {
                    // Background bar
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: progressBarWidth, height: 7)
                        .foregroundColor(.gray2)
                    
                    // Foreground bar (progress)
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: progressBarWidth * progress, height: 7)
                        .foregroundColor(.primary3)
                        .animation(.smooth(duration: 1), value: progress)
                        .overlay {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.primary3)
                                .position(x: redDotPositionX + 6)
                                .offset(x: -6.5, y: 3.25)
                                .animation(.smooth(duration: 1), value: progress)
                        }
                }
            }
        }
        .onAppear {
            withAnimation { progress = targetProgress }
        }
        .bbipShadow1()
    }
}

struct StudyProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        StudyProgressBar(totalWeek: 10, currentWeek: 5, periodString: "2023.09.01 ~ 2023.10.31")
            .padding(.horizontal, 18)
    }
}
