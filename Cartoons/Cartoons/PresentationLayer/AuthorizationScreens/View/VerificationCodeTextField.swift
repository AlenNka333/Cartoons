import UIKit

class VerificationCodeTextField: UITextField {
    private var isConfigured = false
    private var digitLabels = [UILabel()]

    func configure(with slotCount: Int = 6) {
        guard isConfigured == false else {
            return
        }
        isConfigured.toggle()
        configureTextField()
        let labelStackView = createLabelsStackView(with: slotCount)
        addSubview(labelStackView)

        NSLayoutConstraint.activate([labelStackView.topAnchor.constraint(equalTo: topAnchor),
                                     labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }

    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
    }

    private func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        for _ in 1 ... count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            label.backgroundColor = UIColor(named: "login_button_color")

            stackView.addArrangedSubview(label)
            digitLabels.append(label)
        }
        return stackView
    }
}
