import UIKit

final class BivvyProfileSetupViewController: BivvyKeyboardAvoidingViewController {
    private let email: String
    private let password: String
    private let nameField = BivvyAuthTextFieldView(title: "Name", placeholder: "Howard Ramos")
    private let aboutField = BivvyAuthTextFieldView(title: "About me", placeholder: "Please enter")
    private let birthdayButton = UIButton(type: .system)
    private let datePicker = UIDatePicker()
    private let maleButton = UIButton(type: .system)
    private let femaleButton = UIButton(type: .system)
    private let enterButton = BivvyGradientButton(title: "Enter")
    private let errorLabel = UILabel()
    private var selectedGender = "Male"

    init(email: String, password: String) {
        self.email = email
        self.password = password
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        updateGenderButtons()
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let background = BivvyGradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.isUserInteractionEnabled = false
        background.colors = [
            UIColor(red: 255 / 255, green: 235 / 255, blue: 244 / 255, alpha: 1),
            .white,
            .white
        ]
        background.startPoint = CGPoint(x: 0.5, y: 0)
        background.endPoint = CGPoint(x: 0.5, y: 1)
        view.insertSubview(background, belowSubview: scrollView)

        let back = UIButton(type: .custom)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setImage(UIImage(named: "bivvy_auth_back_icon"), for: .normal)
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "COMPLETE THE DATA"
        title.font = BivvyAuthTheme.displayFont(size: 27)
        title.adjustsFontSizeToFitWidth = true
        title.textAlignment = .center

        let genderLabel = makeSectionLabel("Gender")
        maleButton.translatesAutoresizingMaskIntoConstraints = false
        femaleButton.translatesAutoresizingMaskIntoConstraints = false
        [maleButton, femaleButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.layer.cornerRadius = 24
            $0.layer.borderWidth = 1.5
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        maleButton.setTitle("♂  Male  ♀", for: .normal)
        femaleButton.setTitle("♂  ♀  Female", for: .normal)
        maleButton.addTarget(self, action: #selector(selectMale), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(selectFemale), for: .touchUpInside)

        let genderRow = UIStackView(arrangedSubviews: [maleButton, femaleButton])
        genderRow.translatesAutoresizingMaskIntoConstraints = false
        genderRow.axis = .horizontal
        genderRow.spacing = 28
        genderRow.distribution = .fillEqually

        let birthdayLabel = makeSectionLabel("Birthday")
        birthdayButton.translatesAutoresizingMaskIntoConstraints = false
        birthdayButton.setTitle("2023-03-23  ▾", for: .normal)
        birthdayButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        birthdayButton.setTitleColor(BivvyAuthTheme.ink, for: .normal)
        birthdayButton.layer.borderColor = UIColor.black.cgColor
        birthdayButton.layer.borderWidth = 1.5
        birthdayButton.layer.cornerRadius = 28
        birthdayButton.heightAnchor.constraint(equalToConstant: 56).isActive = true

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        birthdayButton.addSubview(datePicker)

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        errorLabel.textColor = BivvyAuthTheme.hotPink
        errorLabel.numberOfLines = 0

        enterButton.addTarget(self, action: #selector(enter), for: .touchUpInside)

        [back, title, nameField, genderLabel, genderRow, birthdayLabel, birthdayButton, aboutField, enterButton, errorLabel].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            back.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            back.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            back.widthAnchor.constraint(equalToConstant: 44),
            back.heightAnchor.constraint(equalToConstant: 44),

            title.topAnchor.constraint(equalTo: back.bottomAnchor, constant: 72),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),

            nameField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 70),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            genderLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 32),
            genderLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),

            genderRow.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 16),
            genderRow.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            genderRow.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),

            birthdayLabel.topAnchor.constraint(equalTo: genderRow.bottomAnchor, constant: 32),
            birthdayLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),

            birthdayButton.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 16),
            birthdayButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            birthdayButton.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),

            datePicker.trailingAnchor.constraint(equalTo: birthdayButton.trailingAnchor, constant: -18),
            datePicker.centerYAnchor.constraint(equalTo: birthdayButton.centerYAnchor),

            aboutField.topAnchor.constraint(equalTo: birthdayButton.bottomAnchor, constant: 44),
            aboutField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            aboutField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),

            enterButton.topAnchor.constraint(equalTo: aboutField.bottomAnchor, constant: 56),
            enterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            enterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            errorLabel.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 14),
            errorLabel.leadingAnchor.constraint(equalTo: enterButton.leadingAnchor, constant: 12),
            errorLabel.trailingAnchor.constraint(equalTo: enterButton.trailingAnchor, constant: -12),
            errorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -32)
        ])
    }

    private func makeSectionLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = BivvyAuthTheme.titleFont(size: 20)
        label.textColor = .black
        return label
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func selectMale() {
        selectedGender = "Male"
        updateGenderButtons()
    }

    @objc private func selectFemale() {
        selectedGender = "Female"
        updateGenderButtons()
    }

    private func updateGenderButtons() {
        let maleSelected = selectedGender == "Male"
        styleGenderButton(maleButton, selected: maleSelected)
        styleGenderButton(femaleButton, selected: !maleSelected)
    }

    private func styleGenderButton(_ button: UIButton, selected: Bool) {
        button.setTitleColor(selected ? .white : .systemGray, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = selected ? BivvyAuthTheme.pink : .clear
    }

    @objc private func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthdayButton.setTitle("\(formatter.string(from: datePicker.date))  ▾", for: .normal)
    }

    @objc private func enter() {
        guard !nameField.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorLabel.text = "Name is required."
            return
        }

        enterButton.isLoading = true
        errorLabel.text = nil
        let draft = BivvyProfileDraft(
            email: email,
            password: password,
            name: nameField.text,
            gender: selectedGender,
            birthday: datePicker.date,
            about: aboutField.text
        )
        BivvyMockAuthStore.shared.register(draft: draft) { [weak self] result in
            guard let self else { return }
            self.enterButton.isLoading = false
            switch result {
            case .success:
                (self.view.window?.windowScene?.delegate as? BivvySceneDelegate)?.showMainInterface()
            case .failure(let error):
                self.errorLabel.text = error.localizedDescription
            }
        }
    }
}
