/**
 * 日期格式化工具
 */

/**
 * 格式化日期
 * @param {Date|String} date 日期对象或日期字符串
 * @param {String} fmt 格式化字符串 例如: 'yyyy-MM-dd HH:mm:ss'
 * @returns {String} 格式化后的日期字符串
 */
export function formatDate(date, fmt) {
  if (!date) return '';
  
  if (typeof date === 'string') {
    // 尝试转换为日期对象
    date = new Date(date);
  }
  
  if (!(date instanceof Date) || isNaN(date.getTime())) {
    console.warn('无效的日期:', date);
    return '';
  }

  const o = {
    'yyyy': date.getFullYear(),
    'MM': (date.getMonth() + 1).toString().padStart(2, '0'),
    'dd': date.getDate().toString().padStart(2, '0'),
    'HH': date.getHours().toString().padStart(2, '0'),
    'mm': date.getMinutes().toString().padStart(2, '0'),
    'ss': date.getSeconds().toString().padStart(2, '0')
  };
  
  let result = fmt;
  for (let k in o) {
    if (new RegExp(`(${k})`).test(result)) {
      result = result.replace(RegExp.$1, o[k]);
    }
  }
  
  return result;
}

/**
 * 获取日期是星期几
 * @param {Date} date 日期对象
 * @returns {String} 星期几
 */
export function getWeekDay(date) {
  if (!date) return '';
  
  const weekDays = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
  return weekDays[date.getDay()];
}

/**
 * 日期比较
 * @param {Date|String} date1 日期1
 * @param {Date|String} date2 日期2
 * @returns {Number} 1: date1 > date2, 0: date1 = date2, -1: date1 < date2
 */
export function compareDate(date1, date2) {
  const d1 = new Date(date1).getTime();
  const d2 = new Date(date2).getTime();
  
  if (d1 > d2) return 1;
  if (d1 === d2) return 0;
  return -1;
} 