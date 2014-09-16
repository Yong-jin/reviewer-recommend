package link.thinkonweb.configuration;

import java.io.File;

public interface SystemConstants {
	public static final boolean TEST_MODE = true;
	/*	Reviewer Recommend	*/
	public static int constraint_review_num_for_paper = 3;
	public static int constraint_review_num_for_reviewer = 3;
	public static int FR_period_days = 180;
	public static double u_weight_value = 0.75;
	public static int recommend_extra_ratio = 2;
	
	/*	Journal Types	*/
	public static final String journalTypeA = "A";
	public static final String journalTypeB = "B";
	public static final String journalTypeC = "C";
	public static final String journalTypeD = "D";
	
	/*	Roles	*/
	public static final String roleSuperManager = "ROLE_SUPER_MANAGER";
	public static final String roleUser = "ROLE_USER";
	public static final String roleMember = "ROLE_MEMBER";	
	public static final String roleManager = "ROLE_MANAGER";	
	public static final String roleCEditor = "ROLE_C-EDITOR";
	public static final String roleAEditor = "ROLE_A-EDITOR";
	public static final String roleGEditor = "ROLE_G-EDITOR";
	public static final String roleBMember = "ROLE_B-MEMBER";
	public static final String roleReviewer = "ROLE_REVIEWER";
	
	/*	Manuscript Status	*/
	public static final String statusB = "B";	//Being submitted
	public static final String statusI = "I";	//Submitted
	public static final String statusO = "O";	//Associate/Guest editor is being selected
	public static final String statusR = "R";	//Under Review
	public static final String statusE = "E";	//Review result has been made and reported to chief editor
	public static final String statusD = "D"; 	//Review result mailed to the author(s)
	public static final String statusV = "V";	//Revised Paper has been received
	public static final String statusA = "A";	//Accept
	public static final String statusM = "M";	//Camera-ready paper has been received
	public static final String statusG = "G";	//Gallery Proofs Ready
	public static final String statusP = "P";	//Published
	public static final String statusJ = "J";	//Rejected
	public static final String statusX = "X";	//Revision-deadline expired
	public static final String statusW = "W";	//Withdrawn
	
	/*	Manuscript Build Level	*/
	public static final int NONE_BUILD = 0;
	public static final int VIEW_BUILD = 1;
	public static final int TABLE_BUILD = 2;
	public static final int HISTORY_BUILD = 3;
	public static final int FILE_HISTORY_BUILD = 4;
	public static final int EMAIL_BUILD = 5;
	public static final int EVENT_DATE_TIME_BUILD = 6;
	
	/*	Reviewer Status	*/
	public static final String reviewerS = "S";	//Selected
	public static final String reviewerI = "I";	//Invited
	public static final String reviewerA = "A";	//Assigned
	public static final String reviewerC = "C";	//Review Completed
	public static final String reviewerD = "D";	//Declined
	public static final String reviewerM = "M";	//Dismissed
	public static final String reviewerT = "T";	//Automatic Dismissed

	/*	Associate(Guest) Editor Status	*/
	public static final String editorA = "A";	//Assigned
	public static final String editorT = "T";	//Take in
	public static final String editorD = "D";	//Declined
	
	/*	Initial Journal Configurations	*/
	public static final int REVIEW_COMPLETE_COUNT = 3;
	public static final int REVIEW_DUE_DURATION = 6;
	public static final int ASSIGN_REMIND_DURATION = 2;
	public static final int ASSIGN_CANCEL_DURATION = 7;
	public static final int INVITE_REMIND_DURATION = 2;
	public static final int INVITE_CANCEL_DURATION = 7;
	public static final int RESUBMIT_DURATION = 30;
	public static final int CAMERA_SUBMIT_DURATION = 15;
	public static final int GENTLE_REMIND_REVIEWER = 7;
	public static final int GENTLE_REMIND_RESUBMIT = 7;
	public static final int GENTLE_REMIND_CAMERA_SUBMIT = 6;
	public static final int REMIND_REVIEWER = 3;
	public static final int REMIND_RESUBMIT = 3;
	public static final int REMIND_CAMERA_SUBMIT = 3;
	
	/*	File	*/
	public static final String ORIGIN_PATH = File.separator + "var" + File.separator + "jms" + File.separator;
	public static final String fileTypeG = "galleryProof";
	public static final String fileTypeA = "galleryProofCorrectionRequest";
	public static final String fileTypeCP = "copyright";
	public static final String fileTypeCT = "cameraReadyTemplate";
	public static final String fileTypeFC = "frontCover";
	public static final String fileTypeCHK = "checkList";
	
	/*	etc	*/
	public static final String addRole = "addRole";
	public static final String deleteRole = "deleteRole";
	
	public static final String englishLanguageName = "English";
	public static final String koreanLanguageName = "Korean";
	public static final String englishLanguageCode = "en";
	public static final String koreanLanguageCode = "ko";
	
	
	/*	Email	*/
	public static final String baseUrl = "http://www.manuscriptlink.com";
	public static final String[] EMAIL_TEST_TO = {"cmdrkim@gmail.com"};
	public static final String[] EMAIL_TEST_CC = {"yh21.han@gmail.com"};
	public static final String EMAIL_FROM_USERNAME = "ManuscriptLink <no-reply@manuscriptlink.com>";
	public static final int NO_REPLY_USER_ID = 2;
	
	public static final String rAuthors = "AU";
	public static final String rMembers = "MAA";
	public static final String rMember = "MA";
	public static final String rCEditor = "CE";
	public static final String rAEditor = "AE";
	public static final String rGEditor = "GE";
	public static final String rReviewer = "RV";
	public static final String rAccountOwner = "OW";
	public static final String rAccountCreatee = "TE";
	//EMAIL_ROLES[mailID][journalType][manuscriptTrack][closingRole_and_receiverRoles]
	//receiverRoles=to/cc1/cc2/cc3
	//ML: ManuscriptLink	AU: Author			MA: Manager			CE: Chief Editor		AE: Associate Editor		GE: Guest Editor	
	//RV: Reviewer			OW: Account Owner	TE: Account Createe
	public static final String[][][][] EMAIL_ROLES
	= new String[][][][] 
	{
/*0*/	{{{"ML", "AU"},	{"ML", "AU"}},	{{"ML", "AU"},	{"ML", "AU"}},	{{"ML", "AU"},	{"ML", "AU"}},	{{"ML", "AU"},	{"ML", "AU"}}},
/*1*/	{{{"ML", "MAA"},	{"ML", "MAA"}},	{{"ML", "MAA"},	{"ML", "MAA"}},	{{"ML", "MAA"},	{"ML", "MAA"}},	{{"ML", "MAA"},	{"ML", "MAA"}}},
/*2*/	{{{"MA", "AU"},	{"MA", "AU"}},	{{null, null},	{null, null}},	{{"MA", "AU"},	{"MA", "AU"}},	{{null, null},	{null, null}}},
/*3*/	{{{"ML","MA"},	{"ML", "MA"}},	{{null, null},	{null, null}},	{{"ML", "MA"},	{"ML", "MA"}},	{{null, null},	{null, null}}},
/*4*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}}},
/*5*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}}},
/*6*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}}},
/*7*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}}},
/*8*/	{{{"MA", "CE/MA"},	{"MA", "GE/MA"}},	{{"MA", "CE/MA"},	{"MA", "GE/MA"}},	{{"MA", "CE/MA"},	{"MA", "GE/MA"}},	{{"MA", "CE/MA"},	{"MA", "GE/MA"}}},
/*9*/	{{{"MA", "AE/MA"},	{"MA", "GE/MA"}},	{{null, null},	{null, null}},	{{null, null},	{"MA", "GE/MA"}},	{{null, null},	{null, null}}},
/*10*/	{{{"CE", "AE/CE/MA"},	{null, null}},	{{"CE", "AE/CE/MA"},	{null, null}},	{{null, null},	{null, null}},	{{null, null},	{null, null}}},
/*11*/	{{{"CE", "AE/CE/MA"},	{null, null}},	{{"CE", "AE/CE/MA"},	{null, null}},	{{null, null},	{null, null}},	{{null, null},	{null, null}}},
/*12*/	{{{"MA", "CE/AE/MA"},	{null, null}},	{{"MA", "CE/AE/MA"},	{null, null}},	{{null, null},	{null, null}},	{{null, null},	{null, null}}},
/*13*/	{{{"MA", "CE/AE/MA"},	{null, null}},	{{"MA", "CE/AE/MA"},	{null, null}},	{{null, null},	{null, null}},	{{null, null},	{null, null}}},
/*14*/	{{{"CE", "AE/CE/MA"},	{null, null}},	{{"CE", "AE/CE/MA"},	{null, null}},	{{null, null},	{null, null}},	{{null, null},	{null, null}}},
/*15*/	{{{"CE", "AE/CE/MA"},	{null, null}},	{{"CE", "AE/CE/MA"},	{null, null}},	{{null, null},	{null, null}},	{{null, null},	{null, null}}},
/*16*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*17*/	{{{"MA", "AE/MA"},	{"MA", "GE/MA"}},	{{"MA", "AE/MA"},	{"MA", "GE/MA"}},	{{"MA", "CE/MA"},	{"MA", "GE/MA"}},	{{"MA", "CE/MA"},	{"MA", "GE/MA"}}},
/*18*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*19*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*20*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*21*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*22*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*23*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*24*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*25*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*26*/	{{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"AE", "RV/AE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}},	{{"CE", "RV/CE"},	{"GE", "RV/GE"}}},
/*27*/	{{{"ML", "RV/AE"},	{"ML", "RV/GE"}},	{{"ML", "RV/AE"},	{"ML", "RV/GE"}},	{{"ML", "RV/CE"},	{"ML", "RV/GE"}},	{{"ML", "RV/CE"},	{"ML", "RV/GE"}}},
/*28*/	{{{"ML", "RV/AE"},	{"ML", "RV/GE"}},	{{"ML", "RV/AE"},	{"ML", "RV/GE"}},	{{"ML", "RV/CE"},	{"ML", "RV/GE"}},	{{"ML", "RV/CE"},	{"ML", "RV/GE"}}},
/*29*/	{{{"ML", "AE"},	{"ML", "GE"}},	{{"ML", "AE"},	{"ML", "GE"}},	{{"ML", "CE"},	{"ML", "GE"}},	{{"ML", "CE"},	{"ML", "GE"}}},
/*30*/	{{{"MA", "CE/AE"},	{null, null}},	{{"MA", "CE/AE"},	{null, null}},	{{null, null},	{null, null}},	{{null, null},	{null, null}}},
/*31*/	{{{"CE", "AU/CE/AE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/AE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/MA"},	{"CE", "AU/GE/MA"}}},
/*32*/	{{{"CE", "AU/CE/AE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/AE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/MA"},	{"CE", "AU/GE/MA"}}},
/*33*/	{{{"CE", "AU/CE/AE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/AE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/MA"},	{"CE", "AU/GE/MA"}}},
/*34*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}}},
/*35*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}}},
/*36*/	{{{"AU", "MA/AU"},	{"AU", "MA/AU"}},	{{null, null},	{null, null}},	{{"AU", "MA/AU"},	{"AU", "MA/AU"}},	{{null, null},	{null, null}}},
/*37*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}}},
/*38*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{null, null},	{null, null}}},
/*39*/	{{{"CE", "AU/CE/AE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/AE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/MA"},	{"CE", "AU/GE/MA"}},	{{"CE", "AU/CE/MA"},	{"CE", "AU/GE/MA"}}},
/*40*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}}},
/*41*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}}},
/*42*/	{{{"MA", "AU"},	{"MA", "AU"}},	{{"MA", "AU"},	{"MA", "AU"}},	{{"MA", "AU"},	{"MA", "AU"}},	{{"MA", "AU"},	{"MA", "AU"}}},
/*43*/	{{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}}},
/*44*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}}},
/*45*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}}},
/*46*/	{{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}},	{{"MA", "AU/MA"},	{"MA", "AU/MA"}}},
/*47*/	{{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}}},
/*48*/	{{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}},	{{"ML", "MA"},	{"ML", "MA"}}},
/*49*/	{{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}}},
/*50*/	{{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}}},
/*51*/	{{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}}},
/*52*/	{{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}}},
/*53*/	{{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}},	{{"ML", "TE"},	{"ML", "TE"}}},
/*54*/	{{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}},	{{"ML", "OW"},	{"ML", "OW"}}}
	};
}