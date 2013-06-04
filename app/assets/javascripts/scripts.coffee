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
################################
	if $("body").hasClass("nfl_picks-new") && $(".pool").attr("data-pool-type") == "supercontest"

		$(".matchup-team").on "click", (e) ->
			team_picked = $(e.target).attr("data-team-id")
			pick_number = find_next_unpopulated_pick()
			if pick_number
				if pick_is_not_duplicate(team_picked)
					$row_to_populate = $("tr.pick#{pick_number}")
					$row_to_populate.find(".pick").text($(e.target).text()).attr("data-team-id", team_picked)
					increment_total_picks()
				else
					alert "You have already chosen this team"
			else
				alert "You need to delete a pick before you can make another one"

		find_next_unpopulated_pick = ->
			total_picks = parseInt $(".picks-table").attr("data-total-picks"), 10
			if total_picks < 5 then return total_picks + 1 else return false

		increment_total_picks = ->
			total_picks = parseInt $(".picks-table").attr("data-total-picks"), 10
			$(".picks-table").attr("data-total-picks", total_picks + 1)

		pick_is_not_duplicate = (team_picked) ->
			teams_picked = []
			_.each $("td.pick"), (item) ->
				if $(item).attr("data-team-id")
					teams_picked.push $(item).attr("data-team-id")
			if _.include(teams_picked, team_picked) then return false else return true

	if $("body").hasClass("nfl_picks-new") && $(".pool").attr("data-pool-type") == "survival"

		$(".matchup-team").on "click", (e) ->
			team_picked = $(e.target).attr("data-team-id")
			$(".current-pick").text($(e.target).text())
			$(".current-pick-team-id").val(team_picked)
			$(".current-pick-matchup-id").val($(e.target).parents(".matchup").attr("data-matchup-id"))
