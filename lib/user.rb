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
    elsif interaction == "Agent"
        agents(user_instance)
    elsif interaction == "Help"
        help
        interactions(user_instance)
    elsif interaction == "Buy House"
        buy_house
    elsif interaction == "Visit House"
        visit_house(user_instance)
    elsif interaction == "Exit"
        puts "Have a nice day!"
    else
        interactions(user_instance)
    end
end

def agents(user_instance)
    budget = user_instance.budget
    if budget == 0
        puts "What is your budget?"
        budget = gets.strip
    end
    #list the agents who match that budget
    houses_agent(budget)
    puts "Which agent do you want to choose?"
    angent_name = gets.strip

    puts "Visting house list:"
    list_houses(angent_name)
end

def houses(budget)
    house = House.where("price <= #{budget}").order("price DESC")
end

def houses_agent(budget)
    house = houses(budget)
    agent = house.map {|house| house.agent.name}.uniq
    agent.each {|agent| puts agent}
end

def help
    puts "Here are the commands you can enter"
    puts "Visit House"
    puts "Houses Seen"
    puts "List Available Houses"
end

def visit_house(user_instance)
    puts "What house would you like to visit"
    house_id = gets.strip
    house_visit = HouseVisit.new({house_id: house_id, buyer_id: user_instance.id})
    house_visit.save

    puts "This house costs $#{house_visit.house.price}."
end

def list_houses
    puts House.all
end

def buy_house
    puts "Which house would you like to buy?"
    house_id = gets.strip
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
