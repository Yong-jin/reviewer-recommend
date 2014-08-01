package link.thinkonweb.util;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

public class DataTableClientRequest {
	private int			iDisplayStart; 	//Display start point in the current data set.
	private int			iDisplayLength; //Number of records that the table can display in the current draw. 
	private int 		iColumns; 		//Number of columns being displayed
	private int			iSortingCols;	//Number of columns to sort on
	private String 		sEcho;			//Information for DataTables to use for rendering.
	
	private String 		sSearchGlobal;	//Global search field
	private boolean 	bRegexGlobal;	//True if the global filter should be treated as a regular expression for advanced filtering

	private boolean[] 	bSearchable;	//Indicator for if a column is flagged as searchable or not on the client-side
	private String[] 	sSearch;		//Individual column filter	
	private boolean[] 	bRegex;			//True if the individual column filter should be treated as a regular expression for advanced filtering
	
	private boolean[] 	bSortable;		//Indicator for if a column is flagged as sortable or not on the client-side
	private int[] 		iSortCol;		//Column being sorted on
	private String[] 	sSortDir;		//Direction to be sorted - "desc" or "asc".
	
	private String[] 	mDataProp;		//The value specified by mDataProp for each column.
	private HttpServletRequest request;
	
	public DataTableClientRequest(HttpServletRequest request) {
		this.iDisplayStart 	= Integer.parseInt(request.getParameter("iDisplayStart"));
	    this.iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
	    this.iColumns		= Integer.parseInt(request.getParameter("iColumns"));
	    this.iSortingCols	= Integer.parseInt(request.getParameter("iSortingCols"));
	    this.sEcho			= request.getParameter("sEcho");
	    this.sSearchGlobal	= request.getParameter("sSearch");
	    this.bRegexGlobal	= Boolean.parseBoolean(request.getParameter("bRegex"));

	    int i;
	    
		this.bSearchable 	= new boolean[this.iColumns];
		this.sSearch		= new String[this.iColumns];
		this.bRegex			= new boolean[this.iColumns];
		this.bSortable		= new boolean[this.iColumns];
		this.iSortCol		= new int[this.iColumns];
		this.sSortDir		= new String[this.iColumns];
		this.mDataProp		= new String[this.iColumns];
		
		for (i = 0; i < this.iColumns; i++) {
			this.bSearchable[i] = Boolean.parseBoolean(request.getParameter("bSearchable_" + i));
			this.sSearch[i] 	= request.getParameter("sSearch_" + i);
			this.bRegex[i] 		= Boolean.parseBoolean(request.getParameter("bRegex_" + i));
			this.bSortable[i] 	= Boolean.parseBoolean(request.getParameter("bSortable_" + i));
			
			if (request.getParameter("iSortCol_" + i) != null) {
				this.iSortCol[i] = Integer.parseInt(request.getParameter("iSortCol_" + i));
			}
			
			this.sSortDir[i]	= request.getParameter("sSortDir_" + i);
			this.mDataProp[i]	= request.getParameter("mDataProp_" + i);
		}
		
		this.request = request;
	}

	public int getiDisplayStart() {
		return iDisplayStart;
	}

	public void setiDisplayStart(int iDisplayStart) {
		this.iDisplayStart = iDisplayStart;
	}

	public int getiDisplayLength() {
		return iDisplayLength;
	}

	public void setiDisplayLength(int iDisplayLength) {
		this.iDisplayLength = iDisplayLength;
	}

	public int getiColumns() {
		return iColumns;
	}

	public void setiColumns(int iColumns) {
		this.iColumns = iColumns;
	}

	public int getiSortingCols() {
		return iSortingCols;
	}

	public void setiSortingCols(int iSortingCols) {
		this.iSortingCols = iSortingCols;
	}

	public String getsEcho() {
		return sEcho;
	}

	public void setsEcho(String sEcho) {
		this.sEcho = sEcho;
	}

	public String getsSearchGlobal() {
		return sSearchGlobal;
	}

	public void setsSearchGlobal(String sSearchGlobal) {
		this.sSearchGlobal = sSearchGlobal;
	}

	public boolean isbRegexGlobal() {
		return bRegexGlobal;
	}

	public void setbRegexGlobal(boolean bRegexGlobal) {
		this.bRegexGlobal = bRegexGlobal;
	}

	public boolean[] getbSearchable() {
		return bSearchable;
	}

	public void setbSearchable(boolean[] bSearchable) {
		this.bSearchable = bSearchable;
	}

	public String[] getsSearch() {
		return sSearch;
	}

	public void setsSearch(String[] sSearch) {
		this.sSearch = sSearch;
	}

	public boolean[] getbRegex() {
		return bRegex;
	}

	public void setbRegex(boolean[] bRegex) {
		this.bRegex = bRegex;
	}

	public boolean[] getbSortable() {
		return bSortable;
	}

	public void setbSortable(boolean[] bSortable) {
		this.bSortable = bSortable;
	}

	public int[] getiSortCol() {
		return iSortCol;
	}

	public void setiSortCol(int[] iSortCol) {
		this.iSortCol = iSortCol;
	}

	public String[] getsSortDir() {
		return sSortDir;
	}

	public void setsSortDir(String[] sSortDir) {
		this.sSortDir = sSortDir;
	}

	public String[] getmDataProp() {
		return mDataProp;
	}

	public void setmDataProp(String[] mDataProp) {
		this.mDataProp = mDataProp;
	}
	
	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	@Override
	public String toString() {
		return "DataTableClientRequest [iDisplayStart=" + iDisplayStart + ", iDisplayLength="
				+ iDisplayLength + ", iColumns=" + iColumns + ", iSortingCols="
				+ iSortingCols + "\n, sEcho=" + sEcho + ", sSearchGlobal=" + sSearchGlobal + ", bRegexGlobal=" + bRegexGlobal
				+ "\n, bSearchable=" + Arrays.toString(bSearchable)
				+ "\n, sSearch=" + Arrays.toString(sSearch) + "\n, bRegex="
				+ Arrays.toString(bRegex) + "\n, bSortable="
				+ Arrays.toString(bSortable) + "\n, iSortCol="
				+ Arrays.toString(iSortCol) + "\n, sSortDir="
				+ Arrays.toString(sSortDir) + "\n, mDataProp="
				+ Arrays.toString(mDataProp) + "]";
	}
}
