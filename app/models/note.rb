class Note < ActiveRecord::Base
	attr_accessible :note_collection_id, :text, :start, :end
	belongs_to :note_collections

	def start_to_string
		time = start.to_i
		hours   = (time / 3600).floor
		minutes = ((time - (hours * 3600)) / 60).floor
		seconds = time - (hours * 3600) - (minutes * 60)
		if (hours   < 10)
			hours = "0" + hours.to_s
		end
		if (minutes < 10 && hours ==0 )
			minutes = minutes
		elsif	(minutes < 10)
			minutes = "0" + minutes.to_s
		end
		if (seconds < 10) 
			seconds = "0" + seconds.to_s
		end
		minutes = minutes.to_s
		seconds = seconds.to_s
		hours = hours.to_s
		if(hours.to_i != 0)
			timestring = hours + ':' + minutes + ':' + seconds;
		else
			timestring = minutes + ':' + seconds;
		end
		return timestring;
	end
end
