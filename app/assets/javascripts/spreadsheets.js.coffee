# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#new_spreadsheetdoc').fileupload
		dataType: "script"
		add: (e, data) ->
		  types = /(\.|\/)(xls|xlsx|csv|ods)$/i
		  file = data.files[0]
		  if types.test(file.type) || types.test(file.name)
		    data.context = $(tmpl("template-upload", file))
		    (data.context).insertAfter($('.topbtn'))
		    data.submit()
		  else
		    alert("#{file.name} is not a xls, xlsx, ods, or csv file")
		progress: (e, data) ->
		  if data.context
		    progress = parseInt(data.loaded / data.total * 100, 10)
		    data.context.find('.progress-bar').css('width', progress + '%')
		done: (e, data) ->
			$('.upload').hide()
