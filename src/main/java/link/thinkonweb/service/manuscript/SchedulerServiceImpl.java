package link.thinkonweb.service.manuscript;

import link.thinkonweb.service.roles.AssociateEditorService;
import link.thinkonweb.service.roles.ManagerService;
import link.thinkonweb.service.roles.ReviewerService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
@Component
public class SchedulerServiceImpl implements SchedulerService {
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private AssociateEditorService associateEditorService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private ManagerService managerService;
	
	@Scheduled(cron = "10 * * * * ?")
	public void message() {
		System.out.println("------------- SCHEDULED PROCEDURE START -------------");
		reviewerService.checkReviewerDueDate();
		reviewerService.checkInvitedReviewer();
		associateEditorService.checkAssignedAssociateEditor();
		manuscriptService.checkResubmitDuration();
		manuscriptService.checkCameraReadyDuration();
		managerService.checkSpecialIssues();
		System.out.println("------------- SCHEDULED PROCEDURE END -------------");
	}

}
