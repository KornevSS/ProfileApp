//
//  CompanyV2.swift
//  CompanyV2
//
//  Created by Сергей Корнев on 01.08.2021.
//

import Foundation

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

    let name: Name?
    
    let fio: FIO?

    let okato: String?
    let oktmo: String?
    let okpo: String?
    let okogu: String?
    let okfs: String?
    let okved: String?
    let okved_type: String?
    let opf: Opf?
    let address: Address?
    
    var description: String {
        return ""
    }
}


// MARK: - FIO
struct FIO: Decodable {
    let name: String?
    let surname: String?
    let patronymic: String?
}

// MARK: - Address
struct Address: Decodable {
    let value: String?
    let unrestricted_value: String?
    let data: AddressData?
}

// MARK: - AddressData
struct AddressData: Decodable {
    let source: String?
    let qc: String?
    let postal_code: String?
    let country: String?
    let federal_district: String?
    let region_with_type: String?
//    let regionType: String
//    let regionTypeFull: String
//    let region: String
    let city_with_type: String?
//    let cityType: String
//    let cityTypeFull: String
//    let city: String
    let city_area: String?
    let city_district_with_type: String?
//    let cityDistrictType: String
//    let cityDistrictTypeFull: String
//    let cityDistrict: String
    let street_with_type: String?
//    let street_type: String
//    let street_type_full: String
//    let street: String
    let okato: String?
    let oktmo: String?
    let timezone: String?
    let geo_lat: String?
    let geo_lon: String?
    let metro: [Metro]?
    let qcGeo: String?
}

// MARK: - Metro
struct Metro: Decodable {
    let name: String?
    let line: String?
    let distance: Double?
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
    
    let actuality_date: Double?    // дата последних изменений
    let registration_date: Double? // дата регистрации
    let liquidation_date: Double?  // дата ликвидации
}

