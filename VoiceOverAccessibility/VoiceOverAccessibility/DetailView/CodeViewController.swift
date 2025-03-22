//
//  ViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//


import UIKit
import Highlightr

class CodeViewController: IUIViewController {
    private let textView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .tertiarySystemGroupedBackground
        textView.font = UIFont(name: "Menlo", size: 14)
        textView.isEditable = false
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 10
        return textView
    }()

    let paragraphStyle : NSMutableParagraphStyle = {
        let para = NSMutableParagraphStyle()
        para.lineSpacing = 10 // Set the line spacing (in points)
        para.paragraphSpacing = 15 // Set the spacing between paragraphs (in points)
        para.lineHeightMultiple = 1.2 // Set the line height multiplier
        return para
    }()

    private let highlightr = Highlightr()!

    private lazy var copyNavBar : UIBarButtonItem = UIBarButtonItem(title: "Copy", style: .plain, target: self, action: #selector(copyButtonTapped))
    private let codeString: String

    init(codeString: String) {
        self.codeString = codeString
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Code"

        setupViews()
        navigationItem.rightBarButtonItem = copyNavBar
    }
    
    private func setupViews() {
        highlightr.setTheme(to: "xcode")

        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -8)
        ])
        
        updateString()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection){
            updateString()
        }
    }

    private func updateString() {
        highlightr.setTheme(to: traitCollection.userInterfaceStyle == .dark ? "xcode-dark" : "xcode")
        if let highlightedCode = highlightr.highlight(codeString, as: "swift") {
            textView.attributedText = highlightedCode
        } else {
            textView.text = codeString
        }
    }

    @objc private func copyButtonTapped() {
        UIPasteboard.general.string = codeString
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
}

#Preview{
    CodeViewController(codeString: """
let button2 = UIButton()
button2.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
button2.backgroundColor = .green
button2.clipsToBounds = true
button2.layer.cornerRadius = 10
button2.accessibilityLabel = "Edit"
button2.accessibilityHint = "Edits data"
""")
}
