package link.thinkonweb.controller.journal;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.FileImageInputStream;
import javax.imageio.stream.ImageInputStream;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.dao.journal.CategoryDao;
import link.thinkonweb.dao.journal.JournalCategoryDao;
import link.thinkonweb.domain.journal.Category;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalCategory;
import link.thinkonweb.domain.user.CountryCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@SessionAttributes("journal")
@Transactional
@RequestMapping("/submitJournal")
public class SubmitJournalController {
	private Journal journal = null;
	@Autowired
	private JournalService journalService;
	@Autowired
	private UserService userService;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private MessageSource messageSource;
	@Inject
	private FileSystemResource fileSystemResource;
	@Autowired
	private JournalConfigurationService jcService;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private JournalCategoryDao journalCategoryDao;
	
	@RequestMapping(method=RequestMethod.GET)
	public String setupForm(Model model, HttpServletRequest request, Locale locale) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		if (username == null || username.equals("anonymousUser")) {
			return "promotion.signin";
		} else {
			SystemUser creator = userService.getByUsername(username);
			journal = journalService.getBeingCreated(creator.getId());
			if(journal == null) {
				journal = new Journal();
				journal.setCreator(creator);
				int journalId = journalService.create(journal);
				journal.setId(journalId);
			}
			journal.setPublisherCountryCode(new CountryCode());
			journal.setCreator(creator);
			String type = null;
			if(journal.getType() != null)
				type = journal.getType();
			else
				type = "A";
			journal.setType(type);
			
			List<Category> categories = categoryDao.findAll();
			model.addAttribute("categories", categories);
			int upperCategory = 0;
			List<JournalCategory> journalCategories = journalCategoryDao.findByJournalId(journal.getId());
			if(journalCategories != null && journalCategories.size() > 0) {
				String categoryName =  journalCategories.get(0).getName();
				Category category = categoryDao.findByName(categoryName);
				if(category != null)
					upperCategory = categoryDao.findByName(categoryName).getUpperCategory();
			}
			model.addAttribute("upperCategory", upperCategory);
			model.addAttribute("journalCategories", journalCategories);
			model.addAttribute("journal", journal);
			return "openJournal.setupForm";
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/getCategories", method=RequestMethod.GET)
	public @ResponseBody String getCategories(HttpServletRequest request, Locale locale, 
			@RequestParam(value="journalId", required=true) int journalId,
			@RequestParam(value="upperCategory", required=true) int upperCategory) {
		StringBuffer sb = new StringBuffer();
		List<Category> lowerCategories = categoryDao.findByUpperCategory(upperCategory);
		for(Category category: lowerCategories) {
			sb.append("<option value='" + category.getName() +"'>");
			sb.append(messageSource.getMessage("journal.category." + category.getName(), null, locale));
			sb.append("</option>");
		}
		return sb.toString();
	}
	
	@RequestMapping(value="/saveCategories", method=RequestMethod.POST)
	public @ResponseBody Boolean saveJournalInfo(Model model, HttpServletRequest request,
			@RequestParam(value="journalId", required=true) int journalId,
			@RequestParam(value="name", required=true) String name,
			@RequestParam(value="value", required=true) String value) {
		Journal journal = journalService.getById(journalId);
		if(name.equals("type"))
			journal.setType(value);
		else if(name.equals("journalCategory")) {
			String[] values = value.split(",");
			journalCategoryDao.deleteByJournalId(journal.getId());
			for(String categoryName : values) {
				if(journalCategoryDao.findByNameAndJournalId(name.trim(), journal.getId()) == null) {
					JournalCategory jc = new JournalCategory();
					jc.setName(categoryName);
					jc.setJournalId(journal.getId());
					journalCategoryDao.insert(jc);
				}
			}
		}

		journalService.update(journal);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/numCategories", method=RequestMethod.GET)
	public @ResponseBody String numCategories(HttpServletRequest request, Locale locale, 
			@RequestParam(value="journalId", required=true) int journalId) {
		int numCategories = 0;
		List<JournalCategory> journalCategories = journalCategoryDao.findByJournalId(journalId);
		if(journalCategories != null)
			numCategories = journalCategories.size();
		return Integer.toString(numCategories);
	}

	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView submitForm(@ModelAttribute("journal") Journal journal,
							 BindingResult result, 
							 HttpServletRequest request, 
							 SessionStatus status, 
							 Model model) {
		ModelAndView mav = new ModelAndView();
		if (result.hasErrors()) {
			for(ObjectError error : result.getAllErrors()) {
		        System.err.println("Error: " + error.getCode() +  " - " + error.getDefaultMessage());
		    }
			mav.addObject("journal", journal);
			mav.setViewName("openJournal.setupForm");
			return mav;
		} else {
			int x1 = Integer.parseInt(request.getParameter("x1"));
			int y1 = Integer.parseInt(request.getParameter("y1"));
			int x2 = Integer.parseInt(request.getParameter("x2"));
			int y2 = Integer.parseInt(request.getParameter("y2"));
			int w = Integer.parseInt(request.getParameter("w"));
			int h = Integer.parseInt(request.getParameter("h"));
			int realW = 0;
			int realH = 0;
			try {
				String extension = this.getExtension(fileSystemResource.getPath() + File.separator + "coverImages" + File.separator + request.getParameter("imgName"));
				Iterator<ImageReader> iter = ImageIO.getImageReadersBySuffix(extension);
				ImageInputStream imgStream = null;
				if (iter.hasNext()) {
					ImageReader reader = iter.next();
					try {
						imgStream = new FileImageInputStream(new File(fileSystemResource.getPath() + File.separator + "coverImages" + File.separator + request.getParameter("imgName")));
						reader.setInput(imgStream);
						realW = reader.getWidth(reader.getMinIndex());
						realH = reader.getHeight(reader.getMinIndex());
					} catch (IOException e) {
						System.out.println(e.getMessage());
					} finally {
						reader.dispose();
					}
				} else {
					System.out.println("No reader found for given format: " + extension);
				}
				
				BufferedImage src = ImageIO.read(new File(fileSystemResource.getPath() +File.separator + "coverImages" + File.separator + request.getParameter("imgName")));
	
				int registerX = Math.round(x1 * realW / w);
				int registerY = Math.round(y1 * realH / h);
				int width = Math.round(x2 * realW / w) - registerX;
				int height = Math.round(y2 * realH / h) - registerY;
				
				BufferedImage registerImage = src.getSubimage(registerX, registerY, width, height);
				File outputfile = new File(fileSystemResource.getPath() + File.separator + "coverImages" + File.separator + "r-" + request.getParameter("imgName"));			
				ImageIO.write(registerImage, getExtension(request.getParameter("imgName")), outputfile);
	
				outputfile = new File(servletContext.getRealPath("") + File.separator + "WEB-INF" + File.separator + "classes" + File.separator + "images" + File.separator + "coverImages" + File.separator + "r-" + request.getParameter("imgName"));			
				ImageIO.write(registerImage, getExtension(request.getParameter("imgName")), outputfile);
	
				journal.setCoverImageFilename("r-" + request.getParameter("imgName"));
				journal.setCoverImageUploaded(true);
			} catch (IOException e) {
				System.out.println(e);
			}
			
			journal.setEnabled(false);
			journal.setPaid(false);
			this.journalService.submit(journal);
			jcService.create(journal.getId());
			
			status.setComplete();
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			String nextStep = "1";
			if(journal.getLanguageCode().equals("ko") && user.getContact().getLocalJobTitle() == null)
				nextStep = "0";
			
			RedirectView rv = new RedirectView("journals/"+ journal.getJournalNameId() + "/manager/configuration/journal/setup/step/" + nextStep);
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
	
	@RequestMapping(value = "/coverImageUpload", method=RequestMethod.POST)
	public @ResponseBody String submitCoverImageForm(MultipartHttpServletRequest request, @RequestParam(value="journalId", required=false) String journalId) {
		String saveFileName = null;
		int width = 0;
		int height = 0;
		try{
			Iterator<String> itr =  request.getFileNames();
			MultipartFile file = request.getFile(itr.next());
			
			String genId = UUID.randomUUID().toString();
			String filename = file.getOriginalFilename();
	        byte[] bytes = file.getBytes();
	        
	        saveFileName = genId + "." + getExtension(filename);
			//journal.setCoverImageFilename(saveFileName);           
        	BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(fileSystemResource.getPath() + File.separator + "coverImages" + File.separator + saveFileName));
        	bos.write(bytes);
    		bos.flush();
    		bos.close();
    		    		
    		bos = new BufferedOutputStream(new FileOutputStream(servletContext.getRealPath("") + File.separator + "WEB-INF" + File.separator + "classes" + File.separator + "images" + File.separator + "coverImages" + File.separator + saveFileName));
    		bos.write(bytes);
    		bos.flush();
    		bos.close();
    		
			ImageInputStream imgStream = new FileImageInputStream(new File(fileSystemResource.getPath() + File.separator + "coverImages" + File.separator + saveFileName));
			String extension = this.getExtension(saveFileName);
//			System.out.println("extension: " + extension);
			Iterator<ImageReader> iter = ImageIO.getImageReadersBySuffix(extension);
			if (iter.hasNext()) {
				ImageReader reader = iter.next();
				try {
					reader.setInput(imgStream);
					width = reader.getWidth(reader.getMinIndex());
					height = reader.getHeight(reader.getMinIndex());
				} catch (IOException e) {
					System.out.println(e);
				}
			}					
        }catch(IOException ie){
            System.err.println("File writing error! " + ie);
        }
		if(journalId != null)
			journal = journalService.getById(Integer.parseInt(journalId));
		
        this.journalService.update(journal);
        String returnString = "<img id='uploadImage' width='100%' src='" 
				+ servletContext.getContextPath()
				+ "/images/coverImages/" + saveFileName + "' />"
				+ "<script>$('img[id=\"uploadImage\"]').imgAreaSelect({ aspectRatio: '5:7', show:true, onInit: preview, onSelectStart: preview, onSelectEnd: preview, disable: false }); $('img[id=\"uploadImage\"]').load(imgSelInitial);</script>"
				+ "-----"
				+ "<div style='overflow:hidden;width:150px;height:210px;'><img id='previewImage' src='" 
				+ servletContext.getContextPath()
				+ "/images/coverImages/" + saveFileName + "' /></div>"
				+ "-----" 
				+ width
        		+ "-----"
				+ height
				+ "-----"
				+ saveFileName;
        return returnString;
	}
	
	private String getExtension(String fileName) {
		int dotPosition = fileName.lastIndexOf('.');		
		if (-1 != dotPosition && fileName.length() - 1 > dotPosition) {
			return fileName.substring(dotPosition + 1).toLowerCase();
		} else {
			return "";
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/jnidDuplicateCheck", method=RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean isJournalNameIDDuplicated(@RequestParam("jnid") String jnid, HttpServletRequest request) {
		if (journalService.isUniqueJournalNameID(jnid)) 
			return true;  
		else 
			return false;
	}

}