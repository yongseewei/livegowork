// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui
//= require private_pub
//= require chat
//= require jquery.raty
//= require ratyrate
//= require jquery.raty.min
//= require underscore
//= require gmaps/google
//= require bootstrap-sprockets
//= require geocomplete
//= require turbolinks
//= require_tree .


$(document).ready(function(){
  if ($("#error-message-job_applications").length){ 	
  	var listing = "/jobs/" + $("#error-message-job_applications").attr("data-id")
		window.history.pushState("object or string", "Title", listing);		
	}

	// $(".loginmodal-register").click(function(){
	// 	$(".loginmodal-register").toggle();
	// 	$(".loginmodal-signin").toggle();
	// });

	// $('#myModal').on('hidden.bs.modal', function () {
	// 	$($(".loginmodal-register")[0]).show();
	// 	$($(".loginmodal-register")[1]).hide();
	// 	$($(".modal-body .loginmodal-signin")[0]).show();
	// 	$($(".modal-body .loginmodal-signin")[1]).hide();
	// 	$($(".loginmodal-signin")[0]).show();
	// 	$($(".loginmodal-signin")[1]).hide();
	// })
});



