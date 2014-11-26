module HomePageHelper
	def home_page_get_started_path
		user_signed_in? ? spreadsheetdocs_path : new_user_registration_path
	end
end
