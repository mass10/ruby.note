#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'date'

# Encoding.default_external = Encoding::UTF_8

def Main()

	Mongo::Logger.logger.level = ::Logger::INFO

	client = Mongo::Client.new(
		['127.0.0.1:27017'], :database => 'test')

	collection = client['db20160325']

	collection.find({}).delete_many

	# 特定の属性に一意インデックスを作成する
	collection.indexes.create_one({'USER_NAME' => 1}, :unique => true)

	puts 'Ok.'

end

Main()
