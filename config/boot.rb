# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
#ENV['API_ENDPOINT'] ||= 'https://devapi.teknion.com/'

ENV['BOX_CLIENT_ID']='ag2ym5fj936xxeue07wh7xr7e8xofdfo'
ENV['BOX_CLIENT_SECRET']='f3jzMDPr2HiTgX9l6Oy2zbAyZCzwZkRJ'
