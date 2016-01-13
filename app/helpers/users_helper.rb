module UsersHelper
    #返回指定用户的 gravatar
    def gravatar_for(user)
        gravatar_id = Digest::MD5::hexdigest(user.mail.downcase)
        gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url , alt: user.name , class: "gravatar")
    end
end
