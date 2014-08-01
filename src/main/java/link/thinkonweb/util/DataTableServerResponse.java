package link.thinkonweb.util;

import java.io.IOException;
import java.util.Arrays;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

public class DataTableServerResponse {
	int			iTotalRecords;
	int			iTotalDisplayRecords;
	String		sEcho;
	String[][]	aaData;
	
	static ObjectMapper mapper = new ObjectMapper();
	
	public DataTableServerResponse(DataTableClientRequest dRequest, int iTotalRecords, int iTotalDisplayRecords, int resultSize) {
		this.sEcho = dRequest.getsEcho();
		this.iTotalRecords = iTotalRecords;
		this.iTotalDisplayRecords = iTotalDisplayRecords;
		aaData = new String[resultSize][dRequest.getiColumns()];
	}
		
	public String[][] getAaData() {
		return aaData;
	}

	public void setAaData(int rowIndex, int columnIndex, String data) {
		aaData[rowIndex][columnIndex] = data;
	}

	public int getiTotalRecords() {
		return iTotalRecords;
	}

	public void setiTotalRecords(int iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}

	public int getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}

	public void setiTotalDisplayRecords(int iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}
	
	public static String toJSONString(DataTableServerResponse object) {
		String jsonString = null;
		try {
			jsonString = mapper.writeValueAsString(object);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jsonString;
	}

	@Override
	public String toString() {
		return "DataTableServerResponse [iTotalRecords=" + iTotalRecords
				+ ", iTotalDisplayRecords=" + iTotalDisplayRecords + ", sEcho="
				+ sEcho + ", aaData=" + Arrays.toString(aaData) + "]";
	}
	
	
}
