package link.thinkonweb.util;

import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Locale;
import java.util.TimeZone;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.service.user.AuthorityService;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

@Service
public class SystemUtil {	
	private String DATE_FORMAT = "yyyy-MM-dd";
	private String TIME_FORMAT = "HH:mm:ss";
	
	@Inject
	private MessageSource messageSource;
	
	@Inject
	private AuthorityService authorityService;
	
	public String getDateAsString(Date date, String timeZone){
	    final SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	    sdf.setTimeZone(TimeZone.getTimeZone(timeZone));
	    return sdf.format(date);
		}
	
	public String getTimeAsString(Time time, String timeZone){
	    final SimpleDateFormat sdf = new SimpleDateFormat(TIME_FORMAT);
	    sdf.setTimeZone(TimeZone.getTimeZone(timeZone));
	    return sdf.format(time);
	}
	
	// Use This - 05/12/2014
	@SuppressWarnings("deprecation")
	public String getClientLocalDateAsString(Date utcDate, Time utcTime, HttpServletRequest request, Locale locale) {
		Cookie[] cookies = request.getCookies();
		int timeOffset = 0;
		for (int j=0; j < cookies.length; j++) {
			Cookie cookie = cookies[j];
			if (cookie.getName().equals("TimeOffset")) {
				timeOffset = Integer.parseInt(cookie.getValue());
			};
		}
		
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
	
		cal.set(utcDate.getYear() + 1900, 
				utcDate.getMonth(),
				utcDate.getDate(),
				utcTime.getHours(),
				utcTime.getMinutes() - timeOffset,
				utcTime.getSeconds());
		
		Date localDate = new Date(cal.getTimeInMillis());
		String year = Integer.toString(localDate.getYear() + 1900);
		String month = localDate.getMonth() < 10 ? "0" + (localDate.getMonth() + 1) : Integer.toString(localDate.getMonth() + 1);
		String date = localDate.getDate() < 10 ? "0" + localDate.getDate() : Integer.toString(localDate.getDate());
		/*		SimpleDateFormat sdf = null;
		if (locale.toString().equals("ko_KR"))
			sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		else
			sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
		
		String localDateString = sdf.format(localDate);
		return localDateString;*/
		if (locale.toString().equals("ko_KR")) {
			return year + "-" + month + "-" + date;			
		} else {
			return month + "/" + date + "/" + year;
		}
	}
	
	
	
	
	//################################################################
	@SuppressWarnings("deprecation")
	public String[] getClientLocalDateTimeAsString(HttpServletRequest request, Date utcDate, Time utcTime) {
		Cookie[] cookies = request.getCookies();
		int timeOffset = 0;
		for (int j=0; j < cookies.length; j++) {
			Cookie cookie = cookies[j];
			if (cookie.getName().equals("TimeOffset")) {
				timeOffset = Integer.parseInt(cookie.getValue());
			};
		}
		
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
	
		cal.set(utcDate.getYear() + 1900, 
				utcDate.getMonth(),
				utcDate.getDate(),
				utcTime.getHours(),
				utcTime.getMinutes() - timeOffset,
				utcTime.getSeconds());
		
		Date localDate = new Date(cal.getTimeInMillis());
		
		String[] returnDateTime = new String[2];
		SimpleDateFormat sdf = null;
		sdf = new SimpleDateFormat(DATE_FORMAT);
		returnDateTime[0] = sdf.format(localDate);
		sdf = new SimpleDateFormat(TIME_FORMAT);
		returnDateTime[1] = sdf.format(localDate);
		
		return returnDateTime;
    }
	
	@SuppressWarnings("deprecation")
	public Date getClientLocalDate(HttpServletRequest request, Date utcDate, Time utcTime) {
		Cookie[] cookies = request.getCookies();
		int timeOffset = 0;
		for (int j=0; j < cookies.length; j++) {
			Cookie cookie = cookies[j];
			if (cookie.getName().equals("TimeOffset")) {
				timeOffset = Integer.parseInt(cookie.getValue());
			};
		}
		
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
	
		cal.set(utcDate.getYear() + 1900, 
				utcDate.getMonth(),
				utcDate.getDate(),
				utcTime.getHours(),
				utcTime.getMinutes() - timeOffset,
				utcTime.getSeconds());
		
		return new Date(cal.getTimeInMillis());
    }
	
	@SuppressWarnings("deprecation")
	public Time getClientLocalTime(HttpServletRequest request, Date utcDate, Time utcTime) {
		Cookie[] cookies = request.getCookies();
		int timeOffset = 0;
		for (int j=0; j < cookies.length; j++) {
			Cookie cookie = cookies[j];
			if (cookie.getName().equals("TimeOffset")) {
				timeOffset = Integer.parseInt(cookie.getValue());
			};
		}
		
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
	
		cal.set(utcDate.getYear() + 1900, 
				utcDate.getMonth(),
				utcDate.getDate(),
				utcTime.getHours(),
				utcTime.getMinutes() - timeOffset,
				utcTime.getSeconds());
		
		Date localDate = new Date(cal.getTimeInMillis());

		return new Time(localDate.getTime());
    }
	
	public String getUTCDateFromClintLocalDateAsString(HttpServletRequest request, Calendar clientCal) {
		Cookie[] cookies = request.getCookies();
		int timeOffset = 0;
		for (int j=0; j < cookies.length; j++) {
			Cookie cookie = cookies[j];
			if (cookie.getName().equals("TimeOffset")) {
				timeOffset = Integer.parseInt(cookie.getValue());
			};
		}
				
		clientCal.add(Calendar.MINUTE, timeOffset);
				
		Date localDate = new Date(clientCal.getTimeInMillis());
		
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		return sdf.format(localDate);
    }
	
	public Date getUtcDate() {
		long time = Calendar.getInstance(TimeZone.getTimeZone("UTC")).getTimeInMillis();		

		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
		
		Date d = new Date(time);
		return d;
	}
	
	public Time getUtcTime() {
		long time = Calendar.getInstance(TimeZone.getTimeZone("UTC")).getTimeInMillis();		

		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
		
		Time t =  new Time(time);
		return t;
	}
	
	public Time getUtcTime2() {
		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
		long time = Calendar.getInstance(TimeZone.getTimeZone("UTC")).getTimeInMillis();		

		Time t =  new Time(time);
		return t;
	}
	
	public String getStatusTooltipData(Locale locale) {
		String statusTootipDate = "<table border='0' width='500px'>" 
								   + "<tr><td class='cellLeft'>" + SystemConstants.statusB + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleB", null, locale) + "</td></tr>"
								   + "<tr><td class='cellLeft'>" + SystemConstants.statusI + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleI", null, locale) + "</td></tr>"
								   + "<tr><td class='cellLeft'>" + SystemConstants.statusO + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleO", null, locale) + "</td></tr>"
								   + "<tr><td class='cellLeft'>" + SystemConstants.statusR + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleR", null, locale) + "</td></tr>"
								   + "<tr><td class='cellLeft'>" + SystemConstants.statusE + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleE", null, locale) + "</td></tr>"
								   + "<tr><td class='cellLeft'>" + SystemConstants.statusD + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleD", null, locale) + "</td></tr>"
								   + "<tr><td class='cellLeft'>" + SystemConstants.statusV + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleV", null, locale) + "</td></tr>"
   								   + "<tr><td class='cellLeft'>" + SystemConstants.statusA + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleA", null, locale) + "</td></tr>"
   								   + "<tr><td class='cellLeft'>" + SystemConstants.statusM + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleM", null, locale) + "</td></tr>"
   								   + "<tr><td class='cellLeft'>" + SystemConstants.statusG + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleG", null, locale) + "</td></tr>"
   								   + "<tr><td class='cellLeft'>" + SystemConstants.statusP + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleP", null, locale) + "</td></tr>"
   								   + "<tr><td class='cellLeft'>" + SystemConstants.statusJ + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleJ", null, locale) + "</td></tr>"
   								   + "<tr><td class='cellLeft'>" + SystemConstants.statusW + ". </td><td class='cellLeft'> " + this.messageSource.getMessage("system.titleW", null, locale) + "</td></tr>"
   								   + "</table>";
		return statusTootipDate;
	}
	
	
	
	
	public String getStatusTitle(String status, Locale locale) {
		switch (status) {
			case SystemConstants.statusB:
				return this.messageSource.getMessage("system.titleB", null, locale);
			case SystemConstants.statusI:
				return this.messageSource.getMessage("system.titleI", null, locale);
			case SystemConstants.statusO:
				return this.messageSource.getMessage("system.titleO", null, locale);
			case SystemConstants.statusR:
				return this.messageSource.getMessage("system.titleR", null, locale);
			case SystemConstants.statusE:
				return this.messageSource.getMessage("system.titleE", null, locale);
			case SystemConstants.statusD:
				return this.messageSource.getMessage("system.titleD", null, locale);
			case SystemConstants.statusV:
				return this.messageSource.getMessage("system.titleV", null, locale);
			case SystemConstants.statusA:
				return this.messageSource.getMessage("system.titleA", null, locale);
			case SystemConstants.statusM:
				return this.messageSource.getMessage("system.titleM", null, locale);
			case SystemConstants.statusP:
				return this.messageSource.getMessage("system.titleP", null, locale);
			case SystemConstants.statusJ:
				return this.messageSource.getMessage("system.titleJ", null, locale);
			case SystemConstants.statusW:
				return this.messageSource.getMessage("system.titleW", null, locale);
			default:
				return "NoneStatusTitle";
		}
	}
	
	public String getStatusDatatableLabel(String status, Locale locale) {
		StringBuffer label = new StringBuffer("<strong>Status ");
		label.append(status).append("</strong><br/>");
		label.append(this.messageSource.getMessage("system.title" + status, null, locale));
		return label.toString();
	}
	
	public String getReviewerToolTipData(Review review, Journal journal, Locale locale) {
		StringBuffer label = new StringBuffer();
		label.append("<p style='text-align:left;'>");
		label.append("<b><span style='font-size: 14px;'>");
		if(journal.getLanguageCode().equals("ko") && review.getUser().getContact().getLocalFullName() != null)
			label.append(review.getUser().getContact().getLocalFullName());
		else {
			label.append(review.getUser().getContact().getFirstName());
			label.append(" ");
			label.append(review.getUser().getContact().getLastName());
		}
		label.append("</b></span>");
		label.append("<br/>");
		label.append(messageSource.getMessage("user.degree",null, locale));
		label.append(": ");
		label.append(messageSource.getMessage("signin.degreeDesignation." + review.getUser().getContact().getDegree(), null, locale));
		label.append("<br/>");
		label.append(messageSource.getMessage("user.institutionSmallWidth",null, locale));
		label.append(": ");
		if(journal.getLanguageCode().equals("ko") && review.getUser().getContact().getLocalInstitution() != null)
			label.append(review.getUser().getContact().getLocalInstitution());
		else
			label.append(review.getUser().getContact().getInstitution());
		if((review.getUser().getContact().getDepartment() != null && !review.getUser().getContact().getDepartment().trim().equals("")) || 
				(review.getUser().getContact().getLocalDepartment() != null && !review.getUser().getContact().getLocalDepartment().trim().equals(""))) {
			label.append("<br/>");
			label.append(messageSource.getMessage("user.department",null, locale));
			label.append(": ");
			if(journal.getLanguageCode().equals("ko") && review.getUser().getContact().getLocalDepartment() != null)
				label.append(review.getUser().getContact().getLocalDepartment());
			else {
				if(review.getUser().getContact().getDepartment() != null)
					label.append(review.getUser().getContact().getDepartment());
			}
		}
		label.append("</p>");
		return label.toString();
	}
	
	public String getBaseUrl(HttpServletRequest request) {
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI();
		String baseUrl = url.substring(0, url.length() - uri.length());
		baseUrl += request.getContextPath();
		return baseUrl;
	}
	
	public static boolean contains(Collection<?> coll, Object o) {
	    return coll.contains(o);
	}
	
	public String trim(String str) {
	    return str.trim()/*.replace("\n", "").replace("\r", "")*/;
	}
	
	public String capitalize(String string) {
	    if (string == null) return null;
	    String[] wordArray = string.split(" "); // Split string to analyze word by word.
	    int i = 0;
	    
	    lowercase:
	    for (String word : wordArray) {
	        if (word != wordArray[0]) { // First word always in capital
	            String [] lowercaseWords = {"a", "an", "as", "and", "although", "at", "because", "but", "by", "for", "in", "nor", "of", "on", "or", "so", "the", "to", "up", "yet"};
	            for (String word2 : lowercaseWords) {
	                if (word.equals(word2)) {
	                    wordArray[i] = word;
	                    i++;
	                    continue lowercase;
	                }
	            }
	        }
	        char[] characterArray = word.toCharArray();
	        characterArray[0] = Character.toTitleCase(characterArray[0]);
	        if (characterArray[characterArray.length-1] == '.') {
	        	characterArray = Arrays.copyOfRange(characterArray, 0, characterArray.length-1);
	        }
	        wordArray[i] = new String(characterArray);
	        i++;
	    }
	    return StringUtils.join(wordArray, " "); // Re-join string
	}
}
