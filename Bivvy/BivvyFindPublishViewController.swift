import UIKit

final class BivvyFindPublishViewController: ContentFilteringKeyboardAvoidingViewController {
    private let uploadButton = UIButton()
    private let productNameField = UITextField()
    private let priceField = UITextField()
    private let qualityField = UITextField()
    private let cityField = UITextField()
    private let exchangeField = UITextField()
    private let releaseButton = SharingMechanicGradientButton(title: BivvyStringVault.release)
    private let errorLabel = UILabel()
    private var categoryButtons: [UIButton] = []
    private var selectedCategory = BivvyMockContent.categories.first?.productHighlightTitle ?? "Trendy toys"
    private var uploadedFindImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        configureInputs()
        updateReleaseButtonState()
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let background = ProductCurationGradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.curatedListColors = [
            UIColor(red: 255 / 255, green: 204 / 255, blue: 214 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 246 / 255, blue: 251 / 255, alpha: 1),
            UIColor.white
        ]
        view.insertSubview(background, belowSubview: contentFilteringScrollView)

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
            makeFieldBlock(productHighlightTitle: BivvyStringVault.productName, field: productNameField, placeholder: BivvyStringVault.enterProductName),
            makeFieldBlock(productHighlightTitle: BivvyStringVault.commodityPrices, field: priceField, placeholder: BivvyStringVault.originalPrice),
            makeFieldBlock(productHighlightTitle: BivvyStringVault.qualityGrade, field: qualityField, placeholder: BivvyStringVault.exampleQuality),
            makeFieldBlock(productHighlightTitle: BivvyStringVault.city, field: cityField, placeholder: BivvyStringVault.enterCity),
            makeFieldBlock(productHighlightTitle: BivvyStringVault.exchangeDemands, field: exchangeField, placeholder: BivvyStringVault.exchangeReq)
        ]

        let categoryTitle = UILabel()
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.text = BivvyStringVault.productCategories
        categoryTitle.font = CommunitySharingAuthTheme.productShowcaseTitleFont(size: 30)
        categoryTitle.textColor = .black

        let categoryWrap = makeCategoryWrap()

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        errorLabel.textColor = CommunitySharingAuthTheme.favoriteFindPink
        errorLabel.numberOfLines = 0

        releaseButton.addTarget(self, action: #selector(publishFind), for: .touchUpInside)

        [backButton, uploadButton].forEach(communitySharingContentView.addSubview)
        fields.forEach(communitySharingContentView.addSubview)
        [categoryTitle, categoryWrap, releaseButton, errorLabel].forEach(communitySharingContentView.addSubview)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            backButton.topAnchor.constraint(equalTo: communitySharingContentView.safeAreaLayoutGuide.topAnchor, constant: 19),
            backButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),

            uploadButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 21),
            uploadButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            uploadButton.widthAnchor.constraint(equalToConstant: 100),
            uploadButton.heightAnchor.constraint(equalToConstant: 100),

            fields[0].topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 52),
            fields[0].leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            fields[0].trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -12)
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
            releaseButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            releaseButton.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -12),
            releaseButton.heightAnchor.constraint(equalToConstant: 64),

            errorLabel.topAnchor.constraint(equalTo: releaseButton.bottomAnchor, constant: 12),
            errorLabel.leadingAnchor.constraint(equalTo: releaseButton.leadingAnchor, constant: 10),
            errorLabel.trailingAnchor.constraint(equalTo: releaseButton.trailingAnchor, constant: -10),
            errorLabel.bottomAnchor.constraint(equalTo: communitySharingContentView.bottomAnchor, constant: -34)
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

    private func makeFieldBlock(productHighlightTitle: String, field: UITextField, placeholder: String) -> UIView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 18

        let label = UILabel()
        label.text = productHighlightTitle
        label.font = CommunitySharingAuthTheme.productShowcaseTitleFont(size: 30)
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
            let button = makeCategoryButton(productHighlightTitle: item.productHighlightTitle)
            button.tag = index
            button.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
            categoryButtons.append(button)
            (index < 2 ? firstRow : secondRow).addArrangedSubview(button)
        }
        updateCategoryButtons()
        return rows
    }

    private func makeCategoryButton(productHighlightTitle: String) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = productHighlightTitle
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
            let title = BivvyMockContent.categories[button.tag].productHighlightTitle
            var configuration = button.configuration
            configuration?.baseForegroundColor = title == selectedCategory ? .white : UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
            configuration?.baseBackgroundColor = title == selectedCategory ? CommunitySharingAuthTheme.favoriteFindPink : UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
            button.configuration = configuration
        }
    }

    @objc private func selectCategory(_ sender: UIButton) {
        selectedCategory = BivvyMockContent.categories[sender.tag].productHighlightTitle
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
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            errorLabel.text = BivvyStringVault.photoUnavailable
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    private func updateReleaseButtonState() {
        releaseButton.isEnabled = isFormReady
    }

    private var isFormReady: Bool {
        uploadedFindImage != nil &&
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
        guard let uploadedFindImage else {
            errorLabel.text = BivvyStringVault.uploadPhoto
            updateReleaseButtonState()
            return
        }
        guard !title.isEmpty, !price.isEmpty, !quality.isEmpty, !city.isEmpty, !exchange.isEmpty else {
            errorLabel.text = BivvyStringVault.completeFields
            updateReleaseButtonState()
            return
        }

        view.endEditing(true)
        releaseButton.isSharingMechanicLoading = true
        errorLabel.text = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            guard let savedImagePath = BivvyLocalFindStore.communityMarket.saveProductShowcaseImage(uploadedFindImage) else {
                self.releaseButton.isSharingMechanicLoading = false
                self.errorLabel.text = BivvyStringVault.uploadFailed
                self.updateReleaseButtonState()
                return
            }
            BivvyLocalFindStore.communityMarket.addProductShowcase(
                productHighlightTitle: title,
                communityMarketPrice: price,
                excellentConditionGrade: quality,
                communityMarketCity: city,
                itemExchangeDemand: exchange,
                productCategoryName: self.selectedCategory,
                productShowcaseImageName: savedImagePath,
                productWalkthroughImageNames: [savedImagePath]
            )
            self.releaseButton.isSharingMechanicLoading = false
            self.showPublishSuccess()
        }
    }

    private func showPublishSuccess() {
        let alert = UIAlertController(title: BivvyStringVault.released, message: BivvyStringVault.releaseMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: BivvyStringVault.viewHome, style: .default) { [weak self] _ in
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

extension BivvyFindPublishViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let selectedImage = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        picker.dismiss(animated: true) { [weak self] in
            guard let self, let selectedImage else { return }
            self.uploadedFindImage = selectedImage
            self.uploadButton.setImage(selectedImage, for: .normal)
            self.uploadButton.imageView?.contentMode = .scaleAspectFill
            self.uploadButton.backgroundColor = UIColor.white.withAlphaComponent(0.58)
            self.errorLabel.text = nil
            self.updateReleaseButtonState()
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
