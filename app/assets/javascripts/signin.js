$(document).ready(function(){
	$(".loginmodal-register").click(function(){
		$(".loginmodal-register").toggle();
		$(".loginmodal-signin").toggle();
	});

	$('#myModal').on('hidden.bs.modal', function () {
		$($(".loginmodal-register")[0]).show();
		$($(".loginmodal-register")[1]).hide();
		$($(".modal-body .loginmodal-signin")[0]).show();
		$($(".modal-body .loginmodal-signin")[1]).hide();
		$($(".loginmodal-signin")[0]).show();
		$($(".loginmodal-signin")[1]).hide();
	})
});