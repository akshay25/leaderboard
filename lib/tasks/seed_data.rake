namespace :seed_data do

  desc "create random users"
  task :create_users => :environment do
    500.times do
      name = (0..5).map { (65 + rand(26)).chr }.join
      user_data = {
        name: name.capitalize,
        email: "#{name.downcase}@xmail.com",
        phone: (0...10).map { rand(10) }.join,
        age: (0...1).map { rand(50) }.join.to_i,
        sex: rand(2) ? "male" : "female"
      }
      User.create(user_data)
    end
  end

  desc "update seed score in table"
  task :seed_scores => :environment do
    Score.all.each do |score|
      score.update_attributes(points: rand(1000))
    end
  end

end
