User.seed do |s|
  s.id = 1
  s.user_digest = BCrypt::Password.create(SecureRandom.urlsafe_base64)
  s.email = Settings.admin[:email]
  s.password = Settings.admin[:password]
  s.password_confirmation = Settings.admin[:password_confirmation]
  s.role = 5
end
