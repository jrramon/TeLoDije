# TeLoDije - App de Predicciones Sociales

Una aplicación Rails completa para crear, votar y comentar predicciones con funcionalidades sociales y gamificación.

## 🎯 Características

### 🔮 Predicciones
- ✅ Crear predicciones con categorías temáticas
- ✅ Sistema de votación con puntos
- ✅ Comentarios en predicciones
- ✅ Fechas de resolución automáticas

### 👥 Funcionalidades Sociales
- ✅ Sistema de usuarios con autenticación
- ✅ Seguir a otros usuarios
- ✅ Notificaciones automáticas
- ✅ Perfiles de usuario con estadísticas

### 🏆 Gamificación
- ✅ Sistema de puntos y badges
- ✅ Rankings de usuarios
- ✅ Títulos automáticos basados en rendimiento
- ✅ Rachas de predicciones correctas

### 📂 Categorías
- ⚽ Deportes
- 🏛️ Política  
- 💻 Tecnología
- 🎬 Entretenimiento
- 💰 Economía
- 🔬 Ciencia
- 🌤️ Clima
- ❓ Otros

## 🚀 Instalación

1. Clona el repositorio:
   ```bash
   git clone <tu-repositorio>
   cd TeLoDije
   ```

2. Instala las dependencias:
   ```bash
   bundle install
   ```

3. Configura la base de datos:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Inicia el servidor:
   ```bash
   rails server
   ```

5. Abre tu navegador en `http://localhost:3000`

## 👤 Usuarios de Prueba

La aplicación incluye datos de prueba con los siguientes usuarios:

| Usuario | Email | Contraseña | Título |
|---------|-------|------------|--------|
| maria_predice | maria@example.com | password123 | Profeta |
| carlos_futuro | carlos@example.com | password123 | Sabio |
| ana_vidente | ana@example.com | password123 | Leyenda |
| juan_apuesta | juan@example.com | password123 | Aprendiz |
| lucia_ciencia | lucia@example.com | password123 | Vidente |
| pedro_deportes | pedro@example.com | password123 | Maestro |
| sofia_tech | sofia@example.com | password123 | Vidente |
| miguel_economia | miguel@example.com | password123 | Sabio |

## 🎮 Cómo Jugar

1. **Regístrate** o inicia sesión con un usuario de prueba
2. **Crea predicciones** sobre eventos futuros
3. **Vota** en predicciones de otros usuarios usando tus puntos
4. **Comenta** y discute las predicciones
5. **Sigue** a otros usuarios para ver su actividad
6. **Gana puntos** cuando tus predicciones se resuelven correctamente
7. **Desbloquea badges** por logros especiales
8. **Sube en el ranking** basado en tu precisión y puntos

## 🏅 Sistema de Badges

- 🥇 **Primera Predicción**: Crear tu primera predicción
- 🎯 **Primera Victoria**: Acertar tu primera predicción
- 🔥 **Racha de 3/5/10**: Consecutivas predicciones correctas
- 👑 **Profeta**: 80%+ precisión con 5+ predicciones
- ⭐ **Popular**: Predicción con 50+ votos

## 🛠️ Tecnologías

- **Backend**: Ruby on Rails 7.1
- **Base de Datos**: SQLite3 (desarrollo)
- **Autenticación**: bcrypt
- **Frontend**: HTML, CSS, JavaScript vanilla
- **Diseño**: CSS moderno con variables y gradientes

## 📁 Estructura del Proyecto

```
app/
├── controllers/
│   ├── predictions_controller.rb
│   ├── users_controller.rb
│   ├── sessions_controller.rb
│   ├── votes_controller.rb
│   ├── comments_controller.rb
│   ├── follows_controller.rb
│   ├── notifications_controller.rb
│   ├── profiles_controller.rb
│   └── rankings_controller.rb
├── models/
│   ├── user.rb
│   ├── prediction.rb
│   ├── vote.rb
│   ├── comment.rb
│   ├── category.rb
│   ├── follow.rb
│   ├── notification.rb
│   ├── badge.rb
│   └── user_badge.rb
├── services/
│   └── prediction_resolver.rb
└── views/
    ├── predictions/
    ├── users/
    ├── sessions/
    ├── profiles/
    ├── rankings/
    └── notifications/
```

## 🔧 Configuración

### Variables de Entorno
Crea un archivo `.env` en la raíz del proyecto:
```
SECRET_KEY_BASE=tu_clave_secreta_aqui
```

### Base de Datos
La aplicación usa SQLite3 por defecto. Para producción, considera usar PostgreSQL o MySQL.

## 📊 Estadísticas

La aplicación incluye:
- **10 predicciones** de ejemplo en diferentes categorías
- **8 usuarios** con diferentes niveles de actividad
- **Votos y comentarios** realistas
- **Relaciones de seguimiento** entre usuarios
- **Notificaciones** automáticas
- **Badges** asignados a usuarios

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🆘 Soporte

Si tienes problemas o preguntas:
1. Revisa los issues existentes
2. Crea un nuevo issue con detalles del problema
3. Incluye información sobre tu entorno (Rails version, Ruby version, etc.)

---

¡Disfruta prediciendo el futuro! 🔮✨
