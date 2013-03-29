jQuery ->	
	
	$(".myeditable").editable url: "/post" #this url will not be used for creating new user, it is only for update

	#make username required
	$("#new_username").editable "option", "validate", (v) ->
	  "Required field!"  unless v


	#automatically show next editable
	$(".myeditable").on "save.newuser", ->
	  that = this
	  setTimeout (->
	    $(that).closest("tr").next().find(".myeditable").editable "show"
	  ), 200

	$("#save-btn").click ->
  $(".myeditable").editable "submit",
    url: "/posts/new"
    ajaxOptions:
      dataType: "json" #assuming json response

    success: (data, config) ->
      if data and data.id #record created, response like {"id": 2}
        #set pk
        $(this).editable "option", "pk", data.id
        
        #remove unsaved class
        $(this).removeClass "editable-unsaved"
        
        #show messages
        msg = "New user created! Now editables submit individually."
        $("#msg").addClass("alert-success").removeClass("alert-error").html(msg).show()
        $("#save-btn").hide()
        $(this).off "save.newuser"
      
      #server-side validation error, response like {"errors": {"username": "username already exist"} }
      else config.error.call this, data.errors  if data and data.errors

    error: (errors) ->
      msg = ""
      if errors and errors.responseText #ajax error, errors = xhr object
        msg = errors.responseText
      else #validation error (client-side or server-side)
        $.each errors, (k, v) ->
          msg += k + ": " + v + "<br>"

      $("#msg").removeClass("alert-success").addClass("alert-error").html(msg).show()

