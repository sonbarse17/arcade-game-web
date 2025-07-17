# HTML5 Arcade Game

## Description

This project is a modern HTML5 endless runner game. It features advanced graphics, a responsive UI, and is built with vanilla JavaScript. The game is containerized using Docker for easy deployment.

## Game Demo

![Game Screenshot](screenshots/game-demo.png)

## Tech Stack

- **Frontend:** HTML5, CSS, JavaScript
- **Containerization:** Docker
- **Development Server:** Node.js, http-server
- **Testing:** Jest
- **Linting:** ESLint
- **CI/CD:** GitHub Actions

## Setup Instructions

### Prerequisites
- Node.js (v16 or higher)
- Docker (for containerized deployment)

### Installation

```bash
# Clone the repository
git clone https://github.com/sonbarse17/html5-arcade-game.git

# Navigate to project directory
cd html5-arcade-game

# Install dependencies
npm install
```

## Development Commands

```bash
# Start development server
npm run dev

# Run linting
npm run lint

# Run tests
npm test

# Build the application
npm run build
```

## Docker Deployment

```bash
# Build Docker image
docker build -t html5-arcade-game .

# Run Docker container
docker run -p 8080:80 html5-arcade-game
```

---

Created by @Sushant Sonbarse
[GitHub](https://github.com/sonbarse17)
