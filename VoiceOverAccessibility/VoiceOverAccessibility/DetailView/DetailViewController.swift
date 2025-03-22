//
//  DynamicScrollViewController.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 22/03/25.
//


import UIKit

class DetailViewController: IUIViewController {
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGray5
        return scrollView
    }()

    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.backgroundColor = .systemGray5
        return stackView
    }()

    private let element:UIElement

    init(element:UIElement){
        self.element = element
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = element.title(for: .UIKit)
        setupScrollView()
        setupStackView()

        element.accessibilityUIView().forEach{item in
            item.delegate = self
            addItem(newItem: item)
        }
        addItem(newItem: element.defaultUIKit())
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupStackView() {

        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)


        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40) // Adjust for padding
        ])
    }

    private func addItem<T:UIView>(newItem:T) {
        stackView.addArrangedSubview(newItem)

        // Adjust scrollView contentSize
        let contentHeight = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight + 40) // Add padding
    }
}

extension DetailViewController : ElementViewDelegate{
    func viewCodeTapped() {
        let vc = CodeViewController(codeString: element.accessibilityCode)
        navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview{
    DetailViewController(element: .button)
}
