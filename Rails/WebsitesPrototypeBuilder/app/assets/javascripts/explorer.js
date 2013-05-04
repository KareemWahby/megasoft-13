//these functions are used in the package explorer

function show(id){
	var designPage = document.getElementById('designpage');
	designPage.setAttribute("data-pageid", id);
	var params = $.param({
		pageId: id
	});
	$.ajax("/projects/showPage?" + params);
	$("html, body").animate({ scrollTop: 0 }, 600);
}

function store(){
	var pageId = $('#designpage').data("pageid");	
	alert(pageId);
	if(pageId != 0){
		var response=confirm("هل أنت متأكد أنك تريد حفظ؟");
		if(response==true){
			var html = document.getElementById('designpage').innerHTML; 
			html = html.replace(/\s+/g, ' ');
			var htmlToDisplay=html;
			document.getElementById(pageId).ondblclick= function () {
																										var designPage = document.getElementById('designpage');
																										designPage.setAttribute("data-pageid", pageId);
																										var params = $.param({
																											'pageId': pageId
																										});
																										$.ajax("/projects/showPage?" + params);
																										$("html, body").animate({ scrollTop: 0 }, 600);
																									};
			html=html.replace( "onclickevent", "onclick" , 'g');
			html=html.replace( "onhoverevent", "onmouseover" , 'g');
			var params = $.param({
				pageid: pageId,
				pagehtml: html
			});
			$.ajax({
				url: "/projects/savePage",
				method: 'post',
				data: params
			});
		}
	}
}

function deletePage(){
	var pageId = $("#alt-text").text();
	if(pageId != 0){
		var response=confirm("هل أنت متأكد أنك تريد حذف هذه الصفحة؟");
		if(response){	
			var pageid = document.getElementById('designpage').getAttribute("data-pageid");	
			if(pageid==pageId){
				var designPage = document.getElementById('designpage');
				designpage.innerHTML="<p>صمم صفحتك هنا</p>";
				designPage.setAttribute("data-pageid", 0);
			}
			var params = $.param({
				pageid: pageId
			});
			$.ajax("/projects/deletePage?" + params);
		}
	}
}

function addPage(project_id){
	//this function is used to create new page by the designer
	var pagename=prompt("الرجاء إدخال اسم الصفحة","");
	if(pagename!=null ){
		if (pagename!=""){
	  	var params = $.param({
				pageName: pagename,
				projectId: project_id,

			});
			$.ajax("/projects/createPage?" + params);
	  }else{
	  	alert("الرجاء التأكد من أن اسم الصفحة فريد من نوعه وغير فارغ");
	  } 
	}
	// event.stopDefault();
}

$(document).ready(function() {
	$('#myCarousel').slideUp('slow', function() {
		document.getElementById('title-text').setAttribute("style","display:none");
		$('#alt-text').attr( 'style',"display: none");
	});
	$('#navbar').mouseenter(function(){
		$('#myCarousel').slideDown('slow', function() {
			document.getElementById('title-text').setAttribute("style","visibility:visible");
			if($('#myCarousel').children().first().children().size!=0){
				$('#title-text').attr( 'style',"display: block");
			}
		});
	});
	$('#designpage').mouseenter(function() {
		$('#myCarousel').slideUp('slow', function() {
			document.getElementById('title-text').setAttribute("style","visibility:hidden");
			$('#title-text').attr( 'style',"display: none");
		});
	});	
	$('#sidebar').mouseenter(function() {
		$('#myCarousel').slideUp('slow', function() {
		});
	});
});
function showpopup() {
  $("#popup-projectbck").fadeIn(400);
  $("#popup-project").fadeIn(400);
}
