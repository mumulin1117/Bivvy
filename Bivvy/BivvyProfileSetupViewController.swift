import UIKit

final class ProductCurationProfileSetupViewController: ContentFilteringKeyboardAvoidingViewController {
    private let peerInteractionEmail: String
    private let contentFilteringPassword: String
    private let contentCreatorNameField = ProductTaggingAuthTextFieldView(productTaggingTitle: BivvyStringVault.name, conversationStarterPlaceholder: "Howard Ramos")
    private let authenticReviewAboutField = ProductTaggingAuthTextFieldView(productTaggingTitle: BivvyStringVault.aboutMe, conversationStarterPlaceholder: BivvyStringVault.pleaseEnter)
    private let dailyRoutineBirthdayButton = UIButton(type: .system)
    private let dailyRoutineDatePicker = UIDatePicker()
    private let interestMatchingMaleButton = UIButton(type: .system)
    private let interestMatchingFemaleButton = UIButton(type: .system)
    private let communitySharingEnterButton = SharingMechanicGradientButton(title: BivvyStringVault.enter)
    private let contentFilteringErrorLabel = UILabel()
    private var selectedInterestMatchingGender = "Male"

    init(email: String, password: String) {
        self.peerInteractionEmail = email
        self.contentFilteringPassword = password
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildProductCurationProfileLayout()
        updateInterestMatchingButtons()
    }

    private func buildProductCurationProfileLayout() {
        view.backgroundColor = .white

        let dailyInspirationBackground = ProductCurationGradientView()
        dailyInspirationBackground.translatesAutoresizingMaskIntoConstraints = false
        dailyInspirationBackground.isUserInteractionEnabled = false
        dailyInspirationBackground.curatedListColors = [
            UIColor(red: 255 / 255, green: 235 / 255, blue: 244 / 255, alpha: 1),
            .white,
            .white
        ]
        dailyInspirationBackground.productCurationStartPoint = CGPoint(x: 0.5, y: 0)
        dailyInspirationBackground.productCurationEndPoint = CGPoint(x: 0.5, y: 1)
        view.insertSubview(dailyInspirationBackground, belowSubview: contentFilteringScrollView)

        let productCurationBackButton = UIButton(type: .custom)
        productCurationBackButton.translatesAutoresizingMaskIntoConstraints = false
        productCurationBackButton.setImage(UIImage(named: "bivvy_auth_back_icon"), for: .normal)
        productCurationBackButton.addTarget(self, action: #selector(closeProductCurationProfile), for: .touchUpInside)

        let productCurationTitle = UILabel()
        productCurationTitle.translatesAutoresizingMaskIntoConstraints = false
        productCurationTitle.text = BivvyStringVault.completeData
        productCurationTitle.font = CommunitySharingAuthTheme.dailyInspirationDisplayFont(size: 27)
        productCurationTitle.adjustsFontSizeToFitWidth = true
        productCurationTitle.textAlignment = .center

        let interestMatchingGenderLabel = makeProductCurationSectionLabel(BivvyStringVault.gender)
        interestMatchingMaleButton.translatesAutoresizingMaskIntoConstraints = false
        interestMatchingFemaleButton.translatesAutoresizingMaskIntoConstraints = false
        [interestMatchingMaleButton, interestMatchingFemaleButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.layer.cornerRadius = 24
            $0.layer.borderWidth = 1.5
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        interestMatchingMaleButton.setTitle(BivvyStringVault.maleGlyph, for: .normal)
        interestMatchingFemaleButton.setTitle(BivvyStringVault.femaleGlyph, for: .normal)
        interestMatchingMaleButton.addTarget(self, action: #selector(selectInterestMatchingMale), for: .touchUpInside)
        interestMatchingFemaleButton.addTarget(self, action: #selector(selectInterestMatchingFemale), for: .touchUpInside)

        let interestMatchingGenderRow = UIStackView(arrangedSubviews: [interestMatchingMaleButton, interestMatchingFemaleButton])
        interestMatchingGenderRow.translatesAutoresizingMaskIntoConstraints = false
        interestMatchingGenderRow.axis = .horizontal
        interestMatchingGenderRow.spacing = 28
        interestMatchingGenderRow.distribution = .fillEqually

        let dailyRoutineBirthdayLabel = makeProductCurationSectionLabel(BivvyStringVault.birthday)
        dailyRoutineBirthdayButton.translatesAutoresizingMaskIntoConstraints = false
        dailyRoutineBirthdayButton.setTitle(BivvyStringVault.defaultDate, for: .normal)
        dailyRoutineBirthdayButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        dailyRoutineBirthdayButton.setTitleColor(CommunitySharingAuthTheme.trustedReviewInk, for: .normal)
        dailyRoutineBirthdayButton.layer.borderColor = UIColor.black.cgColor
        dailyRoutineBirthdayButton.layer.borderWidth = 1.5
        dailyRoutineBirthdayButton.layer.cornerRadius = 28
        dailyRoutineBirthdayButton.heightAnchor.constraint(equalToConstant: 56).isActive = true

        dailyRoutineDatePicker.translatesAutoresizingMaskIntoConstraints = false
        dailyRoutineDatePicker.datePickerMode = .date
        dailyRoutineDatePicker.preferredDatePickerStyle = .compact
        dailyRoutineDatePicker.maximumDate = Date()
        dailyRoutineDatePicker.addTarget(self, action: #selector(dailyRoutineDateChanged), for: .valueChanged)
        dailyRoutineBirthdayButton.addSubview(dailyRoutineDatePicker)

        contentFilteringErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentFilteringErrorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        contentFilteringErrorLabel.textColor = CommunitySharingAuthTheme.favoriteFindPink
        contentFilteringErrorLabel.numberOfLines = 0

        communitySharingEnterButton.addTarget(self, action: #selector(enterCommunitySharingProfile), for: .touchUpInside)

        [
            productCurationBackButton,
            productCurationTitle,
            contentCreatorNameField,
            interestMatchingGenderLabel,
            interestMatchingGenderRow,
            dailyRoutineBirthdayLabel,
            dailyRoutineBirthdayButton,
            authenticReviewAboutField,
            communitySharingEnterButton,
            contentFilteringErrorLabel
        ].forEach(communitySharingContentView.addSubview)

        NSLayoutConstraint.activate([
            dailyInspirationBackground.topAnchor.constraint(equalTo: view.topAnchor),
            dailyInspirationBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyInspirationBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyInspirationBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            productCurationBackButton.topAnchor.constraint(equalTo: communitySharingContentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            productCurationBackButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            productCurationBackButton.widthAnchor.constraint(equalToConstant: 44),
            productCurationBackButton.heightAnchor.constraint(equalToConstant: 44),

            productCurationTitle.topAnchor.constraint(equalTo: productCurationBackButton.bottomAnchor, constant: 72),
            productCurationTitle.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 28),
            productCurationTitle.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -28),

            contentCreatorNameField.topAnchor.constraint(equalTo: productCurationTitle.bottomAnchor, constant: 70),
            contentCreatorNameField.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 20),
            contentCreatorNameField.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -20),

            interestMatchingGenderLabel.topAnchor.constraint(equalTo: contentCreatorNameField.bottomAnchor, constant: 32),
            interestMatchingGenderLabel.leadingAnchor.constraint(equalTo: contentCreatorNameField.leadingAnchor),

            interestMatchingGenderRow.topAnchor.constraint(equalTo: interestMatchingGenderLabel.bottomAnchor, constant: 16),
            interestMatchingGenderRow.leadingAnchor.constraint(equalTo: contentCreatorNameField.leadingAnchor),
            interestMatchingGenderRow.trailingAnchor.constraint(equalTo: contentCreatorNameField.trailingAnchor),

            dailyRoutineBirthdayLabel.topAnchor.constraint(equalTo: interestMatchingGenderRow.bottomAnchor, constant: 32),
            dailyRoutineBirthdayLabel.leadingAnchor.constraint(equalTo: contentCreatorNameField.leadingAnchor),

            dailyRoutineBirthdayButton.topAnchor.constraint(equalTo: dailyRoutineBirthdayLabel.bottomAnchor, constant: 16),
            dailyRoutineBirthdayButton.leadingAnchor.constraint(equalTo: contentCreatorNameField.leadingAnchor),
            dailyRoutineBirthdayButton.trailingAnchor.constraint(equalTo: contentCreatorNameField.trailingAnchor),

            dailyRoutineDatePicker.trailingAnchor.constraint(equalTo: dailyRoutineBirthdayButton.trailingAnchor, constant: -18),
            dailyRoutineDatePicker.centerYAnchor.constraint(equalTo: dailyRoutineBirthdayButton.centerYAnchor),

            authenticReviewAboutField.topAnchor.constraint(equalTo: dailyRoutineBirthdayButton.bottomAnchor, constant: 44),
            authenticReviewAboutField.leadingAnchor.constraint(equalTo: contentCreatorNameField.leadingAnchor),
            authenticReviewAboutField.trailingAnchor.constraint(equalTo: contentCreatorNameField.trailingAnchor),

            communitySharingEnterButton.topAnchor.constraint(equalTo: authenticReviewAboutField.bottomAnchor, constant: 56),
            communitySharingEnterButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            communitySharingEnterButton.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -12),

            contentFilteringErrorLabel.topAnchor.constraint(equalTo: communitySharingEnterButton.bottomAnchor, constant: 14),
            contentFilteringErrorLabel.leadingAnchor.constraint(equalTo: communitySharingEnterButton.leadingAnchor, constant: 12),
            contentFilteringErrorLabel.trailingAnchor.constraint(equalTo: communitySharingEnterButton.trailingAnchor, constant: -12),
            contentFilteringErrorLabel.bottomAnchor.constraint(lessThanOrEqualTo: communitySharingContentView.bottomAnchor, constant: -32)
        ])
    }

    private func makeProductCurationSectionLabel(_ productCurationText: String) -> UILabel {
        let productCurationLabel = UILabel()
        productCurationLabel.translatesAutoresizingMaskIntoConstraints = false
        productCurationLabel.text = productCurationText
        productCurationLabel.font = CommunitySharingAuthTheme.productShowcaseTitleFont(size: 20)
        productCurationLabel.textColor = .black
        return productCurationLabel
    }

    @objc private func closeProductCurationProfile() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func selectInterestMatchingMale() {
        selectedInterestMatchingGender = "Male"
        updateInterestMatchingButtons()
    }

    @objc private func selectInterestMatchingFemale() {
        selectedInterestMatchingGender = "Female"
        updateInterestMatchingButtons()
    }

    private func updateInterestMatchingButtons() {
        let interestMatchingMaleSelected = selectedInterestMatchingGender == "Male"
        styleInterestMatchingButton(interestMatchingMaleButton, selected: interestMatchingMaleSelected)
        styleInterestMatchingButton(interestMatchingFemaleButton, selected: !interestMatchingMaleSelected)
    }

    private func styleInterestMatchingButton(_ interestMatchingButton: UIButton, selected: Bool) {
        interestMatchingButton.setTitleColor(selected ? .white : .systemGray, for: .normal)
        interestMatchingButton.layer.borderColor = UIColor.black.cgColor
        interestMatchingButton.backgroundColor = selected ? CommunitySharingAuthTheme.productHighlightPink : .clear
    }

    @objc private func dailyRoutineDateChanged() {
        let dailyRoutineFormatter = DateFormatter()
        dailyRoutineFormatter.dateFormat = BivvyStringVault.dateFormat
        dailyRoutineBirthdayButton.setTitle("\(dailyRoutineFormatter.string(from: dailyRoutineDatePicker.date))\(BivvyStringVault.dateArrow)", for: .normal)
    }

    @objc private func enterCommunitySharingProfile() {
        guard !contentCreatorNameField.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            contentFilteringErrorLabel.text = BivvyStringVault.nameReq
            return
        }

        communitySharingEnterButton.isSharingMechanicLoading = true
        contentFilteringErrorLabel.text = nil
        let communitySharingDraft = BivvyProfileDraft(
            peerInteraction: peerInteractionEmail,
            contentFiltering: contentFilteringPassword,
            handpickedItem: contentCreatorNameField.text,
            interestMatching: selectedInterestMatchingGender,
            dailyRoutine: dailyRoutineDatePicker.date,
            authenticReview: authenticReviewAboutField.text
        )
        CommunitySharingAuthStore.communityHub.communitySharingRegister(communitySharingDraft: communitySharingDraft) { [weak self] productReviewResult in
            guard let self else { return }
            self.communitySharingEnterButton.isSharingMechanicLoading = false
            switch productReviewResult {
            case .success:
                (self.view.window?.windowScene?.delegate as? BivvySceneDelegate)?.showMainInterface()
            case .failure(let contentFilteringError):
                self.contentFilteringErrorLabel.text = contentFilteringError.localizedDescription
            }
        }
    }
}

typealias BivvyProfileSetupViewController = ProductCurationProfileSetupViewController
