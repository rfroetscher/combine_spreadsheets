$ ->
	elements = document.getElementsByClassName("sortclass")
	i = 0

	while i < elements.length
	  element = elements[i].id
	  estring = "#" + element

	  $(estring).sortable 
	  	axis: "x",
	  	update: ->
	    	$.post($(this).data('update-url'), $(this).sortable('serialize'))

	  $(estring).disableSelection()


	  i++


