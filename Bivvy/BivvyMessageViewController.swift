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

        let aiCard = makeAICard()
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
        view.addSubview(aiCard)
        view.addSubview(latestTitle)
        view.addSubview(emptyCard)
        emptyCard.addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backButton.trailingAnchor, constant: 20),

            aiCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            aiCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            aiCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            aiCard.heightAnchor.constraint(equalToConstant: 254),

            latestTitle.topAnchor.constraint(equalTo: aiCard.bottomAnchor, constant: 46),
            latestTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            latestTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            emptyCard.topAnchor.constraint(equalTo: latestTitle.bottomAnchor, constant: 24),
            emptyCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emptyCard.heightAnchor.constraint(equalToConstant: 140),

            emptyLabel.leadingAnchor.constraint(equalTo: emptyCard.leadingAnchor, constant: 20),
            emptyLabel.trailingAnchor.constraint(equalTo: emptyCard.trailingAnchor, constant: -20),
            emptyLabel.centerYAnchor.constraint(equalTo: emptyCard.centerYAnchor)
        ])
    }

    private func makeAICard() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255 / 255, green: 104 / 255, blue: 126 / 255, alpha: 1)
        button.layer.cornerRadius = 30
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(openAssistant), for: .touchUpInside)

        let gradient = BivvyGradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.isUserInteractionEnabled = false
        gradient.colors = [
            UIColor(red: 241 / 255, green: 87 / 255, blue: 231 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 112 / 255, blue: 74 / 255, alpha: 1)
        ]
        gradient.layer.cornerRadius = 30
        gradient.layer.masksToBounds = true

        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "ShareSpark\nInspiration Generation"
        title.font = BivvyAuthTheme.titleFont(size: 30)
        title.textColor = .white
        title.numberOfLines = 2
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOpacity = 0.28
        title.layer.shadowRadius = 4
        title.layer.shadowOffset = CGSize(width: 0, height: 3)

        let arrow = UIButton(type: .system)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.isUserInteractionEnabled = false
        arrow.backgroundColor = UIColor.white.withAlphaComponent(0.72)
        arrow.layer.cornerRadius = 28
        arrow.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        arrow.tintColor = .black

        let robot = UIImageView(image: UIImage(named: "recopal"))
        robot.translatesAutoresizingMaskIntoConstraints = false
        robot.contentMode = .scaleAspectFit
        robot.isUserInteractionEnabled = false

        button.addSubview(gradient)
        button.addSubview(title)
        button.addSubview(arrow)
        button.addSubview(robot)

        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: button.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: button.bottomAnchor),

            title.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 30),
            title.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: -12),
            title.trailingAnchor.constraint(lessThanOrEqualTo: robot.leadingAnchor, constant: -12),

            arrow.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 28),
            arrow.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 28),
            arrow.widthAnchor.constraint(equalToConstant: 200),
            arrow.heightAnchor.constraint(equalToConstant: 64),

            robot.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 18),
            robot.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 24),
            robot.widthAnchor.constraint(equalToConstant: 190),
            robot.heightAnchor.constraint(equalToConstant: 220)
        ])
        return button
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func openAssistant() {
        guard let url = BivvyH5Route.aiAssistant.url() else { return }
        let web = BivvyWebViewController(url: url)
        web.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(web, animated: true)
    }
}
