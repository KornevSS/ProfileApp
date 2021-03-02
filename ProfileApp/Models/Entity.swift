//
//  Counterparty.swift
//  ProfileApp
//
//  Created by Сергей Корнев on 02.03.2021.
//

struct Entity: Decodable {
    let name: String?                     // Наименование Юрлица
    let ogrn: String?                     // ОГРН
    let inn: String?                      // ИНН
    let region: String?                   // Область
    let address: String?                  // Адрес
    let inactive: Int?                    // Не действующее если, то 3
    let ceo_name: String?                 // ФИО Руководителя
    let ceo_type: String?                 // Должность
    let okved_descr: String?              // Описание вида деятельности
}

struct EntityCount: Decodable {
    let ul_count: Int?                    // Кол-во юрлиц контрагента
    let ul: [Entity]?               // Массив юрлиц
}
