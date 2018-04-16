module UsersHelper
  def searchUser(fieldSearch)
    fieldSearch.strip!
    fieldSearch.downcase!
    # Build query
    userFound = (User.where("first_name like?", "%#{fieldSearch}%") + User.where("last_name like?", "%#{fieldSearch}%") + User.where("email like?", "%#{fieldSearch}%")).uniq
    return nil unless userFound
    userFound
  end

  def excludeFromSearch(users, currentUser)
    users.reject { |user| user.id == currentUser.id}
  end
end