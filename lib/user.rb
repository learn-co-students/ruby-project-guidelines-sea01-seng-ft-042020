def open_app
    puts "\nWelcome to Find Your House."
    puts "If you already have an account please say 'Log In'."
    puts "Otherwise say 'Create User' or 'Exit'."
    user_input = gets.strip
    if user_input == "Log In"
        user_instance = login
        if user_instance.instance_of? Buyer
            interactions(user_instance)
        end
    elsif user_input == "Create User"
        user_instance = create_buyer
        if user_instance.instance_of? Buyer
            interactions(user_instance)
        end
    elsif user_input == "Exit"
    else
        puts "Please say 'Log In' or 'Create User' or 'Exit'"
        open_app
    end
end

def interactions(user_instance)
    puts "\nIf you have any questions type Help."
    puts "What would you like to do?"
    interaction = gets.strip
    if interaction == "List Available Houses"
        list_houses(user_instance)
    elsif interaction == "Agent"
        choose_agent(user_instance)
    elsif interaction == "Switch Agent"
        agents_valid_budget(user_instance)
    elsif interaction == "Help"
        help(user_instance)
    elsif interaction == "Change Budget"
        change_budget(user_instance)
    elsif interaction == "Buy House"
        buy_house(user_instance)
    elsif interaction == "Visit House"
        visit_house(user_instance)
    elsif interaction == "Visited Houses"
        all_houses_visited(user_instance)
    elsif interaction == "Delete Buyer"
        delete_buyer(user_instance)
    elsif interaction == "Log Out"
        open_app
    elsif interaction == "Exit"
        puts "Have a nice day!"
    else
        interactions(user_instance)
    end
end

# (1) list the agents who satisfy the budget
# (2) choose an agent
# (3) and vist the houses on the agent
def list_agents(user_instance)
    puts "Listing agents who satisfy your budege"
    list_houses_agent(user_instance)

    puts "Which agent do you want to choose?"
    agent_name = gets.strip

    puts "Visting house list:"
    agent_list_houses(agent_name)

    visit_house(user_instance)
end

# determine if the buyer has a valid budget
def agents_valid_budget(user_instance)
    budget = user_instance.budget
    
    if budget.to_f > House.all.map {|house| house.price}.min
        puts "You budget is valid!"                
        list_agents(user_instance)        
    else 
        puts "Your budget is to low for this market."
        puts "Please change your budget to a higher value."
        puts "The cheapest house costs #{House.all.map {|house| house.price}.min}"
        puts "\nPlease change a valid budget to?"        
        user_instance.budget = gets.strip
        agents_valid_budget(user_instance)
    end
end

# list the houses which satisfy the buyer budget
def list_houses_for_user(user_instance)
    house_list = House.where("price <= #{user_instance.budget}").order("price DESC")    
end

# list the agents which satisfy the buyer budget
def list_houses_agent(user_instance)
    house = list_houses_for_user(user_instance)
    agent = house.map {|house| house.agent.name}.uniq
    agent.each {|agent| puts agent}
end

def agent_list_houses(agent_name)
    house = House.all.select {|house| house.agent.name == agent_name}
    house.each {|house| puts "House ID: #{house.id}, House price: #{house.price}, Agent name: #{house.agent.name} "}
end

def choose_agent(user_instance)
    puts "We are going to choose an agent:"
    houses = user_instance.houses
    agents_arr = houses.map {|house| house.agent}
    if agents_arr.empty?
        agents_valid_budget(user_instance)
    else
        puts "You already have an agent! Do you want to switch one?"
        interaction = gets.strip
        if interaction == "No"
            interactions(user_instance)
        elsif interaction == "Switch"
            agents_valid_budget(user_instance)
        end
    end
end

def help(user_instance)
    puts "\nHere are the commands you can enter"
    puts "List Available Houses"
    puts "Agent"
    puts "Change Budget"
    puts "Buy House"
    puts "Visit House"
    puts "Visited Houses"
    puts "Delete Buyer"
    puts "Help"
    puts "Log Out"
    puts "Exit"
    interactions(user_instance)
end

def visit_house(user_instance)
    puts "\nWhat house would you like to visit"
    house_id = gets.strip
    if House.find_by(id: house_id)
        house_visit = HouseVisit.new({house_id: house_id, buyer_id: user_instance.id})
        house_visit.save

        puts "This house costs $#{house_visit.house.price}."
        interactions(user_instance)
    else
        puts "I'm sorry the house ID that you entered is not in our system."
        puts "Please try again."
        visit_house(user_instance)
    end
end

def buy_house(user_instance)
    puts "\nWhich house would you like to buy?"
    house_id = gets.strip
    house = House.find_by(id: house_id)
    binding.pry
    if house
        puts "We hope that you enjoy your lovely new home."
        if HouseVisit.find_by(house_id: house_id.to_i)
            HouseVisit.find_by(house_id: house_id.to_i).delete
        end
        house.delete
        interactions(user_instance)
    else
        puts "Sorry we could not find this house."
        buy_house(user_instance)
    end
end

def all_houses_visited(user_instance)
    visited_houses = user_instance.houses
    if visited_houses
        puts "You have visited:"
        visited_houses.each {|house_seen| puts "House ID: #{house_seen.id}, House Price: #{house_seen.price}"}
        interactions(user_instance)
    else
        puts "You have not visited any houses."
        interactions(user_instance)
    end
end

def delete_buyer(user_instance)
    puts "\nAre you sure you would like to delete your account? (Y/N)"
    answer = gets.strip
    if answer == "Y"
        puts "\nWe are sad to see you go. We hope you use next time for all you home purchasing needs."
        user_instance.visithouses.delete_all
        user_instance.delete
        open_app
    elsif answer == "N"
        interactions(user_instance)
    else
        puts "Please enter 'Y' or 'N'."
        delete_buyer(user_instance)
    end
end

def change_budget(user_instance)
    puts "\nWhat would you like to change your budget to?"
    budget = gets.strip
    if budget.to_f > 0 and houses(budget.to_f)[0]
        user_instance.budget == budget.to_f
        interactions(user_instance)
    elsif houses(budget.to_f)[0] == nil
        puts "Your budget is to low for this market."
        puts "Please change your budget to a higher value."
        puts "The cheapest house costs #{House.all.map {|house| house.price}.min}"
        change_budget(user_instance)
    else
        puts "You must give a dollar amount greater than $0.00."
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
    puts "\nPlease enter your username for the account."
    buyer_name = gets.strip
    if valid?(buyer_name)
        create_buyer
    else
        puts "\nWhat would you like your budget to be?"
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

def login
    puts "\nPlease enter your username"
    user_name = gets.strip
    user = Buyer.find_by(name: user_name)
    if user
        user
    elsif user_name == "Create User"
        create_buyer
    elsif user_name == "Exit"
    else
        puts "Sorry we could not find this account."
        puts "If you dont know your username then type 'Create User' or 'Exit'"
        login
    end
end