import UIKit

final class BivvyFindPublishViewController: BivvyKeyboardAvoidingViewController {
    private let productNameField = UITextField()
    private let priceField = UITextField()
    private let qualityField = UITextField()
    private let cityField = UITextField()
    private let exchangeField = UITextField()
    private let releaseButton = BivvyGradientButton(title: "Release")
    private let errorLabel = UILabel()
    private var categoryButtons: [UIButton] = []
    private var selectedCategory = BivvyMockContent.categories.first?.title ?? "Trendy toys"

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let background = BivvyGradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.colors = [
            UIColor(red: 255 / 255, green: 204 / 255, blue: 214 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 246 / 255, blue: 251 / 255, alpha: 1),
            UIColor.white
        ]
        view.insertSubview(background, belowSubview: scrollView)

        let backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        let uploadButton = UIButton()
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        
        uploadButton.setImage(UIImage(named: "addImageNOing"), for: .normal)
        uploadButton.imageView?.contentMode = .scaleAspectFit

        let fields = [
            makeFieldBlock(title: "Product Name", field: productNameField, placeholder: "Enter product name..."),
            makeFieldBlock(title: "Commodity prices", field: priceField, placeholder: "Original price: $399"),
            makeFieldBlock(title: "Quality grade", field: qualityField, placeholder: "For example: 90% new"),
            makeFieldBlock(title: "City", field: cityField, placeholder: "Enter your city..."),
            makeFieldBlock(title: "Exchange of demands", field: exchangeField, placeholder: "Please enter your exchange request....")
        ]

        let categoryTitle = UILabel()
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.text = "Product Categories"
        categoryTitle.font = BivvyAuthTheme.titleFont(size: 30)
        categoryTitle.textColor = .black

        let categoryWrap = makeCategoryWrap()

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        errorLabel.textColor = BivvyAuthTheme.hotPink
        errorLabel.numberOfLines = 0

        releaseButton.addTarget(self, action: #selector(publishFind), for: .touchUpInside)

        [backButton, uploadButton].forEach(contentView.addSubview)
        fields.forEach(contentView.addSubview)
        [categoryTitle, categoryWrap, releaseButton, errorLabel].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 19),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),

            uploadButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 21),
            uploadButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            uploadButton.widthAnchor.constraint(equalToConstant: 100),
            uploadButton.heightAnchor.constraint(equalToConstant: 100),

            fields[0].topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 52),
            fields[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            fields[0].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])

        for index in 1..<fields.count {
            NSLayoutConstraint.activate([
                fields[index].topAnchor.constraint(equalTo: fields[index - 1].bottomAnchor, constant: 34),
                fields[index].leadingAnchor.constraint(equalTo: fields[0].leadingAnchor),
                fields[index].trailingAnchor.constraint(equalTo: fields[0].trailingAnchor)
            ])
        }

        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: fields.last!.bottomAnchor, constant: 36),
            categoryTitle.leadingAnchor.constraint(equalTo: fields[0].leadingAnchor),
            categoryTitle.trailingAnchor.constraint(equalTo: fields[0].trailingAnchor),

            categoryWrap.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor, constant: 18),
            categoryWrap.leadingAnchor.constraint(equalTo: fields[0].leadingAnchor),
            categoryWrap.trailingAnchor.constraint(equalTo: fields[0].trailingAnchor),

            releaseButton.topAnchor.constraint(equalTo: categoryWrap.bottomAnchor, constant: 28),
            releaseButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            releaseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            releaseButton.heightAnchor.constraint(equalToConstant: 64),

            errorLabel.topAnchor.constraint(equalTo: releaseButton.bottomAnchor, constant: 12),
            errorLabel.leadingAnchor.constraint(equalTo: releaseButton.leadingAnchor, constant: 10),
            errorLabel.trailingAnchor.constraint(equalTo: releaseButton.trailingAnchor, constant: -10),
            errorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -34)
        ])
    }

    private func makeFieldBlock(title: String, field: UITextField, placeholder: String) -> UIView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 18

        let label = UILabel()
        label.text = title
        label.font = BivvyAuthTheme.titleFont(size: 30)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true

        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        field.layer.cornerRadius = 32
        field.font = .systemFont(ofSize: 20, weight: .regular)
        field.textColor = .black
        field.textAlignment = .center
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)]
        )
        field.heightAnchor.constraint(equalToConstant: 64).isActive = true

        stack.addArrangedSubview(label)
        stack.addArrangedSubview(field)
        return stack
    }

    private func makeCategoryWrap() -> UIStackView {
        let rows = UIStackView()
        rows.translatesAutoresizingMaskIntoConstraints = false
        rows.axis = .vertical
        rows.spacing = 16

        let firstRow = UIStackView()
        let secondRow = UIStackView()
        [firstRow, secondRow].forEach {
            $0.axis = .horizontal
            $0.spacing = 16
            $0.distribution = .fillEqually
            rows.addArrangedSubview($0)
        }

        for (index, item) in BivvyMockContent.categories.enumerated() {
            let button = makeCategoryButton(title: item.title)
            button.tag = index
            button.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
            categoryButtons.append(button)
            (index < 2 ? firstRow : secondRow).addArrangedSubview(button)
        }
        updateCategoryButtons()
        return rows
    }

    private func makeCategoryButton(title: String) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseForegroundColor = UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
        configuration.baseBackgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        configuration.cornerStyle = .capsule
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        let button = UIButton(configuration: configuration)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.heightAnchor.constraint(equalToConstant: 58).isActive = true
        return button
    }

    private func updateCategoryButtons() {
        for button in categoryButtons {
            let title = BivvyMockContent.categories[button.tag].title
            var configuration = button.configuration
            configuration?.baseForegroundColor = title == selectedCategory ? .white : UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
            configuration?.baseBackgroundColor = title == selectedCategory ? BivvyAuthTheme.hotPink : UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
            button.configuration = configuration
        }
    }

    @objc private func selectCategory(_ sender: UIButton) {
        selectedCategory = BivvyMockContent.categories[sender.tag].title
        updateCategoryButtons()
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func publishFind() {
        let title = productNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let price = priceField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let quality = qualityField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let city = cityField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let exchange = exchangeField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !title.isEmpty, !price.isEmpty, !quality.isEmpty, !city.isEmpty, !exchange.isEmpty else {
            errorLabel.text = "Please complete all product fields."
            return
        }

        releaseButton.isLoading = true
        errorLabel.text = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            BivvyLocalFindStore.shared.addFind(
                title: title,
                price: price,
                qualityGrade: quality,
                city: city,
                exchangeDemand: exchange,
                category: self.selectedCategory
            )
            self.releaseButton.isLoading = false
            self.navigationController?.popViewController(animated: true)
        }
    }
}
