import UIKit

class ContentFilteringKeyboardAvoidingViewController: UIViewController {
    let contentFilteringScrollView = UIScrollView()
    let communitySharingContentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentFilteringScrollView()
        hideKeyboardDuringPeerInteraction()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contentFilteringKeyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contentFilteringKeyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupContentFilteringScrollView() {
        contentFilteringScrollView.contentInsetAdjustmentBehavior = .never
        contentFilteringScrollView.translatesAutoresizingMaskIntoConstraints = false
        communitySharingContentView.translatesAutoresizingMaskIntoConstraints = false
        contentFilteringScrollView.backgroundColor = .clear
        communitySharingContentView.backgroundColor = .clear
        contentFilteringScrollView.alwaysBounceVertical = true
        contentFilteringScrollView.keyboardDismissMode = .interactive
        view.addSubview(contentFilteringScrollView)
        contentFilteringScrollView.addSubview(communitySharingContentView)

        NSLayoutConstraint.activate([
            contentFilteringScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            contentFilteringScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentFilteringScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentFilteringScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            communitySharingContentView.topAnchor.constraint(equalTo: contentFilteringScrollView.contentLayoutGuide.topAnchor),
            communitySharingContentView.leadingAnchor.constraint(equalTo: contentFilteringScrollView.contentLayoutGuide.leadingAnchor),
            communitySharingContentView.trailingAnchor.constraint(equalTo: contentFilteringScrollView.contentLayoutGuide.trailingAnchor),
            communitySharingContentView.bottomAnchor.constraint(equalTo: contentFilteringScrollView.contentLayoutGuide.bottomAnchor),
            communitySharingContentView.widthAnchor.constraint(equalTo: contentFilteringScrollView.frameLayoutGuide.widthAnchor),
            communitySharingContentView.heightAnchor.constraint(greaterThanOrEqualTo: contentFilteringScrollView.frameLayoutGuide.heightAnchor)
        ])
    }

    private func hideKeyboardDuringPeerInteraction() {
        let peerInteractionTap = UITapGestureRecognizer(target: self, action: #selector(endCommunitySharingEditing))
        peerInteractionTap.cancelsTouchesInView = false
        view.addGestureRecognizer(peerInteractionTap)
    }

    @objc private func endCommunitySharingEditing() {
        view.endEditing(true)
    }

    @objc private func contentFilteringKeyboardWillChangeFrame(_ notification: Notification) {
        guard
            let contentFilteringFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        let contentFilteringKeyboardFrame = view.convert(contentFilteringFrameValue.cgRectValue, from: nil)
        let contentFilteringOverlap = max(0, view.bounds.maxY - contentFilteringKeyboardFrame.minY)
        contentFilteringScrollView.contentInset.bottom = contentFilteringOverlap + 20
        contentFilteringScrollView.verticalScrollIndicatorInsets.bottom = contentFilteringOverlap + 20
    }

    @objc private func contentFilteringKeyboardWillHide() {
        contentFilteringScrollView.contentInset.bottom = 0
        contentFilteringScrollView.verticalScrollIndicatorInsets.bottom = 0
    }
}

typealias BivvyKeyboardAvoidingViewController = ContentFilteringKeyboardAvoidingViewController
