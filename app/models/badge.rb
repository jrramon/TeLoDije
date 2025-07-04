class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true
  
  scope :by_category, ->(category) { where(category: category) }
  
  # Badge categories
  CATEGORIES = %w[achievement streak special milestone].freeze
  
  # Predefined badges
  BADGES = {
    first_prediction: {
      name: 'Primera Predicción',
      description: 'Creaste tu primera predicción',
      icon: '🎯',
      category: 'milestone'
    },
    first_victory: {
      name: 'Primera Victoria',
      description: 'Acertaste tu primera predicción',
      icon: '🏆',
      category: 'achievement'
    },
    streak_3: {
      name: 'Racha de 3',
      description: 'Acertaste 3 predicciones seguidas',
      icon: '🔥',
      category: 'streak'
    },
    streak_5: {
      name: 'Racha de 5',
      description: 'Acertaste 5 predicciones seguidas',
      icon: '🔥🔥',
      category: 'streak'
    },
    streak_10: {
      name: 'Racha de 10',
      description: 'Acertaste 10 predicciones seguidas',
      icon: '🔥🔥🔥',
      category: 'streak'
    },
    contrarian: {
      name: 'Contrario',
      description: 'Ganaste votando en contra de la mayoría',
      icon: '🃏',
      category: 'special'
    },
    prophet: {
      name: 'Profeta',
      description: 'Tienes más del 80% de aciertos',
      icon: '🔮',
      category: 'achievement'
    },
    popular: {
      name: 'Popular',
      description: 'Una de tus predicciones recibió más de 50 votos',
      icon: '⭐',
      category: 'achievement'
    }
  }.freeze
  
  def self.create_default_badges
    BADGES.each do |key, badge_data|
      find_or_create_by(name: badge_data[:name]) do |badge|
        badge.description = badge_data[:description]
        badge.icon = badge_data[:icon]
        badge.category = badge_data[:category]
      end
    end
  end
end 