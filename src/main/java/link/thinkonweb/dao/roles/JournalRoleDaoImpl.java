package link.thinkonweb.dao.roles;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.JournalDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.roles.BoardMember;
import link.thinkonweb.domain.roles.ChiefEditor;
import link.thinkonweb.domain.roles.GuestEditor;
import link.thinkonweb.domain.roles.JournalRole;
import link.thinkonweb.domain.roles.Manager;
import link.thinkonweb.domain.roles.Member;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;

public class JournalRoleDaoImpl extends NamedParameterJdbcDaoSupport implements JournalRoleDao {
	@Autowired
	private JournalDao journalDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private JournalMemberRowMapper journalMemberRowMapper; 
	
	@Autowired
	private JournalReviewerRowMapper journalReviewerRowMapper;
	
	@Autowired
	private JournalAssociateEditorRowMapper journalAssociateEditorRowMapper;
	
	@Autowired
	private JournalChiefEditorRowMapper journalChiefEditorRowMapper;
	
	@Autowired
	private JournalGuestEditorRowMapper journalGuestEditorRowMapper;
	
	@Autowired
	private JournalManagerRowMapper journalManagerRowMapper;

	@Autowired
	private JournalBoardMemberRowMapper journalBoardMemberRowMapper;
	
	final String[] journalRoleTableNames={"JOURNAL_MEMBERS", 
										  "JOURNAL_MANAGERS", 
										  "JOURNAL_CHIEF_EDITORS", 
										  "JOURNAL_ASSOCIATE_EDITORS", 
										  "JOURNAL_GUEST_EDITORS", 
										  "JOURNAL_REVIEWERS", 
										  "JOURNAL_BOARD_MEMBERS"};
	
	@SuppressWarnings("rawtypes")
	final JournalRoleRowMapper[] journalRoleRowMappers={journalMemberRowMapper, 
														journalManagerRowMapper, 
														journalChiefEditorRowMapper, 
														journalAssociateEditorRowMapper, 
														journalGuestEditorRowMapper, 
														journalReviewerRowMapper, 
														journalBoardMemberRowMapper};
	
	public JournalRoleDaoImpl() {
	}
	
	@Autowired 
	public JournalRoleDaoImpl(DataSource dataSource) {
	    super();
	    setDataSource(dataSource);
	}
	
	public void setJournalDao(JournalDao journalDao) {
		this.journalDao = journalDao;
	}
	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	private String roleNameToTableName(String role) {
		String tableName = null;
		switch (role) {
			case SystemConstants.roleMember:
				tableName = journalRoleTableNames[0];
				break;
			case SystemConstants.roleManager:
				tableName = journalRoleTableNames[1];
				break;
			case SystemConstants.roleCEditor:
				tableName = journalRoleTableNames[2];
				break;
			case SystemConstants.roleAEditor:
				tableName = journalRoleTableNames[3];
				break;
			case SystemConstants.roleGEditor:
				tableName = journalRoleTableNames[4];
				break;
			case SystemConstants.roleReviewer:
				tableName = journalRoleTableNames[5];
				break;
			case SystemConstants.roleBMember:
				tableName = journalRoleTableNames[6];
				break;
			default:
		}
		return tableName;
	}
	
	@SuppressWarnings("rawtypes")
	private JournalRoleRowMapper roleNameToRowMapper(String role) {		
		JournalRoleRowMapper journalRoleRowMapper = null;
		switch (role) {
			case SystemConstants.roleMember:
				journalRoleRowMapper = journalMemberRowMapper;
				break;
			case SystemConstants.roleManager:
				journalRoleRowMapper = journalManagerRowMapper;
				break;
			case SystemConstants.roleCEditor:
				journalRoleRowMapper = journalChiefEditorRowMapper;
				break;
			case SystemConstants.roleAEditor:
				journalRoleRowMapper = journalAssociateEditorRowMapper;
				break;
			case SystemConstants.roleGEditor:
				journalRoleRowMapper = journalGuestEditorRowMapper;
				break;
			case SystemConstants.roleReviewer:
				journalRoleRowMapper = journalReviewerRowMapper;
				break;
			case SystemConstants.roleBMember:
				journalRoleRowMapper = journalBoardMemberRowMapper;
				break;
			default:
		}
		return journalRoleRowMapper;
	}
	
	private String journalRoleBeanClassNameToTableNameMapper(String journalRoleBeanClassName) {
		String tableName = null;

		if (journalRoleBeanClassName.equals("link.thinkonweb.jums.domain.JournalMember")) {
			tableName = journalRoleTableNames[0];
		} else if (journalRoleBeanClassName.equals("link.thinkonweb.jums.domain.JournalManager")) {
			tableName = journalRoleTableNames[1];
		} else if (journalRoleBeanClassName.equals("link.thinkonweb.jums.domain.JournalChiefEditor")) {
			tableName = journalRoleTableNames[2];
		} else if (journalRoleBeanClassName.equals("link.thinkonweb.jums.domain.JournalAssociateEditor")) {
			tableName = journalRoleTableNames[3];
		} else if (journalRoleBeanClassName.equals("link.thinkonweb.jums.domain.JournalGuestEditor")) {
			tableName = journalRoleTableNames[4];
		} else if (journalRoleBeanClassName.equals("link.thinkonweb.jums.domain.JournalReviewer")) {
			tableName = journalRoleTableNames[5];
		} else if (journalRoleBeanClassName.equals("link.thinkonweb.jums.domain.JournalBoardMember")) {
			tableName = journalRoleTableNames[6];
		}
		return tableName;
	}
	
	@Override
	public void create(int userId, int journalId, int authorityId, String role) {
		if (role == null) {
			return;
		}
		String sql = "INSERT INTO " + roleNameToTableName(role) + " (USER_ID, JOURNAL_ID, AUTHORITY_ID) VALUES (:userid, :journalid, :authorityid)";
		Map<String, Object> argMap = new HashMap<String, Object>();
		argMap.put("userid", userId);
		argMap.put("journalid", journalId);
		argMap.put("authorityid", authorityId);
		this.getNamedParameterJdbcTemplate().update(sql, argMap);
	}
	
	@Override
	public void create(int userId, int journalId, int authorityId, Object roleType) {
		if(roleType instanceof Reviewer) {
			
		}
		/*
		if (role == null) {
			return;
		}
		String sql = "INSERT INTO " + roleNameToTableName(role) + " (USER_ID, JOURNAL_ID, AUTHORITY_ID) VALUES (:userid, :journalid, :authorityid)";
		Map<String, Object> argMap = new HashMap<String, Object>();
		argMap.put("userid", userId);
		argMap.put("journalid", journalId);
		argMap.put("authorityid", authorityId);
		
		this.getNamedParameterJdbcTemplate().update(sql, argMap);
		*/
	}
	
	/*
	@Override
	public void delete(int userId, int journalId, String role) {
		String sql = null;
		if (role == null) {
			for (int i = 0; i < journalRoleTableNames.length; i++) {
				if (userId == 0 && journalId == 0) {
					sql = "TRUNCATE " + journalRoleTableNames[i];
					this.getJdbcTemplate().update(sql);
				} else if (journalId == 0) {
					sql = "DELETE FROM " + journalRoleTableNames[i] + " WHERE USER_ID = ?";
					this.getJdbcTemplate().update(sql, new Object[] {userId});
				} else if (userId == 0) {
					sql = "DELETE FROM " + journalRoleTableNames[i] + " WHERE JOURNAL_ID = ?";
					this.getJdbcTemplate().update(sql, new Object[] {journalId});
				} else {
					sql = "DELETE FROM " + journalRoleTableNames[i] + " WHERE USER_ID = ? AND JOURNAL_ID = ?";
					this.getJdbcTemplate().update(sql, new Object[] {userId, journalId});
				}
			}
		} else {
			if (userId == 0 && journalId == 0) {
				sql = "TRUNCATE " + roleNameToTableName(role);
				this.getJdbcTemplate().update(sql);
			} else if (journalId == 0) {
				sql = "DELETE FROM " + roleNameToTableName(role) + " WHERE USER_ID = ?";
				this.getJdbcTemplate().update(sql, new Object[] {userId});
			} else if (userId == 0) {
				sql = "DELETE FROM " + roleNameToTableName(role) + " WHERE JOURNAL_ID = ?";
				this.getJdbcTemplate().update(sql, new Object[] {journalId});
			} else {
				sql = "DELETE FROM " + roleNameToTableName(role) + " WHERE USER_ID = ? AND JOURNAL_ID = ?";
				this.getJdbcTemplate().update(sql, new Object[] {userId, journalId});
			}
		}
	}*/
	
	@Override
	public void update(JournalRole journalRole) {
		String tableName = journalRoleBeanClassNameToTableNameMapper(journalRole.getClass().getName());
		if (tableName != null) {
			String sql = "UPDATE " + tableName + "SET USER_ID = ? AND JOURNAL_ID = ? AND AUTHORITY_ID = ? WHERE ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {journalRole.getUserId(), journalRole.getJournalId(), journalRole.getAuthorityId(), journalRole.getId()});
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public JournalRole findSpecificJournalRole(int userId, int journalId, String role) {
		if (userId == 0 || journalId == 0 || role == null) {
			return null;
		} else {
			String sql = "SELECT * FROM " + roleNameToTableName(role) + " WHERE USER_ID = ? AND JOURNAL_ID = ?";
			try {
				return (JournalRole) this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, journalId}, roleNameToRowMapper(role));
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public JournalRole findSpecificJournalRole(int id, String role) {

		String sql = "SELECT * FROM " + roleNameToTableName(role) + " WHERE ID = ?";
		try {
			return (JournalRole) this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, roleNameToRowMapper(role));
		} catch(EmptyResultDataAccessException e) {
			return null;
		}

	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<JournalRole> findAnyJournalRoles(int userId, int journalId) {
		String sql = null;
		List<JournalRole> listJournalRoles = new LinkedList<JournalRole>();
		List<JournalRole> listJournalRoleParts = null;
		
		for (int i = 0; i < journalRoleTableNames.length; i++) {
			if (userId == 0 && journalId == 0) {
				sql = "SELECT * FROM " + journalRoleTableNames[i];
				listJournalRoleParts = this.getJdbcTemplate().query(sql, journalRoleRowMappers[i]);
				Iterator<JournalRole> iterator = listJournalRoleParts.iterator();
				while(iterator.hasNext()) {
					listJournalRoles.add((JournalRole)iterator.next());	
				}
			} else if (journalId == 0) {
				sql = "SELECT * FROM " + journalRoleTableNames[i] + " WHERE USER_ID = ?";
				listJournalRoleParts = this.getJdbcTemplate().query(sql, new Object[] {userId}, journalRoleRowMappers[i]);
				Iterator<JournalRole> iterator = listJournalRoleParts.iterator();
				while(iterator.hasNext()) {
					listJournalRoles.add((JournalRole)iterator.next());	
				}
			} else if (userId == 0) {
				sql = "SELECT * FROM " + journalRoleTableNames[i] + " WHERE JOURNAL_ID = ?";
				listJournalRoleParts = this.getJdbcTemplate().query(sql, new Object[] {journalId}, journalRoleRowMappers[i]);
				Iterator<JournalRole> iterator = listJournalRoleParts.iterator();
				while(iterator.hasNext()) {
					listJournalRoles.add((JournalRole)iterator.next());	
				}
			} else {
				sql = "SELECT * FROM " + journalRoleTableNames[i] + " WHERE USER_ID = ? AND JOURNAL_ID = ?";
				listJournalRoleParts = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, journalRoleRowMappers[i]);
				Iterator<JournalRole> iterator = listJournalRoleParts.iterator();
				while(iterator.hasNext()) {
					listJournalRoles.add((JournalRole)iterator.next());	
				}
			}
		}
		return listJournalRoles;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private JournalRole findJournalRole(int userId, int journalId, String tableName, JournalRoleRowMapper journalRoleRowMapper) {
		if(userId == 0 && journalId == 0) {
			try {
				String sql = "SELECT * FROM " + tableName;
				return (JournalRole) this.getJdbcTemplate().queryForObject(sql, journalRoleRowMapper);
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
		} else if (userId == 0) {
			return null;
		} else if(journalId == 0) {
			try {
				String sql = "SELECT * FROM " + tableName + " WHERE USER_ID = ?";
				return (JournalRole) this.getJdbcTemplate().queryForObject(sql, new Object[] {userId}, journalRoleRowMapper);
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
		} else {
			try {
				String sql = "SELECT * FROM " + tableName + " WHERE USER_ID = ? AND JOURNAL_ID = ?";
				return (JournalRole) this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, journalId}, journalRoleRowMapper);
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private List<JournalRole> findJournalRoles(int userId, int journalId, String tableName, JournalRoleRowMapper journalRoleRowMapper) {
		String sql = null;
		List<JournalRole> listJournalRoles = null;
		try {
			if (userId == 0 && journalId == 0) {
				sql = "SELECT * FROM " + tableName;
				listJournalRoles = this.getJdbcTemplate().query(sql, journalRoleRowMapper);
				return listJournalRoles;
			} else if (journalId == 0) {
				sql = "SELECT * FROM " + tableName + " WHERE USER_ID = ?";
				listJournalRoles = this.getJdbcTemplate().query(sql, new Object[] {userId}, journalRoleRowMapper);
				return listJournalRoles;
			} else if (userId == 0) {
				sql = "SELECT * FROM " + tableName + " WHERE JOURNAL_ID = ?";
				listJournalRoles = this.getJdbcTemplate().query(sql, new Object[] {journalId}, journalRoleRowMapper);
				return listJournalRoles;
			} else {
				sql = "SELECT * FROM " + tableName + " WHERE USER_ID = ? AND JOURNAL_ID = ?";
				listJournalRoles = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, journalRoleRowMapper);
				return listJournalRoles;
			}
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	private int numJournalRoles(int userId, int journalId, String tableName) {
		String sql = null;
		try {
			if (userId == 0 && journalId == 0) {
				sql = "SELECT COUNT(*) FROM " + tableName;
				return this.getJdbcTemplate().queryForObject(sql, Integer.class);
			} else if (journalId == 0) {
				sql = "SELECT COUNT(*) FROM " + tableName + " WHERE USER_ID = ?";
				return this.getJdbcTemplate().queryForObject(sql, new Object[] {userId}, Integer.class);
			} else if (userId == 0) {
				sql = "SELECT COUNT(*) FROM " + tableName + " WHERE JOURNAL_ID = ?";
				return this.getJdbcTemplate().queryForObject(sql, new Object[] {journalId}, Integer.class);
			} else {
				sql = "SELECT COUNT(*) FROM " + tableName + " WHERE USER_ID = ? AND JOURNAL_ID = ?";
				return this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, journalId}, Integer.class);
			}
		} catch(EmptyResultDataAccessException e) {
			return 0;
		}
	}

	@Override
	public Member findJournalMember(int userId, int journalId) {
		return (Member)findJournalRole(userId, journalId, roleNameToTableName(SystemConstants.roleMember), roleNameToRowMapper(SystemConstants.roleMember));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<Member> findJournalMembers(int userId, int journalId) {
		return (List<Member>)(List)findJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleMember), roleNameToRowMapper(SystemConstants.roleMember));
	}

	@Override
	public int numJournalMembers(int userId, int journalId) {
		return numJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleMember));
	}

	
	
	@Override
	public Manager findJournalManager(int userId, int journalId) {
		return (Manager)findJournalRole(userId, journalId, roleNameToTableName(SystemConstants.roleManager), roleNameToRowMapper(SystemConstants.roleManager));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<Manager> findJournalManagers(int userId, int journalId) {
		return (List<Manager>)(List)findJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleManager), roleNameToRowMapper(SystemConstants.roleManager));
	}

	@Override
	public int numJournalManagers(int userId, int journalId) {
		return numJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleManager));
	}

	
	
	@Override
	public ChiefEditor findJournalChiefEditor(int userId, int journalId) {
		return (ChiefEditor)findJournalRole(userId, journalId, roleNameToTableName(SystemConstants.roleCEditor), roleNameToRowMapper(SystemConstants.roleCEditor));
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<ChiefEditor> findJournalChiefEditors(int userId, int journalId) {
		return (List<ChiefEditor>)(List)findJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleCEditor), roleNameToRowMapper(SystemConstants.roleCEditor));
	}

	@Override
	public int numJournalChiefEditors(int userId, int journalId) {
		return numJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleCEditor));
	}



	@Override
	public AssociateEditor findJournalAssociateEditor(int userId, int journalId) {
		return (AssociateEditor)findJournalRole(userId, journalId, roleNameToTableName(SystemConstants.roleAEditor), roleNameToRowMapper(SystemConstants.roleAEditor));		
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<AssociateEditor> findJournalAssociateEditors(int userId, int journalId) {
		return (List<AssociateEditor>)(List)findJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleAEditor), roleNameToRowMapper(SystemConstants.roleAEditor));
	}

	@Override
	public int numJournalAssociateEditors(int userId, int journalId) {
		return numJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleAEditor));
	}


	
	@Override
	public GuestEditor findJournalGuestEditor(int userId, int journalId) {
		return (GuestEditor)findJournalRole(userId, journalId, roleNameToTableName(SystemConstants.roleGEditor), roleNameToRowMapper(SystemConstants.roleGEditor));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<GuestEditor> findJournalGuestEditors(int userId, int journalId) {
		return (List<GuestEditor>)(List)findJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleGEditor), roleNameToRowMapper(SystemConstants.roleGEditor));
	}

	@Override
	public int numJournalGuestEditors(int userId, int journalId) {
		return numJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleGEditor));
	}

	
	
	@Override
	public BoardMember findJournalBoardMember(int userId, int journalId) {
		return (BoardMember)findJournalRole(userId, journalId, roleNameToTableName(SystemConstants.roleBMember), roleNameToRowMapper(SystemConstants.roleBMember));
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<BoardMember> findJournalBoardMembers(int userId, int journalId) {
		return (List<BoardMember>)(List)findJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleBMember), roleNameToRowMapper(SystemConstants.roleBMember));
	}

	@Override
	public int numJournalBoardMembers(int userId, int journalId) {
		return numJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleBMember));
	}

	
	
	@Override
	public Reviewer findJournalReviewer(int userId, int journalId) {
		return (Reviewer)findJournalRole(userId, journalId, roleNameToTableName(SystemConstants.roleReviewer), roleNameToRowMapper(SystemConstants.roleReviewer));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<Reviewer> findJournalReviewers(int userId, int journalId) {
		return (List<Reviewer>)(List)findJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleReviewer), roleNameToRowMapper(SystemConstants.roleReviewer));
	}

	@Override
	public int numJournalReviewers(int userId, int journalId) {
		return numJournalRoles(userId, journalId, roleNameToTableName(SystemConstants.roleReviewer));
	}

	
	
	@SuppressWarnings("unchecked")
	@Override
	public Set<Journal> getJournalsByUser(int userId, String role) {
		String sql = null;
		Set<Journal> journalSet = new HashSet<Journal>();
		List<JournalRole> journalRoles = null;
		
		if (role == null) {
			if (userId == 0) {  // for all users - not meaningful query
				return null;
			} else {
				for (int i = 0; i < journalRoleTableNames.length; i++) {
					sql = "SELECT * FROM " + journalRoleTableNames[i] + " WHERE USER_ID = ?";
					journalRoles = this.getJdbcTemplate().query(sql, new Object[] {userId}, journalRoleRowMappers[i]);
					Iterator<JournalRole> iterator = journalRoles.iterator();

					int journalId = 0;
				    while(iterator.hasNext()) {
				    	journalId = ((JournalRole)iterator.next()).getJournalId();
				    	journalSet.add(this.journalDao.findById(journalId));	
					}
				}
				return journalSet;
			}
		} else {
			if (userId == 0) {  // for all users - not meaningful query
				return null;
			} else {
				sql = "SELECT * FROM " + roleNameToTableName(role) + " WHERE USER_ID = ?";
				journalRoles = this.getJdbcTemplate().query(sql, new Object[] {userId}, roleNameToRowMapper(role));
				Iterator<JournalRole> iterator = journalRoles.iterator();

				int journalId = 0;
			    while(iterator.hasNext()) {
			    	journalId = ((JournalRole)iterator.next()).getJournalId();
			    	journalSet.add(this.journalDao.findById(journalId));	
				}
			    return journalSet;
			}
		}
	}
	
	@Override
	public int numJournalsByUser(int userId, String role) {
		String sql = null;
		int numJournals = 0;
		
		if (role == null) {
			if (userId == 0) {  // for all users - not meaningful query
				return -1;
			} else {
				for (int i = 0; i < journalRoleTableNames.length; i++) {
					sql = "SELECT COUNT(JOURNAL_ID) FROM " + journalRoleTableNames[i] + " WHERE USER_ID = ?";
					numJournals += this.getJdbcTemplate().queryForObject(sql, new Object[] {userId}, Integer.class);
				}
				return numJournals;
			}
		} else {
			if (userId == 0) {  // for all users - not meaningful query
				return -1;
			} else {
				sql = "SELECT COUNT(JOURNAL_ID) FROM " + roleNameToTableName(role) + " WHERE USER_ID = ?";
				return this.getJdbcTemplate().queryForObject(sql, new Object[] {userId}, Integer.class);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Set<SystemUser> getUsersByJournal(int journalId, String role) {
		String sql = null;
		Set<SystemUser> userSet = new HashSet<SystemUser>();
		List<JournalRole> journalRoles = null;
		
		if (role == null) {
			if (journalId == 0) {  // for all journals - not meaningful query
				return null;
			} else {
				for (int i = 0; i < journalRoleTableNames.length; i++) {
					sql = "SELECT * FROM " + journalRoleTableNames[i] + " WHERE JOURNAL_ID = ?";
					journalRoles = this.getJdbcTemplate().query(sql, new Object[] {journalId}, journalRoleRowMappers[i]);
					Iterator<JournalRole> iterator = journalRoles.iterator();

					int userId = 0;
				    while(iterator.hasNext()) {
				    	userId = ((JournalRole)iterator.next()).getUserId();
				    	userSet.add(this.userDao.findById(userId));	
					}
				}
				return userSet;
			}
		} else {
			if (journalId == 0) {  // for all users - not meaningful query
				return null;
			} else {
				sql = "SELECT * FROM " + roleNameToTableName(role) + " WHERE JOURNAL_ID = ?";
				journalRoles = this.getJdbcTemplate().query(sql, new Object[] {journalId}, roleNameToRowMapper(role));
				Iterator<JournalRole> iterator = journalRoles.iterator();

				int userId = 0;
			    while(iterator.hasNext()) {
			    	userId = ((JournalRole)iterator.next()).getUserId();
			    	userSet.add(this.userDao.findById(userId));	
				}
			    return userSet;
			}
		}
	}
	
	public int numUsersByJournal(int journalId, String role) {
		String sql = null;
		int numJournals = 0;
		
		if (role == null) {
			if (journalId == 0) {  // for all journals - not meaningful query
				return -1;
			} else {
				for (int i = 0; i < journalRoleTableNames.length; i++) {
					sql = "SELECT COUNT(USER_ID) FROM " + journalRoleTableNames[i] + " WHERE JOURNAL_ID = ?";
					numJournals += this.getJdbcTemplate().queryForObject(sql, new Object[] {journalId}, Integer.class);
				}
				return numJournals;
			}
		} else {
			if (journalId == 0) {  // for all journals - not meaningful query
				return -1;
			} else {
				sql = "SELECT COUNT(USER_ID) FROM " + roleNameToTableName(role) + " WHERE JOURNAL_ID = ?";
				return this.getJdbcTemplate().queryForObject(sql, new Object[] {journalId}, Integer.class);
			}
		}
	}
}