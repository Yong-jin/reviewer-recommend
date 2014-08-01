package link.thinkonweb.service.user;

import java.sql.Date;
import java.sql.Time;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.user.ChangePasswordCodeDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.user.ChangePasswordCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.roles.ManagerService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.SystemUtil;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Service;

@Service("userDetailsService")
public class UserServiceImpl implements UserService, UserDetailsService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private ManagerService managerService;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private UserDetailsManager userDetailsManager;
	@Autowired
	private ShaPasswordEncoder shaPasswordEncoder;
	@Autowired
	private ChangePasswordCodeDao changePasswordCodeDao;
	@Autowired
	private EmailService emailService;
	
	@Override
	public void create(SystemUser user) {
		long time = Calendar.getInstance(TimeZone.getTimeZone("UTC")).getTimeInMillis();		
		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
			
		Date d = new Date(time);
		Time t = new Time(time);
		
		user.setSignupDate(d);
		user.setSignupTime(t);
		
		user.setPassword(shaPasswordEncoder.encodePassword(user.getPassword(), user.getUsername()));
		
		int id = this.userDao.create(user);
		user.setId(id);
		user.getContact().setUserId(id);
		this.contactService.create(user.getContact());
		
		authorityService.create(user.getId(), 0, SystemConstants.roleUser);
		authorityService.authenticateUserAndSetSession(user);
	}
	
	@Override
	public void createWithoutLogin(SystemUser user) {
		long time = Calendar.getInstance(TimeZone.getTimeZone("UTC")).getTimeInMillis();		
		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
			
		Date d = new Date(time);
		Time t = new Time(time);
		
		user.setSignupDate(d);
		user.setSignupTime(t);
		
		user.setPassword(shaPasswordEncoder.encodePassword(user.getPassword(), user.getUsername()));
		
		int id = this.userDao.create(user);
		user.setId(id);
		user.getContact().setUserId(id);
		this.contactService.create(user.getContact());
		
		authorityService.create(user.getId(), 0, SystemConstants.roleUser);
		//authorityService.authenticateUserAndSetSession(user);
	}

	@Override
	public List<SystemUser> getAll() {
		List<SystemUser> userList = this.userDao.findAll();
		for (SystemUser user : userList) {
			user.setContact(contactService.getByUserId(user.getId()));
		}
		return userList;
	}

	@Override
	public void changeEnabled(boolean isEnabled, int userId) {
		this.userDao.changeEnabled(isEnabled, userId);
	}
	
	@Override
	public void changeUsername(String newUsername, int userId) {
		this.userDao.changeUsername(newUsername, userId);
	}
	
	@Override
	public void changePassword(String newPassword, int userId, String username) {
		System.out.println("from: " + newPassword.trim());
		String encodedPassword = shaPasswordEncoder.encodePassword(newPassword.trim(), username.trim());
		System.out.println("to: " + encodedPassword);
		this.userDao.changePassword(encodedPassword, userId);
	}

	@Override
	public void delete(SystemUser user) {
		this.contactService.delete(user.getContact());
		this.userDao.delete(user);
	}

	@Override
	public SystemUser getById(int id) {
		SystemUser returnUser = this.userDao.findById(id);
		returnUser.setContact(this.contactService.getByUserId(returnUser.getId()));
		return returnUser;
	}

	@Override
	public SystemUser getByUsername(String username) {
		username = username.trim();
		SystemUser returnUser = this.userDao.findByUsername(username);
		returnUser.setContact(this.contactService.getByUserId(returnUser.getId()));
		return returnUser;
	}

	@Override
	public List<SystemUser> getByUsernameLike(String filterString) {
		List<SystemUser> userList = this.userDao.findByUsernameLike(filterString);
		for (SystemUser user : userList) {
			user.setContact(this.contactService.getByUserId(user.getId()));
		}
		return userList;
	}
	
	@Override
	public boolean isUniqueUsername(String username) {
		if (this.userDao.findByUsername(username) == null) {
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public List<SystemUser> getSuperManagerRoleList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder) {
		int journalId = -1;
		if (!dRequest.getRequest().getParameter("jnid").equals("any")) {
			journalId = this.journalService.getByJournalNameId(dRequest.getRequest().getParameter("jnid")).getId();			
		}
		return userDao.findSuperManagerRoleList(journalId, dRequest, iTotalDisplayRecordsPlaceHolder);
	}

	@Override
	public List<SystemUser> getSuperManagerAccountList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder) {
		return userDao.findSuperManagerAccountList(dRequest, iTotalDisplayRecordsPlaceHolder);
	}
	
	@Override
	public List<SystemUser> getEditorCandidateUsers(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId, List<String> preventEmailList) {	
		return this.userDao.findEditorCandidateUsers(dRequest, iTotalDisplayRecordsPlaceHolder, locale, journalId, preventEmailList);
	}
	
	@Override
	public List<SystemUser> getReviewerCandidateUsers(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId, int member, int manuscriptId, List<String> preventEmailList) {	
		return this.userDao.findReviewerCandidateUsers(dRequest, iTotalDisplayRecordsPlaceHolder, locale, journalId, member, manuscriptId, preventEmailList);
	}
	
	
	@Override
	public List<SystemUser> getUsers(int userId, int journalId, String role) {
		List<SystemUser> userList = userDao.findUsers(userId, journalId, role);
		for (SystemUser user : userList)
			user.setContact(contactService.getByUserId(user.getId()));
		return userList;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		SystemUser user = userDao.findByUsername(username);
		if (user == null) {
			throw new UsernameNotFoundException("Invalid username/password.");
		}
		Collection<? extends GrantedAuthority> authorities = (Collection<? extends GrantedAuthority>) authorityService.getAuthorities(user.getId(), 0, null);
		return new User(user.getUsername(), user.getPassword(), authorities);
	}
	
	@Override
	public String generatePassword(int number) {
		String uuid = UUID.randomUUID().toString().replace("-", "");
		return uuid.substring(0, number);
	}

	@Override
	public void resetPassword(String username, HttpServletRequest request, Locale locale) {
		SystemUser targetUser = this.getByUsername(username);
		if (targetUser != null) {
			String maskCode = RandomStringUtils.randomAlphabetic(30);	
			
			ChangePasswordCode code = new ChangePasswordCode();
			code.setEmail(username);
			code.setExpired(false);
			code.setMaskCode(maskCode);
			
			Date todayDate = systemUtil.getUtcDate();
			Calendar expireCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			expireCalendar.add(Calendar.DAY_OF_YEAR, 3);			
			java.util.Date expiredDate = expireCalendar.getTime();
			
			
			code.setRegisterDate(todayDate);
			code.setExpirationDate(new Date(expiredDate.getTime()));
			
			changePasswordCodeDao.add(code);
			
			EmailMessage emailMessage = emailService.getGeneralEmailMessage(54, null, null, username, request, locale);
			String body = emailMessage.getBody();
			String changeUrl = SystemConstants.baseUrl + "/changePassword?code=" + code.getMaskCode();
			body = body.replace("[passwordChangeUrl]", changeUrl);
			emailMessage.setBody(body);
			emailService.sendEmailOther(54, username, emailMessage, request, locale);
		}
	}

	@Override
	public List<SystemUser> getManagerAccountList(
			DataTableClientRequest dRequest,
			int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId) {
		return userDao.findManagerAccountList(dRequest, iTotalDisplayRecordsPlaceHolder, locale, journalId);
	}

	@Override
	public void update(SystemUser user) {
		this.userDao.update(user);
	}
}