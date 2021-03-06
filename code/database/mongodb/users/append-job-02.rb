#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'date'
require 'time'

def _update(collection, user_name, attributes)

	e = collection.find({'USER_NAME' => user_name})
	if e == nil
		return
	end

	e.update_one({'$set' => attributes})

end

def _main()

	Mongo::Logger.logger.level = ::Logger::INFO

	client = Mongo::Client.new(
		['127.0.0.1:27017'], :database => 'test')

	collection = client['db20160325']

	_update(collection, '岸部シロー', {'JOB' => ['ザ・タイガース', '俳優']})
	_update(collection, '岸部一徳', {'JOB' => ['ザ・タイガース', '俳優']})
	_update(collection, '沢田研二', {'JOB' => ['ザ・タイガース', '歌手']})
	_update(collection, '加橋かつみ', {'JOB' => 'ザ・タイガース'})
	_update(collection, '森本太郎', {'JOB' => 'ザ・タイガース'})
	_update(collection, '瞳みのる', {'JOB' => ['ザ・タイガース', '中国文学・中国語研究者', '高等学校教諭']})

	puts collection.find({}).count

	puts '--- end ---'

end

_main()
