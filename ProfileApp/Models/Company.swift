//
//  Company.swift
//  Company
//
//  Created by Сергей Корнев on 01.08.2021.
//

import Foundation


// MARK: - Company
struct DataResponse: Codable {
    let suggestions: [Suggestion]?
}

// MARK: - Suggestion
struct Suggestion: Codable {
    let value: String?
    let unrestricted_value: String?
    let data: SuggestionData?
}

// MARK: - SuggestionData
struct SuggestionData: Codable {
    let kpp: String?                // КПП
    let management: Management?     // Руководитель; ФИО, должность
    let branchType: String?         // MAIN - головной офис, BRANCH - филиал
    let branchCount: Int?           // Кол-во филиалов
    let type: String?               // LEGAL — юридическое лицо, INDIVIDUAL — индивидуальный предприниматель
    let state: State?               // Состояние
    
    let inn: String?                // ИНН
    let ogrn: String?               // ОГРН
    let ogrnDate: Double?           // Дата выдачи
    
    let name: Name?                 // Название организации
    
    let fio: FIO?                   // ФИО ИП
    
    let okato: String?              // Код ОКАТО
    let oktmo: String?              // Код ОКТМО
    let okpo: String?               // Код ОКПО
    let okogu: String?              // Код ОКОГУ
    let okfs: String?               // Код ОКФС
    let okved: String?              // Код ОКВЭД
    let okvedType: String?          // Версия справочника ОКВЭД
    let opf: Opf?                   // Организационно-правовая форма
    let address: Address?           // Адрес организации
    
    var description: String {
        let description = """
        Наименование: \(name?.fullWithOpf ?? "-")
        \(branchType == "MAIN" ? "Головной офис" : "Филиал")
        Статус: \(state?.description ?? "-")
        Руководитель: \(management?.name ?? "-")
        Должность: \(management?.post ?? "-")
        ИНН: \(inn ?? "-")
        КПП: \(kpp ?? "-")
        ОКВЭД: \(okved ?? "-")
        ОКПО: \(okpo ?? "-")
        Адрес: \(address?.value ?? "")
        Адрес в ЕГРЮЛ: \(address?.data?.source ?? "")
        """
        return description
    }
    
    enum CodingKeys: String, CodingKey {
        case kpp
        case management
        case branchType = "branch_type"
        case branchCount = "branch_count"
        case type
        case state
        case inn
        case ogrn
        case ogrnDate = "ogrn_date"
        case name
        case fio
        case okato
        case oktmo
        case okpo
        case okogu
        case okfs
        case okved
        case okvedType = "okved_type"
        case opf
        case address
    }
}


// MARK: - FIO
struct FIO: Codable {               // ФИО ИП
    let name: String?
    let surname: String?
    let patronymic: String?
}

// MARK: - Address
struct Address: Codable {
    let value: String?              // Адрес одной строкой
    let unrestrictedValue: String?  // Адрес одной строкой (полный, с индексом)
    let data: AddressData?          // Адресные данные
    
    enum CodingKeys: String, CodingKey {
        case value
        case unrestrictedValue = "unrestricted_value"
        case data
    }
}

// MARK: - AddressData
struct AddressData: Codable {
    let source: String?              // Адрес как в ЕГРЮЛ
    let country: String?             // Страна
    let federalDistrict: String?
    let regionWithType: String?
    let cityWithType: String?
    let cityArea: String?
    let cityDistrictWithType: String?
    let streetWithType: String?
    let okato: String?
    let oktmo: String?
    let timezone: String?
    let geoLatitude: String?         // Широта
    let geoLongitude: String?        // Долгота
    let qcGeo: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case country
        case federalDistrict = "federal_district"
        case regionWithType = "region_with_type"
        case cityWithType = "city_with_type"
        case cityArea = "city_area"
        case cityDistrictWithType = "city_district_with_type"
        case streetWithType = "street_with_type"
        case okato
        case oktmo
        case timezone
        case geoLatitude = "geo_lat"
        case geoLongitude = "geo_lon"
        case qcGeo
    }
}

// MARK: - Management
struct Management: Codable {
    let name: String?           // ФИО Руководителя
    let post: String?           // Должность
}

// MARK: - Name
struct Name: Codable {
    let fullWithOpf: String?    // полное наименование
    let shortWithOpf: String?   // краткое наименование
    let full: String?           // полное наименование без ОПФ
    let short: String?          // краткое наименование без ОПФ
    
    enum CodingKeys: String, CodingKey {
        case fullWithOpf = "full_with_opf"
        case shortWithOpf = "short_with_opf"
        case full
        case short
    }
    
    var description: String {
        return shortWithOpf ?? "-"
    }
}

// MARK: - Opf
struct Opf: Codable {
    let type: String?           // версия справочника ОКОПФ (99, 2012 или 2014)
    let code: String?           // код ОКОПФ
    let full: String?           // полное название ОПФ
    let short: String?          // краткое название ОПФ
}

// MARK: - State
struct State: Codable {
    var actualityDate: Int?          // дата последних изменений
    let registrationDate: Int?       // дата регистрации
    let liquidationDate: Int?        // дата ликвидации

    let status: String?         /*  ACTIVE       — действующая
                                    LIQUIDATING  — ликвидируется
                                    LIQUIDATED   — ликвидирована
                                    BANKRUPT     — банкротство
                                    REORGANIZING — в процессе присоединения к другому юрлицу, с последующей ликвидацией */
    
    enum CodingKeys: String, CodingKey {
        case actualityDate = "actuality_date"
        case registrationDate = "registration_date"
        case liquidationDate = "liquidation_date"
        case status
    }
    
    var description: String {
        guard let status = status else { return "" }
        switch status {
        case "ACTIVE": return "действующее, дата регистрации: \(Date(milliseconds: actualityDate ?? 0).dateCompactString)"
        case "LIQUIDATING": return "ликвидируется"
        case "LIQUIDATED": return "ликвидировано, дата ликвидации: \(Date(milliseconds: liquidationDate ?? 0).dateCompactString)"
        case "BANKRUPT": return "банкрот"
        case "REORGANIZING": return "в процессе реорганизации"
        default: return "нет данных"
        }
    }
    
}
