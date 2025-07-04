class PredictionResolver
  def self.resolve_pending_predictions
    pending_predictions = Prediction.where(resolved: false)
                                   .where('resolution_date <= ?', Time.current)
    
    pending_predictions.find_each do |prediction|
      new(prediction).resolve
    end
  end
  
  def initialize(prediction)
    @prediction = prediction
  end
  
  def resolve
    return if @prediction.resolved?
    
    # For now, we'll use a simple heuristic to determine outcome
    # In a real app, this would be manual or based on external data
    outcome = determine_outcome
    
    @prediction.update(resolved: true, outcome: outcome)
    
    distribute_points(outcome)
    update_user_stats(outcome)
  end
  
  private
  
  def determine_outcome
    # Simple heuristic: if more people voted YES, outcome is likely YES
    # This is just for demo purposes - in reality, this would be manual
    yes_votes = @prediction.yes_votes
    no_votes = @prediction.no_votes
    
    if yes_votes > no_votes
      true # YES outcome
    elsif no_votes > yes_votes
      false # NO outcome
    else
      # Tie - random outcome for demo
      [true, false].sample
    end
  end
  
  def distribute_points(outcome)
    @prediction.votes.includes(:user).each do |vote|
      user = vote.user
      
      if vote.outcome == outcome
        # Correct prediction - award points
        points_won = calculate_points_won(vote.points, outcome)
        user.award_points(points_won, "Predicción correcta")
        user.update_streak(true)
      else
        # Incorrect prediction - no points awarded
        user.update_streak(false)
      end
      
      user.update_stats
    end
  end
  
  def calculate_points_won(points_bet, outcome)
    # Simple point calculation: if you bet on the winning side,
    # you get your points back plus a bonus based on the odds
    yes_percentage = @prediction.yes_percentage
    no_percentage = @prediction.no_percentage
    
    if outcome # YES won
      winning_percentage = yes_percentage
    else # NO won
      winning_percentage = no_percentage
    end
    
    # Bonus multiplier based on how "surprising" the outcome was
    # If the winning side had low percentage, higher bonus
    surprise_multiplier = (100 - winning_percentage) / 100.0
    bonus = points_bet * surprise_multiplier
    
    points_bet + bonus.round
  end
  
  def update_user_stats(outcome)
    # Update prediction creator's stats
    creator = @prediction.user
    
    # Check if creator voted correctly
    creator_vote = @prediction.votes.find_by(user: creator)
    if creator_vote && creator_vote.outcome == outcome
      creator.award_points(5, "Creador de predicción correcta")
    end
    
    creator.update_stats
  end
end 