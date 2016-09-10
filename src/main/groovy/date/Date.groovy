package date

import java.text.SimpleDateFormat

/**
 * Created by nick on 2016/1/31.
 */
class DateUtils {
    def static toStr(date) {
        if(date){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
            return sdf.format(date)
        }
    }
    def static getHour(date, hours) {
        def calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.add(Calendar.HOUR_OF_DAY, hours)
        date = calendar.getTime()
        (Date)date
    }
    /**
     * 获取当前日再根据参数加或减
     * @param date
     * @return
     */
    def static getDate(date,days){
        def calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.add(Calendar.DAY_OF_MONTH, days)
        date = calendar.getTime()
        (Date)date
    }

    /**
     * 获取当前月份再根据参数加或减
     * @param date
     * @return
     */
    def static getMonth(date,month){
        def calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.add(Calendar.MONTH, month)
        date = calendar.getTime()
        (Date)date
    }
    /**
     * 获取当前月份再根据参数加或减
     * @param date
     * @return
     */
    def static getYear(date,year){
        def calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.add(Calendar.YEAR, year)
        date = calendar.getTime()
        (Date)date
    }

    def static todayBeginning() {
        Calendar currentDate = new GregorianCalendar();
        currentDate.set(Calendar.HOUR_OF_DAY, 0);
        currentDate.set(Calendar.MINUTE, 0);
        currentDate.set(Calendar.SECOND, 0);
        return (Date)currentDate.getTime().clone()
    }

    def static todayEndding() {
        Calendar currentDate = new GregorianCalendar();
        currentDate.set(Calendar.HOUR_OF_DAY, 23);
        currentDate.set(Calendar.MINUTE, 59);
        currentDate.set(Calendar.SECOND, 59);
        return (Date)currentDate.getTime().clone()
    }

    def static thisWeekBeginning() {
        Calendar currentDate = new GregorianCalendar();
        currentDate.setFirstDayOfWeek(Calendar.MONDAY);

        currentDate.set(Calendar.HOUR_OF_DAY, 0);
        currentDate.set(Calendar.MINUTE, 0);
        currentDate.set(Calendar.SECOND, 0);
        currentDate.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        return (Date)currentDate.getTime().clone()
    }

    def static thisWeekEndding() {
        Calendar currentDate = new GregorianCalendar();
        currentDate.setFirstDayOfWeek(Calendar.MONDAY);
        currentDate.set(Calendar.HOUR_OF_DAY, 23);
        currentDate.set(Calendar.MINUTE, 59);
        currentDate.set(Calendar.SECOND, 59);
        currentDate.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
        return (Date)currentDate.getTime().clone()
    }
}
