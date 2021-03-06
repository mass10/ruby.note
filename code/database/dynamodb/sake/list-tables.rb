#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk-dynamodb'

class Application

	public def initialize()

		@dynamodb = nil

	end

	def open()

		if @dynamodb != nil
			return @dynamodb
		end
		credentials = Aws::Credentials.new('', '')
		@dynamodb = Aws::DynamoDB::Client.new(
			region: 'local', endpoint: 'http://localhost:8000', credentials: credentials)
		return @dynamodb

	end

	def list_tables()

		dynamodb = self.open()
		response = dynamodb.list_tables
		response.table_names.each do |e|
			print(e, "\n")
		end

	end

	def run()

		self.list_tables()

	end

end

def main()

	app = Application.new()
	app.run()

end

main()
