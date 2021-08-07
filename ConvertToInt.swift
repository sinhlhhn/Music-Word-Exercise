//
//  ConvertToInt.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 8/7/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import Foundation
import Charts
class DigitValueFormatter : NSObject, IValueFormatter {

    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        let valueWithoutDecimalPart = String(format: "%.0f", value)
        return "\(valueWithoutDecimalPart)"
    }
}
