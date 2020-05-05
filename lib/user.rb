def open_app
    buyer_name = gets.strip
    if valid?(buyer_name)
        user_instance = Buyer.new({name: buyer_name, budget: 0})
        user_instance.save
        interactions(user_instance)
    else
        open_app
    end
end

def interactions(user_instance)
    puts "What would you like to do?"
    puts "If you have any questions type Help."
    interaction = gets.strip
    if interaction == "List Available Houses"
        list_houses
    elsif interaction == "Help"
        help
    elsif interaction == "Exit"
        puts "Have a nice day!"
    else
        interactions(user_instance)
    end
end

def help
    puts "Here are the commands you can enter"
    puts "Visit House"
    puts "Houses Seen"
    puts "List Available Houses"
end

def visit_house
    puts "What house would you like to visit"
    house_id = gets.strip
    house_visit = HouseVisit.new({house_id: house_id, buyer_id: user_instance.id})
    house_visit.save

    puts "This house costs $#{house_visit.price}."
end

def list_houses
    puts House.all
end

def buy_house(house_id)
    house = House.find_by(id: house_id)
    HouseVisit.find_by(house_id: house_id).delete
    house.delete
end

def all_houses_visited(user_instance)
    visited_houses = user_instance.houses
end

def valid?(username)
    bad_usernames = ["open_app", "create_buyer", "visit_house", "list_houses", "buy_house", "delete_buyer"]
    if bad_usernames.include?(username)
        false
    else
        true
    end
end


def delete_buyer

end

def change_budget

end

# created at the begining when user info is given
def create_buyer

end