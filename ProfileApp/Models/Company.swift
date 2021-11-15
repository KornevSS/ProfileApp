//
//  CompanyV2.swift
//  CompanyV2
//
//  Created by Сергей Корнев on 01.08.2021.
//


// MARK: - Company
struct DataResponse: Decodable {
    let suggestions: [Suggestion]?
}

// MARK: - Suggestion
struct Suggestion: Decodable {
    let value: String?
    let unrestricted_value: String?
    let data: SuggestionData?
}

// MARK: - SuggestionData
struct SuggestionData: Decodable {
    let kpp: String?                // КПП
    let management: Management?     // Руководитель; ФИО, должность
    let branch_type: String?        // MAIN - головной офис, BRANCH - филиал
    let branch_count: Int?          // Кол-во филиалов
    let type: String?               // LEGAL — юридическое лицо, INDIVIDUAL — индивидуальный предприниматель
    let state: State?               // Состояние
    
    let inn: String?                // ИНН
    let ogrn: String?               // ОГРН
    let ogrn_date: Double?          // Дата выдачи

    let name: Name?                 // Название организации
    
    let fio: FIO?                   // ФИО ИП

    let okato: String?              // Код ОКАТО
    let oktmo: String?              // Код ОКТМО
    let okpo: String?               // Код ОКПО
    let okogu: String?              // Код ОКОГУ
    let okfs: String?               // Код ОКФС
    let okved: String?              // Код ОКВЭД
    let okved_type: String?         // Версия справочника ОКВЭД
    let opf: Opf?                   // Организационно-правовая форма
    let address: Address?           // Адрес организации
    
    var description: String {
        let description = """
        Наименование: \(name?.full_with_opf ?? "-")
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
}


// MARK: - FIO
struct FIO: Decodable {             // ФИО ИП
    let name: String?
    let surname: String?
    let patronymic: String?
}

// MARK: - Address
struct Address: Decodable {
    let value: String?              // Адрес одной строкой
    let unrestricted_value: String? // Адрес одной строкой (полный, с индексом)
    let data: AddressData?          // Адресные данные
}

// MARK: - AddressData
struct AddressData: Decodable {
    let source: String?             // Адрес как в ЕГРЮЛ
    let country: String?            // Страна
    let federal_district: String?
    let region_with_type: String?
    let city_with_type: String?
    let city_area: String?
    let city_district_with_type: String?
    let street_with_type: String?
    let okato: String?
    let oktmo: String?
    let timezone: String?
    let geo_lat: String?            // Широта
    let geo_lon: String?            // Долгота
    let qcGeo: String?
}

// MARK: - Management
struct Management: Decodable {
    let name: String?           // ФИО Руководителя
    let post: String?           // Должность
}

// MARK: - Name
struct Name: Decodable {
    let full_with_opf: String?  // полное наименование
    let short_with_opf: String? // краткое наименование
    let full: String?           // полное наименование без ОПФ
    let short: String?          // краткое наименование без ОПФ
}

// MARK: - Opf
struct Opf: Decodable {
    let type: String?           // версия справочника ОКОПФ (99, 2012 или 2014)
    let code: String?           // код ОКОПФ
    let full: String?           // полное название ОПФ
    let short: String?          // краткое название ОПФ
}

// MARK: - State
struct State: Decodable {
    let status: String?         /*  ACTIVE       — действующая
                                    LIQUIDATING  — ликвидируется
                                    LIQUIDATED   — ликвидирована
                                    BANKRUPT     — банкротство
                                    REORGANIZING — в процессе присоединения к другому юрлицу, с последующей ликвидацией */
    
    var description: String {
        guard let status = status else { return "нет данных" }
        switch status {
        case "ACTIVE": return "действующее"
        case "LIQUIDATING": return "ликвидируется"
        case "LIQUIDATED": return "ликвидировано"
        case "REORGANIZING": return "в процессе реорганизации"
        default: return "нет данных"
        }
        
    }
}

