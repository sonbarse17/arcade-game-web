# 🚀 NEON RUNNER - Modern HTML5 Arcade Game

A cutting-edge HTML5 endless runner game featuring advanced graphics, particle effects, and modern web technologies.

## ✨ Features

### 🎮 Gameplay
- **Smooth 60fps Performance**: Optimized game loop with delta time
- **Progressive Difficulty**: Dynamic speed scaling and obstacle variety
- **Multiple Obstacle Types**: Spikes, blocks, and moving obstacles
- **Power-up System**: Collectible coins and gems
- **Lives System**: 3 lives with invincibility frames
- **Particle Effects**: Explosions, trails, and sparkles

### 🎨 Visual Design
- **Neon Theme**: Cyberpunk-inspired visual style
- **Animated UI**: Gradient backgrounds and glowing effects
- **Responsive Design**: Mobile-friendly controls and layout
- **High DPI Support**: Crisp graphics on all devices
- **Advanced Animations**: Character expressions and movement

### 🎯 Controls
- **Desktop**: SPACEBAR or P for pause
- **Mobile**: Touch controls and dedicated buttons
- **Gamepad**: Ready for controller support

## 🛠 Technology Stack

- **Frontend**: HTML5, CSS3, JavaScript ES6+
- **Graphics**: Canvas API with advanced rendering
- **Architecture**: ES6 modules with class-based design
- **Server**: Node.js with http-server
- **Containerization**: Docker with Alpine Linux

## 🎬 Game Demo

### Screenshots
*Screenshots will be added here*

### Live Demo
Play the game online: [Live Demo Link]

## 🚀 Quick Start

### Prerequisites
- Node.js 16+ 
- npm or yarn

### Installation
```bash
# Clone the repository
git clone <repository-url>
cd html5-arcade-game

# Install dependencies
npm install

# Start development server
npm start

# Open browser to http://localhost:8080
```

### Development Mode
```bash
# Run with CORS enabled for development
npm run dev
```

## 🐳 Docker Deployment

```bash
# Build the Docker image
docker build -t neon-runner .

# Run the container
docker run -p 8080:8080 neon-runner

# Access the game at http://localhost:8080
```

## 🎮 Game Mechanics

### Player Character
- **Animated Sprite**: Eyes, mouth, and leg animations
- **Physics**: Realistic gravity and jump mechanics
- **Trail Effects**: Particle trail when moving
- **Invincibility**: Temporary protection after taking damage

### Obstacles
- **Spike Traps**: Triangular hazards
- **Block Obstacles**: Standard rectangular barriers
- **Moving Obstacles**: Vertically oscillating threats

### Power-ups
- **Coins**: Standard collectibles (+100 points)
- **Gems**: Rare collectibles (bonus effects)
- **Stars**: Special rotating collectibles

### Scoring System
- **Distance**: Points for survival time
- **Collectibles**: Bonus points for power-ups
- **Speed Bonus**: Multiplier increases with game speed

## 📁 Project Structure

```
html5-arcade-game/
├── public/
│   └── index.html              # Modern responsive UI
├── src/
│   ├── index.js               # Game application class
│   └── game/
│       ├── engine.js          # Advanced game engine
│       ├── player.js          # Enhanced player class
│       ├── obstacles.js       # Obstacle and power-up classes
│       ├── particles.js       # Particle system
│       └── utils.js           # Utility functions and helpers
├── package.json               # Updated dependencies
├── Dockerfile                 # Optimized container setup
├── .dockerignore             # Docker build optimization
└── README.md                 # This file
```

## 🎨 Customization

### Themes
Modify CSS variables in `index.html` to change the color scheme:
```css
:root {
  --primary-color: #00ff88;
  --secondary-color: #ff4757;
  --background-gradient: linear-gradient(45deg, #0f0f23, #1a1a2e);
}
```

### Game Balance
Adjust game parameters in `engine.js`:
```javascript
this.baseSpeed = 3;        // Initial game speed
this.lives = 3;            // Starting lives
this.speedIncrement = 0.2; // Speed increase rate
```

## 🔧 Development

### Adding New Features
1. **New Obstacle Types**: Extend the `Obstacle` class
2. **Power-up Effects**: Add logic in `collectPowerUp()` method
3. **Visual Effects**: Expand the particle system
4. **Sound Effects**: Integrate Web Audio API

### Performance Optimization
- Object pooling for particles and obstacles
- Efficient collision detection
- Canvas optimization techniques
- Memory management best practices

## 🧪 Testing

```bash
# Run basic tests (when implemented)
npm test

# Performance testing
# Monitor FPS in browser dev tools
```

## 📱 Mobile Support

- Touch controls for jumping
- Responsive canvas sizing
- Optimized performance for mobile devices
- PWA-ready architecture

## 🌐 Browser Compatibility

- Chrome 80+
- Firefox 75+
- Safari 13+
- Edge 80+

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Use ES6+ features
- Follow consistent naming conventions
- Add comments for complex logic
- Maintain 60fps performance

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details

## 🙏 Acknowledgments

- Canvas API documentation and examples
- Modern web game development practices
- Open source game development community

---

## 👨‍💻 Author

**Created by [Sushant Sonbarse](https://github.com/sonbarse17)**

**Made with ❤️ for the web gaming community**