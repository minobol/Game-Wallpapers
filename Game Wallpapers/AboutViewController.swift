//
//  AboutViewController.swift
//  Game Wallpapers
//
//  Created by MacBook on 13.02.2025.
//

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

        notificationStackView.layer.cornerRadius = 10
        notificationStackView.clipsToBounds = true
        notificationStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        notificationStackView.isLayoutMarginsRelativeArrangement = true

        // Загрузка состояния UISwitch из UserDefaults
        notificationsSwitch.isOn = UserDefaults.standard.bool(forKey: "notificationsEnabled")

        // Запрос разрешения на уведомления
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Разрешение на уведомления получено.")
            } else if let error = error {
                print("Ошибка получения разрешения на уведомления: \(error)")
            }
        }
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func notificationsSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notificationsEnabled")
        if sender.isOn {
            scheduleLocalNotification()
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            print("Все ожидающие уведомления отменены.")
        }
    }

    func scheduleLocalNotification() {
           let content = UNMutableNotificationContent()
           content.title = "Напоминание"
           content.body = "Картинка переключится через 5 секунд. Можно свайпнуть."
           content.sound = UNNotificationSound.default

           // Настройка триггера уведомления
           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Уведомление через 5 секунд

           // Создание запроса на уведомление
           let request = UNNotificationRequest(identifier: "imageReminder", content: content, trigger: trigger)

           // Добавление запроса в центр уведомлений
           UNUserNotificationCenter.current().add(request) { (error) in
               if let error = error {
                   print("Ошибка при отправке уведомления: \(error)")
               } else {
                   print("Уведомление запланировано.")
               }
           }
       }
}
