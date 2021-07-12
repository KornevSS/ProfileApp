//
//  Counterparty.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
// для примера ИНН 621200022669 КФХ Шкарапут
import Foundation

// MARK: - Website Description
struct WebsiteDescription: Decodable {
    let ulCount: Int?
    let ul: [Entity]?
    let success: Bool?
    let code: Int?
    let message: String?
}


// MARK: - Entity
struct Entity: Decodable {
    let name, raw_name: String?
    let many_ceo: Int?
    let link, ogrn, raw_ogrn, inn: String?
    let region, address: String?
    let inactive, status_extended: Int?
    let ceo_name, ceo_type, snippet_string, snippet_type: String?
    let status_code, svprekrul_date: String?
    let main_okved_id, okved_descr: String?
    let authorized_capital: String?
    let reg_date, url: String?
    
    var description: String {
        """
        Название: \(name ?? "не указано")
        ОГРН: \(ogrn ?? "не указан")
        ИНН: \(formattedINN)
        Область: \(region ?? "не указана")
        Адрес: \(address ?? "не указан")
        Статус: \(status)
        ФИО руководителя: \(ceo_name ?? "не указано")
        Должность: \(ceo_type ?? "не указана")
        Вид деятельности: \(okved_descr ?? "не указан")
        ОКВЭД: \(main_okved_id ?? "не указан")
        Уставной капитал, руб.: \(authorized_capital ?? "не указан")
        Дата регистрации: \(reg_date ?? "не указана")
        """

    }
    
    
    private var status: String {
        switch inactive {
        case 0: return "Действующее ✅"
        case 1: return "В процессе банкротства 💸"
        case 2, 3: return "В процессе ликвидации 🚫"
        default: return "-"
        }
    }
    
    var formattedINN: String {
        return inn?.filter("01234567890".contains) ?? "-"
    }
}
