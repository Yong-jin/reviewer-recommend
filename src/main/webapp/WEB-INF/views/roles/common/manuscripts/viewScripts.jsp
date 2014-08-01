<script>
var pageType = "${pageType}";
var v = "${v}";
var status = "${manuscript.status}";
$('.historyView').hide();
function historyView(manuscriptId, type) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/manuscripts/viewManuscriptHistory?manuscriptId=${manuscript.id}&type=" + type,
		success: function(html){
			var displayId = "#" + "${pageType }" + type + "historyDisplay";
			var displayViewButtonId = "#" + "${pageType }" + type + "historyViewButton";
			var currentDisplayId = "#" + "${pageType }" + type + "historyCurrentDisplay";
			if($(displayId).css("display") != "none") {
				$(displayId).hide('normal');
				$(currentDisplayId).show('normal');
				$(displayViewButtonId).html('<i class="fa fa-angle-down "></i>');
			} else {
				$(displayId).html(html).show('normal');
				$(currentDisplayId).hide('normal');
				$(displayViewButtonId).html('<i class="fa fa-angle-up "></i>');
			}
		}
	});	
}

var minWidth = $('.ver-inline-menu').css("min-width");
minWidth = minWidth.replace('px', '');
if(Number(firstTabWidth) < Number(minWidth))
	$('.ver-inline-menu').css("width", minWidth);
else
	$('.ver-inline-menu').css("width", firstTabWidth);

$('.backToTable').click(function(event) {
	event.preventDefault();
	viewStatusMap.put("${pageType}", false);
	location.hash = "#" + "${pageType}";
	
	var currentPageRole = "${currentPageRole}";
	if(currentPageRole == 'associateEditor' && dataChanged)
		location.href="${baseUrl}/journals/${jnid}/${currentPageRole}/manuscripts";
	else {
		tableViewId = '#' + "${pageType}" + '-t';
		viewId = '#' + "${pageType}" + '-v';
		$(viewId).hide();
		$(tableViewId).show('normal');
	}
});
</script>