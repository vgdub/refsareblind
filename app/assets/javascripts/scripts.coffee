$ ->
	if $("body").hasClass("pools-admin_dashboard")
		$(".entry-row").on "click", ".approve-entry", (e) ->
			$.ajax({
				url: "/pool-users/approve-entry"
				method: "POST"
				data:
					entry_id: $(e.target).attr("data-entry-id")
				})
			$(e.target).parents("tr").find("td.approval-mark").removeClass("unapproved").addClass("approved").text("✔")
			$(e.target).parents("tr").find(".approve-entry").removeClass("approve-entry").addClass("remove-approval").text("Remove Approval")
		$(".entry-row").on "click", ".remove-approval", (e) ->
			$.ajax({
				url: "/pool-users/remove-approval"
				method: "POST"
				data:
					entry_id: $(e.target).attr("data-entry-id")
				})
			$(e.target).parents("tr").find("td.approval-mark").removeClass("approved").addClass("unapproved").text("✘")
			$(e.target).parents("tr").find(".remove-approval").removeClass("remove-approval").addClass("approve-entry").text("Approve Entry")
