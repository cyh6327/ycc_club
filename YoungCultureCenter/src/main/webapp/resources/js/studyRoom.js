function checkOnlyOne(element) {
  
	const checkboxes 
		= document.getElementsByName("indvSeat");
	
	checkboxes.forEach((cb) => {
	  cb.checked = false;
	})
	
	element.checked = true;
  }