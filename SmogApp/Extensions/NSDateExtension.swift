

import Foundation

extension(NSDate) {
    class func iso8601Formatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }

    class func changeDateToIso8601HowString(dateString: String) -> String {

        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        let formatDate = dateFormatter.dateFromString(dateString)
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formatDateString = dateFormatter.stringFromDate(formatDate!)
        return formatDateString
    }

    class func getActualDateIso8601() -> String {

        let currentDateTime = NSDate()

        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let actualDateIso8601 = dateFormatter.stringFromDate(currentDateTime)

        return actualDateIso8601
    }

    class func getActualDateIso8601ForRequestKeys() -> String {

        let currentDateTime = NSDate()

        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'"

        let actualDateIso8601 = dateFormatter.stringFromDate(currentDateTime)

        return actualDateIso8601
    }

    class func getDayInWeek() -> (dayWeek: Int?, textOpen: String) {

        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Weekday], fromDate: date)
        let day = components.weekday
        let textOpenSite = "Working Hours today open: "

        switch day {
        case 1: return (6, textOpenSite) // Niedziela
        case 2: return (0, textOpenSite) // Poniedzialek
        case 3: return (1, textOpenSite) // wtorek
        case 4: return (2, textOpenSite) // sroda
        case 5: return (3, textOpenSite) // czwartek
        case 6: return (4, textOpenSite) // piatek
        case 7: return (5, textOpenSite) // sobota
        default: return (nil, textOpenSite)
        }
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> NSDate {
        let timezone: NSTimeZone = NSTimeZone.localTimeZone()
        let seconds: NSTimeInterval = NSTimeInterval(timezone.secondsFromGMTForDate(self))
        return NSDate(timeInterval: seconds, sinceDate: self)
    }
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> NSDate {
        let timezone: NSTimeZone = NSTimeZone.localTimeZone()
        let seconds: NSTimeInterval = -NSTimeInterval(timezone.secondsFromGMTForDate(self))
        return NSDate(timeInterval: seconds, sinceDate: self)
    }
}