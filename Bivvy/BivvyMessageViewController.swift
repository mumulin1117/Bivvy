import UIKit

final class BivvyMessageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let background = BivvyGradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.colors = [
            UIColor(red: 255 / 255, green: 205 / 255, blue: 215 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 246 / 255, blue: 251 / 255, alpha: 1),
            UIColor.white
        ]
        background.startPoint = CGPoint(x: 0, y: 0)
        background.endPoint = CGPoint(x: 0.82, y: 0.48)

        let backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Message"
        titleLabel.font = .systemFont(ofSize: 28, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center

       
        let latestTitle = UILabel()
        latestTitle.translatesAutoresizingMaskIntoConstraints = false
        latestTitle.text = "Latest News"
        latestTitle.font = BivvyAuthTheme.titleFont(size: 30)
        latestTitle.textColor = .black

        let emptyCard = UIView()
        emptyCard.translatesAutoresizingMaskIntoConstraints = false
        emptyCard.backgroundColor = .white
        emptyCard.layer.cornerRadius = 26
        emptyCard.layer.shadowColor = UIColor.black.cgColor
        emptyCard.layer.shadowOpacity = 0.06
        emptyCard.layer.shadowRadius = 18
        emptyCard.layer.shadowOffset = CGSize(width: 0, height: 8)

        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "No friend messages yet."
        emptyLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        emptyLabel.textColor = UIColor(red: 145 / 255, green: 145 / 255, blue: 145 / 255, alpha: 1)
        emptyLabel.textAlignment = .center

        view.addSubview(background)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
       
        view.addSubview(latestTitle)
        view.addSubview(emptyCard)
        emptyCard.addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backButton.trailingAnchor, constant: 20),

            latestTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            latestTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            latestTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            emptyCard.topAnchor.constraint(equalTo: latestTitle.bottomAnchor, constant:12),
            emptyCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emptyCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            emptyCard.heightAnchor.constraint(equalToConstant: 80),

            emptyLabel.leadingAnchor.constraint(equalTo: emptyCard.leadingAnchor, constant: 20),
            emptyLabel.trailingAnchor.constraint(equalTo: emptyCard.trailingAnchor, constant: -20),
            emptyLabel.centerYAnchor.constraint(equalTo: emptyCard.centerYAnchor)
        ])
    }


    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

   
}
