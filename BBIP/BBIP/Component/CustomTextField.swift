import SwiftUI

struct CustomTextFieldComponent: View {
    @Binding var text: String
    @Binding var isRight: Bool
    @FocusState.Binding var focusedField: Int?
    
    var index: Int
    var font: Font
    var width: CGFloat = 70
    var height: CGFloat = 70
    var keyboardType: UIKeyboardType = .numberPad
    var backgroundColor: Color = .gray8
    var viewModel: AttendanceCertificationViewModel
    
    var body: some View {
        TextField("", text: $text)
            .font(font)
            .frame(width: width, height: height)
            .multilineTextAlignment(.center)
            .keyboardType(keyboardType)
            .frame(maxWidth: .infinity)
            .background(viewModel.isComplete() && !isRight ? Color(uiColor: UIColor(hexCode: "FF9090", alpha: 0.5)) : backgroundColor)
            .foregroundColor(.mainWhite)
            .cornerRadius(12)
            .focused($focusedField, equals: index)
            .onChange(of: text) { _, newValue in
                if let nextIndex = viewModel.handleTextFieldChange(index: index, newValue: newValue) {
                    focusedField = nextIndex
                }
            }
    }
}
