import UIKit

final class BivvyFindPublishViewController: BivvyKeyboardAvoidingViewController {
    private let uploadButton = UIButton()
    private let productNameField = UITextField()
    private let priceField = UITextField()
    private let qualityField = UITextField()
    private let cityField = UITextField()
    private let exchangeField = UITextField()
    private let releaseButton = BivvyGradientButton(title: "Release")
    private let errorLabel = UILabel()
    private var categoryButtons: [UIButton] = []
    private var selectedCategory = BivvyMockContent.categories.first?.title ?? "Trendy toys"
    private var selectedImageName = "bivvy_find_card_daily"
    private var selectedDetailImageNames = ["bivvy_find_card_daily"]
    private let sampleUploads: [(title: String, category: String, imageName: String, detailImageNames: [String])] = [
        ("Pink plush find", "Trendy toys", "bivvy_find_card_plush", ["bivvy_find_card_plush"]),
        ("Travel organizer", "Apparel", "bivvy_find_local_10007_main", ["bivvy_find_local_10007_main", "bivvy_find_local_10007_detail_01"]),
        ("Figure collection", "Figurines", "bivvy_find_card_figure", ["bivvy_find_card_figure"]),
        ("Smart gadget", "Digital", "bivvy_find_local_10005_main", ["bivvy_find_local_10005_main", "bivvy_find_local_10005_detail_01"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        configureInputs()
        updateReleaseButtonState()
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

        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.setImage(UIImage(named: "addImageNOing"), for: .normal)
        uploadButton.imageView?.contentMode = .scaleAspectFit
        uploadButton.layer.cornerRadius = 28
        uploadButton.clipsToBounds = true
        uploadButton.addTarget(self, action: #selector(selectProductImage), for: .touchUpInside)

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

    private func configureInputs() {
        let fields = [productNameField, priceField, qualityField, cityField, exchangeField]
        fields.forEach {
            $0.delegate = self
            $0.clearButtonMode = .whileEditing
            $0.returnKeyType = $0 === exchangeField ? .done : .next
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        priceField.keyboardType = .decimalPad
        productNameField.textContentType = .name
        cityField.textContentType = .addressCity
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
        updateReleaseButtonState()
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func textFieldDidChange() {
        errorLabel.text = nil
        updateReleaseButtonState()
    }

    @objc private func selectProductImage() {
        view.endEditing(true)
        let sheet = UIAlertController(title: "Choose product photo", message: "Use a local sample image to preview the publishing flow.", preferredStyle: .actionSheet)
        for upload in sampleUploads {
            sheet.addAction(UIAlertAction(title: upload.title, style: .default) { [weak self] _ in
                self?.applySelectedUpload(upload)
            })
        }
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        if let popover = sheet.popoverPresentationController {
            popover.sourceView = uploadButton
            popover.sourceRect = uploadButton.bounds
        }
        present(sheet, animated: true)
    }

    private func applySelectedUpload(_ upload: (title: String, category: String, imageName: String, detailImageNames: [String])) {
        selectedImageName = upload.imageName
        selectedDetailImageNames = upload.detailImageNames
        selectedCategory = upload.category
        uploadButton.setImage(UIImage(named: upload.imageName), for: .normal)
        uploadButton.backgroundColor = UIColor.white.withAlphaComponent(0.58)
        if productNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty != false {
            productNameField.text = upload.title
        }
        errorLabel.text = nil
        updateCategoryButtons()
        updateReleaseButtonState()
    }

    private func updateReleaseButtonState() {
        releaseButton.isEnabled = isFormReady
    }

    private var isFormReady: Bool {
        !trimmed(productNameField).isEmpty &&
        !trimmed(priceField).isEmpty &&
        !trimmed(qualityField).isEmpty &&
        !trimmed(cityField).isEmpty &&
        !trimmed(exchangeField).isEmpty
    }

    private func trimmed(_ field: UITextField) -> String {
        field.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    @objc private func publishFind() {
        let title = trimmed(productNameField)
        let price = trimmed(priceField)
        let quality = trimmed(qualityField)
        let city = trimmed(cityField)
        let exchange = trimmed(exchangeField)
        guard !title.isEmpty, !price.isEmpty, !quality.isEmpty, !city.isEmpty, !exchange.isEmpty else {
            errorLabel.text = "Please complete all product fields."
            updateReleaseButtonState()
            return
        }

        view.endEditing(true)
        releaseButton.isLoading = true
        errorLabel.text = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            BivvyLocalFindStore.shared.addFind(
                title: title,
                price: price,
                qualityGrade: quality,
                city: city,
                exchangeDemand: exchange,
                category: self.selectedCategory,
                imageName: self.selectedImageName,
                detailImageNames: self.selectedDetailImageNames
            )
            self.releaseButton.isLoading = false
            self.showPublishSuccess()
        }
    }

    private func showPublishSuccess() {
        let alert = UIAlertController(title: "Released", message: "Your find has been added to the local showcase.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "View on Home", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}

extension BivvyFindPublishViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case productNameField:
            priceField.becomeFirstResponder()
        case priceField:
            qualityField.becomeFirstResponder()
        case qualityField:
            cityField.becomeFirstResponder()
        case cityField:
            exchangeField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
