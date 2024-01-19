import UIKit

let calendar = Calendar.current
let yest = calendar.date(byAdding: .day, value: -1, to: Date())
let df = DateFormatter()
df.dateFormat = "YYYY-MM-dd"

print(yest)
