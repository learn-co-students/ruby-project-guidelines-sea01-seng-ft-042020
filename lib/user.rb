def open_app
    user_instance = create_buyer
    interactions(user_instance)
end

def interactions(user_instance)
    puts "If you have any questions type Help."
    puts "What would you like to do?"
    interaction = gets.strip
    if interaction == "List Available Houses"
        list_houses
    elsif interaction == "Agent"
        agents(user_instance)
    elsif interaction == "Help"
        help
    elsif interaction == "Change Budget"
        change_budget(user_instance)
    elsif interaction == "Buy House"
        buy_house(user_instance)
    elsif interaction == "Visit House"
        visit_house(user_instance)
    elsif interaction == "Delete Buyer"
        delete_buyer(user_instance)
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
    agent_name = gets.strip

    puts "Visting house list:"
    agent_list_houses(agent_name)
end

def houses(budget)
    house = House.where("price <= #{budget}").order("price DESC")
end

def houses_agent(budget)
    house = houses(budget)
    agent = house.map {|house| house.agent.name}.uniq
    agent.each {|agent| puts agent}
end

def agent_list_houses(agent_name)
    house = House.all.select {|house| house.agent.name == agent_name}
    house.each {|house| puts "house"}
    #binding.pry
end

def help
    puts "Here are the commands you can enter"
    puts "Visit House"
    puts "Houses Seen"
    puts "List Available Houses"
    puts "Change Budget"
    interactions(user_instance)
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

def buy_house(user_instance)
    puts "Which house would you like to buy?"
    house_id = gets.strip
    house = House.find_by(id: house_id)
    HouseVisit.find_by(house_id: house_id).delete
    house.delete
    interactions(user_instance)
end

def all_houses_visited(user_instance)
    visited_houses = user_instance.houses
    interactions(user_instance)
end

def delete_buyer(user_instance)
    puts "Are you sure you would like to delete your account? (Y/N)"
    answer = gets.strip
    if answer == "Y"
        puts "We are sad to see you go. We hope you use next time for all you home purchasing needs."
        user_instance.visithouses.delete_all
        user_instance.delete
    elsif answer == "N"
        interactions(user_instance)
    else
        puts "Please enter 'Y' or 'N'."
        delete_buyer(user_instance)
    end
end

def change_budget(user_instance)
    puts "What would you like to change your budget to?"
    budget = gets.strip
    if budget.to_f > 0
        user_instance.budget == budget.to_f
        interactions(user_instance)
    else
        puts "You must give a dollar amount."
        change_budget(user_instance)
    end
end

def valid?(username)
    bad_usernames = ["open_app", "create_buyer", "visit_house", "list_houses", "buy_house", "delete_buyer"]
    if bad_usernames.include?(username) or Buyer.find_by(name: username)
        puts "Please enter a different username."
        true
    else
        false
    end
end

# created at the begining when user info is given
def create_buyer
    puts "Please enter your username for the account."
    buyer_name = gets.strip
    if valid?(buyer_name)
        create_buyer
    else
        puts "What would you like your budget to be?"
        budget = create_buyer_budget
        user_instance = Buyer.new({name: buyer_name, budget: budget})
        user_instance.save
        user_instance
    end
end

def create_buyer_budget
    budget = gets.strip
    if budget.to_f <= 0
        puts "You must give a dollar amount greater than $0.00."
        budget = create_buyer_budget
    end
    budget.to_f
end