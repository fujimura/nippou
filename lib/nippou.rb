$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pit'
require 'mail'
require 'core_ext/editable'
require "nippou/version"
config = Pit.get("nippou", :require => {
  "name"       => "Your name",
  "email"      => "Your email",
  "password"   => "Password of your email",
  "recipients" => "Recipients"
})

mail         = Mail.new
mail.to      = config['recipients']
mail.from    = config['email']
mail.charset = 'UTF-8'
mail.body    = (config['body'] || 'write your nippou here').dup.edit! # OMG
mail.delivery_method :smtp, {
  :address              => 'smtp.gmail.com',
  :port                 => 587,
  :domain               => (config['domain'] || 'smtp.gmail.com'),
  :user_name            => config['email'],
  :password             => config['password'],
  :authentication       => :plain,
  :enable_starttls_auto => true
}

mail.deliver
