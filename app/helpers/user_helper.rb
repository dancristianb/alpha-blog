module UserHelper
  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{options[:size]}"
    image_tag(image_src, alt: @user.username, class: 'rounded mx-auto d-block mt-4 shadow')
  end
end
