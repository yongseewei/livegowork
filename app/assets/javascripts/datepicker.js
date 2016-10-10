$(document).ready(function(){
	 // var string = jQuery.datepicker.formatDate('dd-mm-yy', date);

	$(document).on("focus","#dateFrom, #dateTo",function(event){
		$('#dateFrom, #dateTo').datepicker({
	    beforeShow: customRange,
	    beforeShowDay: DisableSpecificDates,
	    dateFormat: "dd M yy",
    })
  });
  $(document).on("change","#dateFrom, #dateTo",function(event){
	  if ($('#dateFrom').val() != "" && $('#dateTo').val() != ""){
	  	// debugger
	  }
	});
  $(document).on("focus","#newDateFrom, #newDateTo",function(event){
    $('#newDateFrom, #newDateTo').datepicker({
      beforeShow: newCustomRange,
      dateFormat: "dd M yy",
    })
  });


  function customRange(input) {
    if (input.id == 'dateFrom') {
      var minDate = new Date();
      var maxDate = new Date()
      minDate.setDate(minDate.getDate())
      maxDate.setDate(maxDate.getDate() + 180)
      if (minDate < new Date( gon.reservations[1][0])){
        minDate = new Date( gon.reservations[1][0]);
      }
      if (maxDate > new Date( gon.reservations[1][1])){
        maxDate = new Date( gon.reservations[1][1]);
      }
      return {
          minDate: minDate,
          maxDate: maxDate
      };
    }

    if (input.id == 'dateTo') {
      if($('#dateFrom').val() == ""){
        var minDate = new Date();
        var maxDate = new Date()
        maxDate.setDate(maxDate.getDate() + 180)
      }
      else{
        var minDate = new Date($('#dateFrom').val());   
        for (i = 0; i < gon.reservations[0].length; i++){
          var maxDate = new Date( gon.reservations[0][i])
          if(minDate.setHours(0,0,0,0) < maxDate.setHours(0,0,0,0)){
            break;
          }
        }
        var maxDate = new Date()
        maxDate.setDate(maxDate.getDate() + 180)
      }
      minDate.setDate(minDate.getDate())
      if (maxDate > new Date( gon.reservations[1][1])){
        maxDate = new Date( gon.reservations[1][1]);
      }
      maxDate.setDate(maxDate.getDate())

      
      return {
          minDate: minDate,
          maxDate: maxDate

      };
    }

    return {}

  } 

	function newCustomRange(input) {

    if (input.id == 'newDateFrom') {
      var minDate = new Date();
      minDate.setDate(minDate.getDate())

      return {
          minDate: minDate
      };
    }

    if (input.id == 'newDateTo') {
    	if($('#newDateFrom').val() == ""){
    		var minDate = new Date();
    	}
			else{
	      var minDate = new Date($('#newDateFrom').val());		
			}
      minDate.setDate(minDate.getDate() + 1)      
      return {
          minDate: minDate
      };
    }
    return {}
	}	

  function DisableSpecificDates(date) {
		var disableddates = gon.reservations;
    var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
    return [disableddates[0].indexOf(string) == -1];
    
  }  
});