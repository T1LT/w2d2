require_relative "room"

class Hotel
    attr_reader :rooms
    def initialize(name, rooms)
        @name = name
        @rooms = {}
        rooms.each do |room, capacity|
            @rooms[room] = Room.new(capacity)
        end
    end

    def name
        @name.split(" ").each(&:capitalize!).join(" ")
    end

    def room_exists?(room)
        @rooms.has_key? room
    end

    def check_in(person, room)
        if !(self.room_exists? room)
            print "sorry, room does not exist"
            return
        end
        temp = @rooms[room].add_occupant(person)
        print temp ? "check in successful" : "sorry, room is full"
    end

    def has_vacancy?
        !(rooms.values.all? { |room| room.full? })
    end

    def list_rooms
        @rooms.each do |name, room|
            puts "#{name}.*#{room.available_space}"
        end
    end

end
