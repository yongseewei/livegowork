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

	$(document).on('submit',".sign-in-form",function(event){
		event.preventDefault();
		$.ajax({
			type: 'POST',
			url: $(this).attr('action'),
			data: $(this).serialize(),
			dataType: "script",
			success: function(msg) {
				if($("#show_error .flash").length){
					$("#show_error").slideDown(1000);
					setTimeout(function() { 
						$("#show_error").slideUp(1000,function(){
							$("#show_error").empty();
						}); 
					}, 3000);
				}
				else{
					location.reload();
				}
			}
		})
	})
});