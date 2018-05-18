module UsersHelper
  def avatar (user)
    base_url = '/avatars/'
    if user.photo.nil?
      base_url + 'nophoto.jpg'
    else
      base_url + user.photo
    end
  end
end
