#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk-dynamodb'
require 'securerandom'


class Logger

	def Logger.trace(*parameters)
		print(Time.now().strftime('%Y-%m-%d %H:%M:%S.%L'), ' [TRACE] ', *parameters, "\n")
	end

end

class Users

	public def initialize()
		@dynamodb = nil
	end

	def open()
		if @dynamodb != nil
			return @dynamodb
		end
		credentials = Aws::Credentials.new('', '')
		@dynamodb = Aws::DynamoDB::Client.new(region: 'local', endpoint: 'http://localhost:8000', credentials: credentials)
		return @dynamodb
	end

	def query_by_prefecture(prefecture)
		db = open()
		parameters = {table_name: 'users'}
		response = db.scan(parameters)
		return response.items
	end

end

class Stopwatch

	def initialize()
		@time = Time.now()
	end

	def to_s()
		current = Time.now()
		elapsed = current - @time
		millisec = elapsed * 1000
		sec = millisec / 1000
		millisec = millisec % 1000
		min = sec / 60
		sec = sec % 60
		hour = min / 60
		min = min % 60
		return sprintf('%02d:%02d:%02d.%03d', hour, min, sec, millisec);
	end

end

class Application

	def test0()
		Logger.trace('$$$ begin query $$$')
		model = Users.new()
		items = model.query_by_prefecture('長崎県')
		items.each do |e|
			Logger.trace('found: ', e)
		end
		Logger.trace(items.count, ' item(s) found.')
	end

	def run()
		s = Stopwatch.new()
		test0()
		Logger.trace('処理時間: ', s)
	end

end

def main()
	app = Application.new()
	app.run()
end

main()
