Agent.destroy_all
Buyer.destroy_all
House.destroy_all
HouseVisit.destroy_all

10.times do 
    Agent.create({
        name: Faker::FunnyName.three_word_name,
    })
end

300.times do
    Buyer.create({
        name: Faker::FunnyName.three_word_name,
        agent_id: (rand(10) + 1),
        budget: (100000 + rand(500000) + rand(100) / 100.0),
    })
end

100.times do
    Buyer.create({
        agent_id: (rand(10) + 1),
        price: (100000 + rand(600000) + rand(100) / 100.0),
    })
end