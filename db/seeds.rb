# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "🌱 Iniciando carga de datos de prueba..."

# Limpiar datos existentes (excepto categorías y badges)
puts "🧹 Limpiando datos existentes..."
User.destroy_all
Prediction.destroy_all
Vote.destroy_all
Comment.destroy_all
Follow.destroy_all
Notification.destroy_all
UserBadge.destroy_all

puts "Creating default badges..."
Badge.create_default_badges

# Create default categories
categories = [
  { name: 'Deportes', description: 'Predicciones sobre deportes y competiciones', color: '#FF6B6B', icon: '⚽' },
  { name: 'Política', description: 'Predicciones sobre política y elecciones', color: '#4ECDC4', icon: '🏛️' },
  { name: 'Tecnología', description: 'Predicciones sobre tecnología e innovación', color: '#45B7D1', icon: '💻' },
  { name: 'Entretenimiento', description: 'Predicciones sobre películas, música y celebridades', color: '#96CEB4', icon: '🎬' },
  { name: 'Economía', description: 'Predicciones sobre mercados y economía', color: '#FFEAA7', icon: '💰' },
  { name: 'Ciencia', description: 'Predicciones sobre descubrimientos científicos', color: '#DDA0DD', icon: '🔬' },
  { name: 'Clima', description: 'Predicciones sobre clima y fenómenos naturales', color: '#87CEEB', icon: '🌤️' },
  { name: 'Otros', description: 'Otras predicciones variadas', color: '#D3D3D3', icon: '❓' }
]

categories.each do |category_attrs|
  Category.find_or_create_by(name: category_attrs[:name]) do |category|
    category.assign_attributes(category_attrs)
  end
end

puts "Categorías creadas exitosamente"

# Crear usuarios de prueba
puts "👥 Creando usuarios de prueba..."
users_data = [
  { username: 'maria_predice', email: 'maria@example.com', password: 'password123', points: 1250, title: 'Profeta' },
  { username: 'carlos_futuro', email: 'carlos@example.com', password: 'password123', points: 890, title: 'Sabio' },
  { username: 'ana_vidente', email: 'ana@example.com', password: 'password123', points: 2100, title: 'Leyenda' },
  { username: 'juan_apuesta', email: 'juan@example.com', password: 'password123', points: 450, title: 'Aprendiz' },
  { username: 'lucia_ciencia', email: 'lucia@example.com', password: 'password123', points: 750, title: 'Vidente' },
  { username: 'pedro_deportes', email: 'pedro@example.com', password: 'password123', points: 1800, title: 'Maestro' },
  { username: 'sofia_tech', email: 'sofia@example.com', password: 'password123', points: 650, title: 'Vidente' },
  { username: 'miguel_economia', email: 'miguel@example.com', password: 'password123', points: 950, title: 'Sabio' }
]

users = []
users_data.each do |user_data|
  user = User.create!(user_data)
  users << user
  puts "  ✅ Usuario creado: #{user.username} (#{user.title})"
end

# Crear predicciones de prueba
puts "🔮 Creando predicciones de prueba..."
predictions_data = [
  {
    title: "¿Ganará Argentina la Copa América 2025?",
    question: "¿Argentina será campeona de la Copa América 2025 que se disputará en Estados Unidos?",
    category: Category.find_by(name: 'Deportes'),
    resolution_date: Date.new(2025, 7, 15),
    source: "https://copaamerica.com",
    hint: "Argentina es la actual campeona del mundo y tiene un equipo muy fuerte"
  },
  {
    title: "¿Lanzará Apple el iPhone 17 en septiembre 2025?",
    question: "¿Apple presentará oficialmente el iPhone 17 en su evento de septiembre de 2025?",
    category: Category.find_by(name: 'Tecnología'),
    resolution_date: Date.new(2025, 9, 20),
    source: "https://apple.com",
    hint: "Apple tradicionalmente lanza nuevos iPhones en septiembre"
  },
  {
    title: "¿Ganará Trump las elecciones presidenciales de EE.UU. 2025?",
    question: "¿Donald Trump será elegido presidente de Estados Unidos en las elecciones de noviembre de 2025?",
    category: Category.find_by(name: 'Política'),
    resolution_date: Date.new(2025, 11, 5),
    source: "https://fec.gov",
    hint: "Trump es el candidato republicano y Biden el demócrata"
  },
  {
    title: "¿Superará Bitcoin los $100,000 en 2025?",
    question: "¿El precio de Bitcoin alcanzará o superará los $100,000 USD en algún momento de 2025?",
    category: Category.find_by(name: 'Economía'),
    resolution_date: Date.new(2025, 12, 31),
    source: "https://coinmarketcap.com",
    hint: "Bitcoin ha tenido un comportamiento volátil en los últimos años"
  },
  {
    title: "¿Ganará Oppenheimer el Oscar a Mejor Película?",
    question: "¿Oppenheimer ganará el premio Oscar a Mejor Película en la ceremonia de 2024?",
    category: Category.find_by(name: 'Entretenimiento'),
    resolution_date: Date.new(2024, 3, 10),
    source: "https://oscars.org",
    hint: "Oppenheimer ha sido muy bien recibida por la crítica",
    resolved: true,
    outcome: true,
    skip_validation: true
  },
  {
    title: "¿Descubrirán vida en Marte en 2025?",
    question: "¿Los científicos anunciarán el descubrimiento de vida (pasada o presente) en Marte en 2025?",
    category: Category.find_by(name: 'Ciencia'),
    resolution_date: Date.new(2025, 12, 31),
    source: "https://nasa.gov",
    hint: "Hay varias misiones activas explorando Marte"
  },
  {
    title: "¿Será 2025 el año más caluroso registrado?",
    question: "¿2025 será el año más caluroso registrado globalmente según datos de la NASA o NOAA?",
    category: Category.find_by(name: 'Clima'),
    resolution_date: Date.new(2025, 12, 31),
    source: "https://climate.nasa.gov",
    hint: "Los últimos años han batido récords de temperatura"
  },
  {
    title: "¿Llegará el primer humano a Marte en 2025?",
    question: "¿Una misión tripulada llegará a Marte y aterrizará exitosamente en 2025?",
    category: Category.find_by(name: 'Ciencia'),
    resolution_date: Date.new(2025, 12, 31),
    source: "https://spacex.com",
    hint: "SpaceX tiene planes ambiciosos para Marte"
  },
  {
    title: "¿Ganará Real Madrid la Champions League 2025?",
    question: "¿Real Madrid será campeón de la UEFA Champions League en la temporada 2024/25?",
    category: Category.find_by(name: 'Deportes'),
    resolution_date: Date.new(2025, 6, 1),
    source: "https://uefa.com",
    hint: "Real Madrid es uno de los favoritos históricos"
  },
  {
    title: "¿Lanzará Tesla el Cybertruck en 2025?",
    question: "¿Tesla comenzará las entregas masivas del Cybertruck a clientes en 2025?",
    category: Category.find_by(name: 'Tecnología'),
    resolution_date: Date.new(2025, 12, 31),
    source: "https://tesla.com",
    hint: "El Cybertruck ha tenido varios retrasos en su lanzamiento"
  }
]

predictions = []
predictions_data.each do |pred_data|
  user = users.sample
  prediction = user.predictions.create!(pred_data)
  predictions << prediction
  puts "  ✅ Predicción creada: #{prediction.title} (por #{user.username})"
end

# Crear votos de prueba
puts "🗳️ Creando votos de prueba..."
predictions.each do |prediction|
  # Cada predicción tendrá entre 3-8 votos de diferentes usuarios
  voters = users.sample(rand(3..8))
  voters.each do |voter|
    next if voter == prediction.user # El creador no vota en su propia predicción
    
    points = rand(1..[10, voter.points].min)
    outcome = [true, false].sample
    
    vote = prediction.votes.create!(
      user: voter,
      points: points,
      outcome: outcome
    )
    
    # Actualizar puntos del usuario
    voter.update!(points: voter.points - points)
  end
  puts "  ✅ #{prediction.votes.count} votos creados para: #{prediction.title}"
end

# Crear comentarios de prueba
puts "💬 Creando comentarios de prueba..."
comments_data = [
  "¡Excelente predicción! Creo que tienes razón.",
  "No estoy seguro, pero es interesante ver qué pasa.",
  "Basándome en los datos actuales, creo que será así.",
  "Interesante perspectiva. ¿Qué te hace pensar eso?",
  "Creo que necesitamos más información para evaluar esto.",
  "¡Muy buena observación! No lo había considerado.",
  "Esto podría cambiar todo el panorama.",
  "Interesante predicción, pero creo que será diferente.",
  "¡Totalmente de acuerdo! Los indicadores apuntan a eso.",
  "No estoy convencido, pero respeto tu opinión.",
  "¡Brillante análisis! Creo que acertarás.",
  "Esto va a ser muy interesante de seguir.",
  "Creo que hay factores que no se están considerando.",
  "¡Excelente punto de vista! Me has convencido.",
  "Esto podría tener implicaciones importantes."
]

predictions.each do |prediction|
  # Cada predicción tendrá entre 2-6 comentarios
  commenters = users.sample(rand(2..6))
  commenters.each do |commenter|
    next if commenter == prediction.user # El creador no comenta en su propia predicción
    
    comment = prediction.comments.create!(
      user: commenter,
      content: comments_data.sample
    )
  end
  puts "  ✅ #{prediction.comments.count} comentarios creados para: #{prediction.title}"
end

# Crear follows de prueba
puts "👥 Creando relaciones de seguimiento..."
users.each do |follower|
  # Cada usuario seguirá a 2-4 otros usuarios
  users_to_follow = users.reject { |u| u == follower }.sample(rand(2..4))
  users_to_follow.each do |user_to_follow|
    Follow.create!(
      follower: follower,
      followed: user_to_follow
    )
  end
  puts "  ✅ #{follower.username} sigue a #{users_to_follow.count} usuarios"
end

# Crear algunas notificaciones de prueba
puts "🔔 Creando notificaciones de prueba..."
users.each do |user|
  # Cada usuario tendrá 1-4 notificaciones
  rand(1..4).times do
    notification_types = ['comment', 'follow']
    notification_type = notification_types.sample
    
    case notification_type
    when 'comment'
      # Notificación de comentario
      comment = Comment.where.not(user: user).sample
      if comment && comment.prediction.user == user
        Notification.create!(
          user: user,
          title: "Nuevo comentario",
          message: "#{comment.user.username} comentó en tu predicción: '#{comment.prediction.title}'",
          notification_type: "comment",
          reference_id: comment.id,
          reference_type: "Comment",
          read: [true, false].sample
        )
      end
    when 'follow'
      # Notificación de follow
      follower = users.reject { |u| u == user }.sample
      if follower
        Notification.create!(
          user: user,
          title: "Nuevo seguidor",
          message: "#{follower.username} empezó a seguirte",
          notification_type: "follow",
          reference_id: follower.id,
          reference_type: "User",
          read: [true, false].sample
        )
      end
    end
  end
  puts "  ✅ #{user.notifications.count} notificaciones creadas para #{user.username}"
end

# Asignar algunos badges a usuarios
puts "🏅 Asignando badges a usuarios..."
badges = Badge.all
users.each do |user|
  # Cada usuario tendrá 1-3 badges aleatorios
  user_badges = badges.sample(rand(1..3))
  user_badges.each do |badge|
    UserBadge.create!(
      user: user,
      badge: badge,
      earned_at: rand(1..30).days.ago
    )
  end
  puts "  ✅ #{user.username} tiene #{user.user_badges.count} badges"
end

# Actualizar estadísticas de usuarios
puts "📊 Actualizando estadísticas de usuarios..."
users.each do |user|
  user.update_stats
  puts "  ✅ Estadísticas actualizadas para #{user.username}"
end

puts ""
puts "🎉 ¡Datos de prueba cargados exitosamente!"
puts ""
puts "📈 Resumen:"
puts "  👥 #{User.count} usuarios creados"
puts "  🔮 #{Prediction.count} predicciones creadas"
puts "  🗳️ #{Vote.count} votos creados"
puts "  💬 #{Comment.count} comentarios creados"
puts "  👥 #{Follow.count} relaciones de seguimiento creadas"
puts "  🔔 #{Notification.count} notificaciones creadas"
puts "  🏅 #{UserBadge.count} badges asignados"
puts ""
puts "🚀 La aplicación está lista para usar con datos realistas!"
puts ""
puts "💡 Usuarios de prueba disponibles:"
users.each do |user|
  puts "  👤 #{user.username} (#{user.email}) - Contraseña: password123"
end
