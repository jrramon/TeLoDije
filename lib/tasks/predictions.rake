namespace :predictions do
  desc "Resolve pending predictions that have reached their resolution date"
  task resolve_pending: :environment do
    puts "Resolving pending predictions..."
    PredictionResolver.resolve_pending_predictions
    puts "Done!"
  end
  
  desc "Update user statistics"
  task update_stats: :environment do
    puts "Updating user statistics..."
    User.find_each do |user|
      user.update_stats
    end
    puts "Done!"
  end
end 