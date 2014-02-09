module UsersHelper
	def getName(uid)
		return User.find(uid).name
	end

end
