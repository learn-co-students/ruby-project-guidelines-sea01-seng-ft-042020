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
        puts "Have a nice day!"
    else
        puts "Please say 'Log In' or 'Create User' or 'Exit'"
        open_app
    end
end

def interactions(user_instance)
    puts "\nIf you have any questions type Help."
    puts "What would you like to do?"
    interaction = gets.strip
    if interaction == "List All Houses"
        list_houses(user_instance)
    elsif interaction == "Agent"
        choose_agent(user_instance)
    elsif interaction == "Agents Houses"
        agent_list_houses_helper(user_instance)
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
    agents = list_houses_agent(user_instance)

    puts "Which agent do you want to choose?"
    agent = valid_agent_name(user_instance, agents)
    user_instance = Buyer.find_by(id: user_instance.id)

    puts "Visting house list:"
    agent_list_houses(agent)

    visit_house(user_instance, agent)
end

def valid_agent_name(user_instance, agents)
    agent_name = gets.strip
    if agents.select {|agent| agent.name == agent_name}[0]
        HouseVisit.where("buyer_id = #{user_instance.id}").each {|housevisit| housevisit.delete}
        return Agent.find_by(name: agent_name)
    else
        puts "This is an invalid name. Please try again."
        valid_agent_name(user_instance, agents)
    end
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
        user_instance.save
        agents_valid_budget(user_instance)
    end
end

# list the houses which satisfy the buyer budget
def list_houses_for_user(user_instance)
    house_list = House.where("price <= #{user_instance.budget}").order("price DESC")    
end

# list the agents which satisfy the buyer budget
def list_houses_agent(user_instance)
    houses = list_houses_for_user(user_instance)
    agent = houses.map {|house| house.agent}.uniq
    agent.each {|agent| puts agent.name}
    agent
end

def agent_list_houses_helper(user_instance)
    if user_instance.houses[0]
        agent_list_houses(user_instance.houses[0].agent)
    else
        puts "You currently do not have an angent"
        puts "Please visit the Agents section"
    end
    interactions(user_instance)
end

def agent_list_houses(agent)
    house = House.all.select {|house| house.agent.name == agent.name}
    house.each {|house| puts "House ID: #{house.id}, House price: #{house.price}, Agent name: #{house.agent.name} "}
end

def choose_agent(user_instance)
    puts "We are going to choose an agent:"
    houses = user_instance.houses
    agents_arr = houses.map {|house| house.agent}
    if agents_arr.empty?
        agents_valid_budget(user_instance)
    else
        puts "Your current Agent is #{user_instance.houses[0].agent.name}"
        puts "You already have an agent! Do you want to switch one? (Y/N)"
        interaction = gets.strip
        if interaction == "Y"
            agents_valid_budget(user_instance)
        else
            interactions(user_instance)
        end
    end
end

def help(user_instance)
    puts "\nHere are the commands you can enter"
    puts "List All Houses: List all Houses on the market"
    puts "Agent: To choose or Switch your Agent"
    puts "Agents Houses: List your agents houses"
    puts "Change Budget"
    puts "Buy House: You must visit the house first"
    puts "Visit House"
    puts "Visited Houses: All Houses you have visited"
    puts "Delete Buyer: Delete account"
    puts "Help"
    puts "Log Out: Allows you to switch accounts"
    puts "Exit"
    interactions(user_instance)
end

def visit_house(user_instance, agent = nil)
    if agent.instance_of?(Agent) or user_instance.houses[0]
        puts "\nWhat house would you like to visit?"
        puts "Say 'Exit' to leave."
        house_id = gets.strip
        if house_id == "Exit" or house_id.to_i > 0
            if house_id == "Exit"
                interactions(user_instance)
            elsif House.find_by(id: house_id) and agent
                if House.find_by(id: house_id).agent == agent
                house_visit = HouseVisit.new({house_id: house_id, buyer_id: user_instance.id})
                house_visit.save
                user_instance = Buyer.find_by(id: user_instance.id)

                puts "This house costs $#{house_visit.house.price}."
                interactions(user_instance)
                else
                    puts "I'm sorry the house ID that you entered is not under your agent."
                    puts "Please try again."
                    visit_house(user_instance, agent)
                end
            elsif House.find_by(id: house_id) and user_instance.houses[0]
                if House.find_by(id: house_id).agent == user_instance.houses[0].agent
                    house_visit = HouseVisit.new({house_id: house_id, buyer_id: user_instance.id})
                    house_visit.save
                    user_instance = Buyer.find_by(id: user_instance.id)

                    puts "This house costs $#{house_visit.house.price}."
                    interactions(user_instance)
                else
                    puts "I'm sorry the house ID that you entered is not under your agent."
                    puts "Please try again."
                    visit_house(user_instance, agent)
                end
            else
                puts "I'm sorry the house ID that you entered is not under your agent."
                puts "Please try again."
                visit_house(user_instance, agent)
            end
        else
            puts "Please input an ID or 'Exit'"
            visit_house(user_instance, agent)
        end
    else
        puts "Please visit the agent section to get an agent"
        interactions(user_instance)
    end
end

def buy_house(user_instance)
    puts "\nWhich house would you like to buy?"
    house_id = gets.strip
    house = House.find_by(id: house_id)
    if HouseVisit.where("house_id = #{house_id}").where("buyer_id = #{user_instance.id}")[0]
        puts "We hope that you enjoy your lovely new home."
        if HouseVisit.find_by(house_id: house_id.to_i)
            HouseVisit.find_by(house_id: house_id.to_i).delete
        end
        house.delete
        user_instance = Buyer.find_by(id: user_instance.id)
        interactions(user_instance)
    else
        puts "Sorry this house in your records."
        puts "Would you like to buy a different house? (Y/N)"
        answer = gets.strip
        if answer == "Y"
            buy_house(user_instance)
        else
            interactions(user_instance)
        end
    end
end

def all_houses_visited(user_instance)
    visited_houses = user_instance.houses
    if visited_houses[0]
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
        if user_instance.house_visits[0]
            user_instance.house_visits.delete_all
        end
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
    if budget.to_f >= House.all.map {|house| house.price}.min
        user_instance.budget = budget.to_f
        user_instance.save
        user_instance = Buyer.find_by(id: user_instance.id)
        interactions(user_instance)
    else
        puts "Your budget is to low for this market."
        puts "Please change your budget to a higher value."
        puts "The cheapest house costs #{House.all.map {|house| house.price}.min}"
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

def list_houses(user_instance)
    house = House.all
    house.each {|house| puts "House ID: #{house.id}, House price: #{house.price}, Agent name: #{house.agent.name} "}
    interactions(user_instance)
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