import UIKit
import UserNotifications

class AboutViewController: UIViewController {

    @IBOutlet var notificationStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var notificationsSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadNotificationState()
        requestNotificationAuthorization()
    }

    private func setupUI() {
        notificationStackView.layer.cornerRadius = 10
        notificationStackView.clipsToBounds = true
        notificationStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        notificationStackView.isLayoutMarginsRelativeArrangement = true
    }

    private func loadNotificationState() {
        notificationsSwitch.isOn = UserDefaults.standard.bool(forKey: "notificationsEnabled")
    }

    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            DispatchQueue.main.async {
                if !granted, let error = error {
                    self.showAlert(title: "Ошибка", message: "Не удалось получить разрешение на уведомления. Пожалуйста, проверьте настройки приложения.")
                    print("Ошибка получения разрешения на уведомления: \(error)")
                }
            }
        }
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func notificationsSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notificationsEnabled")
        sender.isOn ? scheduleLocalNotification() : cancelAllNotifications()
    }

    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "Картинка переключится через 5 секунд. Можно свайпнуть."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "imageReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(title: "Ошибка", message: "Не удалось активировать уведомление: \(error.localizedDescription)")
                    print("Ошибка при отправке уведомления: \(error)")
                } else {
                    self.showAlert(title: "Уведомления активированы!", message: "Вы успешно активировали уведомления.")
                    print("Уведомления активированы!")
                }
            }
        }
    }

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        showAlert(title: "Уведомления отключены.", message: "Вы больше не будете получать уведомления от приложения.")
        print("Все ожидающие уведомления отменены.")
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
