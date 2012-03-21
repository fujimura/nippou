$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pit'
require 'mail'
require 'core_ext/editable'
require "nippou/version"
module Nippou
  class Base
    DEFAULT_CHARSET = 'utf-8'
    def self.deliver
      config = Pit.get("nippou", :require => {
                         "name"       => "Your name",
                         "email"      => "Your email",
                         "password"   => "Password of your email",
                         "recipients" => "Recipients"})

      mail         = Mail.new
      mail.to      = config['recipients']
      mail.from    = config['email']
      mail.charset = DEFAULT_CHARSET
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
    end
  end
end
